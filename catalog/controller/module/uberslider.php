<?php
class ControllerModuleUberslider extends Controller {
	protected function index($setting) {
		$this->language->load('module/uberslider'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product');
    $this->load->model('catalog/manufacturer'); 
		
		$this->load->model('tool/image');
    
    $this->document->addScript('catalog/view/theme/gtv1/javascript/mousewheel.js');
    $this->document->addScript('catalog/view/theme/gtv1/javascript/easing.js');
    $this->document->addScript('catalog/view/theme/gtv1/javascript/rhinoslider-1.05.min.js');
    
    if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/rhinoslider-1.05.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/rhinoslider-1.05.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/rhinoslider-1.05.css');
		}

		$this->data['products'] = array();

		$products = explode(',', $this->config->get('uberslider_product'));		

		if (empty($setting['limit'])) {
			$setting['limit'] = 5;
		}
		
		$products = array_slice($products, 0, (int)$setting['limit']);
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
        if ($product_info['manufacturer_id']) {
           $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);
           $manufacturer_name = $manufacturer_info['name'];
           $manufacturer_image = $this->model_tool_image->resize($manufacturer_info['image'], 41, 37);
        } else {
           $manufacturer_name = false;
           $manufacturer_image = false;
        }
      
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}
        
        if ($product_info['bigpic']) {
					$bigpic = $this->model_tool_image->resize($product_info['bigpic'], $setting['image_width2'], $setting['image_height2']);
				} else {
					$bigpic = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = $product_info['rating'];
				} else {
					$rating = false;
				}
        
        if ($product_info['developer']) {
          $developer = $product_info['developer'];
        }
        else {
          $developer = false;
        }
        
        if ($product_info['publisher']) {
          $publisher = $product_info['publisher'];
        }
        else {
          $publisher = false;
        }
        
        if ($developer != false && $publisher != false) { 
          if ($developer != $publisher) {
            $companies = sprintf($this->language->get('text_companies2'), (string)$developer, (string)$publisher);
          }
          else {
            $companies = sprintf($this->language->get('text_companies1'), (string)$developer);
          }
        }
        else {
          $companies = false;
        }
        
        $date_available = sprintf($this->language->get('text_date'), (string)date($this->language->get('date_format_3'), strtotime($product_info['date_available'])));          
					
				$this->data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'thumb'   	 => $image,
          'bigpic'   	 => $bigpic,
					'name'    	 => $product_info['name'],
          'manufacturer_name'=>$manufacturer_name,
          'manufacturer_image'=>$manufacturer_image,
					'price'   	 => $price,
					'special' 	 => $special,
					'rating'     => $rating,
          'companies'  => $companies,
          'date_available' => $date_available,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
				);
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/uberslider.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/uberslider.tpl';
		} else {
			$this->template = 'default/template/module/uberslider.tpl';
		}

		$this->render();
	}
}
?>