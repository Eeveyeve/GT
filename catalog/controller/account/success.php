<?php 
class ControllerAccountSuccess extends Controller {  
	public function index() {
    	$this->language->load('account/success');
  
    	$this->document->setTitle($this->language->get('heading_title'));

		$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),       	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_success'),
			'href'      => $this->url->link('account/success'),
        	'separator' => $this->language->get('text_separator')
      	);

    	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('account/customer_group');
		
		$customer_group = $this->model_account_customer_group->getCustomerGroup($this->customer->getCustomerGroupId());

		if ($customer_group && !$customer_group['approval']) {
    		$this->data['text_message'] = sprintf($this->language->get('text_message'), $this->url->link('information/contact'));
		} else {
			$this->data['text_message'] = $this->language->get('text_approval');
		}
		
    	$this->data['text_iframe_message'] = $this->language->get('text_approval');
      
      $this->data['button_continue'] = $this->language->get('button_continue');
		
		if ($this->cart->hasProducts()) {
			$this->data['continue'] = $this->url->link('checkout/cart', '', 'SSL');
		} else {
			$this->data['continue'] = $this->url->link('account/account', '', 'SSL');
		}
    
    $this->data['button_account'] = $this->language->get('button_account');
    $this->data['button_affiliate'] = sprintf($this->language->get('button_affiliate'), $this->config->get('config_name'));
    $this->data['button_shopping'] = $this->language->get('button_shopping');
    
    $this->data['link_account'] = $this->url->link('account/account');
    $this->data['link_affiliate'] = $this->url->link('affiliate/account');
    $this->data['link_shopping'] = $this->url->link('common/home');

		if (isset($this->request->get['iframe'])) {
			$iframe = $this->request->get['iframe'];
		} else {
			$iframe = 0;
		}
    
    if($iframe == 0) {
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
  			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
  		} else {
  			$this->template = 'default/template/common/success.tpl';
  		}
    } else {
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success_iframe.tpl')) {
  			$this->template = $this->config->get('config_template') . '/template/common/success_iframe.tpl';
  		} else {
  			$this->template = 'default/template/common/success_iframe.tpl';
  		}
    }
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());				
  	}
}
?>