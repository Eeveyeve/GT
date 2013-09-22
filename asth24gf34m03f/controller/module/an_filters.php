<?php

class ControllerModuleAnFilters extends Controller {

    private $error = array();

    public function index() {
        
        // Load models & languages
        $this->load->language('module/an_filters');
        $this->load->model('setting/setting');
        $this->load->model('design/layout');

        // Save settings & redirect to modules list
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $settings = array();
            foreach ($this->request->post as $key => $value) {
                if (strstr($key, 'an_filters_')) {
                    $settings[$key] = $value;
                } else if (strstr($key, 'attributeTextSortOrder_')) {
                    $attributeText = str_replace('attributeTextSortOrder_', '', $key);
                    $attributeTextHash = $attributeText;
                    
                    $updateOrInsert = $this->db->query("SELECT * FROM " . DB_PREFIX . "attribute_text_sort_order WHERE attribute_text = '" . $attributeTextHash . "'");
                    if ($updateOrInsert->num_rows) {
                        $this->db->query("UPDATE " . DB_PREFIX . "attribute_text_sort_order SET sort_order = '" . $value . "' WHERE attribute_text = '" . $attributeTextHash . "'");
                    } else {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "attribute_text_sort_order SET sort_order = '" . $value . "', attribute_text = '" . $attributeTextHash . "'");
                    }

                }
            }
            
            
            $fetchIndexes = $this->db->query('SHOW INDEX FROM ' . DB_PREFIX . 'product_attribute');            
            
            if ($this->request->post['an_filters_attributes_filters_allow_multiple_values'] == 1) {
                if ($fetchIndexes->num_rows > 0) {
                    $this->db->query('DROP INDEX `PRIMARY` ON ' . DB_PREFIX . 'product_attribute');
                }
                $this->db->query('ALTER TABLE ' . DB_PREFIX . 'product_attribute ADD PRIMARY KEY (`product_id`,`attribute_id`,`language_id`,`text`(100))');
            } else {
                if ($fetchIndexes->num_rows > 0) {
                    $this->db->query('DROP INDEX `PRIMARY` ON ' . DB_PREFIX . 'product_attribute');
                }
                $this->db->query('ALTER TABLE ' . DB_PREFIX . 'product_attribute ADD PRIMARY KEY (`product_id`,`attribute_id`,`language_id`)');
            }
            
            
            $this->model_setting_setting->editSetting('an_filters', $settings);

            $this->session->data['success'] = $this->language->get('text_success');
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        // Data pieces
        $this->document->setTitle($this->language->get('heading_title'));
        $this->data['action'] = $this->url->link('module/an_filters', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['layouts'] = $this->model_design_layout->getLayouts();
        
        $languageData = array(
            'heading_title',
            'text_enabled',
            'text_disabled',
            'text_content_top',
            'text_content_bottom',
            'text_column_left',
            'text_column_right',
            'text_yes',
            'text_no',
            'text_hide_with_negative_value',
            'entry_code',
            'entry_list_max_height',
            'entry_layout',
            'entry_attributes',
            'entry_prices',
            'entry_manufacturers',
            'entry_price_band_steps',
            'entry_price_steps',
            'entry_position',
            'entry_general_settings',
            'entry_status',
            'entry_sort_order',
            'entry_attribute_value',
            'entry_sort_attributes',
            'entry_price_bands_status',
            'entry_price_bands_status_info',
            'entry_price_filters_status',
            'entry_price_slider_status',
            'entry_attributes_filters_status',
            'entry_manufacturers_filters_status',
            'entry_collapsible_status',
            'entry_collapsible_hidden_by_default',
            'entry_ajax_status',
            'entry_ajax_status_info',
            'button_save',
            'button_cancel',
            'button_add_module',
            'button_remove',
            'entry_label',
            'entry_attributes_hidden_by_default',
            'text_hide_all',
            'text_show_all',
            'entry_attributes_filters_allow_multiple_values'
        );
        
        foreach ($languageData as $value) {
            $this->data[$value] = $this->language->get($value);
        }
        
        $this->data['text_sort_order_tab'] = sprintf($this->language->get('text_sort_order_tab'), $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL'));

        // Build attribute_text_sort_order table
        // @todo: Move these database functions to the catalog_product model
        $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "attribute_text_sort_order'");
        if (!$query->num_rows) {
            $this->db->query("CREATE TABLE " . DB_PREFIX . "attribute_text_sort_order(attribute_text_sort_order_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(attribute_text_sort_order_id), attribute_text TEXT,  sort_order INT(11))");
        }
        
        $productAttributes = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute_text_sort_order so ON (md5(md5(pa.text)) = md5(so.attribute_text)) GROUP BY text ORDER BY so.sort_order ASC");
        foreach ($productAttributes->rows as $key => $value) {
            if (empty($value['sort_order'])) {
                if ($this->config->get('an_filters_attributes_hidden_by_default') == 1) {
                    $productAttributes->rows[$key]['sort_order'] = '-1';
                } else {
                    $productAttributes->rows[$key]['sort_order'] = '1';
                }
            }
        }
        $this->data['productAttributes'] = $productAttributes->rows;
        
        // Error handling
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['an_filters_attributes_filters_allow_multiple_values'])) {
            $this->data['error_an_filters_attributes_filters_allow_multiple_values'] = $this->error['an_filters_attributes_filters_allow_multiple_values'];
        } else {
            $this->data['error_an_filters_attributes_filters_allow_multiple_values'] = '';
        }
        
        // Breadcrumbs
        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/an_filters', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        // Config settings
        $configSettings = array(
            'an_filters_status' => "",
            'an_filters_ajax_status' => "",
            'an_filters_attributes_filters_status' => "",
            'an_filters_attributes_filters_allow_multiple_values' => "",
            'an_filters_manufacturers_filters_status' => "",
            'an_filters_price_filters_status' => "",
            'an_filters_price_bands_status' => "",
            'an_filters_price_slider_status' => "",
            'an_filters_list_max_height' => "",
            'an_filters_collapsible_status' => "",
            'an_filters_price_bands_upto_10' => "10",
            'an_filters_price_bands_upto_100' => "100",
            'an_filters_price_bands_upto_1000' => "1000",
            'an_filters_price_bands_upto_10000' => "10000",
            'an_filters_manufacturer_label' => "Manufacturers",
            'an_filters_attributes_hidden_by_default' => "0"
        );
        
        foreach ($configSettings as $key => $value) {
            if (isset($this->request->post[$key])) {
                $this->data[$key] = $this->request->post[$key];
            } elseif ($this->config->get($key)) {
                $this->data[$key] = $this->config->get($key);
            } else {
                $this->data[$key] = $value;
            }
        }

        // Modules config settings
        $this->data['modules'] = array();
        if (isset($this->request->post['an_filters_module'])) {
            $this->data['modules'] = $this->request->post['an_filters_module'];
        } elseif ($this->config->get('an_filters_module')) {
            $this->data['modules'] = $this->config->get('an_filters_module');
        }

        // Template
        $this->template = 'module/an_filters.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );
        
        // Output
        $this->response->setOutput($this->render());

    }

    // Validation
    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/an_filters')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        $checkIndexDuplicates = $this->db->query("SELECT (SELECT COUNT(pa2.`text`) FROM " . DB_PREFIX . "product_attribute pa2 WHERE pa.product_id =  pa2.product_id AND pa.attribute_id = pa2.attribute_id AND pa.language_id = pa2.language_id) AS `total` FROM " . DB_PREFIX . "product_attribute pa HAVING `total` > 1");

        if ($this->request->post['an_filters_attributes_filters_allow_multiple_values'] == 0 && $checkIndexDuplicates->num_rows > 0) {
            $this->error['an_filters_attributes_filters_allow_multiple_values'] = $this->language->get('error_an_filters_attributes_filters_allow_multiple_values');
            $this->error['warning'] = $this->language->get('error_has_errors');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }

    }

}

?>