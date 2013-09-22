<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><?php echo $title; ?></title>
    <style>
    *, html, body, table, tbody, tr, td {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;}
    h1 {font-size: 24px; font-weight: normal; margin: 0px; color: #9c9c9c;}
    h2 {font-size: 14px; font-weight: bold; margin: 0px; color: #000000;}
    </style>
  <head>
  <body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;">
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>	
        <tr>
      		<td width="813px" colspan="3"><a href="<?php echo $store_url; ?>"><img style="width:145px;height:52px;" width="145px" height="52px" alt="<?php echo $store_name; ?>" title="<?php echo $store_name; ?>" src="<?php echo $store_url; ?>/image/data/common/email-logo.png"></a></td>
      		<td width="167px" valign="bottom" align="right" style="text-align:right;vertical-align:bottom;"><a href="https://www.facebook.com/gamingtitans" style="color: #375c9d;text-decoration:none;"><img src="<?php echo $store_url; ?>/catalog/view/theme/gtv1/image/social/mini-fb.png" style="float:right;"><!--Join us on Facebook--></a></td>
      	</tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" bgcolor="#f8f8f8" style="background-color: #f8f8f8; color: #666666; border: 1px solid #e0e0e0; padding: 20px; font-size: 12px;">
            <h2>Your order has arrived.</h2>
            Dear <?php echo $firstname; ?> <?php echo $lastname; ?>, your order number <?php echo $order_id; ?> has been fully accomplished and delivered.
            <br>
            Below you will be able to find the products you ordered.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td width="80px" valign="middle" align="center" style="width: 80px;"><img src="<?php echo $product_image; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" width="64px" height="80px" style="width:64px;height:80px;"></td>
          <td width="55px" valign="middle" align="center" style="width: 55px;"><img src="<?php echo $product_manufacturer_image2; ?>" title="<?php echo $product_manufacturer; ?>" alt="<?php echo $product_manufacturer; ?>" width="40px" height="40px" style="width:40px;height:40px;"></td>
          <td width="845px"valign="middle" align="left" style="padding: 30px 5px; color: #555555; font-size: 11px; width: 845px;" colspan="2">
            <h2><?php echo $product_name; ?></h2>
            <h1><?php echo $product_key; ?></h1>
            Download and Play through <?php echo $product_manufacturer; ?> Client.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4" style="border-bottom: 1px solid #ececec;"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" style="font-size: 12px; color: #9c9c9c;">
            <h2>Got questions? Don&rsquo;t Hesitate to ask!</h2>
            We&rsquo;ve got an amazing customer service team waiting to answer your questions!
            <br>
            Use FAQ, Community Live Support or Email to get answer anytime!
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" style="font-size: 12px; color: #9c9c9c;">
            <h2>How did this purchase go for you?</h2>
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