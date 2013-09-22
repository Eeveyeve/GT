<html>
<head>
<meta charset="UTF-8" />
<meta name="robots" content="noindex, nofollow" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/reg_popup.css" />
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script type="text/javascript">
parent.$("#fancybox-content").css('height', '200px');
parent.$.fancybox.center();
/*parent.$.fancybox.close;
parent.window.location = "<?php echo $link_account; ?>";*/
</script>
</head>
<body>
<div id="content"><?php echo $content_top; ?>
  <h1 style="margin-bottom:0px;"><?php echo $heading_title; ?></h1>
  <h2><?php echo $text_iframe_message; ?></h2>
  <br />
  <a target="_parent" href="<?php echo $link_account; ?>" class="darkbluebutton roundbutton largerbutton" style="width:228px;display:block;color:#FFFFFF!important;text-align:center;"><?php echo $button_account; ?></a>
  <br />
  <!--<a target="_parent" href="<?php echo $link_affiliate; ?>" class="greenbutton roundbutton largerbutton" style="width:228px;display:block;color:#FFFFFF!important;text-align:center;"><?php echo $button_affiliate; ?></a>
  <br />-->
  <a target="_parent" href="<?php echo $link_shopping; ?>" class="greenbutton roundbutton largerbutton" style="width:228px;display:block;color:#FFFFFF!important;text-align:center;"><?php echo $button_shopping; ?></a>
  <?php echo $content_bottom; ?></div>
</body>
</html>  