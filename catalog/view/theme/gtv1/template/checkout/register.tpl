<div class="checkout-block">
  <h2 class="checkout-block-heading">Please Register to proceed</h2>
  <div class="checkout-block-content">
    <h3>In case you are already registered, please <strong>Login</strong> in the right menu.</h3>
    <br />
    <input type="text" name="firstname" placeholder="<?php echo $entry_firstname; ?>" value="" class="smaller-field" />
    <input type="text" name="lastname" placeholder="<?php echo $entry_lastname; ?>" value="" class="smaller-field" />
    <br />
    <select name="country_id" class="smaller-field">
      <option value=""><?php echo $text_select; ?></option>
      <?php foreach ($countries as $country) { ?>
        <?php if ($country['country_id'] == $country_id) { ?>
          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php } else { ?>
          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
      <?php } ?>
    </select>
    <input type="text" name="city" placeholder="<?php echo $entry_city; ?>" value="" class="smaller-field" />
    <br />
    <br />
    <input type="text" name="email" placeholder="<?php echo $entry_email_address; ?>" value="" class="larger-field" />
    <br />
    <div style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
      <?php echo $entry_customer_group; ?><br />
      <?php foreach ($customer_groups as $customer_group) { ?>
        <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
          <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
          <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
          <br />
        <?php } else { ?>
          <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
          <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
          <br />
        <?php } ?>
      <?php } ?>
      <br />
    </div>
    <input type="password" name="password" placeholder="<?php echo $entry_password; ?>" value="" class="smaller-field" />  
    <input type="password" name="confirm" placeholder="<?php echo $entry_confirm; ?>" value="" class="smaller-field" />
    
    <input type="hidden" name="address_1" value="" class="smaller-field" />  
    <input type="hidden" name="address_2" value="" class="smaller-field" />
    <input type="hidden" name="postcode" value="<?php echo $postcode; ?>" class="smaller-field" />
    <!--<br />
    <br />
    <span class="required">*</span> <?php echo $entry_zone; ?><br />
    <select name="zone_id" class="smaller-field">
    </select>
    <br />-->
    <br />
    <br />
    
    <div>
      <input type="hidden" name="newsletter" value="1" id="newsletter" />  
      <?php if ($shipping_required) { ?>
        <br />
        <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
        <label for="shipping"><?php echo $entry_shipping; ?></label>
        <br />
        <br />
      <?php } ?>
    </div>
    <?php if ($text_agree) { ?>
      <p><input type="checkbox" name="agree" value="1" /><?php echo $text_agree; ?></p>
    <?php } ?>
    <br />
    <br />
    <span style="float:left;margin: 5px 12px 0 0;">To save time, you can also</span><a class="fbconnectbutton" href="<?php echo $fbconnect; ?>">Connect</a>
    <div style="clear:both;"></div>
  </div>
</div>
<div id="checkout-buttons" class="withtopborder">
  <a id="button-register" class="checkout-button roundbutton lotlargerbutton darkgreenbutton" style="color:#ffffff;float:right;"><img style="width:10px;margin-right:7px" src="catalog/view/theme/gtv1/image/lock-white.png">Proceed to Payment</a>
  <div class="checkout-text">
    <h3><?php echo $this->config->get('config_name'); ?> Reward: <b>$<?php echo $member_reward; ?></b></h3>
    <p>Will be added to your balance after payment.</p>
  </div>
  <div style="clear:both;"></div>
</div>
<div id="checkout-support">
  <img src="catalog/view/theme/gtv1/image/help.png" />
  <h4>Got questions? We&rsquo;re here for you.</h4>
  <p>Use <a href="<?php echo $this->url->link('information/information', 'information_id=3'); ?>" target="_blank">FAQ,</a> <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Community Live Support</a> or <a href="<?php echo $this->url->link('information/contact'); ?>" target="_blank">Email</a> to get answer anytime!</p>
</div>
<script type="text/javascript"><!--
$('#checkout input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('#checkout input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<!--<script type="text/javascript"><!--
$('#checkout select[name=\'country_id\']').bind('change', function() {
	if (this.value == '') return;
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#checkout select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
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
			
			$('#checkout select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#checkout select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 