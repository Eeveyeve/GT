<?php  
class ControllerModuleContent extends Controller {
	protected function index($setting) {
		$this->language->load('module/content');
		
    	$this->data['heading_title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));
    	
		$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/content.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/content.tpl';
		} else {
			$this->template = 'default/template/module/content.tpl';
		}
		
		$this->render();
	}
}
?><?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
