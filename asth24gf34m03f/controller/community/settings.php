<?php  
class ControllerCommunitySettings extends Controller {  
	private $error = array();
	
  	public function index() {
		$this->load->model('community/general');
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),       		
      		'separator' => false
   		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$url = '';
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$this->data['insert'] = $this->url->link('community/settings/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('community/settings/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['words'] = $this->model_community_general->getWords();
		
		$this->template = 'community/settings.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}
	
	function insert () {
		$this->language->load('community/settings');
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('community/general');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_community_general->addWord($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('community/settings', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		}
	
 		if (isset($this->error['word'])) {
			$this->data['error_word'] = $this->error['word'];
		}
				
		$this->data['action'] = $this->url->link('community/settings/insert', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('community/settings', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'community/settings_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	function delete () {
		if (!$this->user->hasPermission('modify', 'community/settings')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if ($this->error) {
			return false;
		}
		
		$this->language->load('community/settings');
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('community/general');		
		
		if (isset($this->request->post['selected'])) {
			foreach ($this->request->post['selected'] as $word) {
				$this->model_community_general->deleteWord($word);
			}

			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('community/settings', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	}
	
	function validateForm () {
		$this->language->load('community/settings');
		if (!$this->user->hasPermission('modify', 'community/settings')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['settings_description'] as $language_id => $value) {
			if ((utf8_strlen($value['word']) < 2) || (utf8_strlen($value['word']) > 255)) {
				$this->error['word'] = $this->language->get('error_word');
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