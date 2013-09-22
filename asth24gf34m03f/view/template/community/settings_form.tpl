<?php echo $header; ?>
<div id="content">
  <?php if (isset($error_warning)) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/category.png" alt="" /> Inserting a new Word/URL to block</h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button">Save</a><a href="<?php echo $cancel; ?>" class="button">Cancel</a></div>
    </div>
    <div class="content">
    <form action="<?php echo $action; ?>" method="post" id="form">
    	<table class="form">
        	<tr><td><span class="required">*</span> URL/Word to be blocked:</td><td><input type="text" name="settings_description[1][word]" size="100" value="<?php echo isset($word) ? $word['word'] : '' ?>">
             <?php if (isset($error_word)) { ?>
                  <span class="error"><?php echo $error_word; ?></span>
                  <?php } ?>
            </td></tr>
        </table>
    </form>
	</div>
</div>
</div>
<?php echo $footer; ?>