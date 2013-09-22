<?php

if(!class_exists('ModelMtaMtaScheme')) require_once(DIR_APPLICATION . 'model/mta/mta_scheme.php');

class ModelMtaMtaProduct extends ModelMtaMtaScheme {
	
	public function moveFromScheme($from, $to, $mods=array("''"), $parent=false) {
		if(!mta_check_int($from) || !mta_check_int($to)) return false;
		if(($from && !$this->_checkId($from)) || ($to && !$this->_checkId($to))) return false;
		$tbl = DB_PREFIX . 'mta_product' . ($parent === true ? '' : '_affiliate');
		$query = "update $tbl set mta_scheme_id=" . ($to ? "'$to'" : "null") . " where mta_scheme_id" . ($from ? "='$from'" : " is null") . " and price_mod_type in (" . implode(',', $mods) . ")";
		$this->db->query($query);
		return $this->db->countAffected();
	}
	
	public function countUsers($scheme_id, $tbl = 'product') {		
		return $this->_countUsage($scheme_id, 'mta_scheme_id', $tbl);
	}
	
	public function countProductUsage($product_id, $tbl = 'product') {
		return $this->_countUsage($product_id, 'product_id', $tbl);
	}	
	
	public function getProductScheme($product_id) {				
		$res = $this->db->query("select mta_scheme_id from " . DB_PREFIX . "mta_product where product_id='" . $this->db->escape($product_id) . "' and price_mod_type=''");
		if($res->num_rows < 1) return false;
		$this->getSchemeById($res->row['mta_scheme_id']);
		if(!$this->scheme_id || !$this->scheme || isset($this->scheme['error'])) return false;
		return $this->scheme;
	}
	
	public function getProductName($product_id) {
		$res = $this->db->query("select `name` from " . DB_PREFIX . "product_description where product_id='$product_id'");
		if($res->rows < 1) return '';
		return $res->row['name'];
	}
	
	public function getAllProductSubSchemes($product_id) {
		$out = array();
		$res = $this->db->query("select price_mod_type as mtype, price_mod_id as mid, mta_scheme_id as scheme_id from " . DB_PREFIX . "mta_product where product_id='" . $this->db->escape($product_id) . "' and price_mod_type!='' order by price_mod_type");
		if($res->num_rows > 0) {
			foreach($res->rows as $r) {				
				$_k = strval($r['mid']);
				if(!isset($out[$r['mtype']])) $out[$r['mtype']] = array();
				$out[$r['mtype']][$_k] = $r['scheme_id'];				
			}
		}
		return $out;
	}
	
	public function unsetSubSchemes($product_id, $ids, $mod_type, $tbl = 'product') {
		if(!is_array($ids)) $ids = array($ids);		
		$this->db->query("delete from " . DB_PREFIX . "mta_{$tbl} where product_id='" . ((int) $product_id) . "' and price_mod_type='" . $this->db->escape($mod_type) . "' and price_mod_id in (" . implode(',', $ids) . ")");		
	}
	
	public function unsetProductScheme($product_id) {
		$this->db->query("delete from " . DB_PREFIX . "mta_product where product_id='" . ((int) $product_id) . "' and price_mod_type=''");
	}
	
	public function setProductScheme($product_id, $scheme_id) {
		$this->unsetProductScheme($product_id);
		$this->db->query("insert " . DB_PREFIX . "mta_product set product_id='" . ((int) $product_id) . "', set mta_scheme_id=" . ((int) $scheme_id) . "'");
	}

	public function setSubScheme($product_id, $id, $scheme_id, $mod_type) {		
		$this->unsetSubSchemes($product_id, $id, $mod_type);
		$this->db->query("insert " . DB_PREFIX . "mta_product set product_id='" . ((int) $product_id) . "', set mta_scheme_id=" . ((int) $scheme_id) . "', set price_mod_type='" . $this->db->escape($mod_type) . "', set price_mod_id='" . ((int) $id) . "'");	
	}
			
///////////////////////////
	protected function _countUsage($id, $id_field, $tbl = 'product') {
		$out = array();
		foreach(array('product','coupon','discount','special') as $k) {
			$out[$k] = 0;
		}				
		$tbl = DB_PREFIX . 'mta_' . $tbl;		
		$res = $this->db->query("select count(*) as c, price_mod_type as modt from $tbl where {$id_field}='" . $this->db->escape($id) . "' group by price_mod_type");
		if($res->num_rows < 1) return $out;
		foreach($res->rows as $r) {
			$r['modt'] = str_replace(DB_PREFIX . 'mta_', '', $tbl) . ($r['modt'] == '' ? '' : '_' . $r['modt']); 
			$out[$r['modt']] = $r['c'];
		}
		return $out;
	}

	
	
}