<?php 
class ControllerInformationContact extends Controller {
	private $error = array(); 
	    
  	public function index() {
		$this->language->load('information/contact');

    	$this->document->setTitle($this->language->get('heading_title'));  
	 
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			# Temporary workaround to make sure we send support e-mails
			# to a different address from the default site one
			# $mail->setTo($this->config->get('config_email'));
			$mail->setTo('support@gamingtitans.com');
	  		$mail->setFrom($this->request->post['email']);
	  		$mail->setSender($this->request->post['name']);
	  		$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']).' - '.$this->request->post['subject'], ENT_QUOTES, 'UTF-8'));
	  		$mail->setText(strip_tags(html_entity_decode($this->request->post['category'].':<br /><br />'.$this->request->post['enquiry'], ENT_QUOTES, 'UTF-8')));
      		$mail->send();

	  		$this->redirect($this->url->link('information/contact', 'success=1'));
    	}

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/contact'),
        	'separator' => $this->language->get('text_separator')
      	);
        
      if (isset($this->request->get['success'])) {
  			$this->data['succ'] = $this->request->get['success'];
  		} else {
  			$this->data['succ'] = 0;
  		}  	
			
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_location'] = $this->language->get('text_location');
      $this->data['text_message'] = $this->language->get('text_message');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_address'] = $this->language->get('text_address');
    	$this->data['text_telephone'] = $this->language->get('text_telephone');
    	$this->data['text_fax'] = $this->language->get('text_fax');

    	$this->data['entry_name'] = $this->language->get('entry_name');
    	$this->data['entry_email'] = $this->language->get('entry_email');
      $this->data['entry_subject'] = $this->language->get('entry_subject');
    	$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
      $this->data['entry_submit'] = $this->language->get('entry_submit');
      $this->data['entry_category'] = $this->language->get('entry_category');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
    
      $this->data['link_contact'] = $this->url->link('information/contact');
      $this->data['link_faq'] = $this->url->link('information/information', 'information_id=3');
      $this->data['link_policies'] = $this->url->link('information/information', 'information_id=4');
      
      $this->data['link_livesupport'] = $this->url->link('community/community', 'board=9');
      
      $this->data['text_faq_box'] = $this->language->get('text_faq_box');
      $this->data['text_policies_box'] = $this->language->get('text_policies_box');
      $this->data['text_contact_box'] = $this->language->get('text_contact_box');
      
      $this->data['text_title'] = $this->language->get('text_title');
      $this->data['text_undertitle'] = $this->language->get('text_undertitle');
      $this->data['text_botinfo'] = $this->language->get('text_botinfo');
      
      $this->data['text_needhelp'] = $this->language->get('text_needhelp');
      $this->data['text_askcommunity'] = $this->language->get('text_askcommunity');
      $this->data['text_community'] = $this->language->get('text_community');
      $this->data['text_livesupport'] = $this->language->get('text_livesupport');
      $this->data['text_communitydesc'] = $this->language->get('text_communitydesc');
      
      $this->data['link_community'] = $this->url->link('community/community');

		if (isset($this->error['name'])) {
    		$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}
		
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}		
		
		if (isset($this->error['enquiry'])) {
			$this->data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$this->data['error_enquiry'] = '';
		}		
		
 		if (isset($this->error['captcha'])) {
			$this->data['error_captcha'] = $this->error['captcha'];
		} else {
			$this->data['error_captcha'] = '';
		}	

    	$this->data['button_continue'] = $this->language->get('button_continue');
    
		$this->data['action'] = $this->url->link('information/contact');
		$this->data['store'] = $this->config->get('config_name');
    	$this->data['address'] = nl2br($this->config->get('config_address'));
    	$this->data['telephone'] = $this->config->get('config_telephone');
    	$this->data['fax'] = $this->config->get('config_fax');
    	
		if ($this->config->get('recaptcha_private_key') && $this->config->get('recaptcha_public_key')) {
			require_once(DIR_SYSTEM . 'library/recaptchalib.php');

			if ($this->config->get('config_ssl')) {
				$recaptcha_ssl = true;
			} else {
				$recaptcha_ssl = false;
			}

			$this->data['recaptcha'] = recaptcha_get_html($this->config->get('recaptcha_public_key'), null, $recaptcha_ssl);
		} else {
			$this->data['recaptcha'] = '';
		}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} else {
			$this->data['name'] = $this->customer->getFirstName();
		}
    
    if (isset($this->request->post['subject'])) {
			$this->data['subject'] = $this->request->post['subject'];
		} else {
			$this->data['subject'] = "";
		}
    
    if (isset($this->request->post['category'])) {
			$this->data['category'] = $this->request->post['category'];
		} else {
			$this->data['category'] = "";
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = $this->customer->getEmail();
		}
		
		if (isset($this->request->post['enquiry'])) {
			$this->data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$this->data['enquiry'] = '';
		}
		
		if (isset($this->request->post['captcha'])) {
			$this->data['captcha'] = $this->request->post['captcha'];
		} else {
			$this->data['captcha'] = '';
		}		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/contact.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/contact.tpl';
		} else {
			$this->template = 'default/template/information/contact.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header',
      'module/show_boards'
		);
				
 		$this->response->setOutput($this->render());		
  	}

  	public function success() {
		$this->language->load('information/contact');

		$this->document->setTitle($this->language->get('heading_title')); 

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/contact'),
        	'separator' => $this->language->get('text_separator')
      	);	
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_message'] = $this->language->get('text_message');

    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/contact.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/contact.tpl';
		} else {
			$this->template = 'default/template/information/contact.tpl';
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
	
  	protected function validate() {
    	if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}

    	if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
      		$this->error['email'] = $this->language->get('error_email');
    	}

    	if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
      		$this->error['enquiry'] = $this->language->get('error_enquiry');
    	}

/*if (!$this->config->get('recaptcha_private_key') || !$this->config->get('recaptcha_public_key')) {
			if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
				$this->error['captcha'] = $this->language->get('error_captcha');
			}
		} else {
			require_once(DIR_SYSTEM . 'library/recaptchalib.php');

			if (!isset($this->request->post['recaptcha_challenge_field']) || !isset($this->request->post['recaptcha_response_field'])) {
				$this->error['captcha'] = $this->language->get('error_captcha');
			} else {
				$response = recaptcha_check_answer($this->config->get('recaptcha_private_key'), $this->request->server['REMOTE_ADDR'], $this->request->post['recaptcha_challenge_field'], $this->request->post['recaptcha_response_field']);

				if (!$response->is_valid) {
					$this->error['captcha'] = $this->language->get('error_captcha');
				}
			}
		}*/


		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  	  
  	}

	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}	
}
?>
