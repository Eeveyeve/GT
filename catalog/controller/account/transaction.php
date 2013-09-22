<?php
class ControllerAccountTransaction extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/transaction', '', 'SSL');
			
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}		
		
		$this->language->load('account/transaction');

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
        	'text'      => $this->language->get('text_transaction'),
			'href'      => $this->url->link('account/transaction', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->load->model('account/transaction');

    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_amount'] = sprintf($this->language->get('column_amount'), $this->config->get('config_currency'));
		
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_empty'] = $this->language->get('text_empty');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
				
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		
		$this->data['transactions'] = array();
		
		$data = array(				  
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);
		
		$transaction_total = $this->model_account_transaction->getTotalTransactions($data);
	
		$results = $this->model_account_transaction->getTransactions($data);
 		
    	foreach ($results as $result) {
			$this->data['transactions'][] = array(
				'amount'      => $this->currency->format($result['amount'], $this->config->get('config_currency')),
				'description' => $result['description'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}	

		$pagination = new Pagination();
		$pagination->total = $transaction_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/transaction', 'page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		$this->data['total'] = $this->currency->format($this->customer->getBalance());
		
		$this->data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/transaction.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/transaction.tpl';
		} else {
			$this->template = 'default/template/account/transaction.tpl';
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
  
  public function withdrawBalance() {		 		
		$json = array();    
    if (isset($this->request->post['paypal_email']) && isset($this->request->post['name']) && isset($this->request->post['email']) && isset($this->request->post['id']) && isset($this->request->post['balance']) && $this->request->post['id'] == $this->customer->getId()) {
      $mail = new Mail(); 
  		$mail->protocol = $this->config->get('config_mail_protocol');
  		$mail->parameter = $this->config->get('config_mail_parameter');
  		$mail->hostname = $this->config->get('config_smtp_host');
  		$mail->username = $this->config->get('config_smtp_username');
  		$mail->password = $this->config->get('config_smtp_password');
  		$mail->port = $this->config->get('config_smtp_port');
  		$mail->timeout = $this->config->get('config_smtp_timeout');
      		$mail->setTo('dan@gamingtitans.com');
  		$mail->setFrom($this->request->post['email']);
  		$mail->setSender($this->request->post['name']);
  		$mail->setSubject(html_entity_decode($this->request->post['name'].' - Withdraw request of '.$this->request->post['balance'].' for user ID: '.$this->request->post['id'], ENT_QUOTES, 'UTF-8'));
  		//$mail->setHtml($html);
  		$mail->setText($this->request->post['name'].' - Withdraw request of '.$this->request->post['balance'].' for user ID: '.$this->request->post['id'].' on paypal email: '.$this->request->post['paypal_email']);
  		$mail->send();
    } else {
      $json['error'] = "error";
    }
		
		$this->response->setOutput(json_encode($json));		
	} 		
}
?>
