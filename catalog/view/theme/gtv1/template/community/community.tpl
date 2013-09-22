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
  <h1 class="content headtitle"><?php echo $heading_title; ?></h1>
	<div class="container">
    	<div class="left_contenedor">
        <input type="hidden" id="board_id" name="board" value="<?php echo $selected_board; ?>" />
        <input type="hidden" id="last_topic" name="last_topic" value="<?php echo $last_topic; ?>" />
        <input type="text" id="que_piensas" placeholder="<?php echo $this->language->get('que_piensas') ?>" value="" /><span id="send_button"><input id="crear_topic" class="darkestbluebutton" type="submit" name="post" value="Submit" /></span><span id="status_msg"></span>
        <div style="clear:both;"></div>
        <div class="topics" id="topics">
        <div id="clone_base" class="topic" style="display:none">
                <div><div class="gravatar"></div>
                <span class="topic_by"></span><br>
                <span class="topic_title"></span>
                <span class="topic_actions"></span>
                </div></div>
        <?php
        function limit_text($text, $limit, $read_more) {
          if (str_word_count($text, 0) > $limit) {
              $words = str_word_count($text, 2);
              $pos = array_keys($words);
              $text = substr($text, 0, $pos[$limit]) . '<span style="color:rgb(7, 152, 214);">' .$read_more. '</span>';
          }
          return $text;
        }
        //Adds all the topics...
        if (count($topics) > 0) {
        	foreach ($topics as $topic) {
            	$actions = ' - <span id="remove_topic_' .$topic['id_topic'] .'"><a href="#" class="remove_topic" id="' .$topic['id_topic'] .'">Remove Topic</a></span>' .(($topic['banned'] != 1) ? ' - <span id="block_user_' .$topic['id_first_msg'] .'"><a href="#" class="block_user" id="' .$topic['id_first_msg'] .'">Block User</a></span>' : ' - User is banned');
            	echo '<div class="topic" id="clone_base_' .$topic['id_topic'] .'">
                <div><div class="gravatar"><img src="http://www.gravatar.com/avatar/' .md5(strtolower(trim($topic['email']))) .'?s=50" /></div>
                <span class="topic_by">' .$topic['poster_name'] .'</span><br />
                <span class="topic_title"><a href="' .$link_topic. '?id=' .$topic['id_topic'] .'#mainmessage" title="'.$this->language->get('reply').'">' . limit_text($topic['body'], 34, $this->language->get('read_more')) .'</a></span>
                <span class="topic_actions"><a href="' .$link_topic. '?id=' .$topic['id_topic'] .'#mainmessage">' .$this->language->get('reply') .'</a> &bull; 
                <span id="helpful_' .$topic['id_msg'] .'">' .(($topic['voted'] == 0) ? '<a href="#" class="helpful" id="' .$topic['id_msg'] .'">' .$this->language->get('helpful') .'</a> &bull; <span class="moment" id="' .$topic['poster_time'] .'"></span>' : '<span class="moment" id="' .$topic['poster_time'] .'"></span> &bull; '.$this->language->get('was_helpful')).(($topic['helpful'] > 0) ? '<img class="helpfulicon" src="catalog/view/theme/gtv1/image/helpful.png" alt="'.$this->language->get('helpful').'" title="'.$this->language->get('helpful').'" />'.$topic['helpful'] : '<img class="helpfulicon" src="catalog/view/theme/gtv1/image/helpful.png" alt="'.$this->language->get('helpful').'" title="'.$this->language->get('helpful').'" />0' ) .'</span>
                '
				.(($this->customer->getCustomerGroupId() == 3 or $this->customer->getCustomerGroupId() == 2) ? $actions : '')              
                .'
                </div></div>';
            } 
        } else {
        	echo '<br />' .$this->language->get('no_topics');
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