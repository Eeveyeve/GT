<?php echo $header; ?>
<div id="wrap">
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php echo $column_left; ?>
  <div id="column-right"><?php echo $column_right; ?></div>
  <div id="content"><?php echo $content_top; ?>
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <h2 class="floatheading"><?php echo $text_address_book; ?></h2>
    <?php foreach ($addresses as $result) { ?>
    <div class="content">
      <table style="width: 100%;">
        <tr>
          <td><?php echo $result['address']; ?></td>
          <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button bluebutton"><?php echo $button_edit; ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button blackbutton"><?php echo $button_delete; ?></a></td>
        </tr>
      </table>
    </div>
    <?php } ?>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button blackbutton"><?php echo $button_back; ?></a></div>
      <div class="right"><a href="<?php echo $insert; ?>" class="button bluebutton"><?php echo $button_new_address; ?></a></div>
    </div>
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