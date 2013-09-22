<?php
class ModelCommunityGeneral extends Model {
	
	function addBoard ($data) {
		$name = mysql_real_escape_string($data['board_description'][1]['name']);
		$order = $data['board_description'][1]['order'];
		$etiq = mysql_real_escape_string($data['board_description'][1]['etiquette']);
		$this->db->query("INSERT INTO " .DB_PREFIX ."boards (board_order, name, etiquette) VALUES ('$order', '$name', '$etiq')");
		return true;
	}
	
	function getBoard ($id_board) {
		$res = $this->db->query("SELECT * FROM " .DB_PREFIX ."boards WHERE id_board = $id_board");
		return $res->row;
	}
	
	function editBoard ($data) {
		$id_board = $this->request->get['id_board'];
		$name = mysql_real_escape_string($data['board_description'][1]['name']);
		$order = $data['board_description'][1]['order'];
		$etiq = mysql_real_escape_string($data['board_description'][1]['etiquette']);
		$this->db->query("UPDATE " .DB_PREFIX ."boards SET board_order = '$order', name = '$name', etiquette = '$etiq' WHERE id_board = $id_board");
		return true;
	}
	
	function deleteBoard ($id_board) {
		$this->db->query("DELETE FROM " .DB_PREFIX ."boards WHERE id_board = $id_board");
		return true;
	}
	
	function addWord ($data) {
		$word = mysql_real_escape_string($data['settings_description'][1]['word']);
		$this->db->query("INSERT INTO " .DB_PREFIX ."block_words (block_word) VALUES ('$word')");
		return true;
	}
	
	function getWords () {
		$res = $this->db->query("SELECT * FROM " .DB_PREFIX ."block_words");
		return $res->rows;
	}
	
	function deleteWord ($data) {
		$this->db->query("DELETE FROM " .DB_PREFIX ."block_words WHERE id = $data");
		return true;
	}
	
	function getBoards () {
		$res = $this->db->query("SELECT * FROM " .DB_PREFIX ."boards ORDER BY board_order ASC");
		foreach ($res->rows as $board) {
			$board['action'][] = array('href' => $this->url->link('community/boards/edit', 'token=' . $this->session->data['token'] .'&id_board=' .$board['id_board'], 'SSL'));
			$boards[] = $board;
		}
		return $boards;
	}
}
?>