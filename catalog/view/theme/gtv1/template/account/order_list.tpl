<div class="order-history">
  <?php if ($products) { ?>
  <div>
  <?php foreach ($products as $product) { ?>
  <div class="order-list">
    <div class="order-image"><img src="<?php echo $product['product_image']; ?>" /></div>
    <div class="order-description">
      <p><?php echo $product['product_name']; ?></p>
      <br /><br /><br />
      <span><b><?php echo $text_order_id; ?></b> #<?php echo $product['order_id']; ?></span><br />
      <span><b><?php echo $text_status; ?></b> 
        <?php if ($product['sys_date_available'] >= date("Y-m-d H:i:s", time())){ ?>
          <?php echo $text_willbe; ?><?php echo $product['date_available']; ?>
        <?php } else { ?>
          <?php echo $product['status']; ?>
        <?php } ?>
      </span>
    </div>
    <div class="order-resend"><a id="<?php echo $product['order_id']; ?>" data-id="<?php echo $product['product_id']; ?>" class="darkestbluebutton resendbutton <?php echo $product['product_id']; ?>"><img src="catalog/view/theme/gtv1/image/resend.png" style="margin-top:1px;" /></a></div>
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
//EvenizeOrderHistory();
$('.order-resend a').live('click', function () {
  var resend_button = $('.resendbutton[data-id="'+$(this).attr('data-id')+'"]#'+$(this).attr('id'));
  if (resend_button.hasClass('darkestbluebutton')) {
    $.ajax({
  		url: 'index.php?route=account/order/resendKey&order_id='+resend_button.attr('id')+'&product_id='+resend_button.attr('data-id'),
  		type: 'post',
  		data: 'order_id=' + resend_button.attr('id'),
  		dataType: 'json',		
  		beforeSend: function() {
        resend_button.css('cursor','wait')
  		},
  		/*complete: function() {
  		},*/
      error: function(json) {
        resend_button.removeClass('darkestbluebutton').addClass('greybuttonstatic').css('cursor','default').empty().html('<img src="catalog/view/theme/gtv1/image/failed.png" />');
      },		
  		success: function(json) {
        if (json['error']) {
          resend_button.removeClass('darkestbluebutton').addClass('greybuttonstatic').css('cursor','default').empty().html('<img src="catalog/view/theme/gtv1/image/failed.png" />');
        } else {
          resend_button.addClass('active').css('cursor','default').empty().html('<img src="catalog/view/theme/gtv1/image/sent.png" style="margin-top:3px;" />');
        }
  		}
  	});
  }  
});
</script>  