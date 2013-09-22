<?php 
class ControllerInformationInformation extends Controller {
	public function index() {  
    	$this->language->load('information/information');
		
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
				    'href'      => $this->url->link('information/information', 'information_id=' .  $information_id),      		
        		'separator' => $this->language->get('text_separator')
      		);		
						
      		$this->data['heading_title'] = $information_info['title'];
      		
      		$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
      
      $this->data['link_contact'] = $this->url->link('information/contact');
      $this->data['link_faq'] = $this->url->link('information/information', 'information_id=3');
      $this->data['link_policies'] = $this->url->link('information/information', 'information_id=4');
      
      $this->data['link_community'] = $this->url->link('community/community');
      $this->data['link_livesupport'] = $this->url->link('community/community', 'board=9');
      
      $this->data['information_id'] = $information_id;
      
      $this->data['text_faq_box'] = $this->language->get('text_faq_box');
      $this->data['text_policies_box'] = $this->language->get('text_policies_box');
      $this->data['text_contact_box'] = $this->language->get('text_contact_box');
      $this->data['text_resolution_side'] = $this->language->get('text_resolution_side');
      $this->data['text_categories_side'] = $this->language->get('text_categories_side');
      $this->data['text_sections_side'] = $this->language->get('text_sections_side');
      
      $this->data['text_needhelp'] = $this->language->get('text_needhelp');
      $this->data['text_askcommunity'] = $this->language->get('text_askcommunity');
      $this->data['text_livesupport'] = $this->language->get('text_livesupport');
      
      $this->data['text_blue_block'] = html_entity_decode($this->language->get('text_blue_block'), ENT_QUOTES, 'UTF-8');
      $this->data['text_features'] = $this->language->get('text_features');
      $this->data['text_about1'] = $this->language->get('text_about1');
      $this->data['text_about2'] = $this->language->get('text_about2');
      $this->data['text_about3'] = $this->language->get('text_about3');
      $this->data['text_about4'] = $this->language->get('text_about4');
      $this->data['text_headquarters'] = $this->language->get('text_headquarters');
      $this->data['text_company'] = $this->language->get('text_company');
      
      $this->data['text_search'] = $this->language->get('text_search');
      $this->data['text_howcan'] = $this->language->get('text_howcan');
      		
			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/information.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/information.tpl';
			} else {
				$this->template = 'default/template/information/information.tpl';
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
				'href'      => $this->url->link('information/information', 'information_id=' . $information_id),
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