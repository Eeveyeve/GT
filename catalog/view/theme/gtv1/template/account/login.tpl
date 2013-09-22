<?php echo $header; ?>
<div id="wrap">
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php echo $column_left; ?><?php echo $column_right; ?>
  <div id="content"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <div class="login-content">
      <div class="left">
        <h2 class="floatheading"><?php echo $text_new_customer; ?></h2>
        <div class="content">
          <!--<p><b><?php echo $text_register; ?></b></p>-->
          <p><?php echo $text_register_account; ?></p>
          <a href="<?php echo $register; ?>" style="float:left;" class="darkestbluebutton button fancylink"><?php echo $text_register; ?></a>
          <p style="display:inline-block;float:left;margin:4px 15px;"><?php echo $text_or; ?></p>
          <a class="fbconnectbutton" href="<?php echo $content_bottom; ?>"><?php echo $text_connect; ?></a>
        </div>
      </div>
      <div class="right">
        <h2 class="floatheading"><?php echo $text_returning_customer; ?></h2>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <div class="content">
            <p><?php echo $text_i_am_returning_customer; ?></p>
            <b><?php echo $entry_email; ?></b><br />
            <input type="text" name="email" value="<?php echo $email; ?>" />
            <br />
            <br />
            <b><?php echo $entry_password; ?></b><br />
            <input type="password" name="password" value="<?php echo $password; ?>" />
            <br />
            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
            <br />
            <input type="submit" value="<?php echo $button_login; ?>" style="float:left;padding:6px 12px 6px 12px;margin:0;height:26px;" class="darkestbluebutton button" />
            <p style="display:inline-block;float:left;margin:4px 15px;"><?php echo $text_or; ?></p>
            <a class="fbconnectbutton" href="<?php echo $content_bottom; ?>"><?php echo $text_connect; ?></a>
            <?php if ($redirect) { ?>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
            <?php } ?>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script>
<script type="text/javascript"><!--
$(document).ready( function() { 
  /*$('#wrap').addClass('clearbg wrapme');
  $('#header').addClass('clearbg wrapme nopaddingheader');
  $('#notification').addClass('wrapme');
  $('.wrapme').wrapAll('<div class="bigwrap"></div>');
  $('.bigwrap').addClass('toppagemargin nopadding');*/
  $('#bgoverlap').hide();
});
//--></script> 
<?php echo $footer; ?>