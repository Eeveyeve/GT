<?php
class ControllerCommunityTopic extends Controller {
   private $error = array();
     public function index() {
		 //Let's see if we need to take some previous actions...
		 if (isset($_POST['action']) and $_POST['action'] == 'post_message') {
			 $this->post_message (); return 0;
		 } elseif (isset($_POST['action']) and $_POST['action'] == 'get_messages') {
			 $this->get_messages (); return 0;
		 }

		$this->document->addStyle('catalog/view/theme/gtv1/stylesheet/community.css');
		$this->document->addScript('catalog/view/javascript/spec.js');
		$this->document->addScript('catalog/view/javascript/community.js');
		$this->document->addScript('catalog/view/javascript/community_topic.js');
		$this->load->model('community/community');

	  //Loads every board...
      $this->data['boards'] = $this->model_community_community->get_boards();

	  //Loads information for this topic...
	  $this->data['topic_info'] = $this->model_community_community->getTopicInfo($_GET['id']);
	  $this->data['selected_etiquette'] = html_entity_decode($this->data['topic_info']['etiquette'], ENT_QUOTES, 'UTF-8');
	  $this->data['selected_board'] = $this->data['topic_info']['id_board'];
	  $this->model_community_community->writeLog($this->data['selected_board']);
	  //Loads every message for this topic...
	  $this->data['topic_messages'] = $this->model_community_community->getTopicMessages($_GET['id'], $this->data['topic_info']['id_first_msg']);
	  $this->data['total_users_online'] = $this->model_community_community->getTotalOnline();
	  $this->data['login'] = $this->url->link('account/login', '', 'SSL');
	  		
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
       
       $this->data['heading_title'] = 'Post #' .$this->data['topic_info']['id_topic'];
       
       $this->data['please_login'] = sprintf($this->language->get('please_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
       
       $this->data['link_community'] = $this->url->link('community/community');

      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/community/topic.tpl')) {
         $this->template = $this->config->get('config_template') . '/template/community/topic.tpl';
      } else {
         $this->template = 'default/template/community/topic.tpl';
      }
      
      $this->children = array(
         'common/column_left',
         'common/column_right',
         'common/content_top',
         'common/content_bottom',
         'common/footer',
         'common/header',
      );
            
      $this->response->setOutput($this->render());      
     }
	 
	 private function post_message () {
		 $this->load->model('community/community');
		 $this->language->load('community/community');
		 if (!$this->customer->isLogged()) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('not_logged_in'));
			 echo json_encode($res);
			 return 0;
		 } elseif ($_POST['mensaje'] == '' or !is_numeric($_POST['topic'])) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('enter_mesage'));
			 echo json_encode($res);
			 return 0;
		 }
		$this->model_community_community->permissionCheck();
		 //Creates the message...
		 $blocked_words = $this->model_community_community->getWords();
		 $msg = $_POST['mensaje'];
		 foreach ($blocked_words as $word) {
			 $msg = str_ireplace($word['block_word'], '*@!*', $msg);
		 }
		 $message_id = $this->model_community_community->create_message($_POST['topic'], $msg);
		 //Actions
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
		 	$actions = ' - <span id="remove_post_' .$message_id .'"><a href="#" class="remove_post" id="' .$message_id .'">Remove Post</a></span>';
		 } else {
			 $actions = '';
		 }
		 //A Gravatar function has been added...
		 $gravatar = md5(strtolower(trim($this->customer->getEmail())));
		 //
		 $res = array('reply' => 'success', 'message_id' => $message_id, 'poster_time' => time(), 'actions' => $actions, 'who' => $this->customer->getFirstName() ." " .$this->customer->getLastName(), 'gravatar' => $gravatar);
		 echo json_encode($res);
	 }
	 
	 private function get_messages () {
		 $this->load->model('community/community');
    	 $this->language->load('community/community');
		 if (!is_numeric($_POST['last_message']) or !is_numeric($_POST['topic'])) {
			 $res = array('reply' => 'failed', 'reason' => $this->language->get('no_new'));
			 echo json_encode($res);
			 return 0;
		 }
		 //Get newer messages starting from the last one...
		 $messages = $this->model_community_community->getTopicMessages($_POST['topic'], $_POST['last_message'], true);
 		 //Actions
		 if ($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) {
		 	$actions = 'true';
		 } else {
			$actions = 'false';
		 }

		 if (count($messages) > 0) {
			 $res = array('reply' => 'success', 'how_much' => count($messages), 'messages' => $messages, 'actions' => $actions);
		 } else {
			 $res = array('reply' => 'nope');
		 }
		 echo json_encode($res);
		 return 0;
	 }
}
?>