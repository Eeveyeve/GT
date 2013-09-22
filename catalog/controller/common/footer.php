<?php  
class ControllerCommonFooter extends Controller {
	protected function index() {
		$this->language->load('common/footer');
		
		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_service'] = $this->language->get('text_service');
		$this->data['text_extra'] = $this->language->get('text_extra');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_return'] = $this->language->get('text_return');
    	$this->data['text_sitemap'] = $this->language->get('text_sitemap');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
    
    $this->data['text_about'] = sprintf($this->language->get('text_about'), $this->config->get('config_name'));
    $this->data['text_delivery'] = $this->language->get('text_delivery');
    $this->data['text_privacy'] = $this->language->get('text_privacy');
    $this->data['text_conditions'] = $this->language->get('text_conditions');
    $this->data['text_resolution'] = $this->language->get('text_resolution');
    $this->data['text_community'] = $this->language->get('text_community');
    $this->data['text_live_support'] = $this->language->get('text_live_support');
    $this->data['text_reseller'] = $this->language->get('text_reseller');
		
		$this->load->model('catalog/information');
		
		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$this->data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
    	}

		$this->data['contact'] = $this->url->link('information/contact');
		$this->data['return'] = $this->url->link('account/return/insert', '', 'SSL');
    	$this->data['sitemap'] = $this->url->link('information/sitemap');
		$this->data['manufacturer'] = $this->url->link('product/manufacturer');
		$this->data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$this->data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$this->data['special'] = $this->url->link('product/special');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/account', '', 'SSL');
    
    $this->data['about'] = $this->url->link('information/information', 'information_id=4');
    $this->data['resolution'] = $this->url->link('information/contact');
    $this->data['faq'] = $this->url->link('information/information', 'information_id=3');
    $this->data['community'] = $this->url->link('community/community');
    $this->data['live_support'] = $this->url->link('community/community', 'board=9');
    $this->data['reseller'] = $this->url->link('information/affiliate', 'information_id=7');		

		$this->data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));
		
		// Categories
		$this->load->model('catalog/category');
		
		$this->load->model('catalog/product');
		
		$this->data['categories'] = array();
					
		$categories = $this->model_catalog_category->getCategories(0);
		
		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();
				
				$children = $this->model_catalog_category->getCategories($category['category_id']);
				
				foreach ($children as $child) {
					$data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);
					
					$product_total = $this->model_catalog_product->getTotalProducts($data);
									
					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);						
				}
				
				// Level 1
				$this->data['categories'][] = array(
					'name'       => $category['name'],
          'category_id'=> $category['category_id'],
					'children'   => $children_data,
					'column'     => $category['column'] ? $category['column'] : 1,
					'href'       => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}
    
    //Manufacturers
    $this->load->model('catalog/manufacturer');
    
    $this->data['manufacturers'] = array();
    
    $manufacturers = $this->model_catalog_manufacturer->getManufacturers();
    
    foreach ($manufacturers as $manufacturer) {				
			$this->data['manufacturers'][] = array(
				'name'       => $manufacturer['name'],
        'manufacturer_id'=> $manufacturer['manufacturer_id'],
				'href'       => $this->url->link('product/manufacturer', 'path=' . $manufacturer['manufacturer_id'])
			);
		}
    
    //Bestsellers
    
    $bestsellers = $this->model_catalog_product->getBestSellerProducts(6);
    
    foreach ($bestsellers as $bestseller) {
							
			$this->data['bestsellers'][] = array(
				'product_id' => $bestseller['product_id'],
				'name'    	 => $bestseller['name'],
				'href'    	 => $this->url->link('product/product', 'product_id=' . $bestseller['product_id']),
			);
		}
    
    //New Releases
    
    $newreleases = $this->model_catalog_product->getProductsCatalog(array('limit'=>'6','filter_preorder'=>'1'));
    
    foreach ($newreleases as $newrelease) {
							
			$this->data['newreleases'][] = array(
				'product_id' => $newrelease['product_id'],
				'name'    	 => $newrelease['name'],
				'href'    	 => $this->url->link('product/product', 'product_id=' . $newrelease['product_id']),
			);
		}
    
    // Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');
	
			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];	
			} else {
				$ip = ''; 
			}
			
			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];	
			} else {
				$url = '';
			}
			
			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];	
			} else {
				$referer = '';
			}
						
			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}		
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}
		
		$this->render();
	}
}
?>
