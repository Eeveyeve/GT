<?php echo $header; ?>
<div id="wrap">
  <?php echo $column_left; ?>
  <div id="column-right"><?php echo $column_right; ?></div>
  <div id="content"><?php echo $content_top; ?>
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <p><?php echo $text_total; ?><b> <?php echo $total; ?></b>.</p>
    <table class="list">
      <thead>
        <tr>
          <td class="left"><?php echo $column_date_added; ?></td>
          <td class="left"><?php echo $column_description; ?></td>
          <td class="right"><?php echo $column_points; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php if ($rewards) { ?>
        <?php foreach ($rewards  as $reward) { ?>
        <tr>
          <td class="left"><?php echo $reward['date_added']; ?></td>
          <td class="left"><?php if ($reward['order_id']) { ?>
            <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
            <?php } else { ?>
            <?php echo $reward['description']; ?>
            <?php } ?></td>
          <td class="right"><?php echo $reward['points']; ?></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
          <td class="center" colspan="5"><?php echo $text_empty; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <div class="pagination"><?php echo $pagination; ?></div>
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