<?php  
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_title'));

   $this->load->model('catalog/product');
		
		$this->load->model('tool/image');
    
    $this->language->load('common/home');
    
    // Categories
		$this->load->model('catalog/category');
		
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
		
    //$this->session->data['session_filtering'] = array();
    
    if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
			 
  	if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
      $this->session->data['session_filtering']['page'] = $this->request->get['page'];
    } else if (isset($this->session->data['session_filtering']['page'])) {
			$page = $this->session->data['session_filtering']['page'];
		} else {
			$page = 1;
		}
		
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
      $this->session->data['session_filtering']['limit'] = $this->request->get['limit'];
    } else if (isset($this->session->data['session_filtering']['limit'])) {
			$limit = $this->session->data['session_filtering']['limit'];  
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}
    
    if (isset($this->request->get['filter_manufacturer_id'])) {
			$filter_manufacturer_id = $this->request->get['filter_manufacturer_id'];
      $this->session->data['session_filtering']['filter_manufacturer_id'] = $this->request->get['filter_manufacturer_id'];
    } else if (isset($this->session->data['session_filtering']['filter_manufacturer_id'])) {
			$filter_manufacturer_id = $this->session->data['session_filtering']['filter_manufacturer_id'];  
		} else {
			$filter_manufacturer_id = "";
		}
    
    if (isset($this->request->get['filter_category_id'])) {
			$filter_category_id = $this->request->get['filter_category_id'];
      $this->session->data['session_filtering']['filter_category_id'] = $this->request->get['filter_category_id'];
    } else if (isset($this->session->data['session_filtering']['filter_category_id'])) {
			$filter_category_id = $this->session->data['session_filtering']['filter_category_id'];  
		} else {
			$filter_category_id = "";
		}
    
    if (isset($this->request->get['filter_special'])) {
			$filter_special = $this->request->get['filter_special'];
      $this->session->data['session_filtering']['filter_special'] = $this->request->get['filter_special'];
    } else if (isset($this->session->data['session_filtering']['filter_special'])) {
			$filter_special = $this->session->data['session_filtering']['filter_special'];  
		} else {
			$filter_special = "";
		}
    
    if (isset($this->request->get['filter_shown'])) {
			$filter_shown = $this->request->get['filter_shown'];
      $this->session->data['session_filtering']['filter_shown'] = $this->request->get['filter_shown'];
    } else if (isset($this->session->data['session_filtering']['filter_shown'])) {
			$filter_shown = $this->session->data['session_filtering']['filter_shown'];  
		} else {
			$filter_shown = "";
		}
    
    if (isset($this->request->get['filter_cheap'])) {
			$filter_cheap = $this->request->get['filter_cheap'];
      $this->session->data['session_filtering']['filter_cheap'] = $this->request->get['filter_cheap'];
    } else if (isset($this->session->data['session_filtering']['filter_cheap'])) {
			$filter_cheap = $this->session->data['session_filtering']['filter_cheap'];  
		} else {
			$filter_cheap = "";
		}
    
    if (isset($this->request->get['filter_preorder'])) {
			$filter_preorder = $this->request->get['filter_preorder'];
      $this->session->data['session_filtering']['filter_preorder'] = $this->request->get['filter_preorder'];
    } else if (isset($this->session->data['session_filtering']['filter_preorder'])) {
			$filter_preorder = $this->session->data['session_filtering']['filter_preorder'];  
		} else {
			$filter_preorder = "";
		}
    
    if (isset($this->request->get['filter_bestseller'])) {
			$filter_bestseller = $this->request->get['filter_bestseller'];
      $this->session->data['session_filtering']['filter_bestseller'] = $this->request->get['filter_bestseller'];
    } else if (isset($this->session->data['session_filtering']['filter_bestseller'])) {
			$filter_bestseller = $this->session->data['session_filtering']['filter_bestseller'];  
		} else {
			$filter_bestseller = "";
		}                                    
				    	
		$this->document->addScript('catalog/view/javascript/jquery/jquery.total-storage.min.js');

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			    'href'      => $this->url->link('common/home'),
      		'separator' => false
   		);

		$url = '';
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}	

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
				
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}	
		
		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
    
    if (isset($this->request->get['filter_manufacturer_id'])) {
			$url .= '&filter_manufacturer_id=' . $this->request->get['filter_manufacturer_id'];
		}
    
    if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
		}
    
    if (isset($this->request->get['filter_special'])) {
			$url .= '&filter_special=' . $this->request->get['filter_special'];
		}
    
    if (isset($this->request->get['filter_shown'])) {
			$url .= '&filter_shown=' . $this->request->get['filter_shown'];
		}
    
    if (isset($this->request->get['filter_cheap'])) {
			$url .= '&filter_cheap=' . $this->request->get['filter_cheap'];
		}
    
    if (isset($this->request->get['filter_preorder'])) {
			$url .= '&filter_preorder=' . $this->request->get['filter_preorder'];
		}
    
    if (isset($this->request->get['filter_bestseller'])) {
			$url .= '&filter_bestseller=' . $this->request->get['filter_bestseller'];
		}                                    
					
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			    'href'      => $this->url->link('common/home', $url),
      		'separator' => $this->language->get('text_separator')
   		);
		
    	$this->data['text_heading'] = $this->language->get('text_heading');
   
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_quantity'] = $this->language->get('text_quantity');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_model'] = $this->language->get('text_model');
		$this->data['text_price'] = $this->language->get('text_price');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_points'] = $this->language->get('text_points');
		$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$this->data['text_display'] = $this->language->get('text_display');
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_grid'] = $this->language->get('text_grid');		
		$this->data['text_sort'] = $this->language->get('text_sort');
		$this->data['text_limit'] = $this->language->get('text_limit');
    
    $this->data['text_showmore'] = $this->language->get('text_showmore');
    $this->data['text_nomore'] = $this->language->get('text_nomore');
    $this->data['text_loading'] = $this->language->get('text_loading');
    $this->data['text_select'] = $this->language->get('text_select');
    
    $this->data['text_reset_filters'] = $this->language->get('text_reset_filters');
    $this->data['text_reset_filters_title'] = $this->language->get('text_reset_filters_title');
    $this->data['text_all_products'] = $this->language->get('text_all_products');
    $this->data['text_bestsellers'] = $this->language->get('text_bestsellers');
    $this->data['text_specials'] = $this->language->get('text_specials');
    $this->data['text_preorders'] = $this->language->get('text_preorders');
    $this->data['text_byplatform'] = $this->language->get('text_byplatform');
    $this->data['text_bycategory'] = $this->language->get('text_bycategory');
    $this->data['text_under_twenty'] = $this->language->get('text_under_twenty');  

		$this->data['button_cart'] = $this->language->get('button_cart');	
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
    
    $protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on'
    ? 'https://'
    : 'http://';
    $this->session->data['fb_redirect_url'] = $this->url->link('common/home', '', 'SSL');
		
		$this->data['compare'] = $this->url->link('product/compare');
		
		$this->data['products'] = array();
    
    /*$data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * $limit,
			'limit' => $limit,
      'filter_manufacturer_id' => $filter_manufacturer_id,
      'filter_category_id' => $filter_category_id,
      'filter_special' => $filter_special,
      'filter_shown' => $filter_shown,
      'filter_cheap' => $filter_cheap,
      'filter_preorder' => $filter_preorder,
      'filter_bestseller' => $filter_bestseller                              
		);*/
    
    if (!isset($this->request->get['filtering']) && isset($this->session->data['session_filtering']['page'])) {
      $data = array(
  			'sort'  => 'p.date_added',
  			'order' => 'DESC',
  			/*'start' => 0,
  			'limit' => ($limit * $page),*/
        'start' => ($page - 1) * $limit,
  			'limit' => $limit,
        'filter_manufacturer_id' => $filter_manufacturer_id,
        'filter_category_id' => $filter_category_id,
        'filter_special' => $filter_special,
        'filter_shown' => $filter_shown,
        'filter_cheap' => $filter_cheap,
        'filter_preorder' => $filter_preorder,
        'filter_bestseller' => $filter_bestseller                              
  		);
		} else {
      $data = array(
  			'sort'  => 'p.date_added',
  			'order' => 'DESC',
  			'start' => ($page - 1) * $limit,
  			'limit' => $limit,
        'filter_manufacturer_id' => $filter_manufacturer_id,
        'filter_category_id' => $filter_category_id,
        'filter_special' => $filter_special,
        'filter_shown' => $filter_shown,
        'filter_cheap' => $filter_cheap,
        'filter_preorder' => $filter_preorder,
        'filter_bestseller' => $filter_bestseller                              
  		);
    }  
    	
		$product_total = $this->model_catalog_product->getTotalProducts($data);
    
    $results = $this->model_catalog_product->getProductsCatalog($data);
			
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$image = false;
			}
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
			
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}	
			
			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
			} else {
				$tax = false;
			}				
			
			if ($this->config->get('config_review_status')) {
				$rating = (int)$result['rating'];
			} else {
				$rating = false;
			}
      
      if ($result['os']) {
        $OS = $result['os'];
      }
      else {
        $OS = false;
      }
      
      if ($result['genre']) {
        $genre = $result['genre'];
      }
      else {
        $genre = false;
      }
      
      if ($result['date_available']) {
        $date_available = $result['date_available'];
      }
      else {
        $date_available = false;
      }
      
      if ($result['special'] != "" || $result['special'] != 0) {
        $saving = -round((($result['price'] - $result['special'])/$result['price'])*100, 0);
      }
      else {
        $saving = 0;
      }
      
      $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($result['manufacturer_id']);
      $manufacturer_name = $manufacturer_info['name'];  
            			
			$this->data['products'][] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'name'        => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
        'short_description' => sprintf($this->language->get('text_short_description'), (string)date($this->language->get('date_format_3'), strtotime($date_available))),
        'manufacturer'=> $manufacturer_name,
        'OS'          => $OS,
				'price'       => $price,
				'special'     => $special,
        'saving'	    => $saving,
				'tax'         => $tax,
				'rating'      => $result['rating'],
				'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
			);
		}

		$url = '';

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
			
		$this->data['sorts'] = array();
		
		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_default'),
			'value' => 'p.sort_order-ASC',
			'href'  => $this->url->link('common/home', 'sort=p.sort_order&order=ASC' . $url)
		);
		
		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_name_asc'),
			'value' => 'pd.name-ASC',
			'href'  => $this->url->link('common/home', 'sort=pd.name&order=ASC' . $url)
		); 

		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_name_desc'),
			'value' => 'pd.name-DESC',
			'href'  => $this->url->link('common/home', 'sort=pd.name&order=DESC' . $url)
		);  

		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_price_asc'),
			'value' => 'ps.price-ASC',
			'href'  => $this->url->link('common/home', 'sort=ps.price&order=ASC' . $url)
		); 

		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_price_desc'),
			'value' => 'ps.price-DESC',
			'href'  => $this->url->link('common/home', 'sort=ps.price&order=DESC' . $url)
		); 
		
		if ($this->config->get('config_review_status')) {	
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_rating_desc'),
				'value' => 'rating-DESC',
				'href'  => $this->url->link('common/home', 'sort=rating&order=DESC' . $url)
			); 
				
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_rating_asc'),
				'value' => 'rating-ASC',
				'href'  => $this->url->link('common/home', 'sort=rating&order=ASC' . $url)
			);
		}
		
		$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('common/home', 'sort=p.model&order=ASC' . $url)
		); 

		$this->data['sorts'][] = array(
			'text'  => $this->language->get('text_model_desc'),
			'value' => 'p.model-DESC',
			'href'  => $this->url->link('common/home', 'sort=p.model&order=DESC' . $url)
		);
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}	

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
    
    if (isset($this->request->get['filter_manufacturer_id'])) {
			$url .= '&filter_manufacturer_id=' . $this->request->get['filter_manufacturer_id'];
		}
    
    if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
		}
    
    if (isset($this->request->get['filter_special'])) {
			$url .= '&filter_special=' . $this->request->get['filter_special'];
		}
    
    if (isset($this->request->get['filter_shown'])) {
			$url .= '&filter_shown=' . $this->request->get['filter_shown'];
		}
    
    if (isset($this->request->get['filter_cheap'])) {
			$url .= '&filter_cheap=' . $this->request->get['filter_cheap'];
		}
    
    if (isset($this->request->get['filter_preorder'])) {
			$url .= '&filter_preorder=' . $this->request->get['filter_preorder'];
		}
    
    if (isset($this->request->get['filter_bestseller'])) {
			$url .= '&filter_bestseller=' . $this->request->get['filter_bestseller'];
		}                                    
									
		$this->data['limits'] = array();

		$limits = array_unique(array($this->config->get('config_catalog_limit'), 25, 50, 75, 100));
		
		sort($limits);

		foreach($limits as $limits){
			$this->data['limits'][] = array(
				'text'  => $limits,
				'value' => $limits,
        'href'  => $this->url->link('common/home', $url . '&limit=' . $limits)
				//'href'  => $url . '&limit=' . $limits
			);
		}
			
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}	

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
    
    if (isset($this->request->get['filter_manufacturer_id'])) {
			$url .= '&filter_manufacturer_id=' . $this->request->get['filter_manufacturer_id'];
		}
    
    if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
		}
    
    if (isset($this->request->get['filter_special'])) {
			$url .= '&filter_special=' . $this->request->get['filter_special'];
		}
    
    if (isset($this->request->get['filter_shown'])) {
			$url .= '&filter_shown=' . $this->request->get['filter_shown'];
		}
    
    if (isset($this->request->get['filter_cheap'])) {
			$url .= '&filter_cheap=' . $this->request->get['filter_cheap'];
		}
    
    if (isset($this->request->get['filter_preorder'])) {
			$url .= '&filter_preorder=' . $this->request->get['filter_preorder'];
		}
    
    if (isset($this->request->get['filter_bestseller'])) {
			$url .= '&filter_bestseller=' . $this->request->get['filter_bestseller'];
		}                                    
						
		$pagination = new loadPagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('common/home', $url . '&page={page}');
			
		$this->data['pagination'] = $pagination->render();
			
		$this->data['page'] = $page;
    $this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['limit'] = $limit;
    $this->data['filter_manufacturer_id'] = $filter_manufacturer_id;
    $this->data['filter_category_id'] = $filter_category_id;
    $this->data['filter_special'] = $filter_special;
    $this->data['filter_shown'] = $filter_shown;
    $this->data['filter_cheap'] = $filter_cheap;
    $this->data['filter_preorder'] = $filter_preorder;
    $this->data['filter_bestseller'] = $filter_bestseller;                    
    
    $this->data['home_link'] = $this->url->link('common/home');
  
		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->data['heading_title'] = $this->config->get('config_title');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/home.tpl';
		} else {
			$this->template = 'default/template/common/home.tpl';
		}
		
		$this->children = array(

			'common/position_slider',
			'common/position_banner',      
      
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
										
		$this->response->setOutput($this->render());
	}
}
?>