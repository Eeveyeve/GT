<?php

class ModelSaleAccountCombine extends Model {

	public function addCustomerFromAffiliate($data, $add_link = true) {
		if(!is_array($data)) {
			if(preg_match("/^\d+$/", $data)) {
				$_q = "SELECT * FROM  " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int) $data . "'";
			} else {
				$_q = "SELECT * FROM  " . DB_PREFIX . "affiliate WHERE email = '" . $this->db->escape($data) . "'";
			}			
			$_res = $this->db->query($_q);
			if($_res->num_rows < 1) return false;
			$data = $_res->row;			
		} else if(!isset($data['email'])) {
			return false;
		}
		$data['customer_group_id'] = $this->config->get('config_customer_group_id');
		$data['status'] = '1';
		$data['newsletter'] = '0';
		$data['address'] = array(
			array(
			'company_id' => '',
			'tax_id' => $data['tax'],
			'default' => true
			)
		);
		foreach(array('firstname', 'lastname', 'company', 'address_1', 'address_2', 'city', 'postcode', 'country_id', 'zone_id') as $_f) {
			$data['address'][0][$_f] = $data[$_f];
		}
		$this->load->model('sale/customer');
		$this->model_sale_customer->addCustomer($data);
		$customer = $this->model_sale_customer->getCustomerByEmail($data['email']);
		if(!$customer || !sizeof($customer)) return false;
		$this->db->query("update " . DB_PREFIX . "customer set password='" . $this->db->escape($data['password']) . (VERSION >= '1.5.4' ? "', salt='" . $this->db->escape($data['salt']) : '') . "', approved='1' where customer_id='" . (int) $customer['customer_id'] . "'");
		if($add_link) $this->linkCustomerAffiliate($customer['customer_id'], $data['affiliate_id']);
		return $customer['customer_id'];
	}
	
	public function linkCustomerAffiliate($customer_id, $affiliate_id) {
		$this->db->query("INSERT IGNORE INTO " . DB_PREFIX . "accc_customer_affiliate (customer_id, affiliate_id) VALUES ('" . (int)$customer_id . "', '" . (int)$affiliate_id . "')");	
	}
	
	public function getAffiliateIdByCustomerId($customer_id) {
		$_res = $this->db->query("SELECT affiliate_id FROM " . DB_PREFIX . "accc_customer_affiliate WHERE customer_id = '" . (int)$customer_id . "'");
		if($_res->num_rows < 1) return false;
		return $_res->row['affiliate_id'];
	}

}