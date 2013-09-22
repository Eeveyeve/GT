<?php  
class ControllerModuleSidebarLoginBox extends Controller {
	
	protected function index($setting) {
	
	/* Language */
	    $this->language->load('module/sidebarloginbox');		
	
	    $this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_new_customer'] = $this->language->get('text_new_customer');
    	$this->data['text_register'] = $this->language->get('text_register');
    	$this->data['text_register_account'] = $this->language->get('text_register_account');
		  $this->data['text_returning_customer'] = $this->language->get('text_returning_customer');
		  $this->data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
    	$this->data['text_forgotten'] = $this->language->get('text_forgotten');
      $this->data['text_connect'] = $this->language->get('text_connect');

    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_password'] = $this->language->get('entry_password');
      
      $this->data['text_login'] = $this->language->get('text_login');
      $this->data['text_islogged'] = $this->language->get('text_islogged');
      $this->data['text_logout'] = $this->language->get('text_logout');
      $this->data['text_account'] = $this->language->get('text_account');
      
      $this->data['text_mystore'] = $this->language->get('text_mystore');
      $this->data['text_howitworks'] = $this->language->get('text_howitworks');
      $this->data['text_history'] = $this->language->get('text_history');
      $this->data['text_in_my_account'] = $this->language->get('text_in_my_account');
      $this->data['text_in_affiliate_account'] = $this->language->get('text_in_affiliate_account');
      
      $this->data['account'] = $this->url->link('account/account', '', 'SSL');
      $this->data['logout'] = $this->url->link('account/logout', '', 'SSL');
      $this->data['mystore'] = $this->url->link('affiliate/account', '', 'SSL');
      $this->data['howitworks'] = $this->url->link('information/affiliate', 'information_id=7', 'SSL');

    	$this->data['button_continue'] = $this->language->get('button_continue');
		  $this->data['button_login'] = $this->language->get('button_login');

		
		$this->load->model('account/customer');
		
		
		
		
		
		$this->data['action'] = $this->url->link('account/login', '', 'SSL');
		$this->data['register'] = $this->url->link('account/register', '', 'SSL');
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
		
		$this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
		$this->data['logged'] = $this->customer->isLogged();
    
    $this->data['firstname'] = $this->customer->getFirstName();
    $this->data['lastname'] = $this->customer->getLastName();
    $this->data['customer_email'] = $this->customer->getEmail();
		
		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['password'])) {
			$this->data['password'] = $this->request->post['password'];
		} else {
			$this->data['password'] = '';
		}
    
    $this->data['show_store_credit'] = $module = $this->getChild('module/show_store_credit');
    
    $this->data['affiliate_logged'] = $this->affiliate->isLogged();
      
    if($this->data['affiliate_logged']) {
      $this->data['show_affiliate_credit'] = $module = $this->getChild('module/show_affiliate_credit'); 
    }
				
		/* Load Template */
    
    $this->children = array(
      'module/fbconnect'		
		);
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/sidebarloginbox.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/sidebarloginbox.tpl';
		} else {
			$this->template = 'default/template/module/sidebarloginbox.tpl';
		}
						
		$this->render();
		
		}
}
?>