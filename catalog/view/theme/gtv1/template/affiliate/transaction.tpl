<div class="order-history">
  <h2><?php echo $heading_title; ?></h2>
  <?php if ($transactions) { ?>
  <div>
  <?php foreach ($transactions as $transaction) { ?>
  <div class="order-list">
    <div class="order-image"><img src="<?php echo $transaction['order_image']; ?>" /></div>
    <div class="order-description"><p><?php echo $transaction['date_added']; ?></p><span><b></b> #<?php echo $transaction['order_id']; ?></span></div>
    <div class="order-status"><p></p><span></span></div>
    <div class="order-commision"><?php echo $transaction['amount']; ?></div>
    <div style="clear:both;"></div>
  </div>
  <?php } ?>
  </div>
<div style="display:none;" class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div class="order-list"><?php echo $text_empty; ?></div>
<?php } ?>
</div>
<script type="text/javascript">
EvenizeOrderHistory();
</script>