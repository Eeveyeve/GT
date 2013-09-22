<?php  
class ControllerCommunityBoards extends Controller {  
	private $error = array();
	
  	public function index() {
		$this->load->model('community/general');
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),       		
      		'separator' => false
   		);
		
		$this->data['boards'] = $this->model_community_general->getBoards();
		
		$this->template = 'community/boards.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		}

		$url = '';
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$this->data['insert'] = $this->url->link('community/boards/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['edit'] = $this->url->link('community/boards/edit', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('community/boards/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');


		$this->response->setOutput($this->render());
  	}
	
		public function insert() {
		$this->language->load('community/boards');
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('community/general');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_community_general->addBoard($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('community/boards', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		}
	
 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		}
		
		if (isset($this->error['order'])) {
			$this->data['error_order'] = $this->error['order'];
		}
		
		$this->data['action'] = $this->url->link('community/boards/insert', 'token=' . $this->session->data['token'] . '&id_board=' . $this->request->get['id_board'], 'SSL');

		$this->data['cancel'] = $this->url->link('community/boards', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'community/boards_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	function edit () {
		$this->language->load('community/boards');
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('community/general');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_community_general->editBoard($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('community/boards', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		}
	
 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		}
		
		if (isset($this->error['order'])) {
			$this->data['error_order'] = $this->error['order'];
		}
		$this->data['action'] = $this->url->link('community/boards/edit', 'token=' . $this->session->data['token'] .'&id_board=' .$this->request->get['id_board'], 'SSL');

		$this->data['cancel'] = $this->url->link('community/boards', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['board'] = $this->model_community_general->getBoard($this->request->get['id_board']);

		$this->template = 'community/boards_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());


		
	}
	
	function delete () {
		$this->language->load('community/boards');
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('community/general');		
		
		if (isset($this->request->post['selected'])) {
			foreach ($this->request->post['selected'] as $id_board) {
				$this->model_community_general->deleteBoard($id_board);
			}

			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('community/boards', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	}
	
	private function validateform() {
		$this->language->load('community/boards');
		if (!$this->user->hasPermission('modify', 'community/boards')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['board_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'] = $this->language->get('error_name');
			}
			if (!is_numeric($value['order']) or $value['order'] >! 0) {
				$this->error['order'] = $this->language->get('error_order');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
					
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>