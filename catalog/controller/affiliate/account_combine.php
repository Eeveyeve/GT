<?php

class ControllerAffiliateAccountCombine extends Controller {
	public function index() {		
		if(!$this->config->get('account_combine_status') || $this->affiliate->isLogged()) $this->redirect($this->url->link('affiliate/account', '', 'SSL'));
		$customer_id = $this->customer->isLogged();		
		if(!$customer_id) {
			$this->session->data['redirect'] = $this->url->link('affiliate/account', '', 'SSL');
			$this->redirect($this->url->link('account/login', '', 'SSL'));		
		}
		$this->load->model('affiliate/account_combine');
		$account_status = $this->model_affiliate_account_combine->getAccountStatus($customer_id);
		if($account_status === true && $this->affiliate->login('', '', $this->customer->getId())) $this->redirect($this->url->link('affiliate/account', '', 'SSL'));
		$this->language->load('affiliate/account_combine');
		if($account_status === 'no_account') {			
			$this->data['text_create_affiliate_account_confirm'] = $this->language->get('text_create_affiliate_account_confirm');
			if(isset($this->request->request['confirm'])) {
				$affiliate_id = $this->model_affiliate_account_combine->addAffiliateFromCustomer($customer_id);
				if(!$affiliate_id) $this->redirect($this->url->link('account/account', '', 'SSL'));
				if($this->config->get('account_combine_affiliate_autoapprove')) {
					$this->redirect($this->affiliate->login('', '', $customer_id) ? $this->url->link('affiliate/account', '', 'SSL') : $this->url->link('affiliate/logout', '', 'SSL'));
				}
				$account_status = 'not_approved';
			}
		}
		
		switch($account_status) {
			case 'no_account':
				$this->data['heading_title'] = $this->language->get('heading_title_create_affiliate_account');
				$this->data['text_message'] = '
          <script language="javascript">
          <!--
          		if(confirm("' . addcslashes(preg_replace("/[\n\r\s]+/", ' ', strip_tags($this->data['text_create_affiliate_account_confirm'])), '"') . '")) {
          			document.location.href = \'' . html_entity_decode($this->url->link('affiliate/account_combine', 'confirm=1', 'SSL'), ENT_QUOTES, 'UTF-8') . '\';
          		} else {
          			document.location.href = \'' . html_entity_decode($this->url->link('account/account', '', 'SSL'), ENT_QUOTES, 'UTF-8') . '\';	
          		}         	
          //-->
          </script>		
				';
				break;
			case 'disabled':
				$this->data['heading_title'] = $this->language->get('heading_title_account_disabled');
				$this->data['text_message'] = sprintf($this->language->get('text_account_disabled'), $this->url->link('information/contact'));
				break;
			default:
				$this->data['heading_title'] = $this->language->get('heading_title_account_not_approved');
				$this->data['text_message'] = sprintf($this->language->get('text_account_not_approved'), $this->config->get('config_name'), $this->url->link('information/contact'));	
				break;		
		}
		////////////////////////////////
    	$this->document->setTitle($this->data['heading_title']);

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
		
    	$this->data['button_continue'] = $this->language->get('button_continue');
		
		$this->data['continue'] = $this->url->link('account/account', '', 'SSL');
    
    $this->data['button_account'] = $this->language->get('button_account');
    $this->data['button_affiliate'] = sprintf($this->language->get('button_affiliate'), $this->config->get('config_name'));
    $this->data['button_shopping'] = $this->language->get('button_shopping');
    
    $this->data['link_account'] = $this->url->link('account/account', '', 'SSL');
    $this->data['link_affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
    $this->data['link_shopping'] = $this->url->link('common/home', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
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
	
	public function transaction() {
		if(!$this->config->get('account_combine_status') || !$this->config->get('account_combine_allow_funds_transfer') || !($affiliate_id = $this->affiliate->isLogged()) || !($customer_id = $this->customer->isLogged()) || !isset($this->request->post['amount'])) $this->redirect($this->url->link('affiliate/account', '', 'SSL'));
		$this->language->load('affiliate/account_combine');
		$amount = str_replace(',', '.', preg_replace("/[\n\r\s]+/", '', trim($this->request->post['amount'])));		
		
		if(preg_match("/^\d+(?:\.\d+)?$/", $amount)) {
			if($this->currency->getCode() != $this->config->get('config_currency')) $amount = $this->currency->convert($amount, $this->currency->getCode(), $this->config->get('config_currency'));			
			$this->load->model('affiliate/transaction');
			if(($amount - $this->model_affiliate_transaction->getBalance()) < 0.01) {
				if(abs($amount - $this->model_affiliate_transaction->getBalance()) < 0.01) $amount = $this->model_affiliate_transaction->getBalance();
				$aff_amount = round(floatval($amount) * 10000) * 0.0001;
				$_m = $this->config->get('account_combine_transfer_multiplier') ? $this->config->get('account_combine_transfer_multiplier') : 1;
				$cust_amount = round(floatval($aff_amount * $_m) * 10000) * 0.0001;
				$this->load->model('affiliate/account_combine');		
				$this->model_affiliate_account_combine->transferEarningsToCustomer($affiliate_id, $customer_id, $aff_amount, $cust_amount, $this->language->get('text_affiliate_transaction_description'), $this->language->get('text_customer_transaction_description'));		
				$this->redirect($this->url->link('account/transaction', '', 'SSL'));
			}
		}
		$this->data['error_invalid_transfer_amount'] = $this->language->get('error_invalid_transfer_amount');
		$this->data['error_invalid_transfer_amount_js'] = addcslashes(str_replace(array("\r\n", "\n", "\r"), array(' ', ' ', ' '), strip_tags(html_entity_decode($this->data['error_invalid_transfer_amount'], ENT_COMPAT))), "'");		
		$this->data['text_transactions'] = $this->language->get('text_transactions');

		$this->document->setTitle($this->data['text_transactions']);
		$this->data['heading_title'] = $this->data['text_transactions'];
		$this->data['text_message'] = '
      <script language="javascript">
      <!--
      	$(document).ready(function() {
      		alert(\'' . $this->data['error_invalid_transfer_amount_js'] . '\');
      		document.location.href = \'' . html_entity_decode($this->url->link('affiliate/transaction', '', 'SSL'), ENT_QUOTES, 'UTF-8') . '\';
      	});
      //-->
      </script>		
    ';
		$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),       	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_transactions'),
			'href'      => $this->url->link('affiliate/transaction', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
    	$this->data['button_continue'] = $this->language->get('button_continue');
		
		$this->data['continue'] = $this->url->link('affiliate/transaction', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
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

