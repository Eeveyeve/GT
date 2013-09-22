<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="edit_edit">
  <label for="firstname"><?php echo $entry_firstname; ?></label><input type="text" id="firstname" name="firstname" class="accinput" value="<?php echo $firstname; ?>" />
  <br />
  <label for="lastname"><?php echo $entry_lastname; ?></label><input type="text" id="lastname" name="lastname" class="accinput" value="<?php echo $lastname; ?>" />
  <div id="address_block"></div>
  <br />
  <br />
  <br />
  <h2><?php echo $text_your_details; ?></h2>
  <label for="email"><?php echo $entry_email; ?></label><input type="text" id="email" name="email" class="accinput" value="<?php echo $email; ?>" />
  <br />
</form>
<?php echo $password; ?>
<!--<tr>
  <td><span class="whitetext small calibri"><?php echo $entry_telephone; ?></span>&nbsp;
  <span id="telephone" class="edit edit_telephone greytext small calibri"><?php if($telephone){ echo $telephone;} else{ echo('xxx-xxx-xxx');} ?></span></td>
</tr>-->
<!--<tr>
  <td><span class="whitetext small calibri"><?php echo $entry_fax; ?></span>&nbsp;
  <span id="fax" class="edit edit_fax greytext small calibri"><?php if($fax){ echo $fax;} else{ echo('xxx-xxx-xxx');} ?></span></td>
</tr>-->