<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="edit_password">
  <label for="password"><?php echo $entry_password; ?></label>
  <input style="margin-left:0;" type="password" id="password" name="password" class="accinput" placeholder="<?php echo $entry_password; ?>" value="" />
  <input type="password" id="confirm" name="confirm" class="accinput" placeholder="<?php echo $entry_confirm; ?>" value="" />
  <br />
</form>
