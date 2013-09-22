<?php if (!isset($redirect)) { ?>
<!--<div class="checkout-product">
  <table>
    <thead>
      <tr>
        <td class="name"><?php echo $column_name; ?></td>
        <td class="model"><?php echo $column_model; ?></td>
        <td class="quantity"><?php echo $column_quantity; ?></td>
        <td class="price"><?php echo $column_price; ?></td>
        <td class="total"><?php echo $column_total; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?></td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="quantity"><?php echo $product['quantity']; ?></td>
        <td class="price"><?php echo $product['price']; ?></td>
        <td class="total"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="name"><?php echo $voucher['description']; ?></td>
        <td class="model"></td>
        <td class="quantity">1</td>
        <td class="price"><?php echo $voucher['amount']; ?></td>
        <td class="total"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td colspan="4" class="price"><b><?php echo $total['title']; ?>:</b></td>
        <td class="total"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
</div>-->
<div class="confirm-thankblock" style="display:none">
  <h2>Payment process is protected by Paypal and Verisign</h2>
  <div class="confirm-greyblock">
    <h3 class="smaller-floatheading" style="margin: 0px 15px 8px;">Every Purchase is secured</h3>
    <p>
	You get an additional layer of privacy when you use Paypal and VeriSign to pay for your purchases. That's because your financial information (like your credit card number) is protected with SSL and High secured methods 24/7.
	</p>
	
	<br />
	
	 <h3 class="smaller-floatheading" style="margin: 0px 15px 8px;">Safer Purchase with Buyer Protection</h3>
    <p>
Gaming Titans gurantee to send the products within 24 hours. If an eligible item doesn't arrive after 24 hours. Gaming Titans Buyer Protection can help you get all your money back.
	</p>
	
	
    <p>Payment Method: <b><?php echo $payment_method; ?></b></p>
     <p>Total price: <b><?php echo $totals[1]['text']; ?></b></p>
  </div>  
</div>


<!--<div class="confirm-thankblock">
  <h2>Thank You for choosing Gaming Titans!</h2>
  <p>You will be now redirected to secured payment page.<br />Your order should be delivered soon after payment has been done.</p>
  <div class="confirm-greyblock">
    <h3 class="smaller-floatheading" style="margin: 0px 15px 8px;">Here are your purchase details:</h3>
    <p>Name: <b><?php echo $firstname.' '.$lastname; ?></b></p>
    <p>Order number: <b>#<?php echo $this->session->data['order_id']; ?></b></p>
    <p>Order Date: <b><?php echo date($this->language->get('date_format_3'), strtotime($order_date)); ?></b></p>
    <br />
    <p>Payment Method: <b><?php echo $payment_method; ?></b></p>
     <p>Total price: <b><?php echo $totals[1]['text']; ?></b></p>
  </div>  
</div>

<h3 class="smaller-floatheading">Products purchased:</h3>
<div class="cart-info">
  <table>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr class="cartproduct">
        <td class="image"><?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
          <?php } ?>
        </td>
        <td class="name"><a class="game" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
        <td class="quantity" style="text-align:center;">
          <span><?php echo $column_quantity; ?></span><br / >
          <span style="margin-top:3px;font-family:Calibri;font-size:17px;color:#000000;"><?php echo $product['quantity']; ?></span>
        </td>
        <td colspan="2" class="price"><span class="lower"><?php echo $product['price']; ?>&nbsp;x<?php echo $product['quantity']; ?></span><br /><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $vouchers) { ?>
      <tr>
        <td class="image"></td>
        <td class="name"><?php echo $vouchers['description']; ?></td>
        <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" /></td>
        <td class="price"><?php echo $vouchers['amount']; ?></td>
        <td class="total"><?php echo $vouchers['amount']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($totals as $total) { ?>
      <tr class="subtotalrow">
        <td colspan="3" class="subtotalleft"><?php echo $total['title']; ?></td>
        <td colspan="2" class="subtotalright"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>

<h3 class="smaller-floatheading">Getting help from Gaming Titans</h3>
<p style="margin: 0 0 0 15px;">While you cannot reply to this, you can contact us through our <a href="<?php echo $this->url->link('information/contact'); ?>" style="text-decoration:none;color:#617daa;">Resolution Center</a> for assistance. You can also visit our <a href="<?php echo $this->url->link('community/community'); ?>" style="text-decoration:none;color:#617daa;">Live Community.</a></p>
<br />
<span style="font-size:12px;color:#000000;margin: 0 0 0 15px;">Gaming Titans &copy; 2013. Trademarks belong to their respective owners. All rights reserved.</span>
-->
<h4 style="margin:40px 0 0" align="center">Loading.....</h4>
<img class="paymentloader" src="catalog/view/theme/gtv1/image/snake-loader.gif" style="margin:150px 320px;" />
<div class="payment"><?php echo $payment; ?></div>
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script> 
<?php } ?>