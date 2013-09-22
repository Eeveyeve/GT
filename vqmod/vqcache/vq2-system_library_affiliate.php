<?php
class Affiliate {
	private $affiliate_id;
	private $firstname;
	private $lastname;
	private $email;
	private $telephone;
	private $fax;
	private $code;
	
  	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
				
		if (isset($this->session->data['affiliate_id'])) { 
			$affiliate_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int)$this->session->data['affiliate_id'] . "' AND status = '1'");
			
			if ($affiliate_query->num_rows) {
				$this->affiliate_id = $affiliate_query->row['affiliate_id'];
				$this->firstname = $affiliate_query->row['firstname'];
				$this->lastname = $affiliate_query->row['lastname'];
				$this->email = $affiliate_query->row['email'];
				$this->telephone = $affiliate_query->row['telephone'];
				$this->fax = $affiliate_query->row['fax'];
				$this->code = $affiliate_query->row['code'];
							
      			$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE affiliate_id = '" . (int)$this->session->data['affiliate_id'] . "'");
			} else {
				$this->logout();
			}
  		}
	}
		
  	public function login($email, $password, $customer_id=false) {//+mod by yp 

		//+mod by yp start
		if(!$email && !$password && !$customer_id) return false;
		if($customer_id !== false && preg_match("/^\d+$/", $customer_id)) {
			$affiliate_query = $this->db->query("SELECT " . DB_PREFIX . "affiliate.* FROM " . DB_PREFIX . "affiliate, " . DB_PREFIX . "accc_customer_affiliate WHERE " . DB_PREFIX . "accc_customer_affiliate.affiliate_id=" . DB_PREFIX . "affiliate.affiliate_id AND " . DB_PREFIX . "accc_customer_affiliate.customer_id = '" . (int) $customer_id . "' AND " . DB_PREFIX . "affiliate.status = '1' AND " . DB_PREFIX . "affiliate.approved = '1' LIMIT 1");
		} else {
		//+mod by yp end

		$affiliate_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1' AND approved = '1'");
		

}//+mod by yp

		if ($affiliate_query->num_rows) {
			$this->session->data['affiliate_id'] = $affiliate_query->row['affiliate_id'];	
		    
			$this->affiliate_id = $affiliate_query->row['affiliate_id'];
			$this->firstname = $affiliate_query->row['firstname'];
			$this->lastname = $affiliate_query->row['lastname'];
			$this->email = $affiliate_query->row['email'];
			$this->telephone = $affiliate_query->row['telephone'];
			$this->fax = $affiliate_query->row['fax'];
      		$this->code = $affiliate_query->row['code'];
	  
	  		return true;
    	} else {
      		return false;
    	}
  	}
  
  	public function logout() {
		unset($this->session->data['affiliate_id']);

		$this->affiliate_id = '';
		$this->firstname = '';
		$this->lastname = '';
		$this->email = '';
		$this->telephone = '';
		$this->fax = '';
  	}
  
  	public function isLogged() {
    	return $this->affiliate_id;
  	}

  	public function getId() {
    	return $this->affiliate_id;
  	}
      
  	public function getFirstName() {
		return $this->firstname;
  	}
  
  	public function getLastName() {
		return $this->lastname;
  	}
  
  	public function getEmail() {
		return $this->email;
  	}
  
  	public function getTelephone() {
		return $this->telephone;
  	}
  
  	public function getFax() {
		return $this->fax;
  	}
	
  	public function getCode() {
		return $this->code;
  	}	
}
?>