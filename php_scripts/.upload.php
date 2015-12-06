<?php
	$target_dir = "uploads/";
	$target_file = $target_dir .  basename($_FILES["uploadedFile"]["name"]);
	$uploadOk = 1;
	$info = pathinfo($target_file);
	$imageFileType = $info["extension"];
	
	//check if form was submitted 
	$uploadOk = 1;
	if(isset($_POST["submit"])) {

		//check on fakeness
		$check = getimagesize($_FILES["uploadedFile"]["tmp_name"]);
		if($check === 0) {
			echo "File is not an image";
			$uploadOk = 0;
		}

		//check for extensions if needed
	}
	if($uploadOk === 1) {
		move_uploaded_file($_FILES["uploadedFile"]["tmp_name"], $target_file); //saving the uploaded file into the uploads/ folder
	}
?>
