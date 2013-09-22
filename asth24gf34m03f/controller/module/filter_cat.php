<?php
class ControllerModuleFilterCat extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/filter_cat');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		  
            $filter = array();
		    if(isset($this->request->post['filter_cat_option'])) {
		        $filter_cat_option = array();
		        $filter_cat_option = array();
                foreach($this->request->post['filter_cat_option'] as $value){
                    $filter_cat_option[$value['cat_id']]['cat_id'] = $value['cat_id'];
                    $filter_cat_option[$value['cat_id']]['sub'] = $value['sub'];
                    $filter_cat_option[$value['cat_id']]['brand'] = $value['brand'];
                    $filter_cat_option[$value['cat_id']]['price'] = $value['price'];
                    if(isset($value['attribute_id'])) {
                        $filter_cat_option[$value['cat_id']]['attribute_id'] = $value['attribute_id'];
                    } else {
                        $filter_cat_option[$value['cat_id']]['attribute_id'] = array();
                    }
                }
                $filter['filter_cat_option'] = $filter_cat_option;
		    } 
            if(isset($this->request->post['filter_cat_module'])) {  
			     $filter['filter_cat_module'] = $this->request->post['filter_cat_module'];
            }
            if(isset($this->request->post['filter_cat_manufacturer'])) {  
			     $filter['filter_cat_manufacturer'] = $this->request->post['filter_cat_manufacturer'];
            }
            if(isset($this->request->post['filter_cat_special'])) {  
			     $filter['filter_cat_special'] = $this->request->post['filter_cat_special'];
            }
            if(isset($this->request->post['filter_cat_search'])) {  
			     $filter['filter_cat_search'] = $this->request->post['filter_cat_search'];
            }
            $this->model_setting_setting->editSetting('filter_cat', $filter);   
            		
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_special'] = $this->language->get('text_special');
        $this->data['text_search'] = $this->language->get('text_search');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
        $this->data['text_none'] = $this->language->get('text_none');
        $this->data['text_option'] = $this->language->get('text_option');
        $this->data['text_add_option'] = $this->language->get('text_add_option');
        $this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['entry_all_cat'] = $this->language->get('entry_all_cat');
		$this->data['entry_filter_cat'] = $this->language->get('entry_filter_cat');
		$this->data['entry_brand'] = $this->language->get('entry_brand'); 
        $this->data['entry_sub'] = $this->language->get('entry_sub'); 
        $this->data['entry_price'] = $this->language->get('entry_price'); 
        $this->data['entry_attribute'] = $this->language->get('entry_attribute'); 
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/filter_cat', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/filter_cat', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['filter_cat_module'])) {
			$this->data['modules'] = $this->request->post['filter_cat_module'];
		} elseif ($this->config->get('filter_cat_module')) { 
			$this->data['modules'] = $this->config->get('filter_cat_module');
		}
        if (isset($this->request->post['filter_cat_manufacturer'])) {
			$this->data['filter_cat_manufacturer'] = $this->request->post['filter_cat_manufacturer'];
		} elseif ($this->config->get('filter_cat_module')) { 
			$this->data['filter_cat_manufacturer'] = $this->config->get('filter_cat_manufacturer');
            if(!isset($this->data['filter_cat_manufacturer']['price'])) {
                $this->data['filter_cat_manufacturer']['price'] = 0;
            }
            if(!isset($this->data['filter_cat_manufacturer']['attribute_id'])) {
                $this->data['filter_cat_manufacturer']['attribute_id'] = array();
            }
		} else {
		    $this->data['filter_cat_manufacturer'] = array();
            $this->data['filter_cat_manufacturer']['price'] = 0;
            $this->data['filter_cat_manufacturer']['attribute_id'] = array();
		}
        if (isset($this->request->post['filter_cat_special'])) {
			$this->data['filter_cat_special'] = $this->request->post['filter_cat_special'];
		} elseif ($this->config->get('filter_cat_module')) { 
			$this->data['filter_cat_special'] = $this->config->get('filter_cat_special');
            if(!isset($this->data['filter_cat_special']['price'])) {
                $this->data['filter_cat_special']['price'] = 0;
            }
            if(!isset($this->data['filter_cat_special']['attribute_id'])) {
                $this->data['filter_cat_special']['attribute_id'] = array();
            }
		} else {
		    $this->data['filter_cat_special'] = array();
            $this->data['filter_cat_special']['price'] = 0;
            $this->data['filter_cat_special']['attribute_id'] = array();
		}
        if (isset($this->request->post['filter_cat_search'])) {
			$this->data['filter_cat_search'] = $this->request->post['filter_cat_search'];
		} elseif ($this->config->get('filter_cat_module')) { 
			$this->data['filter_cat_search'] = $this->config->get('filter_cat_search');
            if(!isset($this->data['filter_cat_search']['price'])) {
                $this->data['filter_cat_search']['price'] = 0;
            }
            if(!isset($this->data['filter_cat_search']['attribute_id'])) {
                $this->data['filter_cat_search']['attribute_id'] = array();
            }
		} else {
		    $this->data['filter_cat_search'] = array();
            $this->data['filter_cat_search']['price'] = 0;
            $this->data['filter_cat_search']['attribute_id'] = array();
		}
        
        $this->data['options'] = array();
        if (isset($this->request->post['filter_cat_option'])) {
			$this->data['options'] = $this->request->post['filter_cat_option'];
		} elseif ($this->config->get('filter_cat_option')) { 
			$this->data['options'] = $this->config->get('filter_cat_option');
		}	
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('catalog/category');
				
		$categories = $this->model_catalog_category->getAllCategories();

		$this->data['categories'] = $this->getAllCategories($categories);
        
        
        $this->load->model('catalog/attribute');
        $this->load->model('catalog/attribute_group');
        
        $attribute = $this->model_catalog_attribute->getAttributesByAttributeGroupId();
        
        $this->data['attribute'] = array();
        foreach ($attribute as $attribut) {
            $group = $this->model_catalog_attribute_group->getAttributeGroupDescriptions($attribut['attribute_group_id']);
            $this->data['attribute'][] = array(
                'attribute_id' => $attribut['attribute_id'],
                'name' => $group[$this->config->get('config_language_id')]['name'].$this->language->get('text_separator').$attribut['name']
            
            );
        }
        
        
				
		$this->template = 'module/filter_cat.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/filter_cat')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
    
    private function getAllCategories($categories, $parent_id = 0, $parent_name = '') {
		$output = array();

		if (array_key_exists($parent_id, $categories)) {
			if ($parent_name != '') {
				$parent_name .= $this->language->get('text_separator');
			}

			foreach ($categories[$parent_id] as $category) {
				$output[$category['category_id']] = array(
					'category_id' => $category['category_id'],
					'name'        => $parent_name . $category['name']
				);

				$output += $this->getAllCategories($categories, $category['category_id'], $parent_name . $category['name']);
			}
		}

		return $output;
	}
}
?>