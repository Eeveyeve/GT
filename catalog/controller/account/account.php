<?php 
class ControllerAccountAccount extends Controller { 
	public function index() {
		if (!$this->customer->isLogged()) {
  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
  
  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    }
    
    //+mod by yp start
		if ($this->config->get('account_combine_status')) {
			if($this->customer->isLogged() && !$this->affiliate->isLogged()) {
				$this->affiliate->login('', '', $this->customer->getId());
			  if(isset($this->session->data['accc_show_aff_section'])) unset($this->session->data['accc_show_aff_section']);
			}
		}
		//+mod by yp end 
	
		$this->language->load('account/account');

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
		
		if (isset($this->session->data['success'])) {
    		$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_my_account'] = $this->language->get('text_my_account');
      $this->data['text_my_store'] = $this->language->get('text_my_store');
      $this->data['text_my_profile'] = $this->language->get('text_my_profile');
		$this->data['text_my_orders'] = $this->language->get('text_my_orders');
		$this->data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
    $this->data['text_save'] = $this->language->get('text_save');
    	$this->data['text_edit'] = $this->language->get('text_edit');
    	$this->data['text_password'] = $this->language->get('text_password');
    	$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
    	$this->data['text_order'] = $this->language->get('text_order');
    	$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_reward'] = $this->language->get('text_reward');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
    
    $this->data['text_partner'] = $this->language->get('text_partner');
    $this->data['text_picture'] = $this->language->get('text_picture');
    $this->data['text_howitworks'] = $this->language->get('text_howitworks');
    $this->data['text_in_my_account'] = $this->language->get('text_in_my_account');
    $this->data['text_withdraw_to'] = $this->language->get('text_withdraw_to');
    $this->data['text_withdraw'] = $this->language->get('text_withdraw');
    $this->data['text_paypal_email'] = $this->language->get('text_paypal_email');
    $this->data['text_under1'] = $this->language->get('text_under1');
    $this->data['text_under2'] = $this->language->get('text_under2');
    $this->data['text_toolow'] = $this->language->get('text_toolow');
    $this->data['text_request_sent'] = $this->language->get('text_request_sent');

    	$this->data['edit_account'] = $this->url->link('account/edit', '', 'SSL');
    	$this->data['edit_password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['edit_address'] = $this->url->link('account/address', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist');
    	//$this->data['order'] = $this->url->link('account/order', '', 'SSL');
    	$this->data['download'] = $this->url->link('account/download', '', 'SSL');
		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$this->data['edit_newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
    $this->data['my_account'] = $this->url->link('account/account', '', 'SSL');
    $this->data['my_store'] = $this->url->link('affiliate/account', '', 'SSL');
    $this->data['link_contact'] = $this->url->link('information/contact', '', 'SSL');
    $this->data['affiliate_explanation'] = $this->url->link('information/information', 'information_id=7');
		
		if ($this->config->get('reward_status')) {
			$this->data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$this->data['reward'] = '';
		}

			$this->data['balance'] = $this->currency->format($this->customer->getBalance(), $this->currency->getCode());
      
      $this->data['customer_name'] = $this->customer->getFirstName()." ".$this->customer->getLastName();
      $this->data['customer_email'] = $this->customer->getEmail();
      $this->data['customer_id'] = $this->customer->getId();
      $this->data['customer_balance'] = $this->customer->getBalance();
      
      $this->data['affiliate_logged'] = $this->affiliate->isLogged();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/account.tpl';
		} else {
			$this->template = 'default/template/account/account.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header',
      'account/edit',
      'account/newsletter',
      'account/order'		
		);
				
		$this->response->setOutput($this->render());
  	}
}
?>
