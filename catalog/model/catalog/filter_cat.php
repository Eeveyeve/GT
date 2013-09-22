<?php
class ModelCatalogFilterCat extends Model {
    
    public function getAttributeDescriptions($attribute_id) {
		$attribute_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "attribute_description WHERE attribute_id = '" . (int)$attribute_id . "'");
		
		foreach ($query->rows as $result) {
			$attribute_data[$result['language_id']] = array('name' => $result['name']);
		}
		
		return $attribute_data;
	}
    
    public function getCategories($id = 0, $type = 'by_parent') {
		static $data = null;

		if ($data === null) {
			$data = array();

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1' ORDER BY c.parent_id, c.sort_order, cd.name");

			foreach ($query->rows as $row) {
				$data['by_id'][$row['category_id']] = $row;
				$data['by_parent'][$row['parent_id']][] = $row;
			}
		}

		return ((isset($data[$type]) && isset($data[$type][$id])) ? $data[$type][$id] : array());
	}
    
    public function getCategoriesByParentId($category_id) {
		$category_data = array();

		$categories = $this->getCategories((int)$category_id);

		foreach ($categories as $category) {
			$category_data[] = $category['category_id'];

			/*$children = $this->getCategoriesByParentId($category['category_id']);

			if ($children) {
				$category_data = array_merge($children, $category_data);
			}*/
		}

		return $category_data;
	}
    
    public function getAttribute($attribute_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '". $attribute_id."' AND language_id = '".(int)$this->config->get('config_language_id')."'");
        
        return $query->rows;
    }
    
    public function getAttributeForManufactured($product_id) {
        $query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '". $product_id . "' AND language_id = '".(int)$this->config->get('config_language_id')."'");
        
        return $query->rows;
    }
    
    public function getCategoriesForManufactured($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
        
        return $query->rows;
    }
    
    public function getPriceFilter() {
        $prices = array();
        $query = $this->db->query("SELECT MIN(price) FROM ". DB_PREFIX ."product WHERE status = '1'");
        $prices['min'] = $query->row['MIN(price)'];
        $query = $this->db->query("SELECT MAX(price) FROM ". DB_PREFIX ."product WHERE status = '1'");
        $prices['max'] = $query->row['MAX(price)'];
        return $prices;
    }
    
    public function getFilterProduct($data) {
        if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
        
        $sql = "SELECT DISTINCT p.product_id";
        if(!empty($data['filterAtr'])){
            $sql .= ", pa.text";
        }
        $sql .= ",(SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating";
        $sql .= " FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)"; 
        
        if($data['filterSpecial']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id)";
        }
        
        
        
        if($data['filterCat']){
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
        }
        
        if(!empty($data['filterAtr'])){
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute pa ON (p.product_id = pa.product_id)";
        }
        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' /*AND p.date_available <= NOW()*/ AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        
        if($data['filterSearch']) {
            $sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filterSearch'])) . "%')";
        }
        
        if(!empty($data['filterCats'])) {
            $implode_data = array();
            $this->load->model('catalog/category');
            foreach($data['filterCats'] as $c){
                $implode_data[] = "p2c.category_id = '" . (int)$c . "'";
                $categories = $this->model_catalog_category->getCategoriesByParentId($c);
                foreach ($categories as $category_id) {
    						$implode_data[] = "p2c.category_id = '" . (int)$category_id . "'";
    					}
                
                	
            }  
            $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
        
        } else {
            if(!empty($data['filterCat'])){
                $implode_data = array();
                $this->load->model('catalog/category');
                foreach($data['filterCat'] as $c){
                    $implode_data[] = "p2c.category_id = '" . (int)$c . "'";
                    $categories = $this->model_catalog_category->getCategoriesByParentId($c);
                    foreach ($categories as $category_id) {
        						$implode_data[] = "p2c.category_id = '" . (int)$category_id . "'";
        					}
                    
                    	
                }  
                $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
                 
            }
        }
        
        
        if(!empty($data['filterAtr'])){
            $implode_data_id = array();
            $implode_data_text = array();
            foreach($data['filterAtr'] as $value){
                $implode_data_text[] = "pa.text = '".$value['value']."'";
                $implode_data_id[] = "pa.attribute_id = '".$value['id']."'";
            }
            $sql .= " AND (" . implode(' OR ', $implode_data_id) . ")";
            $sql .= " AND (" . implode(' OR ', $implode_data_text) . ")";
            $sql .= " AND pa.language_id = '".(int)$this->config->get('config_language_id')."'";
        }
        if(!empty($data['filterMan'])){
            $implode_data = array();
            foreach($data['filterMan'] as $m){
                $implode_data[] = "p.manufacturer_id = '".(int)$m."'";
            }
            $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
        }
        
        if($data['filterSpecial']) {
            $sql .= " AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))";
        }
        
        $sql .= " AND p.price >= '".$data['filterPmin']."' AND p.price <= '".$data['filterPmax']."'";
        
        $sql .= " ORDER BY ".$data['filterSort'];
        
        $sql .= " ".$data['filterOrder'].", LCASE(pd.name) ".$data['filterOrder'];
        
        $sql .= " LIMIT " . (int)$data['filterStart'] . "," . (int)$data['filterLimit'];
        
        
        $query = $this->db->query($sql);
        
        return $query->rows; 
        
        
    }
    
    public function getTotalFilterProduct($data) {
        $sql = "SELECT COUNT(DISTINCT p.product_id) AS total";
        if(!empty($data['filterAtr'])){
            $sql .= ", pa.text";
        }
        
        $sql .= " FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)"; 
        
        if($data['filterCat']){
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
        }
        if(!empty($data['filterAtr'])){
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute pa ON (p.product_id = pa.product_id)";
        }
        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' /*AND p.date_available <= NOW()*/ AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        
        if(!empty($data['filterCat'])){
            $implode_data = array();
            $this->load->model('catalog/category');
            foreach($data['filterCat'] as $c){
                $implode_data[] = "p2c.category_id = '" . (int)$c . "'";
                $categories = $this->model_catalog_category->getCategoriesByParentId($c);
                foreach ($categories as $category_id) {
    						$implode_data[] = "p2c.category_id = '" . (int)$category_id . "'";
    					}
                
                	
            }  
            $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
             
        }
        if(!empty($data['filterAtr'])){
            $implode_data_id = array();
            $implode_data_text = array();
            foreach($data['filterAtr'] as $value){
                $implode_data_text[] = "pa.text = '".$value['value']."'";
                $implode_data_id[] = "pa.attribute_id = '".$value['id']."'";
            }
            $sql .= " AND (" . implode(' OR ', $implode_data_id) . ")";
            $sql .= " AND (" . implode(' OR ', $implode_data_text) . ")";
            $sql .= " AND pa.language_id = '".(int)$this->config->get('config_language_id')."'";
        }
        if(!empty($data['filterMan'])){
            $implode_data = array();
            foreach($data['filterMan'] as $m){
                $implode_data[] = "p.manufacturer_id = '".(int)$m."'";
            }
            $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
        }
        
        $sql .= " AND p.price >= '".$data['filterPmin']."' AND p.price <= '".$data['filterPmax']."'";
        
        
        
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];  
        
        
    }
    
    
}


?>