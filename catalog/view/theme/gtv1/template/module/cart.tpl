<div id="cart">
  <div class="heading" id="cart-total">
    <a><em></em><h4><?php echo $text_in_my_cart; ?></h4></a>
    <a class="numitems"><?php echo $text_items; ?><span></span></a>
  </div> 
  <div class="heading-black darkgreenbutton">
    <a href="<?php echo $cart; ?>"><?php echo $text_checkout; ?></a>
  </div>
  <?php if ($products || $vouchers) { ?>  
    <div class="content">
      <div class="mini-cart-info">
        <?php foreach ($products as $product) { ?>
        <div class="item">
          <?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
          <?php } ?>
          <a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <span class="price"><?php echo $product['total']; ?><b>&nbsp;x<?php echo $product['quantity']; ?>&nbsp;</b></span>
          <div class="remove" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $product['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $product['key']; ?>' + ' #cart > *');"><span>x</span></div>
          <div style="clear:both;"></div>
        </div>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <div class="voucher">
          <div class="image"></div>
          <div class="name"><?php echo $voucher['description']; ?></div>
          <div class="quantity">x&nbsp;1</div>
          <div class="total"><?php echo $voucher['amount']; ?></div>
          <div class="remove"><img src="catalog/view/theme/default/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $voucher['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $voucher['key']; ?>' + ' #cart > *');" /></div>
        </div>
        <?php } ?>
      </div>
      <div class="mini-cart-total">
        <?php foreach ($totals as $total) { ?>
          <div class="total"><?php echo $total['title']; ?>:<b><?php echo $total['text']; ?></b></div>
        <?php } ?>
      </div>
    </div>
    <!--<div class="checkout"><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a> | <a href="<?php echo $cart; ?>"><?php echo $text_checkout; ?></a></div>-->
  <?php } else { ?>
    <div class="content">
      <div class="empty"><?php echo $text_empty; ?></div>
    </div>  
  <?php } ?>
</div>