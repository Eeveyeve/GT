<?php echo $header; ?>
<div id="wrap">
  <div id="column-right"><?php echo $column_right; ?></div>
  <div id="content"><?php echo $content_top; ?>
<div class="menu">
<ul>
<li class="step"><a style="cursor:default" href="javascript:void(0);" >My Shopping Cart</a></li>
<li class="step"><a href="javascript:void(0);">Email</a></li>
<li class="step"><a style="cursor:no-drop" href="javascript:void(0);">Payment</a></li>
<li class="step last"><a style="cursor:no-drop" class="active" href="javascript:void(0);">Confirmation</a></li>
</ul>
</div>
    <!--<h1 class="heading"><?php echo $heading_title; ?></h1>-->
      <br />
    <div style="border:1px solid #ccc; width:95%; background:#eee; padding:10px;">
   <strong> Thank you for choosing Gaming Titans!</strong><br/>
We're happy to say that you order # <?php echo ($order_info) ? $order_info['order_id'] : '';?> been confirmed.<br/>
<!--Your account balance been rewarded with $2.1<br/>-->
    
    </div>
     <br />
      <br />
  <h2>Products Purchased</h2>
  
  <?php if($products){
  foreach($products as $result){
  ?>
  	<div class="productbox">
    	<?php
        if($result['thumb']){?>
        	<img src="<?php echo $result['thumb'];?>" />
        <?php } ?>
        X <?php echo $result['quantity'];?>  <?php echo $result['name'];?>
    </div>
  <?php }?>
   <?php }?>
   <hr />
   <br />
   Total Price: $<?php echo ($order_info) ? $order_info['total'] : '';?><br />
  <!-- Balance used in this purchase: <br />-->
   Total Paid : $<?php echo ($order_info) ? $order_info['total'] : '';?> <br />
    <br />
    <h2>Products Infomation</h2> 
   <div class="orderinfobox">
   		<div class="customerinfo" style="width:40%; float:left">
        <strong>Name:</strong> <?php echo ($order_info) ? $order_info['firstname'].' '.$order_info['lastname'] : '';?> <br />
        <strong>Email:</strong> <?php echo ($order_info) ? $order_info['delivery_email'] : '';?> <br />
        <strong>Phone:</strong> <?php echo ($order_info) ? $order_info['telephone'] : '';?> <br />
        <strong>City:</strong> <?php echo ($order_info) ? $order_info['payment_city'] : '';?> <br />
        <strong>Country:</strong> <?php echo ($order_info) ? $order_info['payment_country'] : '';?> <br />
        </div>
   		<div class="customerinfo" style="width:40%; float:left">
        <strong>Order date: </strong><?php echo ($order_info) ? $order_info['date_modified'] : '';?> <br />
        <strong>Order number: </strong><?php echo ($order_info) ? $order_info['delivery_email'] : '';?> <br />
        <strong>Payment method: </strong><?php echo ($order_info) ? $order_info['payment_method'] : '';?> <br />
        <strong>Total paid:</strong> $<?php echo ($order_info) ? $order_info['total'] : '';?> <br />
        </div>
        
        </div>
   </div>
    <h2 clas="floatheading" style="text-align:center;"><?php //echo $text_message; ?></h2>
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