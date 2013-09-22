<?php

class ControllerModuleAccountCombine extends Controller {
	private $error = array();

	public function install() {				
		ignore_user_abort(1);
		$this->db->query("CREATE TABLE if not exists " . DB_PREFIX . "accc_customer_affiliate (                                  
                          `accc_customer_affiliate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,  
                          `customer_id` int(11) unsigned NOT NULL DEFAULT '0',                   
                          `affiliate_id` int(11) unsigned NOT NULL DEFAULT '0',                          
                          PRIMARY KEY (`accc_customer_affiliate_id`),                             
                          UNIQUE KEY `customer_affiliate_id` (`customer_id`,`affiliate_id`)                          
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED");
		$aclinks = array();			
		$res = $this->db->query("select " . DB_PREFIX . "affiliate.affiliate_id, " . DB_PREFIX . "customer.customer_id from " . DB_PREFIX . "affiliate, " . DB_PREFIX . "customer where " . DB_PREFIX . "affiliate.email=" . DB_PREFIX . "customer.email and " . DB_PREFIX . "affiliate.affiliate_id not in (select affiliate_id from " . DB_PREFIX . "accc_customer_affiliate)");
		if($res->num_rows > 0) {			
			foreach($res->rows as $_r) {
				$aclinks[] = "('" . (int) $_r['customer_id'] . "', '" . (int) $_r['affiliate_id'] . "')";
			}
		}
		$res = $this->db->query("select * from " . DB_PREFIX . "affiliate where email not in (select email from " . DB_PREFIX . "customer) and affiliate_id not in (select affiliate_id from " . DB_PREFIX . "accc_customer_affiliate)");
		if($res->num_rows > 0) {			
			$this->load->model('sale/account_combine');			
			foreach($res->rows as $_r) {
				set_time_limit(100);
				$_cid = $this->model_sale_account_combine->addCustomerFromAffiliate($_r, false);
				if($_cid) $aclinks[] = "('" . (int) $_cid . "', '" . (int) $_r['affiliate_id'] . "')";
			}
		}		
		if(sizeof($aclinks) > 0) $this->db->query("insert ignore into " . DB_PREFIX . "accc_customer_affiliate (customer_id, affiliate_id) values " . implode(',', $aclinks));	
		$this->load->model('setting/setting');
		if(!sizeof($this->model_setting_setting->getSetting('account_combine'))) $this->model_setting_setting->editSetting('account_combine', array('account_combine_affiliate_autoapprove' => 0, 'account_combine_status' => 1, 'account_combine_allow_own_aff' => 1, 'account_combine_allow_funds_transfer' => 0, 'account_combine_transfer_multiplier' => 1));		
	}
	
	public function uninstall() {
		$this->db->query("DELETE FROM " . DB_PREFIX . "accc_customer_affiliate");
	}
	
	public function index() {		
		$this->load->model('setting/setting');
		if(!$this->config->get('account_combine_transfer_multiplier')) {
			$this->config->set('account_combine_transfer_multiplier', 1);
			$this->model_setting_setting->editSetting('account_combine', array_merge($this->model_setting_setting->getSetting('account_combine'), array('account_combine_transfer_multiplier' => 1)));
		}
	
		$settings = array(			
			'affiliate_autoapprove',
			'allow_own_aff',
			'allow_funds_transfer',
			'transfer_multiplier'			
		);	

		$this->data = array_merge($this->data, $this->load->language('module/account_combine'));

		if (!isset($this->session->data['token'])) $this->session->data['token'] = '';		
		$this->data['token'] = $this->session->data['token'];		

		$this->load->language('module/account_combine');		

		if($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ($this->user->hasPermission('modify', 'module/account_combine')) {		
				if(!preg_match("/^\d+(:?\.\d+)?$/", $this->request->post['account_combine_transfer_multiplier'])) {
					$this->request->post['account_combine_transfer_multiplier'] = 1;
				} else {
					$this->request->post['account_combine_transfer_multiplier'] = round(floatval($this->request->post['account_combine_transfer_multiplier']) * 100) * 0.01;
				}
				$this->model_setting_setting->editSetting('account_combine', array_merge($this->model_setting_setting->getSetting('account_combine'), $this->request->post));
				$this->session->data['success'] = $this->language->get('text_success');
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->error['warning'] = $this->language->get('error_permission');
			}
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['heading_title'] = $this->language->get('heading_title');

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_module'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('module/account_combine', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		foreach ($settings as $s) {
			if (isset($this->request->post['account_combine_' . $s])) {
				$this->data['account_combine_' . $s] = $this->request->post['account_combine_' . $s];
			} else {
				$this->data['account_combine_' . $s] = $this->config->get('account_combine_' . $s);
			}
		}

		$this->data['action'] = $this->url->link('module/account_combine', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->id       = 'content';
		$this->template = 'module/account_combine.tpl';

		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());		
	}

}