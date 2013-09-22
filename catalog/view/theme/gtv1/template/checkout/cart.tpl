<?php echo $header; ?>
<div class="checkoutsteps">
  <ul>
    <li class="step"><a class="active" href="javascript:void(0);" style="cursor:default;">My Shopping Cart</a></li>
    <li class="step"><a href="<?php echo $checkout; ?>">User Verification</a></li>
    <li class="step"><a href="javascript:void(0);" style="cursor:no-drop;">Payment</a></li>
    <li class="step last"><a href="javascript:void(0);" style="cursor:no-drop;">Confirmation</a></li>
  </ul>
  <div style="clear:both;"></div>
</div>
<div id="wrap" class="checkout-wrap">
  <!--<?php if ($attention) { ?>
  <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
  <?php } ?>-->
  <?php echo $column_left; ?>
  <div id="column-right" class="checkout-sidebar"><?php echo $column_right; ?></div>
  <div id="content" class="content-wrap"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <!--<h1 class="floatheading"><?php echo $heading_title; ?>
      <?php if ($weight) { ?>
      &nbsp;(<?php echo $weight; ?>)
      <?php } ?>
    </h1>-->
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="cartform">
      <div class="cart-info">
        <table>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr class="cartproduct">
              <td class="image"><?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?></td>
              <td class="name"><a class="game" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php if (!$product['stock']) { ?>
                <span class="stock">***</span>
                <?php } ?>
                <div>
                  <?php foreach ($product['option'] as $option) { ?>
                  - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                  <?php } ?>
                </div>
                <?php if ($product['reward']) { ?>
                <small><?php echo $product['reward']; ?></small>
                <?php } ?></td>
              <!--<td class="model"><?php echo $product['model']; ?></td>-->
              <td class="quantity">
                <span><?php echo $column_quantity; ?></span><br / >
                <input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="quant" />
              </td>
              <td class="price"><span class="lower"><?php echo $product['price']; ?>&nbsp;x<?php echo $product['quantity']; ?></span><br /><?php echo $product['total']; ?></td>
              <td class="remove"><a href="<?php echo $product['remove']; ?>">x</a></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $vouchers) { ?>
            <tr>
              <td class="image"></td>
              <td class="name"><?php echo $vouchers['description']; ?></td>
              <td class="model"></td>
              <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" />
                &nbsp;<a href="<?php echo $vouchers['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
              <td class="price"><?php echo $vouchers['amount']; ?></td>
              <td class="total"><?php echo $vouchers['amount']; ?></td>
            </tr>
            <?php } ?>
            <?php 
            $num = 0;
            foreach ($totals as $total) { // print_r($total);?>
            <?php  if($num == 1) { ?>
               <tr class="subtotalrow">
                <td colspan="2" class="subtotalleft"><?php echo $total['title']; ?></td>
                <td style="text-align:center;font-size: 14px;"><?php echo $this->cart->countProducts(); ?></td>
                <td colspan="2" class="subtotalright"><?php echo $total['text']; ?></td>
              </tr>
            <?php } else { ?>
            <tr class="subtotalrow">
              <td colspan="3" class="subtotalleft"><?php echo $total['title']; ?></td>
              <td colspan="2" class="subtotalright"><?php echo $total['text']; ?></td>
            </tr>
            <?php } if($num == 0) {
            if($this->customer->isLogged()){ ?>
              <tr class="subtotalrow creditsrow">
                <td colspan="3" class="subtotalleft">Use my credits</td>
                <td colspan="2" class="subtotalright"><label style="position:relative;left:-7px;cursor:default;" for="manual_member_reward">- &pound;</label><input type="text" name="manual_member_reward" id="manual_member_reward" value="<?php echo $manual_member_reward ;?>" /></td>
              </tr>
            <?php } else { ?>
              <tr class="subtotalrow creditsrow">
                <td colspan="3" class="subtotalleft">Use my credits</td>
                <td colspan="2" class="subtotalright"><label style="position:relative;left:-7px;cursor:default;" for="manual_member_reward">- &pound;</label><input type="text" name="manual_member_reward" id="manual_member_reward" value="0.00" /></td>
              </tr>
            <?php }} $num++; } ?>
          </tbody>
        </table>
      </div>
	<!--<?php if ($coupon_status || $voucher_status || $reward_status || $shipping_status) { ?>
  <h2><?php echo $text_next; ?></h2>
  <div class="content">
    <p><?php echo $text_next_choice; ?></p>
    <table class="radio">
      <?php if ($coupon_status) { ?>
      <tr class="highlight">
        <td><?php if ($next == 'coupon') { ?>
          <input type="radio" name="next" value="coupon" id="use_coupon" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="next" value="coupon" id="use_coupon" />
          <?php } ?></td>
        <td><label for="use_coupon"><?php echo $text_use_coupon; ?></label></td>
      </tr>
      <?php } ?>
      <?php if ($voucher_status) { ?>
      <tr class="highlight">
        <td><?php if ($next == 'voucher') { ?>
          <input type="radio" name="next" value="voucher" id="use_voucher" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="next" value="voucher" id="use_voucher" />
          <?php } ?></td>
        <td><label for="use_voucher"><?php echo $text_use_voucher; ?></label></td>
      </tr>
      <?php } ?>
      <?php if ($reward_status) { ?>
      <tr class="highlight">
        <td><?php if ($next == 'reward') { ?>
          <input type="radio" name="next" value="reward" id="use_reward" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="next" value="reward" id="use_reward" />
          <?php } ?></td>
        <td><label for="use_reward"><?php echo $text_use_reward; ?></label></td>
      </tr>
      <?php } ?>
      <?php if ($shipping_status) { ?>
      <tr class="highlight">
        <td><?php if ($next == 'shipping') { ?>
          <input type="radio" name="next" value="shipping" id="shipping_estimate" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="next" value="shipping" id="shipping_estimate" />
          <?php } ?></td>
        <td><label for="shipping_estimate"><?php echo $text_shipping_estimate; ?></label></td>
      </tr>
      <?php } ?>
    </table>
  </div>
  <div class="cart-module">
    <div id="coupon" class="content" style="display: <?php echo ($next == 'coupon' ? 'block' : 'none'); ?>;">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <?php echo $entry_coupon; ?>&nbsp;
        <input type="text" name="coupon" value="<?php echo $coupon; ?>" />
        <input type="hidden" name="next" value="coupon" />
        &nbsp;
        <input type="submit" value="<?php echo $button_coupon; ?>" class="button" />
      </form>
    </div>
    <div id="voucher" class="content" style="display: <?php echo ($next == 'voucher' ? 'block' : 'none'); ?>;">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <?php echo $entry_voucher; ?>&nbsp;
        <input type="text" name="voucher" value="<?php echo $voucher; ?>" />
        <input type="hidden" name="next" value="voucher" />
        &nbsp;
        <input type="submit" value="<?php echo $button_voucher; ?>" class="button" />
      </form>
    </div>
    <div id="reward" class="content" style="display: <?php echo ($next == 'reward' ? 'block' : 'none'); ?>;">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <?php echo $entry_reward; ?>&nbsp;
        <input type="text" name="reward" value="<?php echo $reward; ?>" />
        <input type="hidden" name="next" value="reward" />
        &nbsp;
        <input type="submit" value="<?php echo $button_reward; ?>" class="button" />
      </form>
    </div>
    <div id="shipping" class="content" style="display: <?php echo ($next == 'shipping' ? 'block' : 'none'); ?>;">
      <p><?php echo $text_shipping_detail; ?></p>
      <table>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_country; ?></td>
          <td><select name="country_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
          <td><select name="zone_id">
            </select></td>
        </tr>
        <tr>
          <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
          <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
        </tr>
      </table>
      <input type="button" value="<?php echo $button_quote; ?>" id="button-quote" class="button" />
    </div>
  </div>
    </form>
	 <?php } ?>
    <br />-->
	
	  <input type="hidden" id="subtotal" value="<?php echo $this->cart->getSubTotal();?>"  />  
  
    <div id="checkout-buttons">
      <a href="<?php echo $checkout; ?>" class="checkout-button roundbutton lotlargerbutton darkgreenbutton" style="float:right;"><img style="width:10px;margin-right:7px;" src="catalog/view/theme/gtv1/image/lock-white.png" /><?php echo $button_checkout; ?></a>    
      <a href="javascript:void(0);" id="UpdateBtn" class="roundbutton lotlargerbutton darkestbluebutton" style="float:right;font-weight:bold;">Update</a>
      <!--<div style="float:left;"><a href="<?php echo $continue; ?>" class="roundbutton largerbutton darkbluebutton" style="color:#ffffff;"><?php echo $button_shopping; ?></a></div>-->    
      <!--<div style="float:left; padding-left:10px;"><a href="javascript:void(0)" id="updatebtn" class="roundbutton largerbutton darkbluebutton" style="color:#ffffff;">Update</a></div>-->
      <?php if($this->customer->isLogged()) { ?>
        <p id="checkout-user-balance">In my account: <span>$<?php echo $this->currency->format(round($this->customer->getBalance(),2)); ?></span></p>
        <input type="hidden" name="member_reward" id="id_member_reward" value="<?php echo $this->currency->format(round($this->customer->getBalance(),2)); ?>" />
      <?php } else { ?>
        <p id="checkout-user-balance">In my account: <span>Login to show</span></p>
        <input type="hidden" name="member_reward" id="id_member_reward" value="none" />
      <?php } ?>
      <div style="clear:both;"></div>
    </div>
    <div id="checkout-support">
      <img src="catalog/view/theme/gtv1/image/help.png" />
      <h4>Got questions? We&rsquo;re here for you.</h4>
      <p>Use <a href="<?php echo $this->url->link('information/information', 'information_id=3'); ?>" target="_blank">FAQ,</a> <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Community Live Support</a> or <a href="<?php echo $this->url->link('information/contact'); ?>" target="_blank">Email</a> to get answer anytime!</p>
    </div>  
    <?php echo $content_bottom; ?>
    <div style="clear:both;"></div>
  </div>
  <div style="clear:both;"></div>
</div>
<?php if($this->customer->isLogged()) { ?>
<script type="text/javascript"><!--
//$('#UpdateBtn').live('click', function() {
$('#manual_member_reward').keyup(function() {
  if($('#id_member_reward').val() != "none") {
    //$('#loadingoverlap').show();
    if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#subtotal').val())){
  		//alert("You can't use credits more than subtotal");
  		//$('#manual_member_reward').focus();
      $('#manual_member_reward').val(parseFloat($('#subtotal').val())).focus();
  		//return false;
    } else if (parseFloat($('#manual_member_reward').val()) < 0) {
      $('#manual_member_reward').val('');  
    } else if (isNaN(parseFloat($('#manual_member_reward').val()))) {
      $('#manual_member_reward').val('');
    } else if ((parseFloat($('#manual_member_reward').val() * 10) % 1) != 0) {
      $('#manual_member_reward').val(parseFloat($('#manual_member_reward').val()).toFixed(2));
    } else if (parseFloat($('#manual_member_reward').val()) > 0 && parseFloat($('#manual_member_reward').val()) < parseFloat($('#subtotal').val())) {  
	  }
	
		if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#id_member_reward').val())){	
  	  //alert($('#id_member_reward').val());
  		alert("You have not enough credits");
  		$('#manual_member_reward').val(parseFloat($('#id_member_reward').val())).focus()
  		return false;
	  }
    	
	  //$('#cartform').submit();
    $.post('<?php echo $action; ?>', $('#cartform').serialize());
  } 
});
$('#UpdateBtn').live('click', function() {
//$('#manual_member_reward').keyup(function() {
  if($('#id_member_reward').val() != "none") {
    $('#loadingoverlap').show();
    if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#subtotal').val())){
  		//alert("You can't use credits more than subtotal");
  		//$('#manual_member_reward').focus();
      $('#manual_member_reward').val(parseFloat($('#subtotal').val())).focus();
  		//return false;
	  }
	
		if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#id_member_reward').val())){	
  	  //alert($('#id_member_reward').val());
  		//alert("You have not enough credits");
  		$('#manual_member_reward').focus();
  		//return false;
	  }
    	
	  $('#cartform').submit();
    //$.post('<?php echo $action; ?>', $('#cartform').serialize());
  } 
});
//--></script>
<?php } else { ?>
<script type="text/javascript"><!--
$('#manual_member_reward').keyup(function() {
  /*if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#subtotal').val())){
    $('#manual_member_reward').val(parseFloat($('#subtotal').val())).focus();
  } else if (parseFloat($('#manual_member_reward').val()) > 0 && parseFloat($('#manual_member_reward').val()) < parseFloat($('#subtotal').val())) {  
  } else if (parseFloat($('#manual_member_reward').val()) < 0) {
    $('#manual_member_reward').val(0);
  } else {
    $('#manual_member_reward').val(0);
  }*/
  if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#subtotal').val())){
    $('#manual_member_reward').val(parseFloat($('#subtotal').val())).focus();
  } else if (parseFloat($('#manual_member_reward').val()) < 0) {
    $('#manual_member_reward').val('');  
  } else if (isNaN(parseFloat($('#manual_member_reward').val()))) {
    $('#manual_member_reward').val('');
  } else if ((parseFloat($('#manual_member_reward').val() * 10) % 1) != 0) {
    $('#manual_member_reward').val(parseFloat($('#manual_member_reward').val()).toFixed(2));
  } else if (parseFloat($('#manual_member_reward').val()) > 0 && parseFloat($('#manual_member_reward').val()) < parseFloat($('#subtotal').val())) {  
  }
    
  $('#manual_member_reward').val((Math.round(parseFloat($('#manual_member_reward').val()) * 100) / 100));
  $.post('<?php echo $action; ?>', $('#cartform').serialize()); 
});
$('#UpdateBtn').live('click', function() {
  $('#loadingoverlap').show();
  if(parseFloat($('#manual_member_reward').val()) > parseFloat($('#subtotal').val())){
    $('#manual_member_reward').val(parseFloat($('#subtotal').val())).focus();
  } 	
  $('#cartform').submit();
});
//--></script>
<?php } ?>
<script type="text/javascript"><!--
$('input[name=\'next\']').bind('change', function() {
	$('.cart-module > div').hide();
	
	$('#' + this.value).show();
});
$(".quant").change(function() {
  if (parseFloat($(this).val()) < 0) {
    $(this).val(0);
  } else if (parseFloat($(this).val()) > 0) {
    $(this).val(Math.round(parseFloat($(this).val())));
  } else {
    $(this).val(0);
  }
});
/*$(".quant").keyup(function() {
  $.post('<?php echo $action; ?>', $('#cartform').serialize());
});
$(".quant").blur(function() {
  $('#loadingoverlap').show();
  $.ajax({
    url: "<?php echo $action; ?>",
    cache: false,
    success: function(content) {
        $("body").html(content);
        $('#loadingoverlap').hide();
    }
  });
});*/
$(document).ready( function() { 
  /*$('#wrap').addClass('clearbg wrapme');
  $('#header').addClass('clearbg wrapme nopaddingheader');
  $('#notification').addClass('wrapme');
  $('.wrapme').wrapAll('<div class="bigwrap"></div>');
  $('.bigwrap').addClass('toppagemargin nopadding');
  $('.cart-info').find('tr.cartproduct:even').css("background-color", "#f7f7f7");*/
  $('#bgoverlap').hide();
});
/*function LoadCheckout () {
  $('*').addClass('waitcursor');
  $('#wrap').load('<?php echo $checkout; ?> #wrap', function(){
    $('*').removeClass('waitcursor');
  });
}*/
//--></script>
<?php if ($shipping_status) { ?>
<script type="text/javascript"><!--

$('#button-quote').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',		
		beforeSend: function() {
			$('#button-quote').attr('disabled', true);
			$('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-quote').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			$('.success, .warning, .attention, .error').remove();			
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
					$('.warning').fadeIn('slow');
					
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
							
				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}					
			}
			
			if (json['shipping_method']) {
				html  = '<h2><?php echo $text_shipping_method; ?></h2>';
				html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
				html += '  <table class="radio">';
				
				for (i in json['shipping_method']) {
					html += '<tr>';
					html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
					html += '</tr>';
				
					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							html += '<tr class="highlight">';
							
							if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
							} else {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
							}
								
							html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
							html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
							html += '</tr>';
						}		
					} else {
						html += '<tr>';
						html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
						html += '</tr>';						
					}
				}
				
				html += '  </table>';
				html += '  <br />';
				html += '  <input type="hidden" name="next" value="shipping" />';
				
				<?php if ($shipping_method) { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" />';	
				<?php } else { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" disabled="disabled" />';	
				<?php } ?>
							
				html += '</form>';
				
				$.colorbox({
					overlayClose: true,
					opacity: 0.5,
					width: '600px',
					height: '400px',
					href: false,
					html: html
				});
				
				$('input[name=\'shipping_method\']').bind('change', function() {
					$('#button-shipping').attr('disabled', false);
				});
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>
<?php } ?>
<?php echo $footer; ?>
