<?php
class ControllerAffiliateTransaction extends Controller {
	public function index() {
		if (!$this->affiliate->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('affiliate/transaction', '', 'SSL');
			
	  		$this->redirect($this->url->link('affiliate/login', '', 'SSL'));
    	}		
		
		$this->language->load('affiliate/transaction');

		$this->document->setTitle($this->language->get('heading_title'));

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
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_transaction'),
			'href'      => $this->url->link('affiliate/transaction', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->load->model('affiliate/transaction');
    $this->load->model('account/order');
    $this->load->model('catalog/product');
    $this->load->model('tool/image');

    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_amount'] = sprintf($this->language->get('column_amount'), $this->config->get('config_currency'));
		
		$this->data['text_balance'] = $this->language->get('text_balance');
		$this->data['text_empty'] = $this->language->get('text_empty');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
				
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		
		$this->data['transactions'] = array();
		
		$data = array(				  
			'sort'  => 't.date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			//'limit' => 10
      'limit' => 9999
		);
		
		$transaction_total = $this->model_affiliate_transaction->getTotalTransactions($data);
	
		$results = $this->model_affiliate_transaction->getTransactions($data);
 		
    foreach ($results as $result) {
      
			if($result['order_id'] > 0){
        $order_id = $result['order_id'];
        $order_products = $this->model_account_order->getOrderProducts($result['order_id']);
        $first_product = $this->model_catalog_product->getProduct($order_products[0]['product_id']);
        $order = $this->model_account_order->getOrder($result['order_id']);
        //$order_status = $order['order_id'];
        
        if ($first_product['image']) {
  				$order_image = $this->model_tool_image->resize($first_product['image'], 60, 75);
  			} else {
  				$order_image = '';
  			}
      } else {
        $order_id = "No order ID";
        $order_image = false;
        //$order_status = false;
      }
      
      if($result['amount'] > 0) {
        $amount = "+".$this->currency->format($result['amount'], $this->config->get('config_currency'));
      } else {
        $amount = "-".$this->currency->format($result['amount'], $this->config->get('config_currency'));
      }
      
      $this->data['transactions'][] = array(
				'amount'      => $amount,
				'description' => $result['description'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
        'order_id'    => $order_id,
        'order_image' => $order_image
			);
		}	

		$pagination = new Pagination();
		$pagination->total = $transaction_total;
		$pagination->page = $page;
		//$pagination->limit = 10;
    $pagination->limit = 9999; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('affiliate/transaction', 'page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		$this->data['balance'] = $this->currency->format($this->model_affiliate_transaction->getBalance());
		
		$this->data['continue'] = $this->url->link('affiliate/account', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/affiliate/transaction.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/affiliate/transaction.tpl';
		} else {
			$this->template = 'default/template/affiliate/transaction.tpl';
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