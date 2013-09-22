<?php
class ControllerCheckoutSuccess extends Controller { 
	public function index() { 	
		$this->load->model('checkout/order');
		$this->load->model('tool/image');
    $this->language->load('product/product');
		$this->data['products'] = array();
		$this->data['order_info'] = array();
    $this->data['product_ids'] = array();
    
    if (isset($this->request->get['order_id'])) {
      $order_id = $this->request->get['order_id'];
    } else if (isset($this->session->data['order_id'])) {
      $order_id = $this->session->data['order_id'];
    } else {
      $order_id = '';
    }
    
    $this->data['preorders'] = 0;
    $this->data['non_preorders'] = 0;       
    
		if ($order_id) {
			$order_info = $this->model_checkout_order->getOrder($order_id);
      //if ($order_info['customer_id'] == $this->customer->getId()) {
  			//foreach ($this->cart->getProducts() as $product) {
        foreach ($this->model_checkout_order->getOrderProducts($order_id) as $product) {
        
  			  if ($product['image']) {
  					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
  				} else {
  					$image = '';
  				}
          
          array_push($this->data['product_ids'], $product['product_id']);
          
          if (strtotime($product['date_available']) > time()) {
            $this->data['preorders']++;
          } else {
            $this->data['non_preorders']++;
          }
           
  			  $this->data['products'][] = array(
  					'product_id' => $product['product_id'],
            'name'       => $product['name'],
  					'model'      => $product['model'],
  					'price'      => $this->currency->format($product['price'], $order_info['currency_code'], false, false),
  					'quantity'   => $product['quantity'],
            'date_available' => date($this->language->get('date_format_3'), strtotime($product['date_available'])),
            'genre'      => $product['genre'],
  					'thumb'      => $image
  				);
  			}
  			$this->data['order_info'] = $order_info;
        
        $this->data['order_id'] = $order_info['order_id'];
        $this->data['firstname'] = $order_info['firstname'];
        $this->data['lastname'] = $order_info['lastname'];
        $this->data['telephone'] = $order_info['telephone'];
        $this->data['payment_city'] = $order_info['payment_city'];
        $this->data['payment_country'] = $order_info['payment_country'];
        $this->data['date_modified'] = $order_info['date_modified'];
        $this->data['payment_method'] = $order_info['payment_method'];
        $this->data['delivery_email'] = $order_info['delivery_email'];
        $this->data['email'] = $order_info['email'];
        $this->data['total'] = $this->currency->format($order_info['total']);
        $this->data['manual_member_reward'] = $this->currency->format($order_info['manual_member_reward']);
        $this->data['total_price'] = $this->currency->format($order_info['total'] + $order_info['manual_member_reward']);
        $this->data['account_reward'] = $this->currency->format((($order_info['total'] + $order_info['manual_member_reward'])/100)*3);      
        
  			if (isset($this->session->data['order_id'])) {      
          $this->cart->clear();
    			unset($this->session->data['shipping_method']);
    			unset($this->session->data['shipping_methods']);
    			unset($this->session->data['payment_method']);
    			unset($this->session->data['payment_methods']);
    			unset($this->session->data['guest']);
    			unset($this->session->data['comment']);
    			unset($this->session->data['order_id']);	
    			unset($this->session->data['coupon']);
    			unset($this->session->data['reward']);
    			unset($this->session->data['voucher']);
    			unset($this->session->data['vouchers']);
    			unset($this->session->data['anotheremail']);
    			unset($this->session->data['manual_member_reward']);
        }
      /*} else {
        $this->data['order_id'] = "";
        $this->data['firstname'] = "";
        $this->data['lastname'] = "";
        $this->data['telephone'] = "";
        $this->data['payment_city'] = "";
        $this->data['payment_country'] = "";
        $this->data['date_modified'] = "";
        $this->data['payment_method'] = "";
        $this->data['delivery_email'] = "";
        $this->data['email'] = "";
        $this->data['total'] = $this->currency->format("");
        $this->data['manual_member_reward'] = $this->currency->format("");
        $this->data['total_price'] = $this->currency->format("");
        $this->data['account_reward'] = $this->currency->format("");
      } */ 

		}	else {
      $this->data['order_id'] = "";
      $this->data['firstname'] = "";
      $this->data['lastname'] = "";
      $this->data['telephone'] = "";
      $this->data['payment_city'] = "";
      $this->data['payment_country'] = "";
      $this->data['date_modified'] = "";
      $this->data['payment_method'] = "";
      $this->data['delivery_email'] = "";
      $this->data['email'] = "";
      $this->data['total'] = $this->currency->format("");
      $this->data['manual_member_reward'] = $this->currency->format("");
      $this->data['total_price'] = $this->currency->format("");
      $this->data['account_reward'] = $this->currency->format("");
    }
    
    $this->data['text_wait'] = $this->language->get('text_wait');
    $this->data['text_write'] = $this->language->get('text_write');
    $this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_review'] = $this->language->get('entry_review');
		$this->data['entry_rating'] = $this->language->get('entry_rating');
		$this->data['entry_good'] = $this->language->get('entry_good');
		$this->data['entry_bad'] = $this->language->get('entry_bad');
									   
		$this->language->load('checkout/success');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array(); 

      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('common/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => false
      	); 
		
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/cart'),
        	'text'      => $this->language->get('text_basket'),
        	'separator' => $this->language->get('text_separator')
      	);
				
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'text'      => $this->language->get('text_checkout'),
			'separator' => $this->language->get('text_separator')
		);	
					
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/success'),
        	'text'      => $this->language->get('text_success'),
        	'separator' => $this->language->get('text_separator')
      	);

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		if ($this->customer->isLogged()) {
    		$this->data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('community/community'));
		} else {
    		$this->data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('community/community'));
		}
		
    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success2.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success2.tpl';
		} else {
			$this->template = 'default/template/common/success2.tpl';
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