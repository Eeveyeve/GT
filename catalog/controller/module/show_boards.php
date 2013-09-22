<?php
class ControllerModuleShowBoards extends Controller {

	protected function index($setting) {
  
		$this->load->model('community/community');
    $this->data['boards'] = $this->model_community_community->get_boards();
    $this->data['link_community'] = $this->url->link('community/community');
    
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/show_boards.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/show_boards.tpl';
			} else {
				$this->template = 'default/template/module/show_boards.tpl';
			}

			$this->render();
  	}

}
?>