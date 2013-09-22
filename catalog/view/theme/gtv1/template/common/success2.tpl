<?php echo $header; ?>
<div id="wrap" class="checkout-wrap">
  <div id="column-right" class="checkout-sidebar">
    <?php echo $column_right; ?>
    <div id="right-order">
      <h2>Order Completed</h2>
      <div class="part">
        <?php if ($preorders > 0 && $non_preorders > 0) { ?>
          <p style="font-weight:bold;">Your purchased products will be delivered on release date for Pre Orders and within 24 hours for released games.</p>
        <?php } else if ($preorders > 0) { ?>
          <p style="font-weight:bold;">Your purchased products will be delivered on release date.</p>
        <?php } else { ?>
          <p style="font-weight:bold;">Your purchased products will deliver within 24 hours.</p>
        <?php } ?>
        <br />
        <p>Meanwhile, we can offer you to review your purchase, Like us on our <a href="https://www.facebook.com/gamingtitans" target="_blank" class="fb">Facebook</a> page, or chat in our <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Live Community.</a></p>
      </div>
      <br />
      <h2>Review</h2>
      <div class="review write">
        <input type="text" name="name" value="<?php echo $firstname." ".$lastname; ?>" style="display:none;" />
        <textarea name="text" cols="32" rows="5" placeholder="<?php echo $entry_review; ?>" style="margin-top:0px;"></textarea>
        <br />
        <fieldset id="radio-rating">
          <input type="radio" name="rating" value="5" id="star5" /><label for="star5"></label>
          <input type="radio" name="rating" value="4" id="star4" /><label for="star4"></label>
          <input type="radio" name="rating" value="3" id="star3" /><label for="star3"></label>
          <input type="radio" name="rating" value="2" id="star2" /><label for="star2"></label>
          <input type="radio" name="rating" value="1" id="star1" /><label for="star1"></label>
        </fieldset>
        <a id="button-review" class="roundbutton bluebutton"><?php echo $text_write; ?></a>
        <div style="clear: both;"></div>
        <div id="review-title"></div>
      </div>
      <br />
      <br />
      <h2>Our Community</h2>
      <div class="part">
        <p>Chat with friends and get live help from our Support team.</p>
        <a href="<?php echo $this->url->link('community/community'); ?>" class="community lotlargerbutton roundbutton darkestbluebutton" target="_blank">Enter the Community</a>
      </div>
    </div>
  </div>
  <div id="content" class="content-wrap"><?php echo $content_top; ?>
    <div class="checkoutsteps">
      <ul>
      <li class="step"><a style="cursor:default" href="javascript:void(0);" >My Shopping Cart</a></li>
      <li class="step"><a href="javascript:void(0);">User Verification</a></li>
      <li class="step"><a style="cursor:no-drop" href="javascript:void(0);">Payment</a></li>
      <li class="step last"><a style="cursor:no-drop" class="active" href="javascript:void(0);">Confirmation</a></li>
      </ul>
    </div>
    <!--<h1 class="heading"><?php echo $heading_title; ?></h1>-->
    <br />
    <div class="confirm-thankblock">
      <strong style="font-size:16px;"> Thank you for choosing Gaming Titans!</strong><br />
      We're happy to say that you order # <?php echo $order_id; ?> been confirmed.<br />
      Your account balance been rewarded with <?php echo $account_reward; ?>    
    </div>
    <div class="checkout-block">
      <div class="checkout-block-content">
        <div id="checkout-buttons" class="noside">
          <div class="checkout-text">
            <h4>Products Purchased</h4>
          </div>
          <?php if($products){
            foreach($products as $result){ ?>
          	<div class="productbox">
            	<?php if($result['thumb']){ ?>
                <img src="<?php echo $result['thumb'];?>" alt="<?php echo $result['name'];?>" title="<?php echo $result['name'];?>" />
              <?php } ?>
                <div class="quantity">x<span> <?php echo $result['quantity'];?></span></div>
                <div class="texts">
                  <h3><?php echo $result['name'];?><h3>
                  <p><?php echo $result['genre']; ?> - Release Date: <?php echo $result['date_available']; ?></p>
                </div>
            </div>
            <?php }?>
          <?php } ?>
          <div style="clear:left;"></div>
        </div>
        <div id="checkout-buttons" class="withtopborder noside">
          <div class="checkout-text">
            <h4>Total Price: <b><?php echo $total_price; ?></b></h4>
            <p>Balance used in this purchase: <span>- <?php echo $manual_member_reward; ?></span><p>
            <p>Total Paid: <b><?php echo $total; ?></b></p>
          </div>
          <div style="clear:left;"></div>
        </div>
        <div id="checkout-buttons" class="noside">
          <div class="checkout-text">
            <h4>Purchase Information</h4>
            <div class="orderinfos">
              <p>Name: <strong><?php echo $firstname.' '.$lastname; ?></strong></p>
              <p>Email: <strong><?php echo $email; ?></strong></p>
              <p>Phone: <strong><?php echo $telephone; ?></strong></p>
              <p>City: <strong><?php echo $payment_city; ?></strong></p>
              <p>Country: <strong><?php echo $payment_country; ?></strong></p>
            </div>
            <div class="orderinfos">
              <p>Order date: <strong><?php echo $date_modified; ?></strong></p>
              <p>Order number: <strong><?php echo $order_id; ?></strong></p>
              <p>Payment Method: <strong><?php echo $payment_method; ?></strong></p>
              <p>Total Paid: <strong><?php echo $total; ?></strong></p>
            </div>
            <div style="clear:left;"></div>
          </div>
          <div style="clear:both;"></div>
        </div>
        <div id="checkout-buttons" class="noside">
          <div class="checkout-text">
            <h4>Email address for Delivery</h4>
            <p><b><?php echo $delivery_email; ?></b></p>
          </div>
          <div style="clear:both;"></div>
        </div>
      </div>
    </div>
    <div id="checkout-buttons" class="withtopborder">
      <a href="<?php echo $this->url->link('account/account', '', 'SSL'); ?>" class="checkout-button roundbutton lotlargerbutton bluebutton" style="color:#ffffff;float:left;">History Purchases</a>
      <div class="checkout-text" style="margin:0;">
        <h5>Watch your Order Status</h5>
        <p>In History Purchases you will be able to see Status for this order.<p>
      </div>
      <div style="clear:both;"></div>
    </div>
    <div id="checkout-support">
      <img src="catalog/view/theme/gtv1/image/help.png" />
      <h4>Got questions? We&rsquo;re here for you.</h4>
      <p>Use <a href="<?php echo $this->url->link('information/information', 'information_id=3'); ?>" target="_blank">FAQ,</a> <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Community Live Support</a> or <a href="<?php echo $this->url->link('information/contact'); ?>" target="_blank">Email</a> to get answer anytime!</p>
    </div>
    <?php echo $content_bottom; ?>
  </div>  
</div>
<script type="text/javascript"><!--
$(document).ready( function() {
  $('#bgoverlap').hide();
});
var product_ids = new Array();
<?php foreach ($product_ids as $product_id) { ?>
  product_ids.push('<?php echo $product_id; ?>');
<?php } ?>
$('#button-review').bind('click', function() {
  for (index = 0; index < product_ids.length; ++index) {
    $.ajax({
  		url: 'index.php?route=product/product/write&product_id='+product_ids[index],
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
  }  
});
//--></script>
<?php echo $footer; ?>