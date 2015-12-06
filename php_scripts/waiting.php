<html>
    <head>
		<link href="../styles/stylesheet.css" rel="stylesheet" />
		<link href="../styles/gallery.css" rel="stylesheet" />
		<script> 
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					console.log("Args: " + " " + xmlhttp.responseText);
				}
			}
			xmlhttp.open('GET', '../php_scripts/getImages.php', true);
			xmlhttp.send();
		</script>
    </head>
	<body>
		<div class="header">
			<img class="logo" src="../resources/images/logo.jpg" />
			<div class="heading">
				Image Annotation and Retreival
			</div>
		</div>
		<div class="container">
			<div class="heading">Match Results</div>
			<ul class="tags">
				<li>Tag</li>
				<li>Tag</li>
				<li>Tag</li>
			</ul>
			<ul class="gallery">
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
				<li><img src="../resources/images/logo.jpg" /></li>
			</ul>
		</div>
	</body>
</html>

