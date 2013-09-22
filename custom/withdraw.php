<?php

if($_GET['admin'] == 1) {
  
  $user = $_POST['user'];
  $pass = $_POST['pass'];

  if($user == "admin" && $pass == "admin.pass")
  {
    $con = mysql_connect("localhost", "administrator", "My1.EpicPassword!");
    if (!$con) {
      die('Could not connect: ' . mysql_error());
    }
    $db_selected = mysql_select_db("opencart",$con);
  }
  if(isset($_POST))
  {?>  
    <form method="POST" action="secure.php">
    User <input type="TEXT" name="user"></input>
    Pass <input type="TEXT" name="pass"></input>
    <input type="submit" name="submit"></input>
    </form>
  <?}
}

$con = mysql_connect("localhost", "administrator", "My1.EpicPassword!");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

$db_selected = mysql_select_db("opencart",$con);

$sql = "INSERT INTO person VALUES ('Borge','Refsnes','Sandnes','17')";
$result = mysql_query($sql,$con);
echo "ID of last inserted record is: " . mysql_insert_id();

mysql_close($con);
?>