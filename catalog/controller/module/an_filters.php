<?php

class ControllerModuleAnFilters extends Controller {

    public function index() {

        $this->load->model('catalog/product');

        if (method_exists('ModelCatalogProduct', 'getHighestProductPrice')) {
            $vqmodInstalled = true;
        } else {
            echo '<div class="warning">Filters Pro Module cannot load because the vQmod XML file has not been installed properly. Check /vqmod/vqmod.log for more details</div>';
            $vqmodInstalled = false;
        }


        if ($this->config->get('an_filters_status') && (isset($this->request->get['path']) || isset($this->request->get['path_ajax'])) && $vqmodInstalled == true) {

            // Models & Languages
            $this->language->load('module/an_filters');
            $this->load->model('localisation/currency');
            $this->load->model('catalog/product');
            $this->load->model('catalog/manufacturer');

            // Module config settings
            $this->data['ajax_enabled'] = $this->config->get('an_filters_ajax_status');

            // Language values
            $this->data['heading_title'] = $this->language->get('heading_title');
            $this->data['entry_price'] = $this->language->get('entry_price');
            $this->data['entry_manufacturer'] = $this->config->get('an_filters_manufacturer_label');
            $this->data['entry_to'] = $this->language->get('entry_to');
            $this->data['link_go'] = $this->language->get('link_go');
            $this->data['link_clearFilter'] = $this->language->get('link_clearFilter');

            $rawPath = isset($this->request->get['path']) ? $this->request->get['path'] : $this->request->get['path_ajax'];

            // Url filters data
            $urlData = array(
                'path' => $rawPath
            );
            if (isset($this->request->get['sort']))
                $urlData['sort'] = $this->request->get['sort'];
            if (isset($this->request->get['order']))
                $urlData['order'] = $this->request->get['order'];
            if (isset($this->request->get['start']))
                $urlData['start'] = $this->request->get['start'];
            if (isset($this->request->get['limit']))
                $urlData['limit'] = $this->request->get['limit'];
            foreach ($this->request->get as $key => $value) {
                if (strstr($key, 'filter_attribute_')) {
                    $splode = explode('_', $value);
                    foreach ($splode as $splodeValue) {
                        $urlData[$key][$splodeValue] = $splodeValue;
                    }
                }
            }
            if (isset($this->request->get['filter:manufacturer']))
                $urlData['filter:manufacturer'] = explode(',', $this->request->get['filter:manufacturer']);
            if (isset($this->request->get['filter:price']))
                $urlData['filter:price'] = explode(',', $this->request->get['filter:price']);

            $pathBits = explode('_', $rawPath);


            // Price Filters
            $results = $this->model_localisation_currency->getCurrencies();

            foreach ($results as $result) {
                if ($result['status'] && $result['code'] == $this->currency->getCode()) {
                    if ($result['symbol_left']) {
                        $this->data['currencySymbolLeft'] = $result['symbol_left'];
                        $this->data['currencySymbolRight'] = '';
                    } else {
                        $this->data['currencySymbolLeft'] = '';
                        $this->data['currencySymbolRight'] = $result['symbol_right'];
                    }
                }
            }

            $this->data['active_filters'] = array();
            foreach (array_keys($this->request->get) as $key) {

                if (strstr($key, 'filter_attribute_')) {
                    foreach (explode('_', $this->request->get[$key]) as $value) {
                        $this->data['active_filters'][str_replace('filter_attribute_', '', $key)][] = $value;
                    }
                }
            }


            if (isset($this->request->get['filter:price'])) {
                $this->data['priceFilterInUse'] = true;
                $activePriceFilterArray = explode('-', $this->request->get['filter:price']);
                $this->data['activePriceFilter'] = array(
                    'from' => $activePriceFilterArray[0],
                    'to' => $activePriceFilterArray[1]
                );
            } else {
                $this->data['priceFilterInUse'] = false;
                $this->data['activePriceFilter'] = array(
                    'from' => '',
                    'to' => ''
                );
            }

            if ($this->config->get('an_filters_price_bands_status')) {
                $this->data['priceFilters'] = array();

                $pathBits = explode('_', $rawPath);
                $categoryId = end($pathBits);
                $maxPrice = $this->model_catalog_product->getHighestProductPrice($categoryId);

                $bandSize = $this->config->get('an_filters_price_bands_upto_10') ? $this->config->get('an_filters_price_bands_upto_10') : 10;
                if ($maxPrice >= 100)
                    $bandSize = $this->config->get('an_filters_price_bands_upto_100') ? $this->config->get('an_filters_price_bands_upto_100') : 100;
                if ($maxPrice >= 1000)
                    $bandSize = $this->config->get('an_filters_price_bands_upto_1000') ? $this->config->get('an_filters_price_bands_upto_1000') : 1000;
                if ($maxPrice >= 10000)
                    $bandSize = $this->config->get('an_filters_price_bands_upto_10000') ? $this->config->get('an_filters_price_bands_upto_10000') : 10000;
                $this->data['maxPrice'] = ceil($maxPrice / $bandSize) * $bandSize;

                // Build price bands // Starts
                $filters = array();
                $price_to = 0;
                $price_step = $this->config->get('an_filters_price_bands_upto_10') ? $this->config->get('an_filters_price_bands_upto_10') : 10;
                while ($price_to <= ($maxPrice + $price_step)) {

                    if ($price_to >= 100) {
                        $price_step = $this->config->get('an_filters_price_bands_upto_100') ? $this->config->get('an_filters_price_bands_upto_100') : 100;
                    }
                    if ($price_to >= 1000) {
                        $price_step = $this->config->get('an_filters_price_bands_upto_1000') ? $this->config->get('an_filters_price_bands_upto_1000') : 1000;
                    }
                    if ($price_to >= 10000) {
                        $price_step = $this->config->get('an_filters_price_bands_upto_10000') ? $this->config->get('an_filters_price_bands_upto_10000') : 10000;
                    }

                    $price_to += $price_step;

                    $price_range = ($price_to - $price_step) . "-" . $price_to;
                    array_push($filters, $price_range);
                }
                // Build price bands // Ends

                foreach ($filters as $filter) {

                    // Building URL starts
                    $clearUrl = array();
                    if (isset($urlData['path']))
                        $clearUrl['path'] = 'path=' . $urlData['path'];
                    if (isset($urlData['filter:manufacturer']))
                        $clearUrl['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $urlData['filter:manufacturer']);
                    if (isset($urlData['sort']))
                        $clearUrl['sort'] = 'sort=' . $urlData['sort'];
                    if (isset($urlData['order']))
                        $clearUrl['order'] = 'order=' . $urlData['order'];
                    if (isset($urlData['limit']))
                        $clearUrl['limit'] = 'limit=' . $urlData['limit'];
                    if (isset($urlData['page']))
                        $clearUrl['page'] = 'page=' . $urlData['page'];

                    foreach ($urlData as $key => $value) {
                        if (strstr($key, 'filter_attribute')) {
                            $clearUrl[$key] = $key . '=' . implode('_', $value);
                        }
                    }

                    $clearUrl = implode('&', $clearUrl);

                    $price_range = explode('-', $filter);
                    $clear_filter = $this->url->link('product/category', $clearUrl);
                    $clear_filter_ajax = $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', $clearUrl));

                    $this->data['clearPriceFilterUrl'] = $clear_filter;
                    $this->data['clearPriceFilterUrl_ajax'] = $clear_filter_ajax;
                    $url = $this->url->link('product/category', $clearUrl . '&filter:price=' . $filter);
                    $url_ajax = $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', ($clearUrl . '&filter:price=' . $filter)));
                    // Building URL ends

                    $filter_price = array(
                        'price_from' => $this->currency->convert($price_range[0], $this->currency->getCode(), $this->config->get('config_currency')),
                        'price_to' => $this->currency->convert($price_range[1], $this->currency->getCode(), $this->config->get('config_currency')),
                    );

                    $attribute_filters = array();
                    foreach (array_keys($this->request->get) as $key) {
                        if (strstr($key, 'filter_attribute_')) {
                            $values = array();
                            foreach (explode('_', $this->request->get[$key]) as $value) {
                                $values[] = $value;
                            }
                            $attribute_filters[str_replace('filter_attribute_', '', $key)] = $values;
                        }
                    }

                    // Check if this filter is active
                    if (isset($this->request->get['filter:price']) && $this->request->get['filter:price'] == $filter) {
                        $isActive = true;
                    } else {
                        $isActive = false;
                    }

                    // Check getTotalProducts() BEFORE adding attribute filters to see if this filter is relevant for this category
                    $data = array(
                        'filter_category_id' => end($pathBits),
                    );
                    $thisTotal = $this->model_catalog_product->getTotalProducts($data);

                    // Check getTotalProducts() AFTER adding attribute filters to see if this filter is enabled/disabled

                    $data = array(
                        'filter:price' => $filter_price,
                        'filter_category_id' => end($pathBits),
                        'attribute_filters' => $attribute_filters,
                        'filter:manufacturer' => isset($urlData['filter:manufacturer']) ? $urlData['filter:manufacturer'] : null,
                    );

                    if ($thisTotal) {
                        $this->data['priceFilters'][] = array(
                            'filter' => $filter,
                            'href' => $url,
                            'href_off' => $clear_filter,
                            'href_ajax' => $url_ajax,
                            'href_off_ajax' => $clear_filter_ajax,
                            'price_from' => $price_range[0],
                            'price_to' => $price_range[1],
                            'total' => $this->model_catalog_product->getTotalProducts($data),
                            'is_active' => $isActive
                        );
                    }
                }
            } else {
                $categoryId = end($pathBits);
                $maxPrice = $this->model_catalog_product->getHighestProductPrice($categoryId);
                $this->data['maxPrice'] = $maxPrice;

                $clearUrl = array();
                if (isset($urlData['path']))
                    $clearUrl['path'] = 'path=' . $urlData['path'];
                if (isset($urlData['filter:manufacturer']))
                    $clearUrl['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $urlData['filter:manufacturer']);
                if (isset($urlData['sort']))
                    $clearUrl['sort'] = 'sort=' . $urlData['sort'];
                if (isset($urlData['order']))
                    $clearUrl['order'] = 'order=' . $urlData['order'];
                if (isset($urlData['limit']))
                    $clearUrl['limit'] = 'limit=' . $urlData['limit'];
                if (isset($urlData['page']))
                    $clearUrl['page'] = 'page=' . $urlData['page'];

                $clearUrl = implode('&', $clearUrl);

                foreach ($urlData as $key => $value) {
                    if (strstr($key, 'filter_attribute')) {
                        $clearUrl .= '&' . $key . '=' . implode('_', $value);
                    }
                }

                $this->data['clearPriceFilterUrl'] = $this->url->link('product/category', $clearUrl);
                $this->data['clearPriceFilterUrl_ajax'] = $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', $clearUrl));

                $this->data['priceFilters'] = array();
            }
            /* Price filters end */







            /* Attribute Filters */
            $attributes = array();

            if ($this->config->get('an_filters_attributes_filters_status')) {
                $attributes = $this->model_catalog_product->getAttributes();

                foreach ($attributes as $key => $value) {

                    $path = explode('_', $rawPath);

                    $data = array(
                        'attribute_id' => $value['attribute_id'],
                        'category_id' => end($path)
                    );

                    $children = $this->model_catalog_product->getAttributeValues($data);

                    foreach ($children as $cKey => $cValue) {

                        $filterAttributeUrlString = 'filter_attribute_' . $value['attribute_id'];

                        $tempUrlData = $urlData;

                        $tempUrlData[$filterAttributeUrlString][md5($cValue['text'])] = md5($cValue['text']);

                        $urlString = '';

                        foreach ($tempUrlData as $tempUrlDataKey => $tempUrlDataValue) {
                            if (strstr($tempUrlDataKey, 'filter_attribute_') && $tempUrlDataKey != $filterAttributeUrlString) {
                                $urlString .= $tempUrlDataKey . '=' . implode('_', $tempUrlDataValue) . '&';
                            }
                        }

                        $filterAttributeUrlStringOn = $filterAttributeUrlString . '=' . implode('_', $tempUrlData[$filterAttributeUrlString]);

                        unset($tempUrlData[$filterAttributeUrlString][md5($cValue['text'])]);

                        $filterAttributeUrlStringOff = $filterAttributeUrlString . '=' . implode('_', $tempUrlData[$filterAttributeUrlString]);

                        $filterAttributeUrlStringOffArray = explode('=', $filterAttributeUrlStringOff);

                        if (!isset($filterAttributeUrlStringOffArray[1])) {
                            unset($filterAttributeUrlStringOffArray[0]);
                        }

                        if (isset($filterAttributeUrlStringOffArray[1]) && empty($filterAttributeUrlStringOffArray[1])) {
                            unset($filterAttributeUrlStringOffArray[0]);
                            unset($filterAttributeUrlStringOffArray[1]);
                        }

                        $filterAttributeUrlStringOff = implode('=', $filterAttributeUrlStringOffArray);

                        $miscUrlParams = array();
                        if (isset($urlData['path']))
                            $miscUrlParams['path'] = 'path=' . $urlData['path'];
                        if (isset($urlData['filter:price']))
                            $miscUrlParams['filter:price'] = 'filter:price=' . implode(',', $urlData['filter:price']);
                        if (isset($urlData['filter:manufacturer']))
                            $miscUrlParams['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $urlData['filter:manufacturer']);
                        if (isset($urlData['sort']))
                            $miscUrlParams['sort'] = 'sort=' . $urlData['sort'];
                        if (isset($urlData['order']))
                            $miscUrlParams['order'] = 'order=' . $urlData['order'];
                        if (isset($urlData['limit']))
                            $miscUrlParams['limit'] = 'limit=' . $urlData['limit'];
                        if (isset($urlData['page']))
                            $miscUrlParams['page'] = 'page=' . $urlData['page'];

                        $miscUrlParams = implode('&', $miscUrlParams);

                        $thisUrl = $filterAttributeUrlStringOn ? '&' . $filterAttributeUrlStringOn : '';
                        $thisUrl .= $urlString ? '&' . $urlString : '';
                        $children[$cKey]['href'] =
                                $this->url->link(
                                'product/category', $miscUrlParams . $thisUrl
                        );
                        $children[$cKey]['href_ajax'] =
                                $this->url->link(
                                'module/an_filters/ajax', str_replace('path=', 'path_ajax=', $miscUrlParams) . $thisUrl
                        );

                        $thisUrl = $filterAttributeUrlStringOff ? '&' . $filterAttributeUrlStringOff : '';
                        $thisUrl .= $urlString ? '&' . $urlString : '';
                        $children[$cKey]['href_off'] =
                                $this->url->link(
                                'product/category', $miscUrlParams . $thisUrl
                        );
                        $children[$cKey]['href_off_ajax'] =
                                $this->url->link(
                                'module/an_filters/ajax', str_replace('path=', 'path_ajax=', $miscUrlParams) . $thisUrl
                        );




                        $totalProductsDataAttributeFilters = array();
                        foreach (array_keys($this->request->get) as $xkey) {
                            if (strstr($xkey, 'filter_attribute_')) {
                                $keyValues = array();
                                foreach (explode('_', $this->request->get[$xkey]) as $keyValue) {
                                    $keyValues[] = $keyValue;
                                }
                                $totalProductsDataAttributeFilters[str_replace('filter_attribute_', '', $xkey)] = $keyValues;
                            }
                        }

                        $totalProductsDataAttributeFilters[$value['attribute_id']][] = md5($cValue['text']);

                        if (isset($this->request->get['filter:price'])) {
                            $price_array = explode('-', $this->request->get['filter:price']);
                            $filter_price = array(
                                'price_from' => $this->currency->convert($price_array[0], $this->currency->getCode(), $this->config->get('config_currency')),
                                'price_to' => $this->currency->convert($price_array[1], $this->currency->getCode(), $this->config->get('config_currency')),
                            );
                        } else {
                            $filter_price = '';
                        }

                        $attributeFiltersRequired = array(
                            $value['attribute_id'] => md5($cValue['text'])
                        );

                        $pathBits = explode('_', $rawPath);
                        $totalProductsData = array(
                            'filter_category_id' => end($pathBits),
                            'sort' => isset($this->request->get['sort']) ? $this->request->get['sort'] : 'p.sort_order',
                            'order' => isset($this->request->get['order']) ? $this->request->get['order'] : 'ASC',
                            'start' => ((isset($this->request->get['page']) ? $this->request->get['page'] : 1) - 1) * (isset($this->request->get['limit']) ? $this->request->get['limit'] : $this->config->get('config_catalog_limit')),
                            'limit' => isset($this->request->get['limit']) ? $this->request->get['limit'] : $this->config->get('config_catalog_limit'),
                            'filter:price' => $filter_price,
                            'attribute_filters' => $totalProductsDataAttributeFilters,
                            'attribute_filters_required' => $attributeFiltersRequired,
                            'filter:manufacturer' => isset($urlData['filter:manufacturer']) ? $urlData['filter:manufacturer'] : null,
                        );



                        $children[$cKey]['total'] = $this->model_catalog_product->getTotalProducts($totalProductsData);

                        if (isset($this->request->get[$filterAttributeUrlString]) && in_array(md5($cValue['text']), explode('_', $this->request->get[$filterAttributeUrlString]))) {
                            $children[$cKey]['is_active'] = true;
                        } else {
                            $children[$cKey]['is_active'] = false;
                        }
                    }

                    $attributes[$key]['values'] = $children;


                    $clearUrl = array();
                    $clearUrlEnabled = false;

                    $miscUrlParams = array();
                    if (isset($urlData['path']))
                        $clearUrl['path'] = 'path=' . $urlData['path'];
                    if (isset($urlData['filter:price']))
                        $clearUrl['filter:price'] = 'filter:price=' . implode(',', $urlData['filter:price']);
                    if (isset($urlData['filter:manufacturer']))
                        $clearUrl['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $urlData['filter:manufacturer']);
                    if (isset($urlData['sort']))
                        $clearUrl['sort'] = 'sort=' . $urlData['sort'];
                    if (isset($urlData['order']))
                        $clearUrl['order'] = 'order=' . $urlData['order'];
                    if (isset($urlData['limit']))
                        $clearUrl['limit'] = 'limit=' . $urlData['limit'];
                    if (isset($urlData['page']))
                        $clearUrl['page'] = 'page=' . $urlData['page'];

                    $clearUrl = implode('&', $clearUrl);

                    foreach ($urlData as $urlDataKey => $urlDataValue) {
                        if (strstr($urlDataKey, 'filter_attribute')) {
                            if ($urlDataKey != 'filter_attribute_' . $attributes[$key]['attribute_id']) {
                                $clearUrl .= '&' . $urlDataKey . '=' . implode('_', $urlDataValue);
                            } else {
                                $clearUrlEnabled = true;
                            }
                        }
                    }
                    $attributes[$key]['clearUrlEnabled'] = $clearUrlEnabled;
                    $attributes[$key]['clearUrl'] = $this->url->link('product/category', $clearUrl);
                    $attributes[$key]['clearUrl_ajax'] = $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', $clearUrl));
                }
            }
            
            foreach ($attributes as $key => $value) {
                if (!$value['values']) {
                    unset($attributes[$key]);
                }
            }

            $this->data['attributes'] = $attributes;




            // @todo: Fix $urlData
            // Manufacturers
            $manufacturerFilters = array();

            if ($this->config->get('an_filters_manufacturers_filters_status')) {
                $hrefClearData = array();

                foreach ($this->request->get as $key => $value) {
                    if (strstr($key, 'filter_attribute_')) {
                        $hrefClearData[] = $key . '=' . $value;
                    }
                }

                if (isset($urlData['path']))
                    $hrefClearData['path'] = 'path=' . $urlData['path'];
                if (isset($urlData['filter:price']))
                    $hrefClearData['filter:price'] = 'filter:price=' . implode(',', $urlData['filter:price']);
                if (isset($urlData['sort']))
                    $hrefClearData['sort'] = 'sort=' . $urlData['sort'];
                if (isset($urlData['order']))
                    $hrefClearData['order'] = 'order=' . $urlData['order'];
                if (isset($urlData['limit']))
                    $hrefClearData['limit'] = 'limit=' . $urlData['limit'];
                if (isset($urlData['page']))
                    $hrefClearData['page'] = 'page=' . $urlData['page'];

                $this->data['manufacturerClearHref'] = $this->url->link('product/category', implode('&', $hrefClearData));
                $this->data['manufacturerClearHrefAjax'] = $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', implode('&', $hrefClearData)));

                $attribute_filters = array();
                foreach (array_keys($this->request->get) as $key) {
                    if (strstr($key, 'filter_attribute_')) {
                        $values = array();
                        foreach (explode('_', $this->request->get[$key]) as $value) {
                            $values[] = $value;
                        }
                        $attribute_filters[str_replace('filter_attribute_', '', $key)] = $values;
                    }
                }

                foreach ($this->model_catalog_manufacturer->getManufacturers() as $manufacturer) {

                    if (isset($urlData['filter:manufacturer']) && in_array(strtolower($manufacturer['name']), $urlData['filter:manufacturer'])) {
                        $isActive = true;
                    } else {
                        $isActive = false;
                    }

                    $hrefOffData = $hrefClearData;
                    $hrefOnData = $hrefClearData;

                    $activeManufacturersExcludingThis = array();
                    if (isset($urlData['filter:manufacturer'])) {
                        foreach ($urlData['filter:manufacturer'] as $manufacturerName) {
                            if ($manufacturerName != strtolower($manufacturer['name'])) {
                                $activeManufacturersExcludingThis[] = $manufacturerName;
                            }
                        }
                        if ($activeManufacturersExcludingThis)
                            $hrefOffData['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $activeManufacturersExcludingThis);
                    }

                    $activeManufacturersIncludingThis = $activeManufacturersExcludingThis;
                    $activeManufacturersIncludingThis[] = strtolower($manufacturer['name']);
                    $hrefOnData['filter:manufacturer'] = 'filter:manufacturer=' . implode(',', $activeManufacturersIncludingThis);

                    $filterPrice = false;
                    if (isset($urlData['filter:price'])) {
                        $priceBand = explode('-', $urlData['filter:price'][0]);
                        $filterPrice = array('price_from' => $priceBand[0], 'price_to' => $priceBand[1]);
                    }

                    $pathBits = explode('_', $urlData['path']);
                    $totalProductsData = array(
                        'filter_category_id' => end($pathBits),
                        'filter:price' => $filterPrice,
                        'filter:manufacturer' => array(strtolower($manufacturer['name'])),
                        'attribute_filters' => $attribute_filters,
                    );




                    if ($this->model_catalog_product->getTotalProducts(array('filter_category_id' => end($pathBits), 'filter:manufacturer' => array(strtolower($manufacturer['name']))))) {
                        $manufacturerFilters[] = array(
                            'text' => $manufacturer['name'],
                            'total' => $this->model_catalog_product->getTotalProducts($totalProductsData),
                            'isActive' => $isActive,
                            'href' => $this->url->link('product/category', implode('&', $hrefOnData)),
                            'hrefAjax' => $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', implode('&', $hrefOnData))),
                            'hrefOff' => $this->url->link('product/category', implode('&', $hrefOffData)),
                            'hrefOffAjax' => $this->url->link('module/an_filters/ajax', str_replace('path=', 'path_ajax=', implode('&', $hrefOffData))),
                        );
                    }
                }
            }

            $this->data['manufacturerFilterInUse'] = isset($this->request->get['filter:manufacturer']) ? true : false;
            $this->data['manufacturerFilters'] = $manufacturerFilters;

            $this->data['collapsible'] = $this->config->get('an_filters_collapsible_status');
            $this->data['collapsed_by_default'] = $this->config->get('an_filters_collapsible_hidden_by_default');
            $this->data['listMaxHeight'] = $this->config->get('an_filters_list_max_height');

            if ($this->request->get['route'] == 'module/an_filters/ajax') {
                $this->data['ajaxDataOnly'] = true;
            } else {
                $this->data['ajaxDataOnly'] = false;
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/an_filters.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/module/an_filters.tpl';
            } else {
                $this->template = 'default/template/module/an_filters.tpl';
            }

            return $this->render();
        }

    }

    public function ajax() {
        $this->language->load('product/category');

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');

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
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = $this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_catalog_limit');
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

        if (isset($this->request->get['path_ajax'])) {
            $path = '';

            $parts = explode('_', (string) $this->request->get['path_ajax']);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path),
                        'separator' => $this->language->get('text_separator')
                    );
                }
            }

            $category_id = array_pop($parts);
        } else {
            $category_id = 0;
        }

        $category_info = $this->model_catalog_category->getCategory($category_id);

        if ($category_info) {
            $this->document->setTitle($category_info['name']);
            $this->document->setDescription($category_info['meta_description']);
            $this->document->setKeywords($category_info['meta_keyword']);

            $this->data['heading_title'] = $category_info['name'];

            $this->data['text_refine'] = $this->language->get('text_refine');
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

            $this->data['button_cart'] = $this->language->get('button_cart');
            $this->data['button_wishlist'] = $this->language->get('button_wishlist');
            $this->data['button_compare'] = $this->language->get('button_compare');
            $this->data['button_continue'] = $this->language->get('button_continue');

            if ($category_info['image']) {
                $this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
            } else {
                $this->data['thumb'] = '';
            }

            $this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
            $this->data['compare'] = $this->url->link('product/compare');

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

            $this->data['categories'] = array();

            $results = $this->model_catalog_category->getCategories($category_id);

            foreach ($results as $result) {
                $data = array(
                    'filter_category_id' => $result['category_id'],
                    'filter_sub_category' => true
                );

                $product_total = $this->model_catalog_product->getTotalProducts($data);

                $this->data['categories'][] = array(
                    'name' => $result['name'] . ' (' . $product_total . ')',
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '_' . $result['category_id'] . $url)
                );
            }

            $this->data['products'] = array();

            // Filters Pro
            if (isset($this->request->get['filter:price'])) {
                $price_array = explode('-', $this->request->get['filter:price']);
                $filter_price = array(
                    'price_from' => $this->currency->convert($price_array[0], $this->currency->getCode(), $this->config->get('config_currency')),
                    'price_to' => $this->currency->convert($price_array[1], $this->currency->getCode(), $this->config->get('config_currency'))
                );
            } else {
                $filter_price = '';
            }
            $attribute_filters = array();
            foreach (array_keys($this->request->get) as $key) {
                if (strstr($key, 'filter_attribute_')) {
                    $values = array();
                    foreach (explode('_', $this->request->get[$key]) as $value) {
                        $values[] = $value;
                    }
                    $attribute_filters[str_replace('filter_attribute_', '', $key)] = $values;
                }
            }
            $manufacturerFilter = array();
            if (isset($this->request->get['filter:manufacturer'])) {
                $manufacturerFilter = explode(',', $this->request->get['filter:manufacturer']);
            }
            // Filters Pro



            $data = array(
                'filter_category_id' => $category_id,
                'sort' => $sort,
                'order' => $order,
                'start' => ($page - 1) * $limit,
                'limit' => $limit
                , 'filter:price' => $filter_price,
                'attribute_filters' => $attribute_filters,
                'filter:manufacturer' => $manufacturerFilter
            );

            $product_total = $this->model_catalog_product->getTotalProducts($data);

            $results = $this->model_catalog_product->getProducts($data);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                } else {
                    $image = false;
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }

                $this->data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'rating' => $result['rating'],
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'path=' . $this->request->get['path_ajax'] . '&product_id=' . $result['product_id'])
                );
            }

            $url = '';

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }


            // Filters Pro
            if (isset($this->request->get['filter:price'])) {
                $url .= '&filter:price=' . $this->request->get['filter:price'];
            }
            if (isset($this->request->get['filter:manufacturer'])) {
                $url .= '&filter:manufacturer=' . $this->request->get['filter:manufacturer'];
            }
            $attribute_filters = array();
            foreach ($this->request->get as $key => $value) {
                if (strstr($key, 'filter_attribute_')) {
                    $url .= '&' . $key . '=' . $value;
                }
            }
            // Filters Pro


            $this->data['sorts'] = array();

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_default'),
                'value' => 'p.sort_order-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=p.sort_order&order=ASC' . $url)
            );

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_name_asc'),
                'value' => 'pd.name-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=pd.name&order=ASC' . $url)
            );

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_name_desc'),
                'value' => 'pd.name-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=pd.name&order=DESC' . $url)
            );

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_price_asc'),
                'value' => 'p.price-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=p.price&order=ASC' . $url)
            );

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_price_desc'),
                'value' => 'p.price-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=p.price&order=DESC' . $url)
            );

            if ($this->config->get('config_review_status')) {
                $this->data['sorts'][] = array(
                    'text' => $this->language->get('text_rating_desc'),
                    'value' => 'rating-DESC',
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=rating&order=DESC' . $url)
                );

                $this->data['sorts'][] = array(
                    'text' => $this->language->get('text_rating_asc'),
                    'value' => 'rating-ASC',
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=rating&order=ASC' . $url)
                );
            }

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_model_asc'),
                'value' => 'p.model-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=p.model&order=ASC' . $url)
            );

            $this->data['sorts'][] = array(
                'text' => $this->language->get('text_model_desc'),
                'value' => 'p.model-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . '&sort=p.model&order=DESC' . $url)
            );

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }


            // Filters Pro
            if (isset($this->request->get['filter:price'])) {
                $url .= '&filter:price=' . $this->request->get['filter:price'];
            }
            if (isset($this->request->get['filter:manufacturer'])) {
                $url .= '&filter:manufacturer=' . $this->request->get['filter:manufacturer'];
            }
            $attribute_filters = array();
            foreach ($this->request->get as $key => $value) {
                if (strstr($key, 'filter_attribute_')) {
                    $url .= '&' . $key . '=' . $value;
                }
            }
            // Filters Pro


            $this->data['limits'] = array();

            $this->data['limits'][] = array(
                'text' => $this->config->get('config_catalog_limit'),
                'value' => $this->config->get('config_catalog_limit'),
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&limit=' . $this->config->get('config_catalog_limit'))
            );

            $this->data['limits'][] = array(
                'text' => 25,
                'value' => 25,
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&limit=25')
            );

            $this->data['limits'][] = array(
                'text' => 50,
                'value' => 50,
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&limit=50')
            );

            $this->data['limits'][] = array(
                'text' => 75,
                'value' => 75,
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&limit=75')
            );

            $this->data['limits'][] = array(
                'text' => 100,
                'value' => 100,
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&limit=100')
            );

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


            // Filters Pro
            if (isset($this->request->get['filter:price'])) {
                $url .= '&filter:price=' . $this->request->get['filter:price'];
            }
            if (isset($this->request->get['filter:manufacturer'])) {
                $url .= '&filter:manufacturer=' . $this->request->get['filter:manufacturer'];
            }
            $attribute_filters = array();
            foreach ($this->request->get as $key => $value) {
                if (strstr($key, 'filter_attribute_')) {
                    $url .= '&' . $key . '=' . $value;
                }
            }
            // Filters Pro


            $pagination = new Pagination();
            $pagination->total = $product_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->text = $this->language->get('text_pagination');
            $pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path_ajax'] . $url . '&page={page}');

            $this->data['pagination'] = $pagination->render();

            $this->data['sort'] = $sort;
            $this->data['order'] = $order;
            $this->data['limit'] = $limit;

            $this->data['continue'] = $this->url->link('common/home');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/an_filters_category_ajax.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/module/an_filters_category_ajax.tpl';
            } else {
                $this->template = 'default/template/module/an_filters_category_ajax.tpl';
            }

            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom'
            );

            $this->data['json']['categoryView'] = $this->render();
        } else {
            $url = '';

            if (isset($this->request->get['path_ajax'])) {
                $url .= '&path=' . $this->request->get['path_ajax'];
            }

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

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/category', $url),
                'separator' => $this->language->get('text_separator')
            );

            $this->document->setTitle($this->language->get('text_error'));

            $this->data['heading_title'] = $this->language->get('text_error');

            $this->data['text_error'] = $this->language->get('text_error');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->data['continue'] = $this->url->link('common/home');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
            } else {
                $this->template = 'default/template/error/not_found.tpl';
            }

            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom'
            );

            $this->data['json']['categoryView'] = $this->render();
        }

        $this->data['json']['anFilters'] = $this->index();

        $this->response->setOutput(json_encode($this->data['json']));

    }

}

?>