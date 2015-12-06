<!DOCTYPE html>
<?php
	ob_start();
?>
<html>
	<head>
		<!-- <link href="../resources/bootstrap/css/bootstrap.min.acss" rel="stylesheet"/> -->
		<link href="../styles/stylesheet.css" rel="stylesheet" />
	</head>
	<body>
		<div class="header">
			<img class="logo" src="../resources/images/logo.jpg" />
			<div class="heading">
				Image Annotation and Retreival
			</div>
		</div>
		<div class="container">
			<?php
				if( !empty($_POST) ) { //validate the uploaded file
					$target_dir = "../uploads/";
					$target_file = $target_dir . basename($_FILES["uploadedFile"]["name"]);
					$uploadOk = 1;
					if( isset($_POST["submit"])  ) {
						$size = getimagesize($_FILES["uploadedFile"]["tmp_name"]);
						if( $size === false) {
							$uploadOk = 0;
						}
						else {
							session_start();
							$_SESSION['DATA'] = $_POST;
							$_SESSION['FILE'] = $_FILES;
							move_uploaded_file($_FILES["uploadedFile"]["tmp_name"], $target_file);
							header('Location: waiting.php');
							exit;
						}
					}
				}
			?>

			<!--<div id="dummy-img">
				<img src="resources/images/dummy.png" />
			</div>-->
			<div id="upload-form">
				<form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" enctype="multipart/form-data">
				<select name="word_size">
					<?php
						for($i = 1; $i<11; $i++) {
							echo "<option value='" . ($i * 500) . "'>" . $i * 500 . "</option>";
						}
					?>
				</select>
				<select name="descriptor">
					<?php
						$descriptors = array("Surf", "Gist", "Hog", "Brisk", "Sift");
						foreach ( $descriptors as $item ) {
							echo "<option value='" . $item . "'>" . $item . "</option>";
						}
					?>
				</select>
				<span id="imgUpload">
					Select an Image to Upload
				</span>
				<input type="file" name="uploadedFile" id="fileUpload" onchange="showImg()"/>
				<input id="browse-btn" class="btn" type="button" value="Browse" name="browse"/>
				<input id="submit-btn" class="btn" type="submit" value="Upload" name="submit" />
				</form>
			</div>

			<!-- Error Handling -->
			<?php if( !empty($_POST) and $uploadOk === 0 ): ?>
				<div class="error">
					<span>Uploaded File is not an image!</span>
					<span class="close">X</span>
				</div>
			<?php endif; ?>
		</div>
		<script>
		
			function showImg() {
				var image = document.querySelector('#dummy-img > img');
				image.src = "resources/images/" +  document.getElementById('fileUpload').value;
			}	
			var btn = document.getElementById("browse-btn");
			var upload = document.getElementById('fileUpload');

			btn.addEventListener('click', function() {
				upload.click();
			}, false);
			var close_btn = document.getElementsByClassName("close");
			for(var i = 0; i<close_btn.length; i++) {
				close_btn[0].addEventListener('click', function(){
					this.parentNode.style.display = "none";		
				}, false);
			}

		</script>
	</body>
</html>
