<?php 
class ControllerAffiliateAccount extends Controller { 
	public function index() {
		if (!$this->affiliate->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('affiliate/account', '', 'SSL');
	  
	  		$this->redirect($this->url->link('affiliate/login', '', 'SSL'));
    	} 
	
		$this->language->load('affiliate/account');

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('affiliate/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

		$this->document->setTitle($this->language->get('heading_title'));

    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_my_account'] = $this->language->get('text_my_account');
    	$this->data['text_my_tracking'] = $this->language->get('text_my_tracking');
		$this->data['text_my_transactions'] = $this->language->get('text_my_transactions');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_password'] = $this->language->get('text_password');
		$this->data['text_payment'] = $this->language->get('text_payment');
		$this->data['text_tracking'] = $this->language->get('text_tracking');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
    
    $this->data['text_my_store'] = $this->language->get('text_my_store');
    $this->data['text_my_profile'] = $this->language->get('text_my_profile');
    $this->data['text_partner'] = sprintf($this->language->get('text_partner'), $this->config->get('config_name'));
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
    $this->data['text_dashboard'] = $this->language->get('text_dashboard');
    $this->data['text_back'] = $this->language->get('text_back');
    
    $this->data['text_advertise'] = $this->language->get('text_advertise');
    $this->data['text_underadvertise'] = $this->language->get('text_underadvertise');
    
    $this->data['text_orders'] = $this->language->get('text_orders');
    $this->data['text_profit'] = $this->language->get('text_profit');
    $this->data['text_totalearnings'] = $this->language->get('text_totalearnings');
    $this->data['text_totalbalance'] = $this->language->get('text_totalbalance');
    $this->data['text_profitinner'] = $this->language->get('text_profitinner');
    
    $this->load->model('affiliate/transaction');
    
    $this->data['balance'] = $this->currency->format($this->model_affiliate_transaction->getBalance(), $this->currency->getCode());
    //$this->data['balance'] = $this->currency->format($this->customer->getBalance(), $this->currency->getCode());
      
    $this->data['customer_name'] = $this->customer->getFirstName()." ".$this->customer->getLastName();
    $this->data['customer_email'] = $this->customer->getEmail();
    $this->data['customer_id'] = $this->customer->getId();
    $this->data['affiliate_id'] = $this->affiliate->getId();
    $this->data['customer_balance'] = $this->customer->getBalance();    
		
		if (isset($this->session->data['success'])) {
    		$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

    	$this->data['edit_account'] = $this->url->link('affiliate/edit', '', 'SSL');
		$this->data['edit_password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['payment'] = $this->url->link('affiliate/payment', '', 'SSL');
		$this->data['tracking'] = $this->url->link('affiliate/tracking', '', 'SSL');
    	$this->data['transaction'] = $this->url->link('affiliate/transaction', '', 'SSL');
      $this->data['my_account'] = $this->url->link('account/account', '', 'SSL');
    $this->data['my_store'] = $this->url->link('affiliate/account', '', 'SSL');
    $this->data['affiliate_explanation'] = $this->url->link('information/information', 'information_id=7');
    
    $this->load->model('affiliate/transaction');
    
    $this->data['total_earnings'] = $this->currency->format($this->model_affiliate_transaction->getTotalEarnings());
    $this->data['total_transactions'] = $this->model_affiliate_transaction->getTotalTransactions();
    $this->data['total_balance'] = $this->currency->format($this->customer->getBalance(), $this->currency->getCode());
    

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/affiliate/account.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/affiliate/account.tpl';
		} else {
			$this->template = 'default/template/affiliate/account.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header',
      'affiliate/edit',
      'affiliate/tracking',
      'affiliate/transaction'	
		);
				
		$this->response->setOutput($this->render());		
  	}
}
?>