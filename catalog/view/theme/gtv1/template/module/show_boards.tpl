<span class="communities"><?php echo $this->language->get('communities') ?></span>
<ul class="communities_list">
	<?php
    foreach ($boards as $board) {
    	echo '<li><a href="' .$link_community. '?board=' .$board['id_board'] .'"><b>' .$board['name'] .'</b> ' .$board['num_posts'].' ' .$this->language->get('posts') .' - ' .$board['online'] .' ' .$this->language->get('online') .'</a></li>';
    }
    ?>
</ul>