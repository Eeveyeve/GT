        <?php if ($this->customer->isLogged()) { ?>
        Logged in as <strong><?php echo $this->customer->getFirstName() .' ' .$this->customer->getLastName() ?></strong><br />
		Member since <strong><?php echo $this->customer->getMemberSince() ?></strong><br />
        Messages <strong><?php echo $this->customer->getPosts() ?></strong><hr />
        <?php
        } else {
        ?>
        You are not logged in.<br />
        <?php
        }
        ?>
        <span class="communities">Communities</span><br />
        <ul class="communities_list">
        	<?php
            foreach ($boards as $board) {
            	echo '<li ' .($board['id_board'] == $selected_board ? 'class="selected_board"' : '') .'><a href="index.php?route=community/community&board=' .$board['id_board'] .'">' .$board['name'] .'</a> ' .$board['num_posts'].' Posts - ' .$board['online'] .' Online</li>';
            }
            ?>
        </ul><br />
        <span class="communities">Community Etiquette</span><br />
        <?php echo $selected_etiquette ?>
        <br />
        </div>