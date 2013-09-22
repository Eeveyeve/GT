<?php  
class ControllerCheckoutDeliveryEmail extends Controller {
  	public function index() {
		$this->language->load('checkout/checkout');
		
		$this->load->model('checkout/order');
		
		if ($this->customer->isLogged()) {				
		
  		if ($this->request->post['use_account_email'] == 1) {
        $this->session->data['delivery_email'] = $this->customer->getEmail();
        //$this->redirect($this->url->link('checkout/checkout'));
      }
      
      if (isset($this->session->data['delivery_email'])) {
  			$this->data['delivery_email'] = $this->session->data['delivery_email'];
  		} else {
  			$this->data['delivery_email'] = '';
  		}
  			
  		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/delivery_email.tpl')) {
  			$this->template = $this->config->get('config_template') . '/template/checkout/delivery_email.tpl';
  		} else {
  			$this->template = 'default/template/checkout/delivery_email.tpl';
  		}
  		
  		$this->response->setOutput($this->render());
    	}
    }
	
	public function validate() {
		$this->language->load('checkout/checkout');
    $this->load->model('checkout/order');
		
		$json = array();
		
		// Validate if payment address has been set.
		$this->load->model('account/address');
		
		if ($this->customer->isLogged() && isset($this->session->data['payment_address_id'])) {
			$payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);		
		} elseif (isset($this->session->data['guest'])) {
			$payment_address = $this->session->data['guest']['payment'];
		}
											
		if (!$json) {
			if (!isset($this->request->post['payment_method'])) {
				$json['error']['warning'] = $this->language->get('error_payment');
			} elseif (!isset($this->session->data['payment_methods'][$this->request->post['payment_method']])) {
				$json['error']['warning'] = $this->language->get('error_payment');
			}	
							
			if ($this->config->get('config_checkout_id')) {
				$this->load->model('catalog/information');
				
				$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
				
				if ($information_info && !isset($this->request->post['agree'])) {
					$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
				}
			}
			
			if (!$json) {			  
				$this->session->data['comment'] = strip_tags($this->request->post['comment']);
			}							
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>