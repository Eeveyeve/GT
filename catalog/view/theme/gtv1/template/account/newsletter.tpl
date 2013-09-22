<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="edit_newsletter">
  <?php if ($newsletter) { ?>
    <input type="checkbox" name="newsletter" value="1" checked="checked" class="edit_newsletter" />
    <script>$(".edit_newsletter").prop("checked", true);</script>
  <?php } else { ?>
    <input type="checkbox" name="newsletter" value="1" class="edit_newsletter" />
  <?php } ?>
  <span style="font-size:14px;color:#747474;"><?php echo $entry_newsletter; ?></span>
</form>