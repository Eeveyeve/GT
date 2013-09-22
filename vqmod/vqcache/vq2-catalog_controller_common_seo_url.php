<?php
class ControllerCommonSeoUrl extends Controller {
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		// Decode URL
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);
			
			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
				
				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);
					
					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}
					
					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}	
					
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}
					
					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}	
				} else {
					$this->request->get['route'] = 'error/not_found';	
				}
			}
			
			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			}
			
			if (isset($this->request->get['route'])) {
				return $this->forward($this->request->get['route']);
			}
		}
	}
	
	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));
	
		$url = ''; 
		
		$data = array();
		
		parse_str($url_info['query'], $data);
		
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
				
					if ($query->num_rows) {
						$url .= '/' . $query->row['keyword'];
						
						unset($data[$key]);
					}					
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
					
					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
				
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
						}							
					}
					
					unset($data[$key]);
				}
			}
		}
	
		if ($url) {
			unset($data['route']);
		
			$query = '';
		
			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . $key . '=' . $value;
				}
				
				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {

  $link = str_replace('/index.php?route=common/home&', '?', $link);
  $link = str_replace('/index.php?route=common/home', '', $link);
  $link = str_replace('/index.php?route=account/register&', '/register?', $link);
  $link = str_replace('/index.php?route=community/topic', '/community-topic', $link);
  $link = str_replace('/index.php?route=community/topic&', '/community-topic?', $link);
  $link = str_replace('/index.php?route=community/community', '/community', $link);
  $link = str_replace('/index.php?route=community/community&', '/community?', $link);
  $link = str_replace('/index.php?route=product/reviews', '/reviews', $link);
  $link = str_replace('/index.php?route=account/voucher', '/gift', $link);
  $link = str_replace('/index.php?route=information/contact&', '/contact?', $link);
  $link = str_replace('/index.php?route=information/contact', '/contact', $link);  
  $link = str_replace('/index.php?route=information/affiliate&amp;information_id=7', '/reseller', $link);
  $link = str_replace('/index.php?route=product/latest&', '/latest?', $link);
  $link = str_replace('/index.php?route=product/latest', '/latest', $link);
  $link = str_replace('/index.php?route=product/special&', '/specials?', $link);
  $link = str_replace('/index.php?route=product/special', '/specials', $link);
  $link = str_replace('/index.php?route=checkout/cart&', '/cart?', $link);
  $link = str_replace('/index.php?route=checkout/cart', '/cart', $link);
  $link = str_replace('/index.php?route=checkout/success&', '/checkout-success?', $link);
  $link = str_replace('/index.php?route=checkout/success', '/checkout-success', $link);
  $link = str_replace('/index.php?route=checkout/checkout&', '/checkout?', $link);
  $link = str_replace('/index.php?route=checkout/checkout', '/checkout', $link);
  $link = str_replace('/index.php?route=account/account&', '/account?', $link);
  $link = str_replace('/index.php?route=account/account', '/account', $link);
  $link = str_replace('/index.php?route=account/login&', '/login?', $link);
  $link = str_replace('/index.php?route=account/login', '/login', $link);
  $link = str_replace('/index.php?route=account/register&', '/register?', $link);
  $link = str_replace('/index.php?route=account/register', '/register', $link);
  $link = str_replace('/index.php?route=account/wishlist', '/wishlist', $link);
  $link = str_replace('/index.php?route=account/newsletter', '/newsletter', $link);
  $link = str_replace('/index.php?route=module/currency', '/currency', $link);
  $link = str_replace('/index.php?route=account/forgotten', '/forgotten', $link);
  $link = str_replace('/index.php?route=affiliate/login', '/mystore-login', $link);
  $link = str_replace('/index.php?route=affiliate/account_combine&', '/affiliate?', $link);
  $link = str_replace('/index.php?route=affiliate/account_combine', '/affiliate', $link);
  $link = str_replace('/index.php?route=affiliate/account', '/mystore', $link);
  $link = str_replace('/index.php?route=product/manufacturer', '/brands', $link);
  $link = str_replace('/index.php?route=account/return/insert', '/returns', $link);
  $link = str_replace('/index.php?route=information/sitemap', '/sitemap', $link);
  
  $link = str_replace('?amp;', '?', $link);
  
			return $link;
		}
	}	
}
?>