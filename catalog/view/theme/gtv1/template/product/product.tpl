<?php echo $header; ?>

<div id="topcontent">

<link rel="stylesheet" type="text/css" href="css/style1.css" />
<script language="javascript" type="text/javascript" src="js/jquery.easing.js"></script>
<script language="javascript" type="text/javascript" src="js/script.js"></script>
<script type="text/javascript">
 $(document).ready( function(){	
		// buttons for next and previous item						 
		var buttons = { 
            previous:$('.navigator-content .button-previous') ,
						next:$('.navigator-content .button-next') };			
  		        $('#jslidernews1').lofJSidernews( { 
                  interval         : 5000,
  								direction		     : 'opacitys',	
  								easing			     : 'easeInOutExpo',
  								duration		     : 1000,
  								auto		 	       : false,
  								maxItemDisplay   : 6,
  								navPosition      : 'horizontal', // horizontal
  								navigatorHeight  : 80,
  								navigatorWidth   : 105,
  								mainWidth		     : 655,
                  buttons			     : buttons 
                } );	
	});
</script>
<h1 class="aboveopacitor"><?php echo $heading_title; ?></h1>
<div class="blackbannerwrap">
  <div id="jslidernews1" class="lof-slidecontent">
  	<div class="preload"><div></div></div>
      		 <!-- MAIN CONTENT --> 
                <div class="main-slider-content">
                  <ul class="sliders-wrap-inner">
  			
  		 <?php 	foreach($images as $im)
  	     {
  		 if($im['image']!=''):
  		 ?>
  		 
                      <li>
                             <?php
  		 if($im['type_iv']==2)
  		 {
  		 $vfile=explode('?v=',$im['image']);
  		 if(!isset($vfile[1]))
  		 {
  		 $vfile=explode('&v=',$im['image']);
  		 } else if(!isset($vfile[1]))
  		 {
  		 $vfile=explode('embed/',$im['image']);
  		 $vfile[1]=$vfile[count($vfile-1)];
  		 }
  		 
  		 if(isset($vfile[1]))
  		 {
  		 echo '<iframe width="655" height="434" src="http://www.youtube.com/embed/'.$vfile[1].'?fs=1" frameborder="0" allowfullscreen="true"></iframe>';
  		 }
  		 }
  		 else if($im['type_iv']==3)
  		 {
  		 echo '<img src="'.$im['image'].'" style="height:434px;width:655px;">';
  		 
  		  }
  		 else
  		 {
  		 echo '<img src="image/'.$im['image'].'" style="height:434px;width:655px;">';
  		 
  		  }
  		  ?>
  		  
                      </li> 
  					<?php endif;
  		 }
  		 ?>
                    </ul>  	
              </div>
   		   <!-- END MAIN CONTENT --> 
             <!-- NAVIGATOR -->
             	<div class="navigator-content">
                <div class="button-previous">Previous</div>
                <div class="button-next">Next</div>
  				  <!--<div style="width:540px;float:left;padding:0 7px;display:none;">
                    <div class="navigator-wrapper">
                          <ul class="navigator-wrap-inner">
           <?php 	foreach($images as $im)
  	     {
  		 if($im['image']!=''):
  		 ?>
  		 
                      <li>
  					<div class="imgdv">
                             <?php
  		 if($im['type_iv']==2)
  		 {
  		 $vfile=explode('?v=',$im['image']);
  		 if(isset($vfile[1]))
  		 {
  		 //echo '<img src="image/youtubeimg.jpg" style="height:69px;width:91px;margin-top:-1px;margin-left:-1px;">';
       echo '<img class="youtubethumb thumb" src="http://i1.ytimg.com/vi/'.$vfile[1].'/mqdefault.jpg">';
  		 }
  		 }
  		 elseif($im['type_iv']==3 && $im['image']!='')
  		 {
  		 echo '<img class="thumb" src="'.$im['image'].'">';
  		 }
  		 else
  		 {
  		 echo '<img class="thumb" src="image/'.$im['image'].'">';
  		 
  		}
  		  ?>
  		  </div>
  		  
                      </li> 
  					<?php endif;
  		 }
  		 ?>                  </ul>
                    </div></div>-->
               </div> 
            <!-- BUTTON PLAY-STOP -->
            <div class="button-control"><span></span></div>
             <!-- END OF BUTTON PLAY-STOP -->
  </div> 
  <div class="bannerwrap">
    <div class="product-sideinfo">
      <!--<div class="cont image">
        <img src="<?php echo $sidepic; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" width="285px" height="108px"/>
      </div>
      <div class="cont">
        <?php if ($price) { ?>
          <?php if (!$special) { ?>
          <!--<div class="save lightblackbutton"><span class="price-save">-0%</span></div>-->
          <!--<div class="price darkbluebutton" style="margin:0px;">
            <span class="price-only"><?php echo $price; ?></span>
          </div>
          <div style="min-width: 197px;" class="cart bluebutton"><input style="background-position:52px center;" type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product_id; ?>');" class="addtocart" /></div>
          <?php } else { ?>
          <div class="save lightblackbutton"><span class="price-save">-<?php echo $saving; ?>%</span></div>
          <div class="price darkbluebutton">
            <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
          </div>
          <div class="cart bluebutton"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product_id; ?>');" class="addtocart" /></div>
          <?php } ?>
        <?php } ?>
        <div style="clear: both;"></div>
      </div>-->
      <div class="cont texts">
        <h4><?php echo $heading_title; ?></h4>
        <p><?php echo $text_genre; ?>:<span> <?php echo $genre; ?></span></p>
        <p><?php echo $text_developer; ?>:<span> <?php echo $developer; ?></span></p>
        <p><?php echo $text_publisher; ?>:<span> <?php echo $publisher; ?></span></p>
        <p><?php echo $text_date_available; ?>:<span> <?php echo $date_available; ?></span></p>
        <p><?php echo $text_os; ?>: <span><?php if ($os) {$it = 1;foreach(explode(",",$os) as $os1){if($it>1){$os1 = ucfirst($os1);echo ", ".$os1; } else {echo ucfirst($os1);}$it++;}} ?></span></p>  
        <p><?php echo $text_langs; ?>: <span><?php echo $langs; ?></span></p>
        <!--<?php if ($langs) { ?> 
          <?php foreach (explode(",", $langs) as $lang) { ?> 
            <img src="catalog/view/theme/gtv1/image/languages/<?php echo $lang; ?>.png" alt="<?php echo $lang; ?>" width="16px" height="11px" />
          <?php } ?>
        <?php } ?>-->
        <p><?php echo $text_pegi; ?>:<span> <?php echo $pegi; ?></span></p>  
      </div>
      <div class="cont deliverytexts">     
      <img src="catalog/view/theme/gtv1/image/delivery/platform/<?php echo $activation_platform; ?>.png" alt="<?php echo $activation_platform; ?>" />
      <span>
        <?php if ($manufacturer_id == 15) {
          echo $activation_text_xbox;
        } else if ($manufacturer_id == 16) {
          echo $activation_text_psn;
        } else {
          echo $activation_text;
        }?>
      </span>
      <div style="clear:both"></div>
      </div>
    </div>
    <?php echo $position_banner; ?>
  </div>
  <div style="clear:both;"></div>
</div>
<?php echo $content_top; ?>
<div style="clear: both;"></div>
</div>
<div id="wrap" class="checkout-wrap">
  <div class="black-heading">
    <?php foreach ($products as $product) { ?>
      <?php if($product['shown'] == 1) { ?>
        <a class="part" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
      <?php } ?>
    <?php } ?>
    <a class="part active"><?php echo $heading_title; ?></a>
    <?php foreach ($products as $product) { ?>
      <?php if($product['shown'] != 1) { ?>
        <a class="part" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
      <?php } ?>
    <?php } ?>
    <div style="clear:both;"></div>
  </div>
  <?php echo $column_left; ?>
  <div id="column-right" class="whity">
    <!--<div id="sideaffiliate" class="greybuttonbase">
      <a class="greenbutton"><?php echo $text_recommend; ?></a>
    </div>-->
    <div class="sideblock clear full extreviews">
      <div class="productshare">
        <p><?php echo $text_share; ?></p>
        <!-- AddThis Button BEGIN -->
        <div class="addthis_toolbox addthis_counter_style" style="position:relative;padding:20px 0;">
        <a class="addthis_button_facebook_like" fb:like:layout="box_count" style="height:61px;float:left;position:absolute;top:1px;"></a>
        <a class="addthis_button_tweet" tw:count="vertical" style="float:left;margin:-2px 0 0 52px;"></a>
        <a class="addthis_button_google_plusone" g:plusone:size="tall" style="float:left;margin:0 8px;"></a>
        <a class="addthis_counter" style="float:left"></a>
        <!--<a class="addthis_button_orkut"><img src="catalog/view/theme/gtv1/image/share/orkut.png" title="Orkut" alt="Orkut"/></a>-->
        </div>
        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js" async></script>
        <!-- AddThis Button END -->
      </div>
      <div class="nongreybuttonbase">
        <a href="<?php echo $link_community; ?>" class="darkestbluebutton roundbutton"><?php echo $text_joincommunity; ?></a>
      </div>  
    </div>
    <!--<?php if ($attribute_groups) { ?>  
      <div class="sideblock full extreviews">
        <?php foreach ($attribute_groups as $attribute_group) { ?>
          <?php if ($attribute_group['name'] == 'External Reviews') { ?>
            <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
              <?php if ($attribute['name'] == 'Rank') { ?>
                <div class="top">
                  <img src="catalog/view/theme/gtv1/image/reviews/metacritic.png" alt="Metacritic" />
                  <div class="rankouter">
                    <div class="rankwrap">
                      <div class="rank" style="width:<?php echo $attribute['text']; ?>">
                        <span class="left"><?php echo $attribute['name']; ?></span>
                        <span class="right"><?php echo $attribute['text']; ?></span>
                      </div>
                    </div>
                  </div>
                </div>
              <?php } ?>  
            <?php } ?>
            <div class="bot">
              <p><?php echo $text_read; ?></p>
              <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                <?php if ($attribute['name'] != 'Rank') { ?>
                  <?php if ($attribute['text'] != '') { ?><a href="<?php echo $attribute['text']; ?>" target="_blank" rel="nofollow"><img class="on"<?php } else { ?><a href="javascript:void(0);"><img <?php } ?> src="catalog/view/theme/gtv1/image/reviews/<?php echo $attribute['name']; ?>.png" alt="<?php echo $attribute['name']; ?>" title="<?php echo $attribute['name']; ?>" /></a>
                <?php } ?>
              <?php } ?>
            </div>
          <?php } ?>  
        <?php } ?>
      </div>
    <?php } ?>-->
    <?php if ($attribute_groups && $iscard == 0) { ?>  
      <div class="sidepart full extreviews">
        <?php foreach ($attribute_groups as $attribute_group) { ?>
          <?php if ($attribute_group['name'] == 'External Reviews') { ?>
            <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
              <?php if ($attribute['name'] == 'Rank') { ?>
                <div class="metascore">
                  <span><?php echo $text_metascore; ?></span>
                  <em><?php if ($attribute['text'] != '') {echo $attribute['text'];} else {echo 'NA';} ?></em>
                </div>
              <?php } ?>  
            <?php } ?>
            <div class="others">
              <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                <?php if ($attribute['name'] != 'Rank') { ?>
                  <?php if ($attribute['text'] != '' && $attribute['name'] != 'Kotaku') { ?>
                    <a href="<?php echo $attribute['text']; ?>" target="_blank" rel="nofollow" class="extsingle"><?php echo $attribute['name']; ?>.com<span><?php echo $text_read; ?></span></a>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            </div>
            <!--<div class="bot">
              <p><?php echo $text_read; ?></p>
              <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                <?php if ($attribute['name'] != 'Rank') { ?>
                  <?php if ($attribute['text'] != '') { ?><a href="<?php echo $attribute['text']; ?>" target="_blank" rel="nofollow"><img class="on"<?php } else { ?><a href="javascript:void(0);"><img <?php } ?> src="catalog/view/theme/gtv1/image/reviews/<?php echo $attribute['name']; ?>.png" alt="<?php echo $attribute['name']; ?>" title="<?php echo $attribute['name']; ?>" /></a>
                <?php } ?>
              <?php } ?>
            </div>-->
          <?php } ?>  
        <?php } ?>
        <div style="clear: both;"></div>
      </div>
    <?php } ?>
    <?php echo $column_right; ?>  
    <!--<div style="display:none;" class="side-infobox">
      <h4><?php echo $tab_review; ?></h4>
      <div class="side-infobox-reviews">
        <?php if ($review_status) { ?>
          <?php if ($logged) { ?>
            <div class="review write">
              <div class="image" style="float:left;"><img src="" title="" alt="" id="image" width="80px" height="80px" /></div>
              <input type="text" name="name" value="<?php echo $customer_firstname." ".$customer_lastname; ?>" style="display:none;" />
              <textarea name="text" cols="40" rows="5" placeholder="<?php echo $entry_review; ?>" style="margin-top:0px;"></textarea>
              <br />
              <fieldset id="radio-rating">
                <input type="radio" name="rating" value="5" id="star5" /><label for="star5"></label>
                <input type="radio" name="rating" value="4" id="star4" /><label for="star4"></label>
                <input type="radio" name="rating" value="3" id="star3" /><label for="star3"></label>
                <input type="radio" name="rating" value="2" id="star2" /><label for="star2"></label>
                <input type="radio" name="rating" value="1" id="star1" /><label for="star1"></label>
              </fieldset>
              <a id="button-review" class="bluebutton"><?php echo $text_write; ?></a>
              <div style="clear: both;"></div>
              <div id="review-title"></div>
            </div>
          <?php } ?>
        <?php } ?>
        <div id="review"></div>
      </div>
      <a href="<?php echo $link_all_reviews; ?>" class="side-infobox-content-foot"><span><?php echo $text_all_reviews;?></span></a>
    </div>-->  
  </div>
  <div id="content" class="whity">
  <div class="block innerpadding" style="padding:6px 5px 15px 5px;">
      <div class="left">
        <!--<a href="<?php echo $manufacturers; ?>" class="platform">
          <img src="<?php echo $manufacturer_image; ?>" alt="<?php echo $manufacturer_name; ?>" title="<?php echo $manufacturer_name; ?>" />
        </a>-->
        <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/>
        <h2><?php echo $heading_title; ?></h2>
        <b style="font-weight:normal;display:block;">
          <?php
          if ($sys_date_available >= date("Y-m-d H:i:s", time())){
            echo ($text_preorder);
          } else { 
            if($stock>=1) {
              echo ($stock." ".$text_stock);
            } else {
              echo ($stock);
            }
          }   
          ?>
        </b>
        <?php if ($price) { ?>
          <?php if ($sys_date_available >= date("Y-m-d H:i:s", time())){ ?>
            <?php if (!$special) { ?>
              <div style="bottom:75px;" class="price" onclick="addToCart('<?php echo $product_id; ?>');">
                <span class="price-only"><?php echo $price; ?></span>
              </div>
            <?php } else { ?>
              <div style="bottom:75px;" class="price" onclick="addToCart('<?php echo $product_id; ?>');">
                <span class="price-new"><?php echo $special; ?></span> <span class="price-old"><?php echo $price; ?></span>
              </div>
            <?php } ?>
            <div style="bottom:35px;" class="cart greenybutton"><input type="button" value="<?php echo $text_preorder; ?>" onclick="addToCart('<?php echo $product_id; ?>');" class="addtocart" /></div>
            <p style="display:inline-block;position:absolute;bottom:0;left:136px;"><?php echo $text_get_game; ?> <b><?php echo $date_available; ?></b></p>
          <?php } else { ?>
            <?php if (!$special) { ?>
              <div class="price" onclick="addToCart('<?php echo $product_id; ?>');">
                <span class="price-only"><?php echo $price; ?></span>
              </div>
            <?php } else { ?>
              <div class="price" onclick="addToCart('<?php echo $product_id; ?>');">
                <span class="price-new"><?php echo $special; ?></span> <span class="price-old"><?php echo $price; ?></span>
              </div>
            <?php } ?>
            <div class="cart greenybutton"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product_id; ?>');" class="addtocart" /></div>
          <?php } ?>
        <?php } ?>
      </div>  
      <div style="clear: left;"></div>
    </div>
    <div class="block innerpadding nodesign">
      <!--<h2><?php if($iscard == 0) {echo $tab_description;}else{echo $tab_description_card;} ?></h2>
      <br />-->
      <?php echo $description; ?>
    </div>
    <?php if($shown != 1) { ?>
      <?php foreach ($products as $product) { ?>
        <?php if($product['shown'] == 1) { ?>
          <div class="block innerpadding nodesign">
            <?php echo $product['description']; ?>
          </div>
        <?php } ?>
      <?php } ?>
    <?php } ?>  
    <!-- ALERT !!!!!!!!!!!!!!!!! --><?php foreach ($products as $product) { ?>
      <div class="block innerpadding" style="display:none;">
        <div class="left">
          <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"/>
          <a href="<?php echo $product['href']; ?>"><h2><?php echo $product['name']; ?></h2></a>
          <b style="font-weight:normal;display:block;">
            <?php
            if ($product['sys_date_available'] >= date("Y-m-d H:i:s", time())){
              echo ($text_preorder);
            } else { 
              if($product['stock']>=1) {
                echo ($product['stock']." ".$text_stock);
              } else {
                echo ($product['stock']);
              }
            }   
            ?>
          </b>
          <div class="desc">
            <?php echo $product['description']; ?>
          </div>
          <?php if ($product['price']) { ?>
            <?php if (!$product['special']) { ?>
              <div class="price">
                <span class="price-only" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $product['price']; ?></span>
              </div>
            <?php } else { ?>
              <div class="price">
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $product['price']; ?></span>
              </div>
            <?php } ?>
            <div class="cart greenybutton"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="addtocart" /></div>
          <?php } ?>
        </div>  
        <div style="clear: left;"></div>
      </div>  
    <?php } ?>
    <br />
    <?php if ($attribute_groups && $iscard == 0) { ?>
      <div class="block innerpadding nodesign">
        <!--<h2><?php echo $tab_attribute; ?></h2>
        <br />-->
        <?php foreach ($attribute_groups as $attribute_group) { ?>
          <?php if ($attribute_group['name'] == 'PC System Requirements' || $attribute_group['name'] == 'Mac System Requirements' || $attribute_group['name'] == 'Linux System Requirements') { ?>
            <div>  
              <strong><?php echo $attribute_group['name']; ?>:</strong><br />
              <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                <div class="requirements">
                  <p><b><?php echo $attribute['name']; ?>:</b><br />
                  <?php foreach (explode(";", $attribute['text']) as $req) { ?>
                    <span><?php echo $req; ?></span>
                  <?php } ?>
                  </p>
                </div>  
              <?php } ?>
            <div style="clear: left;"></div>  
            </div>  
          <?php } ?>  
        <?php } ?>
      </div>
      <br />
    <?php } ?>
    <?php if ($attribute_groups) { ?>
      <?php foreach ($attribute_groups as $attribute_group) { ?>
        <?php if ($attribute_group['name'] == 'Additional Texts') { ?>
          <div class="block innerpadding nodesign">
            <h2></h2>
            <br />
            <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
              <p><?php echo $attribute['text'] ?></p>
            <?php } ?>
          </div>
          <br /> 
        <?php } ?>  
      <?php } ?>
    <?php } ?>
    <!--<div class="block innerpadding">
      <h2><?php echo $tab_related; ?></h2>
      <br />
      <div class="box-product">
        <?php foreach ($products as $product) { ?>
        <div class="product">
          <?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
          <?php } ?>
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <div class="cart bluebutton"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"></a></div>
          <?php if ($product['price']) { ?>
          <div class="price darkbluebutton">
            <?php if (!$product['special']) { ?>
            <span class="price-only"><?php echo $product['price']; ?></span>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span><span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
          </div>
        <?php } ?>
      </div>
    </div>
    <br />
    <div class="product-info" style="display: none !important;">
      <?php if ($thumb || $images) { ?>
      <div class="left">
        <?php if ($thumb) { ?>
        <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
        <?php } ?>
        <?php if ($images) { ?>
        <div class="image-additional">
          <?php foreach ($images as $image) { ?>
          <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <div class="right">
        <div class="description">
          <?php if ($manufacturer) { ?>
          <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
          <?php } ?>
          <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
          <?php if ($reward) { ?>
          <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
          <?php } ?>
          <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
        <?php if ($price) { ?>
        <div class="price"><?php echo $text_price; ?>
          <?php if (!$special) { ?>
          <?php echo $price; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
          <?php } ?>
          <br />
          <?php if ($tax) { ?>
          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
          <?php } ?>
          <?php if ($points) { ?>
          <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
          <?php } ?>
          <?php if ($discounts) { ?>
          <br />
          <div class="discount">
            <?php foreach ($discounts as $discount) { ?>
            <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
            <?php } ?>
          </div>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($options) { ?>
        <div class="options">
          <h2><?php echo $text_option; ?></h2>
          <br />
          <?php foreach ($options as $option) { ?>
          <?php if ($option['type'] == 'select') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <select name="option[<?php echo $option['product_option_id']; ?>]">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </option>
              <?php } ?>
            </select>
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'radio') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
            <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
            </label>
            <br />
            <?php } ?>
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'checkbox') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
            <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
            </label>
            <br />
            <?php } ?>
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'image') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <table class="option-image">
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <tr>
                <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label></td>
              </tr>
              <?php } ?>
            </table>
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'text') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'textarea') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'file') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'date') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'datetime') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
          </div>
          <br />
          <?php } ?>
          <?php if ($option['type'] == 'time') { ?>
          <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
            <?php if ($option['required']) { ?>
            <span class="required">*</span>
            <?php } ?>
            <b><?php echo $option['name']; ?>:</b><br />
            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
          </div>
          <br />
          <?php } ?>
          <?php } ?>
        </div>
        <?php } ?>
        <div class="cart">
          <div><?php echo $text_qty; ?>
            <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
            <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
            &nbsp;
            <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
            <span>&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;</span>
            <span class="links"><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
              <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></span>
          </div>
          <?php if ($minimum > 1) { ?>
          <div class="minimum"><?php echo $text_minimum; ?></div>
          <?php } ?>
        </div>
        <?php if ($review_status) { ?>
        <div class="review">
          <div><img src="catalog/view/theme/gtv1/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
          <div class="share">
            <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div> 
             
          </div>
        </div>
        <?php } ?>
      </div>
    </div>
    <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
      <?php if ($attribute_groups) { ?>
      <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
      <?php } ?>
      <?php if ($review_status) { ?>
      <a href="#tab-review"><?php echo $tab_review; ?></a>
      <?php } ?>
      <?php if ($products) { ?>
      <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
      <?php } ?>
    </div>
    <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
    <?php if ($attribute_groups) { ?>
    <div id="tab-attribute" class="tab-content">
      <table class="attribute">
        <?php foreach ($attribute_groups as $attribute_group) { ?>
        <thead>
          <tr>
            <td colspan="2"><?php echo $attribute_group['name']; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
          <tr>
            <td><?php echo $attribute['name']; ?></td>
            <td><?php echo $attribute['text']; ?></td>
          </tr>
          <?php } ?>
        </tbody>
        <?php } ?>
      </table>
    </div>
    <?php } ?>
    <?php if ($review_status) { ?>
    <div id="tab-review" class="tab-content">
      <div id="review"></div>
      <h2 id="review-title"><?php echo $text_write; ?></h2>
      <b><?php echo $entry_name; ?></b><br />
      <input type="text" name="name" value="" />
      <br />
      <br />
      <b><?php echo $entry_review; ?></b>
      <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
      <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
      <br />
      <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
      <input type="radio" name="rating" value="1" />
      &nbsp;
      <input type="radio" name="rating" value="2" />
      &nbsp;
      <input type="radio" name="rating" value="3" />
      &nbsp;
      <input type="radio" name="rating" value="4" />
      &nbsp;
      <input type="radio" name="rating" value="5" />
      &nbsp;<span><?php echo $entry_good; ?></span><br />
      <br />
      <b><?php echo $entry_captcha; ?></b><br />
      <input type="text" name="captcha" value="" />
      <br />
      <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
      <br />
      <div class="buttons">
        <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
      </div>
    </div>
    <?php } ?>
    <?php if ($products) { ?>
    <div id="tab-related" class="tab-content">
      <div class="box-product">
        <?php foreach ($products as $product) { ?>
        <div>
          <?php if ($product['thumb']) { ?>
          <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
          <?php } ?>
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"></a></div>
          <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($tags) { ?>
    <div class="tags"><b><?php echo $text_tags; ?></b>
      <?php for ($i = 0; $i < count($tags); $i++) { ?>
      <?php if ($i < (count($tags) - 1)) { ?>
      <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
      <?php } else { ?>
      <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
      <?php } ?>
      <?php } ?>
    </div>
    <?php } ?>-->
    <?php echo $content_bottom; ?>
    <div style="clear: both;"></div>
    <input type="hidden" value="<?php echo $heading_title; ?>" id="product_name" />
    <input type="hidden" value="<?php echo $thumb; ?>" id="product_thumb" />
  </div>
</div>  
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script>
<script type="text/javascript">
$(document).ready(function() {
  $('.youtubethumb').after('<img class="youtubethumbicon" src="/catalog/view/theme/gtv1/image/video-icon.png" />');
});
</script>
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/gtv1/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/gtv1/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/gtv1/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 
<?php echo $footer; ?>