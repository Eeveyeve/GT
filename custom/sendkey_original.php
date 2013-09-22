<?php

if($_GET['admin'] == 1) {
  
  $user = $_POST['user'];
  $pass = $_POST['pass'];

  if($user == "vdy20gamingtitansinc" && $pass == "D3%nd01!Ab&")
  {
    //$con = mysql_connect("localhost", "administrator", "My1.EpicPassword!");
    $con=mysqli_connect("localhost","administrator","My1.EpicPassword!","opencart");
    if (mysqli_connect_errno($con))
    {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }
    //$db_selected = mysql_select_db("opencart",$con);
    
    if($_POST['order_id'] != "" && $_POST['product_id'] != "" && $_POST['product_key'] != "" && $_POST['email'] != "") {
      $sql = "INSERT INTO oc_keys SET product_id='".(int)$_POST['product_id']."', order_id='".(int)$_POST['order_id']."', product_key='".(string)$_POST['product_key']."', email='".(string)$_POST['email']."', date_added = NOW()";
      if (!mysqli_query($con,$sql))
      {
      die('Error: ' . mysqli_error($con));
      }
      
      $sql = "SELECT * FROM oc_product WHERE product_id='".(int)$_POST['product_id']."'";
      if (!mysqli_query($con,$sql))
      {
        die('Error: ' . mysqli_error($con));
      }
      else
      {
        $result = mysqli_query($con,$sql);
        while ($row = mysqli_fetch_assoc($result)) {
          $model = $row['model'];
          $image = 'http://gamingtitans.com/image/'.$row['image'];
          $manufacturer_id = $row['manufacturer_id'];
        }
      }
      
      $sql = "SELECT * FROM oc_order WHERE order_id='".(int)$_POST['order_id']."'";
      if (!mysqli_query($con,$sql))
      {
        die('Error: ' . mysqli_error($con));
      }
      else
      {
        $result = mysqli_query($con,$sql);
        while ($row = mysqli_fetch_assoc($result)) {
          $firstname = $row['firstname'];
          $lastname = $row['lastname'];
        }
      }
      
      if ($manufacturer_id == 13) {
        $manufacturer = 'battlenet';
      } else if ($manufacturer_id == 14) {
        $manufacturer = 'ubisoft';
      } else if ($manufacturer_id == 12) {
        $manufacturer = 'origin';
      } else if ($manufacturer_id == 16) {
        $manufacturer = 'playstation';
      } else if ($manufacturer_id == 11) {
        $manufacturer = 'steam';
      } else if ($manufacturer_id == 15) {
        $manufacturer = 'xbox';
      }
      
      $headers = "From: admin@gamingtitans.com";
      $headers .= "\r\nReply-To: admin@gamingtitans.com";
      $headers .= "\r\nX-Mailer: PHP/".phpversion();
      $headers .= "MIME-Version: 1.0\r\n";
      $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
      
      
      $message = '
<html>
  <head>
    <style>
    *, html, body, table, tbody, tr, td {font-family: Arial;}
    h1 {font-size: 24px; font-weight: normal; margin: 0px; color: #9c9c9c;}
    h2 {font-size: 14px; font-weight: bold; margin: 0px; color: #000000;}
    </style>
  <head>
  <body>
    <table cellspacing="0" cellpadding="5" border="0" width="980px" style="width:980px;margin:0 auto;">
      <tbody>	
        <tr>
      		<td width="813px" colspan="3"><a href="http://gamingtitans.com"><img style="width:145px;height:52px;" width="145px" height="52px" alt="Gaming Titans Logo" title="gamingtitans.com" src="http://gamingtitans.com/image/data/common/email-logo.png"></a></td>
      		<td width="167px" valign="bottom" align="right" style="text-align:right;vertical-align:bottom;"><a href="https://www.facebook.com/gamingtitans" style="color: #375c9d;text-decoration:none;"><img src="http://gamingtitans.com/catalog/view/theme/gtv1/image/social/mini-fb.png" style="float:left;">Join us on Facebook</a></td>
      	</tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" bgcolor="#f8f8f8" style="background-color: #f8f8f8; color: #666666; border: 1px solid #e0e0e0; padding: 20px; font-size: 12px;">
            <h2>Your order have arrived.</h2>
            Dear '.$firstname.' '.$lastname.', your order number #'.$_POST['order_id'].' has been fully acomplished and delivered.
            <br>
            Below you will be able to find the products you ordered.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td width="80px" valign="middle" align="center" style="width: 80px;"><img src="'.$image.'" title="'.$model.'" alt="'.$model.'" width="64px" height="80px" style="width:64px;height:80px;"></td>
          <td width="55px" valign="middle" align="center" style="width: 55px;"><img src="http://gamingtitans.com/catalog/view/theme/gtv1/image/platform/email/'.$manufacturer.'.png" title="'.ucfirst($manufacturer).'" alt="'.ucfirst($manufacturer).'" width="40px" height="40px" style="width:40px;height:40px;"></td>
          <td valign="middle" align="left" style="padding: 30px 5px; color: #555555; font-size: 11px;" colspan="2">
            <h2>'.$model.'</h2>
            <h1>'.$_POST['product_key'].'</h1>
            Download and Play through '.ucfirst($manufacturer).' Client.
          </td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4" style="border-bottom: 1px solid #ececec;"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr><td colspan="4"></td></tr>
        <tr>
          <td colspan="4" style="font-size: 12px; color: #9c9c9c;">
            <h2>Got questions? Don’t Esitate to ask!</h2>
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
            2013 &copy; Gaming Titans
          </td>
        </tr>
      </tbody>  
    </table>
  </body>
</html>      
      ';
      
      
      //$message = "Your product keys is: ".$_POST['product_key'];
      
      mail($_POST['email'], 'Your product key', $message, $headers, "-f admin@gamingtitans.com");
      
      echo "Key successfully sent";
      
      mysqli_close($con);
    }
    
  }
  if(isset($_POST))
  {?>  
    <form method="POST" action="sendkey.php?admin=1">
    User <input type="TEXT" name="user">
    Pass <input type="TEXT" name="pass">
    Order ID <input type="TEXT" name="order_id">
    Product ID <input type="TEXT" name="product_id">
    Key <input type="TEXT" name="product_key">
    Email <input type="TEXT" name="email">
    <input type="submit" name="submit">
    </form>
  <?}
} else {

  $con = mysql_connect("localhost", "administrator", "My1.EpicPassword!");
  if (!$con)
    {
    die('Could not connect: ' . mysql_error());
    }
  
  $db_selected = mysql_select_db("opencart",$con);
  
  /*$sql = "INSERT INTO person VALUES ('Borge','Refsnes','Sandnes','17')";
  $result = mysql_query($sql,$con);
  echo "ID of last inserted record is: " . mysql_insert_id();*/
}
//mysql_close($con);
?>