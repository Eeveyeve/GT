<?php
class ModelCommunityCommunity extends Model {
	
	function get_boards() {
		$res = $this->db->query("SELECT ocb.*, IFNULL(COUNT(ocl.id_board),0) AS online FROM " .DB_PREFIX ."log_online ocl RIGHT JOIN " .DB_PREFIX ."boards ocb on ocl.id_board =  ocb.id_board GROUP BY ocb.id_board ORDER BY ocb.board_order");
		foreach ($res->rows as $board) {
			$boards[$board['id_board']] = $board;
		 }
		return $boards;
	}
	
	function get_topics ($boards, $starting_from = 0) {
		$res = $this->db->query('
		SELECT
			m.poster_time, m.id_topic, m.id_member, m.id_msg, b.id_board, b.name AS board_name, t.id_first_msg, t.num_replies,
			m.poster_name, mem.email, mem.banned, ' . (!$this->customer->isLogged() ? '1 AS is_read, 0 AS new_from' : '
			IFNULL(lt.id_msg, IFNULL(lmr.id_msg, 0)) >= m.id_msg_modified AS is_read,
			IFNULL(lt.id_msg, IFNULL(lmr.id_msg, -1)) + 1 AS new_from') . ', SUBSTRING(m.body, 1, 384) AS body,
			(SELECT COUNT(id_msg) FROM ' .DB_PREFIX .'log_helpful WHERE id_msg = ms.id_msg ) as helpful' .(($this->customer->getId() > 0) ? ', ((select id_member from ' .DB_PREFIX .'log_helpful where id_msg = ms.id_msg AND id_member = ' .$this->customer->getId() .') IS NOT NULL)' : ', 0') .' AS voted
		FROM ' .DB_PREFIX .'topics AS t
			INNER JOIN ' .DB_PREFIX .'messages AS m ON (m.id_msg = t.id_first_msg)
			INNER JOIN ' .DB_PREFIX .'boards AS b ON (b.id_board = t.id_board)
			INNER JOIN ' .DB_PREFIX .'messages AS ms ON (ms.id_msg = t.id_first_msg)
			LEFT JOIN ' .DB_PREFIX .'customer AS mem ON (mem.customer_id = m.id_member)' . ($this->customer->isLogged() ? '
			LEFT JOIN ' .DB_PREFIX .'log_topics AS lt ON (lt.id_topic = t.id_topic AND lt.id_member = ' .$this->customer->getId()  .')
			LEFT JOIN ' .DB_PREFIX .'log_mark_read AS lmr ON (lmr.id_board = b.id_board AND lmr.id_member = ' .$this->customer->getId() .')' : '')
		. ' WHERE t.id_topic > ' . $starting_from
		. ($boards != '' ? ' AND b.id_board IN (' .$boards .')' : '') .'
		ORDER BY t.id_topic DESC
		LIMIT 15');
		return $res->rows;
	}
	
	function create_topic ($board, $message) {
		$board = mysql_real_escape_string($board);
		$message = mysql_real_escape_string($message);

		$this->db->query("INSERT INTO " .DB_PREFIX ."topics (id_board, id_member_started) VALUES ('$board', '" .$this->customer->getId() ."')");
		$topic_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " .DB_PREFIX ."messages (id_topic, id_board, poster_time, id_member, body, poster_name) VALUES ('$topic_id', '$board', '" .time() ."', '" .$this->customer->getId() ."', '$message', '" .$this->customer->getFirstName() ." " .$this->customer->getLastName() ."')");
		$message_id = $this->db->getLastId();

		$this->db->query("UPDATE " .DB_PREFIX ."topics SET id_first_msg = '$message_id', id_last_msg = '$message_id' WHERE id_topic = $topic_id");

		$this->db->query("UPDATE " .DB_PREFIX ."customer SET posts = posts + 1 WHERE customer_id = " .$this->customer->getId());

		$this->db->query("UPDATE " .DB_PREFIX ."boards SET num_topics = num_topics + 1, num_posts = num_posts + 1 WHERE id_board = $board");

		return array('id_topic' => $topic_id, 'id_first_msg' => $message_id);
		
	}
	
	function create_message ($topic, $message) {
		$topic_id = mysql_real_escape_string($topic);
		$message = mysql_real_escape_string($message);
		$topic_info = $this->getTopicInfo($topic_id);

		$this->db->query("INSERT INTO " .DB_PREFIX ."messages (id_topic, id_board, poster_time, id_member, body, poster_name) VALUES ('$topic_info[id_topic]', '$topic_info[id_board]', '" .time() ."', '" .$this->customer->getId() ."', '$message', '" .$this->customer->getFirstName() ." " .$this->customer->getLastName() ."')");
		$message_id = $this->db->getLastId();

		$this->db->query("UPDATE " .DB_PREFIX ."topics SET id_last_msg = '$message_id' WHERE id_topic = $topic_info[id_topic]");

		$this->db->query("UPDATE " .DB_PREFIX ."customer SET posts = posts + 1 WHERE customer_id = " .$this->customer->getId());

		//$this->db->query("UPDATE " .DB_PREFIX ."boards SET num_topics = num_topics + 1, num_posts = num_posts + 1 WHERE id_board = $topic_info[id_board]");
		
		return $message_id;
		
	}
	
	function getTopicInfo ($topic) {
		$topic = mysql_real_escape_string($topic);
		
		$temp = $this->db->query("SELECT t.id_board, t.id_first_msg, b.etiquette FROM " .DB_PREFIX ."topics AS t, " .DB_PREFIX ."boards AS b WHERE t.id_topic = $topic AND b.id_board = t.id_board");
		$board = $temp->row['id_board'];
		$selected_etiquette =  $temp->row['etiquette'];
		$id_first_msg = $temp->row['id_first_msg'];
		
		$temp = $this->db->query("SELECT COUNT(id_msg) AS helpful FROM " .DB_PREFIX ."log_helpful WHERE id_msg = $id_first_msg");
		$helpful = $temp->row['helpful'];
		
		$temp = $this->db->query((($this->customer->getId() > 0) ? "SELECT (SELECT id_member FROM " .DB_PREFIX ."log_helpful WHERE id_msg = $id_first_msg AND id_member = " .$this->customer->getId() .") IS NOT NULL" : "SELECT 0") ." AS voted");
		$voted = $temp->row['voted'];		 
		
		$res = $this->db->query('
		SELECT t.id_topic, t.num_replies, mem.email, ms.body, ms.poster_name, ms.poster_time, t.id_member_started, t.id_first_msg, t.id_last_msg, t.id_board, 
			' . (!$this->customer->isLogged() ? 't.id_last_msg + 1' : 'IFNULL(lt.id_msg, IFNULL(lmr.id_msg, -1)) + 1') . ' AS new_from 
		FROM ' .DB_PREFIX .'topics AS t 
			INNER JOIN ' .DB_PREFIX .'messages AS ms ON (ms.id_msg = t.id_first_msg)' . (!$this->customer->isLogged() ? '' : '
			LEFT JOIN ' .DB_PREFIX .'log_topics AS lt ON (lt.id_topic = ' .$topic .' AND lt.id_member = ' .$this->customer->getId() .')
			LEFT JOIN ' .DB_PREFIX .'log_mark_read AS lmr ON (lmr.id_board = ' .$board .' AND lmr.id_member = ' .$this->customer->getId() .')') 
			. 'LEFT JOIN ' .DB_PREFIX .'customer AS mem ON (mem.customer_id = ms.id_member)'
			. '
		WHERE t.id_topic = ' .$topic .'
		LIMIT 1');
		
		$return = $res->row;
		$return ['voted'] = $voted;
		$return ['helpful'] = $helpful;
		$return ['etiquette'] = $selected_etiquette;
		$return ['gravatar'] = md5(strtolower(trim($return['email'])));
		return $return;
	}
	
	function getTopicMessages ($topic, $first_message, $updater = false) {
		$topic = mysql_real_escape_string($topic);
		$res = $this->db->query("SELECT ms.id_msg, ms.poster_time, ms.id_member, ms.body, ms.poster_name, u.email, u.banned, (SELECT COUNT(id_msg) FROM " .DB_PREFIX ."log_helpful WHERE id_msg = ms.id_msg ) as helpful" .(($this->customer->getId() > 0) ? ", ((select id_member from " .DB_PREFIX ."log_helpful where id_msg = ms.id_msg AND id_member = " .$this->customer->getId() .") IS NOT NULL)" : ", 0") ." AS voted FROM " .DB_PREFIX ."messages AS ms, " .DB_PREFIX ."customer AS u WHERE ms.id_topic = $topic AND ms.id_msg > $first_message AND u.customer_id = ms.id_member"  .(($this->customer->getId() > 0 and $updater == true) ? " AND ms.id_member <> " .$this->customer->getId() : ""));
		
		//This is just to get the gravatar images but will be changed for sure.
		$messages = array();
		foreach ($res->rows as $key=>$data) {
			$messages[$key] = $data;
			$messages[$key]['gravatar'] = md5(strtolower(trim($messages[$key]['email'])));
		}
		//
		
		return $messages;
	}
	
	function writeLog($board)
	{
		//print_r($_SESSION); exit();
		if (!empty($_SESSION['log_time']) && $_SESSION['log_time'] >= (time() - 8))
			return;

		$session_id = !$this->customer->isLogged() ? 'ip' . addslashes($_SERVER['REMOTE_ADDR']) : session_id();
		$do_delete = true;
	
		if (!empty($_SESSION['log_time']) && $_SESSION['log_time'] >= time() - 300)
		{
			if ($do_delete)
			{
				$this->db->query("DELETE FROM " .DB_PREFIX ."log_online WHERE log_time < " .(time()-900) ." 
					AND session != '$session_id'");
			}
			
			$res = $this->db->query("UPDATE " .DB_PREFIX ."log_online
			SET log_time = " .time() .", ip = IFNULL(INET_ATON('" .addslashes($_SERVER['REMOTE_ADDR']) ."'), 0), id_board = '$board'
			WHERE session = '$session_id'");

			if (count($res) == 0)
				$_SESSION['log_time'] = 0;
		}
		else
			$_SESSION['log_time'] = 0;

		if (empty($_SESSION['log_time']))
		{
			if ($do_delete || $this->customer->isLogged())
				$this->db->query("
					DELETE FROM " .DB_PREFIX ."log_online
					WHERE " . ($do_delete ? "log_time < " .(time() - 900) : "") ." OR session = '" .$session_id ."' " . ($do_delete && $this->customer->isLogged() ? ' OR ' : '') . (!$this->customer->isLogged() ? "" : "id_member = " .$this->customer->getId()));
						
			$this->db->query("INSERT INTO " .DB_PREFIX ."log_online (session, id_member, id_spider, log_time, ip, id_board) VALUES ('$session_id', '" .$this->customer->getId() ."', '0', '"  .time() ."', IFNULL(INET_ATON('" . addslashes($_SERVER['REMOTE_ADDR']) . "'), 0), '$board')");
		}

		$_SESSION['log_time'] = time();

		if (empty($_SESSION['timeOnlineUpdated']))
			$_SESSION['timeOnlineUpdated'] = time();
	}
	
	function helpful ($id_msg) {
		$id_msg = mysql_real_escape_string($id_msg);
		$this->db->query("INSERT INTO " .DB_PREFIX ."log_helpful (id_msg, id_member) VALUES ($id_msg, " .$this->customer->getId() .")");
		return true;
	}
	
	function getWords () {
		$res = $this->db->query("SELECT * FROM " .DB_PREFIX ."block_words");
		return $res->rows;
	}
	
	function blockUser ($msg) {
		if (is_numeric($msg)) {
			$this->db->query("UPDATE " .DB_PREFIX ."customer AS u, " .DB_PREFIX."messages AS m SET u.banned = 1 WHERE u.customer_id = m.id_member AND m.id_msg = $msg");
			return true;
		}
	}
	
	function removePost ($msg) {
		if (is_numeric($msg)) {
			$this->db->query("UPDATE " .DB_PREFIX ."customer AS u, " .DB_PREFIX."messages AS m SET u.posts = u.posts -1 WHERE u.customer_id = m.id_member AND m.id_msg = $msg");
			//$this->db->query("UPDATE " .DB_PREFIX ."boards AS b, " .DB_PREFIX."messages AS m SET b.num_posts = b.num_posts -1 WHERE b.id_member = m.id_member AND m.id_msg = $msg");
			$this->db->query("DELETE FROM " .DB_PREFIX ."messages WHERE id_msg = $msg");
			$this->db->query("DELETE FROM " .DB_PREFIX ."log_helpful WHERE id_msg = $msg");
			return true;
		}
	}
	
	function removeTopic ($topic) {
		if (!is_numeric($topic)) return false;
		$data = $this->getTopicInfo($topic);
		$this->db->query("DELETE FROM " .DB_PREFIX ."messages WHERE id_topic = $topic");
		$this->db->query("DELETE FROM " .DB_PREFIX ."topics WHERE id_topic = $topic");
		return true;
	}
	
	function getTotalOnline () {
		$res = $this->db->query("SELECT COUNT('id_member') AS online FROM " .DB_PREFIX ."log_online");
		return $res->row['online'];
	}
	
	function permissionCheck () {
		if ($this->customer->isBanned()) {
		$res = array('reply' => 'failed', 'reason' => 'You has been banned from this forum.');
		echo json_encode($res); exit();
		}
	}
}
?>