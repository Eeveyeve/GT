<!--<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>-->
<?php if ($payment_methods) { ?>
<!--<p><?php echo $text_payment_method; ?></p>
<table class="radio">
  <?php foreach ($payment_methods as $payment_method) { ?>
  <tr class="highlight">
    <td><?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
  </tr>
  <?php } ?>
</table>
<br />-->
<div class="checkout-block" style="display:none;">
  <h2 class="checkout-block-heading"><?php echo $text_payment_method; ?></h2>
  <div class="checkout-block-content">
    <h3>You will be redirected to a secured payment page after order confirmation</h3>
    <br />
    <table class="radio">
      <?php foreach ($payment_methods as $payment_method) { ?>
        <tr class="highlight">
          <td><?php if ($payment_method['code'] == $code || !$code) { ?>
            <?php $code = $payment_method['code']; ?>
            <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
            <?php } ?></td>
          <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
        </tr>
      <?php } ?>
    </table>
  </div>
</div>
<br />
<?php } ?>
<div class="checkout-block" style="display:none;">
  <h2 class="checkout-block-heading"><?php echo $text_comments; ?></h2>
  <div class="checkout-block-content">
    <textarea name="comment" rows="8" style="width: 98%;border-radius: 5px;"><?php echo $comment; ?></textarea>
    <?php if ($text_agree) { ?>
    <br /><br />
    <?php echo $text_agree; ?>
    <?php } ?>
    <?php if ($agree) { ?>
    <input type="checkbox" name="agree" value="1" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="agree" id="agreecheckbox" value="1" checked="checked" />
    <?php } ?>
  </div>
</div>
<?php if ($cart_total-$manual_member_reward > 0) { ?>
<div class="checkout-block">
  <h2 class="checkout-block-heading">Payment process is protected by PayPal and VeriSign.</h2>
  <div class="checkout-block-content">
    <div class="checkout-block-content-block">
      <div class="imageicon"><img src="catalog/view/theme/gtv1/image/step3-lock.png" /></div>
      <h4>Every Purchase is Secured</h4>
      <span>You get an additional layer of privacy when you use PayPal and VeriSign to pay for your purchases. That&rsquo;s because your financial information (like your credit card number) is protected with SSL and High secured methods 24/7.</span>
    </div>
    <br />
    <div class="checkout-block-content-block">
      <div class="imageicon"><img src="catalog/view/theme/gtv1/image/step3-shield.png" /></div>
      <h4>Safer Purchase with Buyer Protection</h4>
      <span><?php echo $this->config->get('config_name'); ?> guarantee to send the products within 24 hours. If an eligible item doesn&rsquo;t arrive after 24 hours, <?php echo $this->config->get('config_name'); ?>&rsquo;s Buyer Protection can help you get all your money back.</span>
    </div>
    <div style="clear:both;"></div>
  </div>
</div>
<?php } else { ?>
<div class="checkout-block">
  <h2 class="checkout-block-heading">Account Balance covered this purchase!</h2>
  <div class="checkout-block-content">
    <div class="checkout-block-content-block">
      <div class="imageicon" style="margin:15px 0;"><img src="catalog/view/theme/gtv1/image/step3-credits.png" /></div>
      <h4>Payment through PayPal is not required.</h4>
      <span>
      Seems like you used your <?php echo $this->config->get('config_name'); ?> balance to complete this purchase.
      <br />
      You can complete this purchase now and skip the PayPal page.
      <br /><br />
      <?php echo $this->config->get('config_name'); ?> guarantee to send the products within 24 hours. If an eligible item doesn&rsquo;t arrive
      <br />
      after 24 hours, Gaming Titans Buyer Protection can help you get all your money back.
      </span>
    </div>
    <div style="clear:both;"></div>
  </div>
</div>
<?php } ?>
<br />
<div id="checkout-buttons" class="withtopborder">
  <?php if ($cart_total-$manual_member_reward > 0) { ?>
    <a href="javascript:ChangeStep(4);" id="button-payment-method" class="checkout-button roundbutton lotlargerbutton darkgreenbutton" style="color:#ffffff;float:right;"><img style="width:10px;margin-right:7px" src="catalog/view/theme/gtv1/image/lock-white.png">Pay with PayPal</a>
  <?php } else { ?>
    <a href="javascript:ChangeStep(4);" id="button-payment-method" class="checkout-button roundbutton lotlargerbutton darkgreenbutton" style="color:#ffffff;float:right;"><img style="width:10px;margin-right:7px" src="catalog/view/theme/gtv1/image/lock-white.png">Complete Purchase</a>
  <?php } ?>
  <div class="checkout-text">
    <h4>Total to Pay: <b><?php echo $this->currency->format($cart_total-$manual_member_reward); ?></b></h4>
    <p>Balance use: <span>- <?php echo $this->currency->format($manual_member_reward); ?></span><p>
    <p>Total Price before Balance use: <b><?php echo $this->currency->format($cart_subtotal); ?></b></p>
  </div>
  <div style="clear:both;"></div>
</div>
<div id="checkout-support">
  <img src="catalog/view/theme/gtv1/image/help.png" />
  <h4>Got questions? We&rsquo;re here for you.</h4>
  <p>Use <a href="<?php echo $this->url->link('information/information', 'information_id=3'); ?>" target="_blank">FAQ,</a> <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Community Live Support</a> or <a href="<?php echo $this->url->link('information/contact'); ?>" target="_blank">Email</a> to get answer anytime!</p>
</div>
<!--<b><?php echo $text_comments; ?></b>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>
<br />
<br />
<?php if ($text_agree) { ?>
<?php echo $text_agree; ?>
<?php if ($agree) { ?>
<input type="checkbox" name="agree" value="1" checked="checked" />
<?php } else { ?>
<input type="checkbox" name="agree" value="1" />
<?php } ?>
<br /><br />
<div style="float:right;"><a href="javascript:void(0);" class="roundbutton largerbutton darkgreenbutton" id="button-payment-method" style="color:#ffffff;">Confirm Order</a></div>
<div style="float:left;"><a href="javascript:ChangeStep(3);" class="roundbutton largerbutton darkbluebutton" style="color:#ffffff;">Back to Payment</a></div>
<?php } else { ?>
<br /><br />
<div style="float:right;"><a href="javascript:ChangeStep(4);" class="roundbutton largerbutton darkgreenbutton" style="color:#ffffff;">Confirm Order</a></div>
<div style="float:left;"><a href="javascript:ChangeStep(3);" class="roundbutton largerbutton darkbluebutton" style="color:#ffffff;">Back to Payment</a></div>
<?php } ?>-->
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//RewriteCheckboxes();
//--></script> 
<script>
/*$('#button-payment-method').die('click').live('click', function() {

	if ($('input[name=\'agree\']').is(':checked')) {
	
	}else{
	//	alert('I have read and agree checkbox must not be uncheck');
		return false;
	}

$.ajax({
					url: 'index.php?route=checkout/confirm',
					dataType: 'html',
					success: function(html) {
						$('#confirm .checkout-content').html(html);
						
						$('#payment-method .checkout-content').slideUp('slow');
						
						$('#confirm .checkout-content').slideDown('slow');
						
						$('#payment-method .checkout-heading a').remove();
						
						$('#payment-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});	
				});*/

</script>