<?php echo (isset($header) ? $header : '');
if (isset($breadcrumbs)) { ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
	<div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
<div class="content">
<div class="tabs htabs"><a tab="#tab_general"><?php echo $tab_general; ?></a></div>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
  <div id="tab_general" class="page">
    <table class="form">
	  <tr>
        <td><?php echo $entry_affiliate_autoapprove; ?></td>
        <td><select name="account_combine_affiliate_autoapprove">
          <?php if ($account_combine_affiliate_autoapprove) { ?>
          <option value="1" selected="selected"><?php echo $text_yes; ?></option>
          <option value="0"><?php echo $text_no; ?></option>
          <?php } else { ?>
          <option value="1"><?php echo $text_yes; ?></option>
          <option value="0" selected="selected"><?php echo $text_no; ?></option>
          <?php } ?>
          </select>
	    </td>
      </tr>
	  <tr>
        <td><?php echo $entry_allow_own_aff_links; ?></td>
        <td><select name="account_combine_allow_own_aff">
          <?php if ($account_combine_allow_own_aff) { ?>
          <option value="1" selected="selected"><?php echo $text_yes; ?></option>
          <option value="0"><?php echo $text_no; ?></option>
          <?php } else { ?>
          <option value="1"><?php echo $text_yes; ?></option>
          <option value="0" selected="selected"><?php echo $text_no; ?></option>
          <?php } ?>
          </select>
	    </td>
      </tr>	 
	  <tr>
        <td><?php echo $entry_allow_funds_transfer; ?></td>
        <td><select name="account_combine_allow_funds_transfer">
          <?php if ($account_combine_allow_funds_transfer) { ?>
          <option value="1" selected="selected"><?php echo $text_yes; ?></option>
          <option value="0"><?php echo $text_no; ?></option>
          <?php } else { ?>
          <option value="1"><?php echo $text_yes; ?></option>
          <option value="0" selected="selected"><?php echo $text_no; ?></option>
          <?php } ?>
          </select>
	    </td>
      </tr>		
	  <tr>
        <td><?php echo $entry_transfer_multiplier; ?></td>
        <td><input name="account_combine_transfer_multiplier" type="text" value="<?php echo $account_combine_transfer_multiplier;?>" size="6" />
	    </td>
      </tr>		  
    </table>
  </div>
</form>
</div>
</div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
</script>
<?php echo (isset($footer) ? $footer : '');?>