<html>
<head>
<meta charset="UTF-8" />
<meta name="robots" content="noindex, nofollow" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/reg_popup.css" />
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
</head>
<body>
  <div id="content">
    <?php if ($error_warning) { ?>
      <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <h2><?php echo $text_account_already; ?></h2>
    <br />
    <form action="<?php echo $action; ?>?iframe=1" method="post" enctype="multipart/form-data">
      <div class="content">
        <table class="form">
          <tr>
            <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" />
              <?php if ($error_firstname) { ?>
              <span class="error"><?php echo $error_firstname; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" />
              <?php if ($error_lastname) { ?>
              <span class="error"><?php echo $error_lastname; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" />
              <?php if ($error_email) { ?>
              <span class="error"><?php echo $error_email; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
            <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
              <?php if ($error_telephone) { ?>
              <span class="error"><?php echo $error_telephone; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><?php echo $entry_fax; ?></td>
            <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
          </tr>
        </table>
      </div>
      <div class="content">
        <table class="form">
          <tr style="display:none;">
            <td><?php echo $entry_company; ?></td>
            <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
          </tr>        
          <tr style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
            <td><?php echo $entry_customer_group; ?></td>
            <td><?php foreach ($customer_groups as $customer_group) { ?>
              <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
              <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
              <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
              <br />
              <?php } else { ?>
              <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
              <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
              <br />
              <?php } ?>
              <?php } ?></td>
          </tr>      
          <tr id="company-id-display" style="display:none;">
            <td><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></td>
            <td><input type="text" name="company_id" value="<?php echo $company_id; ?>" />
              <?php if ($error_company_id) { ?>
              <span class="error"><?php echo $error_company_id; ?></span>
              <?php } ?></td>
          </tr>
          <tr id="tax-id-display" style="display:none;">
            <td><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?></td>
            <td><input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
              <?php if ($error_tax_id) { ?>
              <span class="error"><?php echo $error_tax_id; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
            <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
              <?php if ($error_address_1) { ?>
              <span class="error"><?php echo $error_address_1; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><?php echo $entry_address_2; ?></td>
            <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" /></td>
          </tr>
          <tr>
            <td><input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" />
              <?php if ($error_city) { ?>
              <span class="error"><?php echo $error_city; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
            <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
              <?php if ($error_postcode) { ?>
              <span class="error"><?php echo $error_postcode; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><select name="country_id">
                <option value=""><?php echo $entry_country; ?></option>
                <?php foreach ($countries as $country) { ?>
                <?php if ($country['country_id'] == $country_id) { ?>
                <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
              <?php if ($error_country) { ?>
              <span class="error"><?php echo $error_country; ?></span>
              <?php } ?></td>
          </tr>
          <tr style="display:none;">
            <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
            <td><select name="zone_id">
              </select>
              <?php if ($error_zone) { ?>
              <span class="error"><?php echo $error_zone; ?></span>
              <?php } ?></td>
          </tr>
        </table>
      </div>
      <div class="content">
        <table class="form">
          <tr>
            <td><input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" />
              <?php if ($error_password) { ?>
              <span class="error"><?php echo $error_password; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" />
              <?php if ($error_confirm) { ?>
              <span class="error"><?php echo $error_confirm; ?></span>
              <?php } ?></td>
          </tr>
        </table>
      </div>
      <br />
      <div class="content">
        <table class="form">
          <tr>
            <td><h2><?php echo $text_newsletter; ?>&nbsp;<?php echo $entry_newsletter; ?></h2></td>
            <td style="text-align:right;"><?php if ($newsletter) { ?>
              <input type="radio" name="newsletter" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="newsletter" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="newsletter" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="newsletter" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
          </tr>
        </table>
      </div>
      <br />
      <?php if ($text_agree) { ?>
      <div class="content">
        <table class="form">
          <tr>
            <td style="width: 15px; padding: 0px;"><?php if ($agree) { ?>
                <input type="checkbox" name="agree" value="1" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="agree" value="1" />
                <?php } ?>
            </td>
            <td style="padding: 0px;"><span><?php echo $text_agree; ?></span></td>
          </tr>
        </table>
        <br />
        <div class="centerbuttons">
          <input type="submit" value="<?php echo $text_register; ?>" class="bluebutton litbutton litroundbutton" style="height:26px;" />
          <h2 style="display:block;float:left;margin:4px 4px 0px 20px;"><?php echo $text_or; ?></h2>
          <div style="display:inline-block;float:right;"><a class="fbconnectbutton" href="<?php echo $content_bottom; ?>"><?php echo $text_connect; ?></a></div>
          <div style="clear:both;"></div>
        </div>
      </div>
      <?php } else { ?>
      <div class="centerbuttons">
        <input type="submit" value="<?php echo $text_register; ?>" class="bluebutton litbutton litroundbutton" style="height:26px;" />
        <h2 style="display:block;float:left;margin:4px 4px 0px 20px;"><?php echo $text_or; ?></h2>
        <div style="display:inline-block;float:right;"><a class="fbconnectbutton" href="<?php echo $content_bottom; ?>"><?php echo $text_connect; ?></a></div>
        <div style="clear:both;"></div>
      </div>
      <?php } ?>
    </form>
  </div>
<script type="text/javascript">
$(document).ready(function(){
  /*$('input[type=checkbox]').each(function(){
    var cb = $(this);
    var nm = cb.attr("name");
    nm = "cbmac-"+nm;
    cb.attr("id", nm);
    cb.after($('<label class="css-checkbox" />').attr("for", cb.attr("id")) );
  });*/
  var bh = $('body').outerHeight();
  parent.$("#fancybox-content").css('height', bh);
  $('a.fbconnectbutton').attr('target', '_parent'); 
});
</script>
</body>
</html>