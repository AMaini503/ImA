<?php
	$file = fopen("../codebase/data.txt", "r");
	$data = fgets($file);
	fclose($file);
	$obj = json_decode($data);

	if( gettype($obj->{"data"}->{"knn3"}) == "array" ) {
		$array = $obj->{"data"}->{"knn3"};
		foreach ($array as $item) {
			echo $item . ",";
		}
	};
?>