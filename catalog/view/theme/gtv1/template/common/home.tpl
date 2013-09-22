<?php echo $header; ?>
<div id="topcontent">
<?php echo $position_slider; ?>
<div id="bannerwrap">
<?php echo $position_banner; ?>
</div>
<?php echo $content_top; ?>
</div>
<div id="wrap" class="white-wrap">
<div id="content">
  <div class="black-heading">
    <a href="javascript:ResetFilters();" id="ch-filter_reset" class="part"><?php echo $text_all_products; ?></a>
    <!--<a href="javascript:FilterBestsellers();" id="ch-filter_bestseller" class="part"><?php echo $text_bestsellers; ?></a>-->
    <a href="javascript:FilterPreorders();" id="ch-filter_preorder" class="part"><?php echo $text_preorders; ?></a>
    <a href="javascript:FilterSpecials();" id="ch-filter_special" class="part"><?php echo $text_specials; ?></a>
    <?php if ($manufacturers) { ?>
      <div class="part" id="ch-filter_platform">
        <p><?php echo $text_byplatform; ?> <span><?php echo $text_select; ?> &blacktriangledown;</span></p>
        <div class="plt">
          <ul>
            <?php foreach ($manufacturers as $manufacturer) { ?>
              <li><a href="javascript:ChangeManufacturer(<?php echo $manufacturer['manufacturer_id']; ?>,'<?php echo $manufacturer['name']; ?>');"><?php echo $manufacturer['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
      </div>  
    <?php } ?>
    <?php if ($categories) { ?>
      <div class="part" id="ch-filter_category">
        <p><?php echo $text_bycategory; ?> <span><?php echo $text_select; ?> &blacktriangledown;</span></p>
        <div class="cat">
          <ul>
            <?php foreach ($categories as $category) { ?>
              <li><a href="javascript:ChangeCategory(<?php echo $category['category_id']; ?>,'<?php echo $category['name']; ?>');"><?php echo $category['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
      </div>  
    <?php } ?>
    <a href="javascript:FilterCheap();" id="ch-filter_cheap" class="part"><?php echo $text_under_twenty; ?></a>  
    <div style="clear:both;"></div>
  </div>
  <?php if ($products) { ?>
    <div class="product-filter" style="display:none;">
      <!--<div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>-->
      <div class="limit"><?php echo $text_limit; ?>
        <select onchange="/*location = this.value;*/$('#product-list').load(this.value +' #product-list');">
          <?php foreach ($limits as $limits) { ?>
          <?php if ($limits['value'] == $limit) { ?>
          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
      <div class="sort"><?php echo $text_sort; ?>
        <select onchange="/*location = this.value;*/$('#product-list').load(this.value +' #product-list');">
          <?php foreach ($sorts as $sorts) { ?>
          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
    </div>
    <!--<div class="product-compare" style="display:none;"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>-->
    <div class="product-list" id="product-list">
      <?php foreach ($products as $product) { ?>
      <div class="product">
        <?php if ($product['thumb']) { ?>
          <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <div class="description"><?php echo $product['short_description']; ?></div>
        <div class="platform"><?php echo $product['manufacturer']; ?></div>
        <?php if ($product['price']) { ?>
          <?php if (!$product['special']) { ?>
          <div class="price" onclick="addToCart('<?php echo $product['product_id']; ?>');">
            <span class="price-only"><?php echo $product['price']; ?></span>
          </div>
          <?php } else { ?>
          <div class="price" onclick="addToCart('<?php echo $product['product_id']; ?>');">
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          </div>
          <?php } ?>
        <?php } ?>
        <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="addtocart cart greenybutton" />      
      </div>
      <?php } ?>
      <div style="clear:both;"></div>
    </div>
    <!--<div class="pagination"><?php echo $pagination; ?></div>-->
    <h3 class="bluepaging" id="loadmore" style="cursor:pointer;"><?php echo $text_showmore; ?></h3>
    <div id="preloader" style="display:none;"></div>
    <div id="preloader2" style="display:none;"></div>
  <?php } else { ?>
    <div class="product-list" id="product-list"></div>
    <div id="preloader" style="display:none;"></div>
    <div id="preloader2" style="display:none;"></div>
    <h3 class="bluepaging" id="loadmore"><?php echo $text_empty; ?></h3>
  <?php }?>
<!--<script type="text/javascript">
/*function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';
						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
						
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
						
			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.totalStorage('display', 'grid');
	}
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('list');
}*/
</script>-->
</div>
<div style="clear: both;"></div>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
<script type="text/javascript">
var textloading = "<?php echo $text_loading; ?>";
var textshowmore = "<?php echo $text_showmore; ?>";
var textnomore = "<?php echo $text_nomore; ?>";
var textselect = "<?php echo $text_select; ?>";

var pagetoload = parseInt("<?php echo $page; ?>")+1;
var filter_manufacturer_id = "<?php echo $filter_manufacturer_id; ?>";
var filter_category_id = "<?php echo $filter_category_id; ?>";
var filter_special = "<?php echo $filter_special; ?>";
var filter_shown = "<?php echo $filter_shown; ?>";
var filter_cheap = "<?php echo $filter_cheap; ?>";
var filter_preorder = "<?php echo $filter_preorder; ?>";
var filter_bestseller = "<?php echo $filter_bestseller; ?>";

var limit = parseInt("<?php echo $limit; ?>") * parseInt("<?php echo $page; ?>");
var origlimit = parseInt("<?php echo $limit; ?>");
var page = "<?php echo $page; ?>";

$(document).ready(function(){
  CheckboxSessionProducts();
  WasLastProducts();
  //Evenize();
  RhinoOn();
  $('.home-link').addClass('active').parent().addClass('active');
});
$('.home-link, #logo').live("click", function() {
  ResetFilters();
  return false;
});
</script>