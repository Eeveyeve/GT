<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="wrap">
  <div id="content"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <h1 class="heading"><?php //echo $heading_title; ?></h1>
    <br /><br /><br />
    <h2 clas="floatheading" style="text-align:center;"><?php echo $text_message; ?></h2>
    <br /><br /><br /><br />
    <a href="<?php echo $link_account; ?>" class="bluebutton roundbutton largerbutton" style="width:200px;margin:0 3.8%;display:inline-block;color:#000000!important;text-align:center;"><?php echo $button_account; ?></a>
    <a href="<?php echo $link_affiliate; ?>" class="greenbutton roundbutton largerbutton" style="width:200px;margin:0 3.8%;display:inline-block;color:#FFFFFF!important;text-align:center;"><?php echo $button_affiliate; ?></a>
    <a href="<?php echo $link_shopping; ?>" class="darkbluebutton roundbutton largerbutton" style="width:200px;margin:0 3.8%;display:inline-block;color:#FFFFFF!important;text-align:center;"><?php echo $button_shopping; ?></a>
    <?php echo $content_bottom; ?>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready( function() { 
  $('#wrap').addClass('clearbg wrapme');
  $('#header').addClass('clearbg wrapme nopaddingheader');
  $('#notification').addClass('wrapme');
  $('.wrapme').wrapAll('<div class="bigwrap"></div>');
  $('.bigwrap').addClass('toppagemargin nopadding');
  $('#bgoverlap').hide();
});
//--></script>
<?php echo $footer; ?>