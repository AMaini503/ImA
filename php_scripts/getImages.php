<?php
	session_start();
	
	/* construct parameters for matlab script */
	$img = "'../uploads/" . basename($_SESSION['FILE']['uploadedFile']['name']) . "'";
	$descp = "'" . $_SESSION['DATA']['descriptor'] . "'";
	$wordsize = $_SESSION['DATA']['word_size'];
	$params = $img . ", " . $descp . ", " . $wordsize;
	/*******************************************/

	$chdir = 'cd ../codebase/;';
	$cmd = "echo \"classify_image(" . $params . ")\" | matlab -nodisplay -nojvm -nodesktop";
	$cmd = $chdir . $cmd;
	echo $cmd;
	$output = shell_exec($cmd);
	echo $output;
	//assuming a json object is written into the data.txt file in the same folder as Matlab script : codebase/
	$file = fopen('../codebase/data.txt', 'r');
	$data = fgets($file);
	var_dump($data);

?>
