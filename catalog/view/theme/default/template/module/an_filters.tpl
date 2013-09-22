<?php if ($attributes || $priceFilters || $manufacturerFilters): ?>
<?php if (!$ajaxDataOnly): ?>
    <style type="text/css">
        /* Generic filter styles */
        .box-filter { margin: 0 0 10px; }
        .box-filter ul, .box-filter ul li { margin: 0; padding: 0 0 5px; list-style-type: none; }
        .box-filter ul li a div.checkbox { float: left; border: 1px solid #999; background: #b4c2de; color: #000; width: 10px; height: 10px; margin: 2px 5px 0 0; font-size: 10px; text-align: center; overflow: hidden; }
        .box-filter ul li a div.checkbox span { margin: -1px 0 0 2px; float: left; }
        .box-filter ul li.disabled a div.checkbox { background: #ccc; border: 1px solid #aaa; }
        .box-filter ul li a { text-decoration: none; }
        .box-filter ul li.active a { font-weight: bold; }
        .box-filter ul li.disabled a { color: #999; cursor: default; }
        .box-subheading { border-bottom: 1px solid #eee; font-weight: bold; }
        .priceInput input[type=text] { width: 35px; }
        .priceInput input[type=text].priceError { border: 1px solid red; }
        .clearFilterLink { float: right; }
        .collapse { background: url(catalog/view/theme/default/image/an_filters/arrow_on.jpg) no-repeat 100% 5px transparent; padding-right: 20px; cursor: pointer; }
        .collapse.active { background: url(catalog/view/theme/default/image/an_filters/arrow_off.jpg) no-repeat 98% 5px transparent; }
        
        /* Add scrollbar to values list when max-height is exceeded */
        <?php if ($listMaxHeight > 0): ?>
        .box-filter > ul { max-height: <?php echo $listMaxHeight; ?>px; overflow-y: auto; overflow-x: hidden; }
        <?php endif; ?>
        
        /* AJAX semiopaque overlay & loading GIF */
        #anFiltersLoadingOverlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 9999999999999999999; }
        #anFiltersLoadingOverlay.light { background: url(catalog/view/theme/default/image/an_filters/light_overlay.png) repeat 0 0; }
        #anFiltersLoadingOverlay.dark { background: url(catalog/view/theme/default/image/an_filters/dark_overlay.png) repeat 0 0; }
        #anFiltersLoadingOverlay > #loadingImage { position: fixed; top: 50%; left: 50%; margin: -0px 0 0 -0px; }

        /* Price slider bar */
        .priceSlider { margin: 10px 0; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
        #sliderBar { margin-left: 10px; margin-right: 10px; background: #ebebeb; border: 1px solid #cecece; height: 13px; position: relative; }
        #sliderBarActiveArea { background: #f7ff9f; height: 100%; position: relative; }
        .sliderBarHandle { left: 0; cursor: pointer; background: url('catalog/view/theme/default/image/an_filters/button.png') top left repeat-x; position: absolute; top: -5px; height: 24px; width: 14px; border-radius: 7px; z-index: 50; }
        .sliderBarHandle:hover, .sliderBarHandle.active { background: url('catalog/view/theme/default/image/an_filters/button-active.png') top left repeat-x; }
        #sliderBarHandleLeft { margin-left: -14px; }
        #sliderBarHandleRight { margin-left: 100%; }
        .handleValue { position: absolute; top: 60px; left: 0; }
        #rightHandleValue { margin-left: 100px; }
        
        
    </style>
    <div class="box" id="anFiltersBox">
    <?php endif; ?>
    <span id="ajaxArea">
        <div class="box-heading">
            <?php echo $heading_title; ?>
        </div>
        <div class="box-content">

            <?php foreach ($attributes as $attribute): ?>
                    <div class="box-filter">
                        <div class="box-subheading">
                            <?php if ($collapsible): ?>
                                <span class="collapse">
                                    <?php echo $attribute['name']; ?>
                                </span>
                            <?php else: ?>
                                <?php echo $attribute['name']; ?>
                            <?php endif; ?>

                            <?php if ($attribute['clearUrlEnabled']): ?>
                                <a class="clearFilterLink ajaxLink" href="<?php echo $attribute['clearUrl'] ?>">
                                    <input type="hidden" class="ajaxHref" value="<?php echo $attribute['clearUrl_ajax'] ?>" />
                                    <?php echo $link_clearFilter ?>
                                </a>
                            <?php endif; ?>

                        </div>
                        <ul id="collapse_attribute_<?php echo $attribute['attribute_id']; ?>">
                            <?php foreach ($attribute['values'] as $value): ?>
                                <?php if ($value['is_active']): ?>
                                    <li class="active">
                                        <a class="ajaxLink" href="<?php echo $value['href_off'] ?>">
                                            <input type="hidden" class="ajaxHref" value="<?php echo $value['href_off_ajax'] ?>" />
                                            <div class="checkbox"><span>X</span></div>
                                            <?php echo $value['text'] ?> </a>
                                    </li>
                                <?php else: ?>
                                    <?php if ($value['total'] > 0): ?>
                                        <li>
                                            <a class="ajaxLink" href="<?php echo $value['href'] ?>">
                                                <input type="hidden" class="ajaxHref" value="<?php echo $value['href_ajax'] ?>" />
                                                <div class="checkbox"></div>
                                                <?php echo $value['text'] ?> <!--(<?php echo $value['total'] ?>)--></a>
                                        </li>
                                    <?php else: ?>
                                        <li class="disabled">
                                            <div class="checkbox"></div>
                                            <a>
                                                <div class="checkbox"></div>
                                                <?php echo $value['text'] ?> </a>
                                        </li>
                                    <?php endif; ?>
                                <?php endif; ?>

                            <?php endforeach; ?>
                        </ul>
                    </div>
            <?php endforeach; ?>


            <!-- Manufacturers -->
            <?php if ($manufacturerFilters): ?>
            <div class="box-filter">
                <div class="box-subheading">
                    <?php if ($collapsible): ?>
                        <span class="collapse">
                            <?php echo $entry_manufacturer; ?>
                        </span>
                    <?php else: ?>
                        <?php echo $entry_manufacturer; ?>
                    <?php endif; ?>
                    
                    
                    <?php if ($manufacturerFilterInUse): ?>
                        <a class="clearFilterLink ajaxLink" href="<?php echo $manufacturerClearHref ?>">
                            <?php echo $link_clearFilter ?>
                            <input type="hidden" class="ajaxHref" value="<?php echo $manufacturerClearHrefAjax ?>" />
                        </a>
                    <?php endif; ?>
                </div>
                <ul id="collapse_manufacturer">
                    <?php foreach ($manufacturerFilters as $manufacturerFilter): ?>
                        <?php if ($manufacturerFilter['isActive']): ?>
                            <li class="active">
                                <a class="ajaxLink" href="<?php echo $manufacturerFilter['hrefOff'] ?>">
                                    <input type="hidden" class="ajaxHref" value="<?php echo $manufacturerFilter['hrefOffAjax'] ?>" />
                                    <div class="checkbox"><span>X</span></div>
                                    <?php echo $manufacturerFilter['text'] ?>
                                </a>
                            </li>
                        <?php else: ?>
                            <?php if ($manufacturerFilter['total'] > 0): ?>
                                <li>
                                    <a class="ajaxLink" href="<?php echo $manufacturerFilter['href'] ?>">
                                        <input type="hidden" class="ajaxHref" value="<?php echo $manufacturerFilter['hrefAjax'] ?>" />
                                        <div class="checkbox"></div>
                                        <?php echo $manufacturerFilter['text'] ?>
                                    </a>
                                </li>
                            <?php else: ?>
                                <li class="disabled">
                                    <a>
                                        <div class="checkbox"></div>
                                        <?php echo $manufacturerFilter['text'] ?>
                                    </a>
                                </li>
                            <?php endif; ?>
                        <?php endif; ?>

                    <?php endforeach; ?>

                </ul>
            </div>
            <?php endif; ?>

            <!-- Prices -->
            <?php if ($this->config->get('an_filters_price_filters_status') && ($this->config->get('an_filters_price_slider_status') || $priceFilters)): ?>
                <div class="box-filter">
                    <div class="box-subheading">
                        <?php if ($collapsible): ?>
                            <span class="collapse">
                                <?php echo $entry_price; ?>
                            </span>
                        <?php else: ?>
                            <?php echo $entry_price; ?>
                        <?php endif; ?>
                        
                        
                        <?php if ($priceFilterInUse): ?>
                            <a class="clearFilterLink ajaxLink" href="<?php echo $clearPriceFilterUrl ?>">
                                <?php echo $link_clearFilter ?>
                                <input type="hidden" class="ajaxHref" value="<?php echo $clearPriceFilterUrl_ajax ?>" />
                            </a>
                        <?php endif; ?>
                    </div>
                    <ul id="collapse_price">
                        <?php foreach ($priceFilters as $priceFilter): ?>
                            <?php if ($priceFilter['is_active']): ?>
                                <li class="active">
                                    <a class="ajaxLink" href="<?php echo $priceFilter['href_off'] ?>">
                                        <input type="hidden" class="ajaxHref" value="<?php echo $priceFilter['href_off_ajax'] ?>" />
                                        <div class="checkbox"><span>X</span></div>
                                        <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_from'] . $this->data['currencySymbolRight'] ?> - <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_to'] . $this->data['currencySymbolRight'] ?></a>
                                </li>
                            <?php else: ?>
                                <?php if ($priceFilter['total'] > 0): ?>
                                    <li>
                                        <a class="ajaxLink" href="<?php echo $priceFilter['href'] ?>">
                                            <input type="hidden" class="ajaxHref" value="<?php echo $priceFilter['href_ajax'] ?>" />
                                            <div class="checkbox"></div>
                                            <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_from'] . $this->data['currencySymbolRight'] ?> - <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_to'] . $this->data['currencySymbolRight'] ?></a>
                                    </li>
                                <?php else: ?>
                                    <li class="disabled">
                                        <div class="checkbox"></div>
                                        <a>
                                            <div class="checkbox"></div>
                                            <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_from'] . $this->data['currencySymbolRight'] ?> - <?php echo $this->data['currencySymbolLeft'] . $priceFilter['price_to'] . $this->data['currencySymbolRight'] ?></a>
                                    </li>
                                <?php endif; ?>
                            <?php endif; ?>

                        <?php endforeach; ?>

                    </ul>

                    <?php if ($this->config->get('an_filters_price_slider_status')): ?>
                        <div class="priceSlider" id="priceSlider">

                            <div id="sliderBar">
                                <div id="sliderBarActiveArea"></div>
                                <div href="#" class="sliderBarHandle" id="sliderBarHandleLeft"></div>
                                <div href="#" class="sliderBarHandle" id="sliderBarHandleRight"></div>
                            </div>
                            <script type="text/javascript">
                                $(document).ready(function() {
                                    // Price slider // Run on page load
                                    $maxAmount = <?php echo $maxPrice ?>;
                                    leftHandleAmount = <?php echo !empty($activePriceFilter['from']) ? $activePriceFilter['from'] : '0.00'; ?>;
                                    rightHandleAmount = <?php echo !empty($activePriceFilter['to']) ? $activePriceFilter['to'] : round($maxPrice); ?>;
                                    
                                    if ((rightHandleAmount <= $maxAmount)) {
                                        $('#sliderBarHandleRight').css('margin-left', ($('#sliderBar').width()  - $('#sliderBarHandleLeft').width()) * (rightHandleAmount / $maxAmount));
                                    } else {
                                        $('#sliderBarHandleRight').css('margin-left', ($('#sliderBar').width()  - $('#sliderBarHandleLeft').width()));
                                    }
                                    $('#sliderBarHandleLeft').css('margin-left', ($('#sliderBar').width() * (leftHandleAmount / $maxAmount)) - $('#sliderBarHandleLeft').width());
                                    $('#priceFrom').val(leftHandleAmount);
                                    $('#priceTo').val(rightHandleAmount);
                                    $('#sliderBarActiveArea').css('margin-right', $('#sliderBar').width() - parseFloat($('#sliderBarHandleRight').css('margin-left')));
                                    $('#sliderBarActiveArea').css('margin-left', parseFloat($('#sliderBarHandleLeft').css('margin-left')));
                                })
                            </script>
                        </div>

                        <div class="priceInput">

                            <?php echo $this->data['currencySymbolLeft'] ?>
                            <input type="text" value="<?php echo $activePriceFilter['from'] ?>" id="priceFrom" size="1"/> 
                            <?php echo $entry_to ?>
                            <input type="text" value="<?php echo $activePriceFilter['to'] ?>" id="priceTo" size="1"/>
                            <?php echo $this->data['currencySymbolRight'] ?>
                            <input type="hidden" id="clearPriceUrl" value="<?php echo $clearPriceFilterUrl ?>" />
                            <input type="hidden" id="clearPriceUrl_ajax" value="<?php echo $clearPriceFilterUrl_ajax ?>" />
                            <a class="button" id="priceSubmit"><span><?php echo $link_go ?></span></a>

                        </div>
                    <?php endif; ?>

                </div>
            <?php endif; ?>
            
        </div>
    </span>
    <?php if (!$ajaxDataOnly): ?>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            
            // Collapsible links
            <?php if ($collapsible): ?>
                $('.box-filter ul').each(function() {
                    
                    <?php if ($collapsed_by_default): ?>
                            if ($.cookie($(this).attr('id')) == null) {
                                console.log('setting true');
                                $.cookie($(this).attr('id'), 'true');
                            }
                    <?php endif; ?>
                        
                        console.log($.cookie($(this).attr('id')));

                    if ($.cookie($(this).attr('id')) == 'true') {
                        $(this).hide();
                        $(this).parent('.box-filter').children('.box-subheading').children('.collapse').addClass('active');
                    }
                })
                $('.box-subheading .collapse').live('click', function() {
                    if ($(this).hasClass('active')) {
                        $(this).removeClass('active');
                        $.cookie($(this).parent('.box-subheading').parent('.box-filter').children('ul').attr('id'), 'false');
                    } else {
                        $(this).addClass('active');
                        $.cookie($(this).parent('.box-subheading').parent('.box-filter').children('ul').attr('id'), 'true');
                    }

                    $(this).parent('.box-subheading').parent('.box-filter').children('ul').slideToggle(200);
                })
            <?php endif; ?>

            // Price slider
            $('.sliderBarHandle').live('mousedown', function(e) {
                $handle = $(this);
                $mousedown = true;
                $marginLeft = parseFloat($($handle).css('margin-left'));
                $maxAmount = <?php echo $maxPrice ?>;
                cursorLeftStart = e.pageX;
                cursorTopStart = e.pageX;
                            
                $($handle).addClass('active');
                
                $(document).bind('mouseup', function() {                    
                    $($handle).removeClass('active');
                    $mousedown = false;
                })

                $(document).bind('mousemove', function(e) {

                    if ($mousedown == true) {                        
                        cursorLeftNew = e.pageX;
                        cursorTopNew = e.pageX;

                        newMarginLeft = $marginLeft + (cursorLeftNew - cursorLeftStart)
                        maxMarginLeft = $('#sliderBar').width() - $handle.width();
                        minMarginLeft = 0 - $($handle).width();

                        if (newMarginLeft != $marginLeft) {

                            leftHandleAmount = Math.round(((parseFloat($('#sliderBarHandleLeft').css('margin-left')) + $('#sliderBarHandleLeft').width()) / maxMarginLeft) * $maxAmount);
                            rightHandleAmount = Math.round(((parseFloat($('#sliderBarHandleRight').css('margin-left')) /*- $('#sliderBarHandleRight').width()*/) / maxMarginLeft) * ($maxAmount/* + ($('#sliderBarHandleRight').width() * 2)*/));

                            if ($($handle).attr('id') == 'sliderBarHandleRight') {
                                minMarginLeft = parseFloat($('#sliderBarHandleLeft').css('margin-left')) + $('#sliderBarHandleLeft').width();
                            } else {
                                maxMarginLeft = parseFloat($('#sliderBarHandleRight').css('margin-left')) - $('#sliderBarHandleRight').width();
                            }

                            if (leftHandleAmount <= rightHandleAmount) {
                                $($handle).css('margin-left', $marginLeft + (cursorLeftNew - cursorLeftStart));
                                $('#priceFrom').val(leftHandleAmount);
                                $('#priceTo').val(rightHandleAmount);
                            }
                                        

                            if (parseFloat($($handle).css('margin-left')) < minMarginLeft) {
                                $($handle).css('margin-left', minMarginLeft);
                            }
                            if (parseFloat($($handle).css('margin-left')) > maxMarginLeft) {
                                $($handle).css('margin-left', maxMarginLeft);
                            }
                                        
                            $('#sliderBarActiveArea').css('margin-right', $('#sliderBar').width() - parseFloat($('#sliderBarHandleRight').css('margin-left')));
                            $('#sliderBarActiveArea').css('margin-left', parseFloat($('#sliderBarHandleLeft').css('margin-left')));
                        }

                    }

                })

            })



            // AJAXify links
    <?php if ($ajax_enabled): ?>
                function anFiltersLoad(_ajaxHref, _staticHref) {
                    if ($('#anFiltersLoadingOverlay').length < 1) {
                        $('body').append('<div id="anFiltersLoadingOverlay" class="light"><img id="loadingImage" src="catalog/view/theme/default/image/an_filters/loading.gif" /></div>');
                    }
                    $('#anFiltersLoadingOverlay').fadeIn('slow');
                    $.ajax({
                        url: _ajaxHref,
                        dataType: 'json',
                        success: function(json) {

                            if (json['categoryView'] && json['anFilters']) {
                                $('#anFiltersLoadingOverlay').fadeOut('fast');
                                $('#content').html(json['categoryView']);
                                $('#anFiltersBox').html(json['anFilters']);

                                view = $.cookie('display');
                                if (view) {
                                    display(view);
                                } else {
                                    display('list');
                                }
                                
                                <?php if ($collapsible): ?>
                                    $('.box-filter ul').each(function() {
                                        if ($.cookie($(this).attr('id')) == 'true') {
                                            $(this).hide();
                                            $(this).parent('.box-filter').children('.box-subheading').children('.collapse').addClass('active');
                                        }
                                    })
                                <?php endif; ?>
                            } else {
                                location = _staticHref;
                            }

                        },
                        error: function() {
                            location = _staticHref;
                        }
                    });
                }

                $('#anFiltersBox a.ajaxLink').live('click', function() {
                    anFiltersLoad($(this).children('input.ajaxHref').val(), $(this).attr('href'));
                    return false;
                })
    <?php endif; ?>

            // Price input validation

            $('#priceSubmit').live('click', function() {
                _error = false;

                // Don't allow a larger priceFrom value than the priceTo value
                if (parseFloat($('#priceFrom').val()) >= parseFloat($('#priceTo').val())) {
                    $('#priceFrom').val($('#priceTo').val() - 1);
                }

                if ($('#priceFrom').val().length < 1 && $('#priceTo').val().length < 1) {
                    $('#priceFrom, #priceTo').removeClass('priceError');
                    _staticHref = $('#clearPriceUrl').val();
                    _ajaxHref = $('#clearPriceUrl_ajax').val();
                    
    <?php if ($ajax_enabled): ?>
                        anFiltersLoad(_ajaxHref, _staticHref)
    <?php else: ?>
                        location = _staticHref
    <?php endif; ?>

                } else {

                    if ($('#priceFrom').val().length < 1) {
                        $('#priceFrom').val('0.00')
                    } else {
                        $('#priceFrom').removeClass('priceError');
                    }
                    if ($('#priceTo').val().length < 1) {
                        $('#priceTo').addClass('priceError');
                        _error = true;
                    } else {
                        $('#priceTo').removeClass('priceError');
                    }

                    if (_error != true) {

                        _staticHref = $('#clearPriceUrl').val();
                        _staticHref += '&filter:price=' + $('#priceFrom').val() + '-' + $('#priceTo').val();
                        _ajaxHref = $('#clearPriceUrl_ajax').val();
                        _ajaxHref += '&filter:price=' + $('#priceFrom').val() + '-' + $('#priceTo').val();

    <?php if ($ajax_enabled): ?>

                            anFiltersLoad(_ajaxHref, _staticHref)
    <?php else: ?>
        
                            location = _staticHref
    <?php endif; ?>
                    }
                }

            })
        })
    </script>
<?php endif; ?>
<?php endif; ?>