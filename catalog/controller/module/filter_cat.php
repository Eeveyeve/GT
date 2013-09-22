<?php  
class ControllerModuleFilterCat extends Controller {
	protected function index($setting) {
		static $module = 0;
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/filter_cat');
        $this->language->load('module/filter_cat');
        $options = $this->config->get('filter_cat_option');
        $this->data['text_allcat'] = $this->language->get('text_allcat');
        $this->data['text_brand'] = $this->language->get('text_brand');
        $this->data['text_priceof'] = $this->language->get('text_priceof');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_priceto'] = $this->language->get('text_priceto');
        $this->data['text_subcat'] = $this->language->get('text_subcat');
        if (isset($this->request->get['sort'])) {
			$this->data['sort'] = $this->request->get['sort'];
		} else {
			$this->data['sort'] = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$this->data['order'] = $this->request->get['order'];
		} else {
			$this->data['order'] = 'ASC';
		}
        
        $filter_view = false;
        $filter = array();
        
        
        $position_filter = $setting['position'];
        
        
		if (isset($this->request->get['path'])) {
            if($position_filter == 'column_left' or $position_filter == 'column_right') {
                $this->document->addScript('catalog/view/javascript/filter_cat.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat.css');
        		}
            } elseif ($position_filter == 'content_top' or $position_filter == 'content_bottom') {
                $this->document->addScript('catalog/view/javascript/filter_cat_horizontal.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat_horizontal.css');
        		}
            }
        
			$path = '';
		    $parts = explode('_', (string)$this->request->get['path']);
		    foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
			}		
		    $category_id = array_pop($parts);
            $this->data['category_id'] = $category_id;
            $cat_data = $this->model_catalog_category->getCategory($category_id);
            if(isset($options[$category_id])){
                $filter_view = true;
                $filter['cat_id'] = $options[$category_id]['cat_id'];
                $filter['sub'] = $options[$category_id]['sub'];   
                $filter['brand'] = $options[$category_id]['brand'];   
                $filter['price'] = $options[$category_id]['price'];   
                $filter['attribute_id'] = $options[$category_id]['attribute_id'];       
            } elseif(isset($options[$cat_data['parent_id']])) {
                $filter_view = true;
                $filter['cat_id'] = $options[$cat_data['parent_id']]['cat_id'];
                $filter['sub'] = $options[$cat_data['parent_id']]['sub'];   
                $filter['brand'] = $options[$cat_data['parent_id']]['brand'];   
                $filter['price'] = $options[$cat_data['parent_id']]['price'];   
                $filter['attribute_id'] = $options[$cat_data['parent_id']]['attribute_id'];     
            } elseif(isset($options[0])) {
                $filter_view = true;
                $filter['cat_id'] = $options[0]['cat_id'];
                $filter['sub'] = $options[0]['sub'];   
                $filter['brand'] = $options[0]['brand'];   
                $filter['price'] = $options[0]['price'];   
                $filter['attribute_id'] = $options[0]['attribute_id'];     
            } else {
                $filter_view = false;
                $filter['cat_id'] = 0;
                $filter['sub'] = 0;   
                $filter['brand'] = 0;   
                $filter['price'] = 0;   
                $filter['attribute_id'] = array();     
            }
            $data = array('filter_category_id' => $category_id);
            $products = $this->model_catalog_product->getProducts($data);
            $products_id = array();
            $afps = array();
            if(empty($products)) {
                $filter_view = false;
                
            } else {
                foreach($products as $key=>$val) {
                    $afp = $this->model_catalog_filter_cat->getAttributeForManufactured($key);
                    foreach($afp as $val){
                        $afps[] = $val['attribute_id'];
                    }
                    $products_id[] = $key;
                }
                $afps = array_unique($afps);
            }
            $this->data['categories'] = array();
            if($filter['sub']) 
            {
                $results = $this->model_catalog_category->getCategories($category_id);
                foreach ($results as $result) {
                    $this->data['categories'][] = array(
    					'name'  => $result['name'],
    					'id' => $result['category_id']
    				);
                }
                if(empty($results)) {
                    $filter['sub'] = 0;
                }
            }
            $this->data['manufacturers'] = array();
            if($filter['brand']) {
                foreach($products as $product) {
                    if($product['manufacturer_id']){
                        $this->data['manufacturers'][$product['manufacturer_id']] = array(
                            'name' => $product['manufacturer'],
                            'id' => $product['manufacturer_id']
                        );
                    }
                }
                if(empty($products) or empty($this->data['manufacturers'])) {
                    $filter['brand'] = 0;
                }
            }
            $this->data['atributes'] = array();
            if(!empty($filter['attribute_id'])){
                foreach($filter['attribute_id'] as $key=>$value) {
                    if(in_array($value, $afps)) {
                    $atribut_data = $this->model_catalog_filter_cat->getAttributeDescriptions($value);
                    $this->data['atributes'][$key]['name'] = $atribut_data[$this->config->get('config_language_id')]['name'];
                    $this->data['atributes'][$key]['id'] = $value;
                    foreach($this->model_catalog_filter_cat->getAttribute($value) as $val) {
                        if(in_array($val['product_id'],$products_id)) {
                        $this->data['atributes'][$key]['values'][] = $val['text'];
                        }
                    }
                    }   
                }
            }
            foreach($this->data['atributes'] as $key=>$val){
                $this->data['atributes'][$key]['values'] = array_unique($this->data['atributes'][$key]['values']);
            }
            $this->data['prices'] = array();
            if($filter['price']){
                $this->data['prices'] = $this->model_catalog_filter_cat->getPriceFilter();
            }
            $this->data['special'] = false;
            $this->data['search'] = false;
            
            
        } elseif(isset($this->request->get['manufacturer_id'])) {
            if($position_filter == 'column_left' or $position_filter == 'column_right') {
                $this->document->addScript('catalog/view/javascript/filter_cat.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat.css');
        		}
            } elseif ($position_filter == 'content_top' or $position_filter == 'content_bottom') {
                $this->document->addScript('catalog/view/javascript/filter_cat_horizontal.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat_horizontal.css');
        		}
            }
            
            $manufacturer_id = $this->request->get['manufacturer_id'];
			$options = $this->config->get('filter_cat_manufacturer');	
		    $category_id = 0;
            $this->data['category_id'] = $category_id;
            
            
                $filter_view = true;
                $filter['cat_id'] = $category_id;
                $filter['sub'] = true;   
                $filter['brand'] = false;   
                $filter['price'] = $options['price'];   
                $filter['attribute_id'] = $options['attribute_id'];    
                $this->load->model('catalog/manufacturer');
                $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);   
                $this->data['m_name'] = $manufacturer_info['name'];
            
            $data = array('filter_manufacturer_id' => $manufacturer_id);
            $products = $this->model_catalog_product->getProducts($data);
            $products_id = array();
            $afps = array();
            if(empty($products)) {
                $filter_view = false;
                
            } else {
                foreach($products as $key=>$val) {
                    $afp = $this->model_catalog_filter_cat->getAttributeForManufactured($key);
                    foreach($afp as $val){
                        $afps[] = $val['attribute_id'];
                    }
                    $products_id[] = $key;
                }
                $afps = array_unique($afps);
            }
            $this->data['categories'] = array();
            $catform = array();
            if($filter['sub']) 
            {
                foreach($products_id as $val) {
                $results = $this->model_catalog_filter_cat->getCategoriesForManufactured($val);
                foreach ($results as $result) {
                    $catform[] = $result['category_id'];
                    
                }
                
                }
                
                $catform = array_unique($catform);
                
                foreach($catform as $cats) {
                    $results = $this->model_catalog_category->getCategory($cats);
                    
                        if($results['parent_id'] == 0) {
                            $this->data['categories'][] = array(
            					'name'  => $results['name'],
            					'id' => $results['category_id']
            				);
                        }
                    
                }
                
            }
            $this->data['manufacturers'] = array();
            
            $this->data['atributes'] = array();
            if(!empty($filter['attribute_id'])){
                foreach($filter['attribute_id'] as $key=>$value) {
                    if(in_array($value, $afps)) {
                    $atribut_data = $this->model_catalog_filter_cat->getAttributeDescriptions($value);
                    $this->data['atributes'][$key]['name'] = $atribut_data[$this->config->get('config_language_id')]['name'];
                    $this->data['atributes'][$key]['id'] = $value;
                    foreach($this->model_catalog_filter_cat->getAttribute($value) as $val) {
                        if(in_array($val['product_id'],$products_id)) {
                        $this->data['atributes'][$key]['values'][] = $val['text'];
                        }
                    }
                    }   
                }
            }
            foreach($this->data['atributes'] as $key=>$val){
                $this->data['atributes'][$key]['values'] = array_unique($this->data['atributes'][$key]['values']);
            }
            
            $this->data['prices'] = array();
            if($filter['price']){
                $this->data['prices'] = $this->model_catalog_filter_cat->getPriceFilter();
            }
            $this->data['special'] = false;
            $this->data['search'] = false;
            
        } elseif($this->request->get['route'] == 'product/special') {
            if($position_filter == 'column_left' or $position_filter == 'column_right') {
                $this->document->addScript('catalog/view/javascript/filter_cat.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat.css');
        		}
            } elseif ($position_filter == 'content_top' or $position_filter == 'content_bottom') {
                $this->document->addScript('catalog/view/javascript/filter_cat_horizontal.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat_horizontal.css');
        		}
            }
        
			
		    $category_id = 0;
            $this->data['category_id'] = $category_id;
            $cat_data = $this->model_catalog_category->getCategory($category_id);
            $options = $this->config->get('filter_cat_special');	
            
            $filter_view = true;
            $filter['cat_id'] = 0;
            $filter['sub'] = false;   
            $filter['brand'] = true;   
            $filter['price'] = $options['price'];   
            $filter['attribute_id'] = $options['attribute_id'];       
            
            
            $products = $this->model_catalog_product->getProductSpecials();
            if(empty($products)) {
                $filter_view = false;
            }
            $this->data['categories'] = array();
            
            $this->data['manufacturers'] = array();
            if($filter['brand']) {
                foreach($products as $product) {
                    if($product['manufacturer_id']) {
                        $this->data['manufacturers'][$product['manufacturer_id']] = array(
                            'name' => $product['manufacturer'],
                            'id' => $product['manufacturer_id']
                        );
                    }
                }
                if(empty($products) or empty($this->data['manufacturers'])) {
                    $filter['brand'] = 0;
                }
            }
            $this->data['atributes'] = array();
            if(!empty($filter['attribute_id'])){
                foreach($filter['attribute_id'] as $key=>$value) {
                    $atribut_data = $this->model_catalog_filter_cat->getAttributeDescriptions($value);
                    $this->data['atributes'][$key]['name'] = $atribut_data[$this->config->get('config_language_id')]['name'];
                    $this->data['atributes'][$key]['id'] = $value;
                    foreach($this->model_catalog_filter_cat->getAttribute($value) as $val) {
                        $this->data['atributes'][$key]['values'][] = $val['text'];
                    }   
                }
            }
            $this->data['prices'] = array();
            if($filter['price']){
                $this->data['prices'] = $this->model_catalog_filter_cat->getPriceFilter();
            }
            $this->data['special'] = true;
            $this->data['search'] = false;
            
            
        } elseif(isset($this->request->get['filter_name'])) {
            if($position_filter == 'column_left' or $position_filter == 'column_right') {
                $this->document->addScript('catalog/view/javascript/filter_cat.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat.css');
        		}
            } elseif ($position_filter == 'content_top' or $position_filter == 'content_bottom') {
                $this->document->addScript('catalog/view/javascript/filter_cat_horizontal.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css')) {
        			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/filter_cat_horizontal.css');
        		} else {
        			$this->document->addStyle('catalog/view/theme/default/stylesheet/filter_cat_horizontal.css');
        		}
            }
            
        
			$filter_name = 	$this->request->get['filter_name'];
		    $category_id = 0;
            $this->data['category_id'] = $category_id;
            $cat_data = $this->model_catalog_category->getCategory($category_id);
            $options = $this->config->get('filter_cat_search');
            
            $filter_view = true;
            $filter['cat_id'] = $category_id;
            $filter['sub'] = false;   
            $filter['brand'] = true;   
            $filter['price'] = $options['price'];   
            $filter['attribute_id'] = $options['attribute_id'];       
            
            $data = array(
            'filter_name' => $filter_name,
            'filter_tag'          => $filter_name
            );
            $products = $this->model_catalog_product->getProducts($data);
            if(empty($products)) {
                $filter_view = false;
            }
            $this->data['categories'] = array();
            if($filter['sub']) 
            {
                $results = $this->model_catalog_category->getCategories($category_id);
                foreach ($results as $result) {
                    $this->data['categories'][] = array(
    					'name'  => $result['name'],
    					'id' => $result['category_id']
    				);
                }
                if(empty($results)) {
                    $filter['sub'] = 0;
                }
            }
            $this->data['manufacturers'] = array();
            if($filter['brand']) {
                foreach($products as $product) {
                    if($product['manufacturer_id']) {
                        $this->data['manufacturers'][$product['manufacturer_id']] = array(
                            'name' => $product['manufacturer'],
                            'id' => $product['manufacturer_id']
                        );
                    }
                }
                if(empty($products) or empty($this->data['manufacturers'])) {
                    $filter['brand'] = 0;
                }
            }
            $this->data['atributes'] = array();
            if(!empty($filter['attribute_id'])){
                foreach($filter['attribute_id'] as $key=>$value) {
                    $atribut_data = $this->model_catalog_filter_cat->getAttributeDescriptions($value);
                    $this->data['atributes'][$key]['name'] = $atribut_data[$this->config->get('config_language_id')]['name'];
                    $this->data['atributes'][$key]['id'] = $value;
                    foreach($this->model_catalog_filter_cat->getAttribute($value) as $val) {
                        $this->data['atributes'][$key]['values'][] = $val['text'];
                    }   
                }
            }
            $this->data['prices'] = array();
            if($filter['price']){
                $this->data['prices'] = $this->model_catalog_filter_cat->getPriceFilter();
            }
            
            $this->data['special'] = false;
            $this->data['search'] = $filter_name;
            
            
        } else {
            $filter_view = false; 
            $filter['cat_id'] = 0;
            $filter['sub'] = 0;   
            $filter['brand'] = 0;   
            $filter['price'] = 0;   
            $filter['attribute_id'] = array(); 
        }
        
        $this->data['filter_view'] = $filter_view;
		$this->data['filter'] = $filter;
            
		$this->data['module'] = $module++;
        
        if($position_filter == 'column_left' or $position_filter == 'column_right') {
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/filter_cat.tpl')) {
    			$this->template = $this->config->get('config_template') . '/template/module/filter_cat.tpl';
    		} else {
    			$this->template = 'default/template/module/filter_cat.tpl';
    		} 
        } elseif ($position_filter == 'content_top' or $position_filter == 'content_bottom') {
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/filter_cat_horizontal.tpl')) {
    			$this->template = $this->config->get('config_template') . '/template/module/filter_cat_horizontal.tpl';
    		} else {
    			$this->template = 'default/template/module/filter_cat_horizontal.tpl';
    		} 
        }
		
		$this->render();
	}
    
    public function ajax_filter() {
        $this->language->load('product/category');
		$this->load->model('catalog/filter_cat');
		$this->load->model('catalog/category');
		$this->language->load('module/filter_cat');
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image'); 
                
        
        if($this->request->server['REQUEST_METHOD'] == 'POST'){
            $json = array();
            $data = array();
            $json['sub_cats'] = '';
            //print_r($this->request->post);
            if(strlen($this->request->post['filterCats']) != 0){
                $data['filterCats'] = explode(',',$this->request->post['filterCats']);
            } else {
                $data['filterCats'] = array();
            }
            if(strlen($this->request->post['filterCat']) != 0){
                $data['filterCat'] = explode(',',$this->request->post['filterCat']);
                foreach($data['filterCat'] as $c) {
                    
                    $cat = $this->model_catalog_filter_cat->getCategoriesByParentId($c);
                    if(!empty($cat)) {
                        $json['sub_cats'][$c] = '<div class="filter-block"><div class="top-close-block"></div><div class="body-block f-ssub">';
                    }
                    foreach($cat as $sc) {
                        $cat_info = $this->model_catalog_category->getCategory($sc);
                        if(in_array($sc,$data['filterCats'])) {
                            $json['sub_cats'][$c] .= '<input checked="checked" id="c'.$cat_info['category_id'].'" type="checkbox" value="'.$cat_info['category_id'].'"><label for="c'.$cat_info['category_id'].'">'.$cat_info['name'].'</label><br>';
                        } else {
                            $json['sub_cats'][$c] .= '<input id="c'.$cat_info['category_id'].'" type="checkbox" value="'.$cat_info['category_id'].'"><label for="c'.$cat_info['category_id'].'">'.$cat_info['name'].'</label><br>';
                        }
                        
                    }
                    if(!empty($cat)) {
                        $json['sub_cats'][$c] .=  '</div><div class="bot-close-block"></div></div>';
                    }
                }
                
                /*if(strlen($json['sub_cats']) > 0) {
                    $top = '<div class="filter-block"><div class="top-close-block"></div><div class="body-block f-ssub">';
                    $top .= $json['sub_cats'].'</div><div class="bot-close-block"></div></div>';
                    $json['sub_cats'] = $top;
                }*/
            } else {
                $data['filterCat'][] = $this->request->post['defCat'];
            }
            //print_r($json['sub_cats']);
            
            
            if(strlen($this->request->post['filterMan']) != 0){
                $data['filterMan'] = explode(',',$this->request->post['filterMan']);
            } else {
                $data['filterMan'] = array();
            }
            $data['filterSpecial'] = $this->request->post['filterSpecial'];
            $data['filterSearch'] = $this->request->post['filterSearch'];
            
            $data['filterSort'] = $this->request->post['filterSort'];
            $json['filterSort'] = $this->request->post['filterSort'];
            $data['filterOrder'] = $this->request->post['filterOrder'];
            $json['filterOrder'] = $this->request->post['filterOrder'];
            $atributes = explode(',',$this->request->post['filterAtr']);
            $data['filterPmin'] = (int)$this->request->post['filterPmin'];
            $data['filterPmax'] = (int)$this->request->post['filterPmax'];
            $data['filterLimit'] = $this->config->get('config_catalog_limit');
            $data['filterStart'] = ($this->request->post['start'] - 1) * $data['filterLimit'];
            
            $data['filterAtr'] = array();
            $atribute = array();
            foreach($atributes as $key=>$value) {
                if($value != 0) {
                    $atr_arr = explode('||',$value);
                    $data['filterAtr'][$key]['id'] = $atr_arr[0];
                    $data['filterAtr'][$key]['value'] = $atr_arr[1];
                    $atribute[] = $atr_arr[1];
                }
            }
            //print_r($data);
            $results = $this->model_catalog_filter_cat->getFilterProduct($data);
            
            $product_array = array();
            if(!empty($data['filterAtr'])){
                if(!empty($results)) {
                    foreach($results as $result) {
                        $product_array[$result['product_id']]['product_id'] = $result['product_id'];
                        $product_array[$result['product_id']]['atributes'][] = $result['text'];
                        }
                    }
                $results = array();
                foreach($product_array as $pa) {
                    if($pa['atributes'] == $atribute) {
                        $results[]['product_id'] = $pa['product_id'];
                    }
                }
            }
            if(!empty($results)){
                $products = '';
                
                foreach($results as $result) {
                    $product = $this->model_catalog_product->getProduct($result['product_id']);
                    
                    
                    
                    if ($product['image']) {
    					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
    				} else {
    					$image = false;
    				}
                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
    					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
    				} else {
    					$price = false;
    				}
                    if ((float)$product['special']) {
    					$special = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')));
    				} else {
    					$special = false;
    				}	
    				
    				if ($this->config->get('config_tax')) {
    					$tax = $this->currency->format((float)$product['special'] ? $product['special'] : $product['price']);
    				} else {
    					$tax = false;
    				}
                    
                    $products .= '<div>
                    	<div class="image">
                    		<a href="'.$this->url->link('product/product', 'path=' . $data['filterCat'] . '&product_id=' . $product['product_id']).'">
                    		<img alt="'.$product['name'].'" title="'.$product['name'].'" src="'.$image.'">
                    		</a>
                    	</div>
                        <div class="name">
                    		<a href="'.$this->url->link('product/product', 'path=' . $data['filterCat'] . '&product_id=' . $product['product_id']).'">'.$product['name'].'</a>
                    	</div>
                        <div class="description">'.utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8')), 0, 100).'...</div>
                        <div class="price">';
                        if(!$special) {
                            $products .= $price;
                        } else {
                            $products .= '<span class="price-old">'.$price.'</span> <span class="price-new">'.$special.'</span>';
                        }
                        if($tax){
                            $products .= '<br />
                            <span class="price-tax">'.$this->language->get('text_tax').' '.$tax.'</span>';
                        }
                    	$products .= "</div>
                    	<div class=\"cart\">
                        <input type=\"button\" value=\"".$this->language->get('button_cart')."\" onclick=\"addToCart('".$product['product_id']."');\" class=\"button\" />
                    	</div>
                        <div class=\"wishlist\"><a onclick=\"addToWishList('".$product['product_id']."');\">".$this->language->get('button_wishlist')."</a></div>
      <div class=\"compare\"><a onclick=\"addToCompare('".$product['product_id']."');\">".$this->language->get('button_compare')."</a></div>
                    </div>";
                }
                
                $json['result'] = $products;
                $count = $this->model_catalog_filter_cat->getTotalFilterProduct($data);
                $pagination = new Pagination();
    			$pagination->total = $count;
    			$pagination->page = $this->request->post['start'];
    			$pagination->limit = $data['filterLimit'];
    			$pagination->text = $this->language->get('text_pagination');
    			$pagination->url = "{page},".$this->request->post['filterSort'].",".$this->request->post['filterOrder'];
		
			$json['pagination'] = $pagination->render();
            
            $sort_value = $this->request->post['filterSort'].'-'.$this->request->post['filterOrder'];
            if($sort_value == 'pd.name-ASC') {
                    $snc = 'active';
                    $snf = '&#9660;';
                    $snh = "'1','pd.name','DESC'";
                } else {
                    $snc = '';
                    $snf = '';
                    $snh = "'1','pd.name','ASC'";
                }
                if($sort_value == 'pd.name-DESC') {
                    $snc = 'active';
                    $snf = '&#9650;';
                    $snh = "'1','pd.name','ASC'";
                }
                if($sort_value == 'p.price-ASC') {
                    $spc = 'active';
                    $spf = '&#9660;';
                    $sph = "'1','p.price','DESC'";
                } else {
                    $spc = '';
                    $spf = '';
                    $sph = "'1','p.price','ASC'";
                }
                if($sort_value == 'p.price-DESC') {
                    $spc = 'active';
                    $spf = '&#9650;';
                    $sph = "'1','p.price','ASC'";
                } 
                if($sort_value == 'rating-ASC') {
                    $src = 'active';
                    $srf = '&#9660;';
                    $srh = "'1','rating','DESC'";
                } else {
                    $src = '';
                    $srf = '';
                    $srh = "'1','rating','ASC'";
                }
                if($sort_value == 'rating-DESC') {
                    $src = 'active';
                    $srf = '&#9650;';
                    $srh = "'1','rating','ASC'";
                } 
                
                $json['sort'] = $this->language->get('text_sort').'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="filterCat('.$snh.'); return false;" class="'.$snc.'" href="">'.$this->language->get('text_sort_name').' '.$snf.'</a>&nbsp;&nbsp;&nbsp;<a onclick="filterCat('.$sph.'); return false;" class="'.$spc.'" href="">'.$this->language->get('text_sort_price').' '.$spf.'</a>&nbsp;&nbsp;&nbsp;<a onclick="filterCat('.$srh.'); return false;" class="'.$src.'" href="">'.$this->language->get('text_sort_rating').' '.$srf.'</a>';
                
                
            } else {
                $json['result'] = $this->language->get('text_filtererror');
                $json['sort'] = '';
                $json['pagination'] = '';
                $count = 0;
            }
        } else {
            $json['result'] = $this->language->get('text_filtererror');
            $count = 0;
        }
        
        $json['count'] = sprintf($this->language->get('text_result'), $count);
        $json['clear'] = $this->language->get('text_clear');
        $this->response->setOutput(json_encode($json));
        
    }
}
?>