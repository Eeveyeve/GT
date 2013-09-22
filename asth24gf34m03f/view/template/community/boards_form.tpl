<?php echo $header; ?>
<div id="content">
  <?php if (isset($error_warning)) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/category.png" alt="" /> Inserting a new Board</h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button">Save</a><a href="<?php echo $cancel; ?>" class="button">Cancel</a></div>
    </div>
    <div class="content">
    <form action="<?php echo $action; ?>" method="post" id="form">
    	<table class="form">
        	<tr><td><span class="required">*</span> Board name:</td><td><input type="text" name="board_description[1][name]" size="100" value="<?php echo isset($board) ? $board['name'] : '' ?>">
             <?php if (isset($error_name)) { ?>
                  <span class="error"><?php echo $error_name; ?></span>
                  <?php } ?>
            </td></tr>
            <tr><td><span class="required">*</span> Board order:</td><td><input type="text" name="board_description[1][order]" size="10" value="<?php echo isset($board) ? $board['board_order'] : '' ?>">
            <?php if (isset($error_order)) { ?>
                  <span class="error"><?php echo $error_order; ?></span>
                  <?php } ?>
            </td></tr>
            <tr><td>Board Etiquette:</td><td><textarea name="board_description[1][etiquette]" cols="40" rows="5"><?php echo isset($board) ? $board['etiquette'] : '' ?></textarea></td></tr>
        </table>
    </form>
	</div>
</div>
</div>
<?php echo $footer; ?>