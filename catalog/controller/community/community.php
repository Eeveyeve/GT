<?php
class ControllerCommunityCommunity extends Controller {
   private $error = array();

     public function index() {
		 //Let's see if we need to take some previous actions...
		 if (isset($_POST['action']) and $_POST['action'] == 'post_topic') {
			 $this->post_topic (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'getTopics') {
			 $this->getTopics (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'helpful') {
			 $this->helpful (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'blockUser') {
			 $this->blockUser (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'removePost') {
			 $this->removePost (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'removeTopic') {
			 $this->removeTopic (); return 0;
		 }

		$this->document->addStyle('catalog/view/theme/gtv1/stylesheet/community.css');
		$this->document->addScript('catalog/view/javascript/spec.js');
		$this->document->addScript('catalog/view/javascript/community.js');
		$this->document->addScript('catalog/view/javascript/community_community.js');
		$this->load->model('community/community');
		//Loads every board...
		$this->data['boards'] = $this->model_community_community->get_boards();
		//

		//Are we loading the default board?
		$current = current($this->data['boards']);
		$board = (isset($_GET['board']) and is_numeric($_GET['board'])) ? $_GET['board'] : $current['id_board'];
		$this->data['selected_board'] = $board;
		$this->data['selected_etiquette'] = html_entity_decode($this->data['boards'][$board]['etiquette'], ENT_QUOTES, 'UTF-8');
		$this->data['total_users_online'] = $this->model_community_community->getTotalOnline();
		$this->data['login'] = $this->url->link('account/login', '', 'SSL');
    $this->data['read_more'] = $this->language->get('read_more');

		$this->model_community_community->writeLog($board);

		//Loads the latest topics for this board
		$this->data['topics'] = $this->model_community_community->get_topics($board);
		if (count($this->data['topics']) > 0) {
			$this->data['last_topic'] = $this->data['topics'][0]['id_topic'];
		} else {
			$this->data['last_topic'] = 0;
		}
		// 

      $this->language->load('community/community');

       $this->document->setTitle($this->language->get('heading_title'));

         $this->data['breadcrumbs'] = array();

         $this->data['breadcrumbs'][] = array(
           'text'      => $this->language->get('text_home'),
		   'href'      => $this->url->link('common/home'),           
           'separator' => false
         );

         $this->data['breadcrumbs'][] = array(
           'text'      => $this->language->get('heading_title'),
           'href'      => $this->url->link('community/community'),
           'separator' => $this->language->get('text_separator')
         );   
       
       $this->data['heading_title'] = $this->data['boards'][$board]['name'];
       
       $this->data['please_login'] = sprintf($this->language->get('please_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
       
       $this->data['link_community'] = $this->url->link('community/community');
       $this->data['link_topic'] = $this->url->link('community/topic');

      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/community/community.tpl')) { //if file exists in your current template folder
         $this->template = $this->config->get('config_template') . '/template/community/community.tpl'; //get it
      } else {
         $this->template = 'default/template/community/community.tpl'; //or get the file from the default folder
      }
      
      $this->children = array( //Required. The children files for the page.
         'common/column_left',
         'common/column_right',
         'common/content_top',
         'common/content_bottom',
         'common/footer',
         'common/header'
      );
            
      $this->response->setOutput($this->render());      
     }
	 
	 private function post_topic () {
		 $this->load->model('community/community');
     	 $this->language->load('community/community');
	  
		 if (!$this->customer->isLogged()) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('not_logged_in'));
			 echo json_encode($res);
			 return 0;
		 } elseif ($_POST['mensaje'] == '' or !is_numeric($_POST['board'])) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('enter_mesage'));
			 echo json_encode($res);
			 return 0;
		 }
		 $this->model_community_community->permissionCheck();
		 //Creates the topic...
		 $blocked_words = $this->model_community_community->getWords();
		 $msg = $_POST['mensaje'];
		 foreach ($blocked_words as $word) {
			 $msg = str_ireplace($word['block_word'], '*@!*', $msg);
		 }		 
		 $topic = $this->model_community_community->create_topic($_POST['board'], $msg);
		 //Actions
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
		 	$actions = 'true';
		 } else {
			$actions = 'false';
		 }
		 //A Gravatar function has been added...
		 $gravatar = md5(strtolower(trim($this->customer->getEmail())));
		 //
		 $res = array('reply' => 'success', 'topic_id' => $topic['id_topic'], 'id_first_msg' => $topic['id_first_msg'], 'who' => $this->customer->getFirstName() ." " .$this->customer->getLastName(), 'actions' => $actions, 'gravatar' => $gravatar);
		 echo json_encode($res);
	 }
	 
	 private function getTopics () {
		 $this->load->model('community/community');
		 $this->language->load('community/community');
		 if (!is_numeric($_POST['last_topic']) or !is_numeric($_POST['board'])) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('no_new'));
			 echo json_encode($res);
			 return 0;
		 }
		 
		 //Get newer topics for this board starting from the last one...
		 $topics = $this->model_community_community->get_topics($_POST['board'], $_POST['last_topic']);
		 //Actions
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
		 	$actions = 'true';
		 } else {
			$actions = 'false';
		 }
		 if (count($topics) > 0) {
			 $res = array('reply' => 'success', 'how_much' => count($topics), 'topics' => $topics, 'actions' => $actions);
		 } else {
			 $res = array('reply' => 'nope');
		 }
		 echo json_encode($res);
		 return 0;
	 }
	 
	 function helpful () {
		 $this->load->model('community/community');
		 $this->language->load('community/community');
 		 if (!$this->customer->isLogged()) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('not_logged_in'));
		 } elseif (!is_numeric($_POST['mensaje'])) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('no_helpful'));
		 }

		 $this->model_community_community->permissionCheck();
		 
		 if (isset($res)) { echo json_encode($res); return 0; } 

		 $id_msg = $_POST['mensaje'];
		 if ($this->model_community_community->helpful($id_msg)) {
			 $res = array('reply' => 'success');
			 echo json_encode($res);
			 return 0;
		 }
	 }
	 
	 function blockUser () {
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
			 $this->load->model('community/community');
			 $this->language->load('community/community');
			 $this->model_community_community->blockUser($_POST['mensaje']);
			 $res = array('reply' => 'success');
			 echo json_encode($res);
		 }
	 }
	 
	 function removePost () {
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
			 $this->load->model('community/community');
			 $this->language->load('community/community');
			 $this->model_community_community->removePost($_POST['mensaje']);
			 $res = array('reply' => 'success');
			 echo json_encode($res);
		 }
	 }
	 
 	 function removeTopic () {
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
			 $this->load->model('community/community');
			 $this->language->load('community/community');
			 $this->model_community_community->removeTopic($_POST['topic']);
			 $res = array('reply' => 'success');
			 echo json_encode($res);
		 }
	 }
}
?>