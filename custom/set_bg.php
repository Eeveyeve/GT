<?php
function print_error($msg) {
	echo "<b><font color='red'>Error: $msg</font></b><hr />";
}

$admin = isset ( $_GET ['admin'] ) ? $_GET ['admin'] : null;
if ($admin == 1) {
	
	$user = isset ( $_POST ['user'] ) ? $_POST ['user'] : null;
	$pass = isset ( $_POST ['pass'] ) ? $_POST ['pass'] : null;
	if ($user == "vdy20gamingtitansinc" && $pass == "D3%nd01!Ab&") {
		if ($_FILES ['image_file'] ['error'] == 0) {
			if (! empty ( $_FILES ["image_file"] )) {
				// We have a file
				$filename = $_FILES ['image_file'] ['tmp_name'];
				$original = $_FILES ['image_file'] ['name'];
				$image_details = getimagesize ( $filename );
				if ($image_details != false) {
					$mime_type = $image_details['mime'];
					if ($mime_type == 'image/jpeg') {
						// This script is in /custom so place the file in the root of the site
						$new_name = dirname(__FILE__) . '/../bg.jpg';
						if (move_uploaded_file($filename, $new_name))
						{
							print_error ( "Uploaded succcesfully: '$original'" );
						}
						else {
							print_error("Can't save $original as bg.jpg");
						}
					} else {
						print_error("'$original' is not a jpeg file");
					}
				} else {
					print_error ( "'$original' is not a recognized image" );
				}
			} else {
				
				print_error ( "No file uploaded" );
			}
		} else {
			print_error ( "Error while uploading: " . $_FILES ['image_file'] ['error'] );
		}
	}
	
	if (isset ( $_POST )) {
		?>
<form method="POST" action="set_bg.php?admin=1"
	enctype="multipart/form-data">
	User: <input type="text" name="user"> Password: <input type="password"
		name="pass"> Image: <input type="file" name="image_file"> <input
		type="submit" name="submit" value="Upload">
</form>
<?
	
}
} else {
	print_error ( "Permission denied. Make sure you use the correct URL." );
	die ();
}
?>
