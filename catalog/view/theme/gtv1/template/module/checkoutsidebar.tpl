<?php if (!$logged) { ?>
  <div id="right-login">
    <h2><?php echo $text_login; ?></h2>
    <form enctype="multipart/form-data" method="post" action="<?php echo $action; ?>">
    <table class="form">
      <tr>
        <td><input type="text" placeholder="<? echo $entry_email; ?>" value="" name="email">
        </td>
      </tr>
      <tr>
        <td><input type="password" placeholder="<? echo $entry_password; ?>" value="" name="password">
          <input type="hidden" name="redirect" value="<?php echo 'http://'.$_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];?>">
        </td>
      </tr>
      <tr>
        <td><input type="submit" class="darkestbluebutton button" style="float:left" value="<?php echo $text_login; ?>">
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
          <br />
          <a href="<?php echo $register_iframe; ?>" class="fancylink"><?php echo $text_register; ?></a>
        </td>
      </tr>
    </table>
  </form>
  </div>
<?php } else { ?>
  <div id="right-order">
    <h2><?php echo $text_summary; ?></h2>
    <div class="part">
      <ul>
      	<li><label>Name:</label><?php echo $firstname;?> <?php echo $lastname;?></li>
      	<li><label>Email:</label><?php echo $email;?></li>
      	<?php if($phone){?><li><label>Phone:</label><?php echo $phone;?></li><?php }?>
      	<li><label>City:</label><?php echo $city;?></li>
      	<li><label>Country:</label><?php echo $country;?></li>
      </ul>
    </div>
    <div class="part">
      <h4>Products in my cart:</h4>
      <?php foreach($this->cart->getProducts() as $product) { ?>
        <p><b><?php echo $product['quantity']; ?> x <?php echo $product['name']; ?></b></p>
      <?php } ?>
    </div>
    <div class="part right-delivery-email">
      <p>Delivery adress:</p>
      <?php if(isset($this->session->data['anotheremail']) && $this->session->data['anotheremail'] != "") { ?>
        <p><strong id="side-delivery-email"><?php echo $this->session->data['anotheremail']; ?></strong></p>
      <?php } else { ?>
        <p><strong id="side-delivery-email"><?php echo $this->customer->getEmail(); ?></strong></p>
      <?php } ?>
    </div>
    <div class="part">
      <h3>Total to Pay: <b><?php echo $this->currency->format($this->cart->getTotal()-$manual_member_reward); ?></b></h3>
      <p>Balance use: <span>- <?php echo $this->currency->format($manual_member_reward); ?></span><p>
      <p>Total Price before Balance use: <b><?php echo $this->currency->format($this->cart->getSubTotal()); ?></b><p>
    </div>
    <input type="hidden" id="side-customer-email" value="<?php echo $this->customer->getEmail(); ?>" />
  </div>
  <script type="text/javascript"><!--
  $(document).ready( function() {
    $('#verify-email input[name=anotheremail]').bind('input', function() {
      $('#side-delivery-email').text($('#verify-email input[name=anotheremail]').val()); 
    });
    $('#verifyEmailOption1').bind('click', function() {
      $('#side-delivery-email').text($('#side-customer-email').val());
    });
  });  
  //--></script>  
<?php }?>