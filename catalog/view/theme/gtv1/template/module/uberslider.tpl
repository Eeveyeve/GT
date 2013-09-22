<div id="uberslider">
  <div id="uberslider-content">
    <?php foreach ($products as $product) { ?>
      <div class="uberslider-product">
        <?php if ($product['thumb']) { ?>
        <img class="uberslider-thumbnail" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
        <?php } ?>
        <?php if ($product['bigpic']) { ?>
        <div class="uberslider-image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['bigpic']; ?>" alt="<?php echo $product['name']; ?>" /></a><div class="uberslider-shadow"></div></div>
        <?php } ?>
        <div class="uberslider-desc">
          <div class="uberslider-platform"><img src="<?php echo $product['manufacturer_image']; ?>" alt="<?php echo $product['manufacturer_name']; ?>" /></div>
          <div class="uberslider-text-block">
          <div class="uberslider-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <?php if ($product['date_available']) { ?>
          <div class="uberslider-companies"><span><?php echo $product['date_available']; ?></span></div>
          <?php } ?>
          </div>
          <div class="uberslider-cart greenybutton"><input type="button" value="" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="uberslider-addtocart" /></div>
          <?php if ($product['price']) { ?>
          <div class="uberslider-price" onclick="addToCart('<?php echo $product['product_id']; ?>');">
            <?php if (!$product['special']) { ?>
            <span class="uberslider-price-only"><?php echo $product['price']; ?></span>
            <?php } else { ?>
            <span class="uberslider-price-old"><?php echo $product['price']; ?></span><span class="uberslider-price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
        </div>
      </div>
    <?php } ?>  
  </div>
<div class="uberslider-line"></div>      
</div>
