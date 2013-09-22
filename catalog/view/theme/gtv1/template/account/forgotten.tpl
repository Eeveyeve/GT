<?php echo $header; ?>
<div id="wrap">
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php echo $column_left; ?>
  <div id="content"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <h1 class="heading"><?php echo $heading_title; ?></h1>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <p class="underheading" style="margin-top:0px;"><?php echo $text_email; ?></p>
      <h2 class="floatheading"><?php echo $text_your_email; ?></h2>
      <div class="content">
        <table class="form">
          <tr>
            <td><?php echo $entry_email; ?></td>
            <td><input type="text" name="email" value="" style="border: 1px solid #CCCCCC;" /></td>
          </tr>
        </table>
      </div>
      <div class="buttons">
        <div class="left"><a href="<?php echo $back; ?>" class="darkbluebutton button"><?php echo $button_back; ?></a></div>
        <div class="right">
          <input type="submit" value="<?php echo $button_continue; ?>" class="blackbutton button" />
        </div>
      </div>
    </form>
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