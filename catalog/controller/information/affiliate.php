<?php 
class ControllerInformationAffiliate extends Controller {
	public function index() {  
    	$this->language->load('information/affiliate');
		
		$this->load->model('catalog/information');
		
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			    'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
		
		$information_info = $this->model_catalog_information->getInformation($information_id);
   		
		if ($information_info) {
	  		$this->document->setTitle($information_info['title']); 

      		$this->data['breadcrumbs'][] = array(
        		'text'      => $information_info['title'],
				    'href'      => $this->url->link('information/affiliate', 'information_id=' .  $information_id),      		
        		'separator' => $this->language->get('text_separator')
      		);		
						
      		$this->data['heading_title'] = $information_info['title'];
      		
      		$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
      		
			$this->data['continue'] = $this->url->link('common/home');
      
      
      $this->data['text_heading'] = $this->language->get('text_heading');
      $this->data['text_underheading'] = $this->language->get('text_underheading');
      $this->data['text_bubble1'] = $this->language->get('text_bubble1');
      $this->data['text_bubble2'] = $this->language->get('text_bubble2');
      $this->data['text_bubble3'] = $this->language->get('text_bubble3');
      $this->data['text_middle'] = $this->language->get('text_middle');
      $this->data['text_colhead1'] = $this->language->get('text_colhead1');
      $this->data['text_coltext1'] = $this->language->get('text_coltext1');
      $this->data['text_colmoney1'] = $this->language->get('text_colmoney1');
      $this->data['text_colunder1'] = $this->language->get('text_colunder1');      
      $this->data['text_colhead2'] = $this->language->get('text_colhead2');
      $this->data['text_coltext2'] = $this->language->get('text_coltext2');
      $this->data['text_colmoney2'] = $this->language->get('text_colmoney2');
      $this->data['text_colunder2'] = $this->language->get('text_colunder2');  
      $this->data['text_colhead3'] = $this->language->get('text_colhead3');
      $this->data['text_coltext3'] = $this->language->get('text_coltext3');
      $this->data['text_colmoney3'] = $this->language->get('text_colmoney3');
      $this->data['text_colunder3'] = $this->language->get('text_colunder3');
      $this->data['text_partner'] = $this->language->get('text_partner');
      $this->data['text_month'] = $this->language->get('text_month');
      $this->data['text_est'] = $this->language->get('text_est');
      
      $this->data['link_affiliate'] = $this->url->link('information/contact');
      

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/affiliate.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/affiliate.tpl';
			} else {
				$this->template = 'default/template/information/affiliate.tpl';
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
    	} else {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('information/affiliate', 'information_id=' . $information_id),
        		'separator' => $this->language->get('text_separator')
      		);
				
	  		$this->document->setTitle($this->language->get('text_error'));
			
      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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
	
	public function info() {
		$this->load->model('catalog/information');
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}      
		
		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output  = '<html dir="ltr" lang="en">' . "\n";
			$output .= '<head>' . "\n";
			$output .= '  <title>' . $information_info['title'] . '</title>' . "\n";
			$output .= '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
			$output .= '  <meta name="robots" content="noindex">' . "\n";
			$output .= '</head>' . "\n";
			$output .= '<body>' . "\n";
			$output .= '  <h1>' . $information_info['title'] . '</h1>' . "\n";
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
			$output .= '  </body>' . "\n";
			$output .= '</html>' . "\n";			

			$this->response->setOutput($output);
		}
	}
}
?>
