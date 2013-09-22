<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="community-content" class="content-block"><?php echo $content_top; ?>
  <div class="content spacy" align="center"><h2><?php echo $total_users_online .$this->language->get('users_online'); ?></h2>
  <?php
  if (!$this->customer->isLogged()) {
  	echo '<a href="' .$login.'">' .$this->language->get('login') .'</a> ' .$this->language->get('head_text');
  } else {
    echo $this->language->get('head_text_alternative');
  }
  ?>
  </div>
  <div class="content darkblueline"></div>
  <!--<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>-->
  <h1 class="content headtitle"><a class="backtopic darkestbluebutton roundbutton" href="<?php echo $link_community.'?board='.$selected_board; ?>"><</a><?php echo $heading_title; ?></h1>
	<div class="container">
    	<div class="left_contenedor">
        <?php
    		//Adds the topic default message
    		echo '
        <div class="mainmessage" id="mainmessage">
		    <div><div class="gravatar"><img src="http://www.gravatar.com/avatar/' .$topic_info['gravatar'] .'?s=50" /></div>
        <span class="message_by">'.$topic_info['poster_name'] .'</span><br />
        <span class="message_body">' .$topic_info['body'] .'</span>
        <span class="message_actions"><span id="helpful_' .$topic_info['id_first_msg'] .'">' .(($topic_info['voted'] == 0) ? '<a href="#" class="helpful" id="' .$topic_info['id_first_msg'] .'">' .$this->language->get('helpful') .'</a>' : $this->language->get('was_helpful')) .(($topic_info['helpful'] > 0) ? ' - ' .$topic_info['helpful'] .$this->language->get('find_helpful') : '' ) .'</span>&bull; <span class="moment" id="' .$topic_info['poster_time'] .'"></span></span>
        </div></div>'; ?>
        <div id="reply" class="topicreply">
        <input type="hidden" id="last_message" name="last_message" value="<?php echo $topic_info['id_last_msg']; ?>" />
        <input type="hidden" id="topic_id" name="topic" value="<?php echo $topic_info['id_topic']; ?>" />
        <?php if($this->customer->isLogged()) { echo '<div class="gravatar postgravatar"><img src="http://www.gravatar.com/avatar/'.md5(strtolower(trim($this->customer->getEmail()))).'?s=25" /></div>'; } ?>
        <input type="text" id="que_piensas" placeholder="<?php echo $this->language->get('que_piensas') ?>" value="" /><span id="send_button"><input id="crear_mensaje" type="submit" name="post" value="Submit" class="darkestbluebutton" /></span><span id="status_msg"></span>
        <div style="clear:both;"></div>
        </div>
        <div class="messages comments" id="messages">
        <div id="clone_base" class="message" style="display:none">
                <div>
                <div class="gravatar"></div>
                <span class="message_title"></span>
                <span class="message_by"></span>
                <span class="message_actions"></span>
                </div>
        </div>
        <?php                
        //Adds all the messages...
        if (count($topic_messages) > 0) {
        	foreach ($topic_messages as $message) {
            $actions = ' - <span id="remove_post_' .$message['id_msg'] .'"><a href="#" class="remove_post" id="' .$message['id_msg'] .'">Remove Post</a></span>' .(($message['banned'] != 1) ? ' - <span id="block_user_' .$message['id_msg'] .'"><a href="#" class="block_user" id="' .$message['id_msg'] .'">Block User</a></span>' : ' - User is banned');
            	echo '<div id ="clone_base_' .$message['id_msg'] .'" class="message">
                <div><div class="gravatar"><img src="http://www.gravatar.com/avatar/' .$message['gravatar'] .'?s=25" /></div>
                <span class="message_body">' .$message['body'] .'</span>
                <span class="message_by">' .$this->language->get('by') .' ' .$message['poster_name'] .', <span class="moment" id="' .$message['poster_time'] .'"></span></span>
                <span class="message_actions" id="helpful_' .$message['id_msg'] .'">' .(($message['voted'] == 0) ? '<a href="#" class="helpful" id="' .$message['id_msg'] .'">' .$this->language->get('helpful') .'</a>' : $this->language->get('was_helpful') ) .(($message['helpful'] > 0) ? ' - ' .$message['helpful'] .$this->language->get('find_helpful') : '' ) .'</span>
                '
				.(($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) ? $actions : '')              
                .'
                </div></div>';
            } 
        }
        ?>
        </div>
        </div>
        <div class="right_contenedor"><div class="info">
        <?php if ($this->customer->isLogged()) { ?>
        <?php echo $this->language->get('logged_in_as') ?>: <strong><?php echo $this->customer->getFirstName() .' ' .$this->customer->getLastName() ?></strong><br />
		    <?php echo $this->language->get('member_since') ?>: <strong><?php echo date($this->language->get('date_format_3'), strtotime($this->customer->getMemberSince())) ?></strong><br />
        <?php echo $this->language->get('messages') ?>: <strong><?php echo $this->customer->getPosts() ?></strong><br />
        <?php
        } else {
        ?>
        <em><?php echo $please_login ?></em><br />
        <?php
        }
        ?>
        </div>
        <br />
        <span class="communities"><?php echo $this->language->get('communities') ?></span>
        <ul class="communities_list">
        	<?php
            foreach ($boards as $board) {
            	echo '<li ' .($board['id_board'] == $selected_board ? 'class="selected_board"' : '') .'><a href="'. $link_community .'?board=' .$board['id_board'] .'"><b>' .$board['name'] .'</b> ' .$board['num_posts'].' ' .$this->language->get('posts') .' - ' .$board['online'] .' ' .$this->language->get('online') .'</a></li>';
            }
            ?>
        </ul><br />
        <span class="communities"><?php echo $this->language->get('community_etiquette') ?></span><br />
        <p class="etiquette"><?php echo $selected_etiquette ?></p>
        <br />
        </div>
        <div style="clear:both;"></div>
    </div> 
   <?php echo $content_bottom; ?>
</div>
<br />
<br />
<script type="text/javascript">
$(document).ready(function () {
  $('.communitymark').addClass('active').parent().addClass('active');
});
</script>
<?php echo $footer; ?>