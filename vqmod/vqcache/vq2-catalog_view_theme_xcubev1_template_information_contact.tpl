<?php echo $header; ?>
<script type="text/javascript">
var RecaptchaOptions = {
  theme : 'clean'
};
</script>
<div class="aboveheading">
  <a href="<?php echo $link_contact; ?>" class="darkestbluebutton rightbut active"><?php echo $text_contact_box; ?></a>
  <p class="margtop"><?php echo $text_needhelp; ?> &raquo; <?php echo $heading_title; ?></p>
  <h1 class="margbot"><?php echo $heading_title; ?></h1>
</div>
<div class="content-block">
  <div class="content">
    <?php echo $content_top; ?>
    <div class="black-heading">
      <a class="part" href="<?php echo $link_faq; ?>"><?php echo $text_faq_box; ?></a>
      <a class="part" href="<?php echo $link_policies; ?>"><?php echo $text_policies_box; ?></a>
      <a class="part marked" href="<?php echo $link_livesupport; ?>"><?php echo $text_livesupport; ?></a>
      <a class="part" href="<?php echo $link_community; ?>"><?php echo $text_askcommunity; ?></a>
      <a class="part active" href="<?php echo $link_contact; ?>"><?php echo $text_contact_box; ?></a>
      <div style="clear:both;"></div>
    </div>
    <div class="content">
      <div class="rsidebar fullheight resolsidebar">
        <?php echo $column_right; ?>
        <!--<h3 style="color:#617daa;"><?php echo $text_community; ?></h3>
        <a href="<?php echo $link_community; ?>" class="darkestbluebutton" style="display:block;padding:10px;font-size:18px;font-weight:normal;margin-bottom:10px;border-radius: 5px 0 0 5px;-webkit-border-radius: 5px 0 0 5px;-moz-border-radius: 5px 0 0 5px;"><?php echo $text_livesupport; ?></a>
        <p><?php echo $text_communitydesc; ?></p>-->
        <br />
        <!--<?php echo $show_boards; ?>-->  
      </div>
      <div class="content inner"  style="padding:20px;">
        <div class="text-wrap-content">
          <div class="text-content" style="padding-top:0;">
            <h5 class="smalltitle"><?php echo $text_title; ?></h5>
            <div class="texty"><?php echo $text_undertitle; ?></div>
          </div>  
        </div>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <div class="contactform">
            <select name="category">
              <option value="category"><?php echo $entry_category; ?></option>
              <option value="general">General</option>
              <option value="payment">Payment</option>
              <option value="download">Download</option>
              <option value="activation">Activation</option>
              <option value="community">Community</option>
              <option value="partner">Partner</option>
              <option value="legal">Legal</option>
            </select>
            <input type="text" name="subject" placeholder="<?php echo $entry_subject; ?>" value="<?php echo $subject; ?>" />
            <br />
            <?php if ($error_enquiry) { ?>
            <br /><span class="error"><?php echo $error_enquiry; ?></span>
            <?php } ?>
            <textarea name="enquiry" cols="40" rows="10" placeholder="<?php echo $entry_enquiry; ?>"><?php echo $enquiry; ?></textarea>
            <br />
            <?php if ($error_name) { ?>
            <br /><span class="error" style="padding-left:131px;"><?php echo $error_name; ?></span>
            <?php } ?>
            <span style="float:left;margin:10px 0 0 5px;color:#555555;"><?php echo $entry_name; ?></span><input style="width:75%;float:right;" type="text" name="name" value="<?php echo $name; ?>" /><div style="clear:left"></div>
            <br />
            <?php if ($error_email) { ?>
            <br /><span class="error" style="padding-left:131px;"><?php echo $error_email; ?></span>
            <?php } ?>
            <span style="float:left;margin:10px 0 0 5px;color:#555555;"><?php echo $entry_email; ?></span><input style="width:75%;float:right;" type="text" name="email" value="<?php echo $email; ?>" /><div style="clear:left"></div>
    <?php if ($recaptcha) { ?>
    <?php if ($error_captcha) { ?>
    <br /><br /><span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>
    <?php echo $recaptcha; ?>
    <br />
    <?php } else { ?>
            <b><?php echo $entry_captcha; ?></b><br />
            <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
            <br />
            <img src="index.php?route=information/contact/captcha" alt="" />
            <?php if ($error_captcha) { ?>
            <br /><br /><span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>
            <?php } ?>
            <div class="greybox">
              <input type="submit" value="<?php echo $entry_submit; ?>" class="blackbutton" />
              <span><?php echo $text_botinfo; ?></span>
            </div>
            <?php if ($succ == 1) { ?>
            <br /><span class="error"><?php echo $text_message; ?></span>
            <?php } ?>
            <div style="clear:left"></div>
          </div>
        </form>
      </div>
      <div style="clear:both"></div>
      <?php echo $content_bottom; ?>
    </div>
    <br /><br /><br /><br />
  </div>
</div>
<br />
<br /> 
<?php echo $footer; ?>
<script><!--
$(document).ready(function() {  
  $('#bgoverlap').hide();
  $('#contact').addClass('active');
  var whash = window.location.hash.replace("#","");
  if (whash == "reseller") {
    $('input[name="subject"]').val('Reseller program application');
    $('select[name="category"]').val('partner');
  }
});
//--></script>
