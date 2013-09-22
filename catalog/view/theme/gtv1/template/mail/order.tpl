<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
  <head>
    <style>
    *, html, body, table, tbody, tr, td {font-family: Arial;}
    a {text-decoration: none;}
    p {font-size: 12px; font-weight: normal; margin: 0px; color: #777777;}
    strong {font-size: 12px; font-weight: normal; margin: 0px; color: #000000;}
    p strong {font-size: 12px; font-weight: normal; margin: 0px; color: #000000;}    
    h1 {font-size: 16px; font-weight: bold; margin: 0px; color: #000000;}
    h2 {font-size: 14px; font-weight: bold; margin: 0px; color: #000000;}
    h3 {font-size: 18px; font-weight: bold; margin: 0px; color: #008808;}
    h4 {font-size: 14px; font-weight: bold; margin: 0px; color: #008808;}
    </style>
  </head>
  <body>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>	
        <tr>
      		<td width="813px" colspan="3"><a style="text-decoration:none;" href="<?php echo $store_url; ?>"><img style="width:145px;height:52px;" width="145px" height="52px" alt="<?php echo $store_name; ?>" title="<?php echo $store_name; ?>" src="<?php echo $store_url; ?>/image/data/common/email-logo.png"></a></td>
      		<td width="167px" valign="bottom" align="right" style="text-align:right;vertical-align:bottom;"><a href="https://www.facebook.com/gamingtitans" style="text-decoration:none;color: #375c9d;"><img src="<?php echo $store_url; ?>/catalog/view/theme/gtv1/image/social/mini-fb.png" style="float:right;"><!--Join us on Facebook--></a></td>
      	</tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" bgcolor="#f8f8f8" style="background-color: #f8f8f8; color: #666666; border: 1px solid #e0e0e0; padding: 20px; font-size: 12px;">
            <h2 style="margin:0px;">Order Confirmation to #<?php echo $order_id; ?></h2>
            We're happy to say that your order #<?php echo $order_id; ?> been confirmed.
            <br>
            Your account balance been rewarded with <?php echo $account_reward; ?>.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr><td colspan="2"></td></tr>
        <tr>
      		<td width="44px"><img src="<?php echo $store_url; ?>/catalog/view/theme/gtv1/image/check-v.png" width="44px" height="42px" /></td>
      		<td width="963px" style="font-size:12px;color:#777777;">
            <?php if ($preorders > 0 && $non_preorders > 0) { ?>
              <h1 style="font-size:16px;font-weight:bold;margin:0px;color:#000000;">Your purchased products will be delivered on release date for Pre Orders and within 24 hours for released games.</h1>
            <?php } else if ($preorders > 0) { ?>
              <h1 style="font-size:16px;font-weight:bold;margin:0px;color:#000000;">Your purchased products will be delivered on release date.</h1>
            <?php } else { ?>
              <h1 style="font-size:16px;font-weight:bold;margin:0px;color:#000000;">Your Purchased products will deliver within 24 hours.</h1>
            <?php } ?>
            Meanwhile, we can offer you to review your purchase, Like us on <a href="https://www.facebook.com/gamingtitans"  style="text-decoration:none;color:#3d4f81;">Facebook</a>, or chat in our <a  style="text-decoration:none;color:#777777;" href="<?php echo $community_link; ?>">Live Community</a>.
          </td>
        <tr><td colspan="2"></td></tr>
        <tr><td colspan="2" style="border-bottom:1px solid #ececec"></td></tr>
        <tr><td colspan="2"></td></tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="10" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr>
          <td colspan="4"><h3 style="margin:0px;color:#008808;">Products Purchased</h3></td>
        </tr>
        <?php foreach ($products as $product) { ?>
          <tr>
            <td width="80px" valign="middle" align="center" style="width:80px;"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" width="64px" height="80px" style="width:64px;height:80px;"></td>
            <td width="7px" valign="middle" align="center" style="width:7px;color:#c7c7c7;font-size:16px;">x</td>
            <td width="20px" valign="middle" align="left" style="width:20px;color:#c7c7c7;font-size:20px;text-align:left;"><?php echo $product['quantity']; ?></td>
            <td valign="middle" align="left" style="padding:30px 5px;color:#9c9c9c;font-size:12px;">
              <h1 style="font-size:16px;font-weight:bold;margin:0px;color:#000000;"><?php echo $product['name']; ?></h1>
              <?php echo $product['genre']; ?> - Release Date: <?php echo $product['date_available']; ?>
            </td>
          </tr>
        <?php } ?>  
        <tr><td colspan="4" style="border-bottom:1px solid #ececec"></td>
        </tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr><td></td></tr>
        <tr>
      		<td><h4 style="margin:0px;color:#008808;">Total Price: <b style="color:#000000;font-weight:bold;"><?php echo $total_price; ?></b></h4></td>
        </tr>
        <tr>
      		<td><p style="margin:0px;">Balance used in this purchase: <b style="color:#ff0000;font-weight:bold;">- <?php echo $manual_member_reward; ?></b></p></td>
        </tr>
        <tr>
      		<td><p style="margin:0px;">Total Paid: <b style="color:#000000;font-weight:bold;"><?php echo $total; ?></b></p></td>
        </tr>  
        <tr><td></td></tr>
        <tr><td></td></tr>
        <tr><td></td></tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr><td></td></tr>
        <tr>
      		<td><h3 style="margin:0px;color:#008808;">Purchase Information</h3></td>
        </tr>
        <tr><td></td></tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="1" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr>
      		<td width="2px"></td><td width="280px"><p style="margin:0px;">Name: <strong><?php echo $firstname." ".$lastname; ?></strong></p></td><td><p style="margin:0px;">Order date: <strong><?php echo $date_added; ?></strong></p></td>
        </tr>
        <tr>
      		<td width="2px"></td><td width="280px"><p style="margin:0px;">Email: <strong><?php echo $email; ?></strong></p></td><td style="font-weight:bold;"><p style="margin:0px;">Order number: <strong><?php echo $order_id; ?></strong></p></td>
        </tr>
        <tr>
      		<td width="2px"></td><td width="280px"><p style="margin:0px;">Phone: <strong><?php echo $telephone; ?></strong></p></td><td><p style="margin:0px;">Payment Method: <strong><?php echo $payment_method; ?></strong></p></td>
        </tr>
        <tr>
      		<td width="2px"></td><td width="280px"><p style="margin:0px;">City: <strong><?php echo $payment_city; ?></strong></p></td><td><p style="margin:0px;">Total Paid: <strong><?php echo $total; ?></strong></p></td>
        </tr>
        <tr>
      		<td width="2px"></td><td width="280px"><p style="margin:0px;">Country: <strong><?php echo $payment_country; ?></strong></p></td><td></td>
        </tr>
      </tbody>  
    </table>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr><td></td></tr>
        <tr><td></td></tr>
        <tr><td></td></tr>
        <tr>
      		<td><h3 style="margin:0px;color:#008808;">Email address for Delivery</h3></td>
        </tr>
        <tr>
      		<td><p style="margin:0px;"><strong><?php echo $delivery_email; ?></strong></p></td>
        </tr>  
        <tr><td></td></tr>
      </tbody>  
    </table>  
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4" style="border-bottom: 1px solid #ececec;"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" style="font-size: 12px; color: #9c9c9c;">
            <h2 style="margin:0px;">Got questions? Don&rsquo;t Hesitate to ask!</h2>
            We've got an amazing customer service team waiting to answer your questions!
            <br>
            Use <a href="<?php echo $faq_link; ?>"  style="text-decoration:none;color:#9c9c9c;">FAQ</a>, <a href="<?php echo $community_link; ?>"  style="text-decoration:none;color:#9c9c9c;">Community Live Support</a> or <a href="<?php echo $contact_link; ?>"  style="text-decoration:none;color:#9c9c9c;">Email</a> to get answer anytime!
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" style="font-size: 12px; color: #9c9c9c;">
            <h2 style="margin:0px;">How did this purchase go for you?</h2>
            We would really appreciate if you can write a review and share your expirience.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" bgcolor="#f8f8f8" valign="middle" align="center" style="text-align: center; background-color: #f8f8f8; color: #797979; border: 1px solid #e0e0e0; padding: 20px; font-size: 11px;">
            All trademarks and copyrights are properties of their respective owners.
            <br>
            <?php echo date("Y"); ?> &copy; <?php echo $store_name; ?>
          </td>
        </tr>
      </tbody>  
    </table>
  </body>
</html>
