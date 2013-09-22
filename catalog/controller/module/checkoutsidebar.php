<?php  
class ControllerModuleCheckoutSidebar extends Controller {
	protected function index() {
		
    $this->language->load('module/checkoutsidebar');
    
    $this->data['logged'] = $this->customer->isLogged();
    if($this->customer->isLogged()){
      $this->load->model('account/address');
      $this->load->model('account/customer');
    	$this->data['firstname'] = $this->customer->getFirstName();
    	$this->data['lastname'] = $this->customer->getLastName();
    	$this->data['email'] = $this->customer->getEmail();
    	$this->data['phone'] = $this->customer->getTelephone();
        $address = $this->model_account_address->getAddress($this->customer->getAddressId());
    	$this->data['city']	= 	$address['city'];
    	$this->data['country']	= 	$address['country'];
      
      if (isset($this->session->data['manual_member_reward'])) {
        $this->data['manual_member_reward'] = $this->session->data['manual_member_reward'];
      } else {
        $this->data['manual_member_reward'] = '';
      }
      
    }
    else {
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
      
      $this->data['action'] = $this->url->link('account/login', '', 'SSL');
  		$this->data['register'] = $this->url->link('account/register', '', 'SSL');
      $this->data['register_iframe'] = $this->url->link('account/register', 'iframe=1', 'SSL');
  		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
      
      $this->data['text_forgotten'] = $this->language->get('text_forgotten');
      $this->data['text_login'] = $this->language->get('text_login');
      $this->data['text_register'] = $this->language->get('text_register');
    }
    
    $this->data['text_summary'] = $this->language->get('text_summary');
    
    $this->data['entry_email'] = $this->language->get('entry_email');
    $this->data['entry_password'] = $this->language->get('entry_password');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/checkoutsidebar.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/checkoutsidebar.tpl';
		} else {
			$this->template = 'default/template/module/checkoutsidebar.tpl';
		}
		
		$this->render();
	}
}
?>