<?php echo $header; ?>
<div id="wrap">
  <?php echo $column_left; ?>
  <div id="column-right"><?php echo $column_right; ?></div>
  <div id="content"><?php echo $content_top; ?>
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <?php if ($returns) { ?>
    <?php foreach ($returns as $return) { ?>
    <div class="return-list">
      <div class="return-id"><b><?php echo $text_return_id; ?></b> #<?php echo $return['return_id']; ?></div>
      <div class="return-status"><b><?php echo $text_status; ?></b> <?php echo $return['status']; ?></div>
      <div class="return-content">
        <div><b><?php echo $text_date_added; ?></b> <?php echo $return['date_added']; ?><br />
          <b><?php echo $text_order_id; ?></b> <?php echo $return['order_id']; ?></div>
        <div><b><?php echo $text_customer; ?></b> <?php echo $return['name']; ?></div>
        <div class="return-info"><a href="<?php echo $return['href']; ?>"><img src="catalog/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a></div>
      </div>
    </div>
    <?php } ?>
    <div class="pagination"><?php echo $pagination; ?></div>
    <?php } else { ?>
    <div class="content"><?php echo $text_empty; ?></div>
    <?php } ?>
    <div class="buttons">
      <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
    </div>
    <?php echo $content_bottom; ?>
  </div>
</div>
<?php echo $footer; ?>
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