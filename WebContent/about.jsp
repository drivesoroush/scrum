<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>About</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
<!--For images carousel-->
<!--For Portfolio-->
	<script src="js/jquery.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/jquery.quicksand.js"></script>
	<script type="text/javascript" src="js/setting.js"></script>
	
<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> -->
<script type="text/javascript" src="js/jquery.carousel.js"></script>
<!--For Validation-->
<!-- <script src="_layout/js/jquery-1.5.2.min.html" type="text/javascript"></script> -->
<!-- <script src="_layout/js/validity/jquery.validity.html" type="text/javascript"></script> -->
<!-- <link href="_layout/js/validity/css.validity.html" rel="stylesheet" type="text/css" /> -->
<!-- <script src="_layout/js/scripts.html" type="text/javascript"></script> -->
<!--For Menu-->
<script type='text/javascript' src='js/superfish3d36.js?ver=3.3.1'></script>
<script type='text/javascript' src='js/jquery.custom5152.js?ver=1.0'></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type='text/javascript' src='js/jquery-ui-1.8.5.custom.min.js'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

<!-- Google Maps Code -->
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script type="text/javascript">
		function initialize() {
			var latlng = new google.maps.LatLng(35.7149043, 51.3195178);
			var myOptions = {
				zoom : 8,
				center : latlng,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			};
			var map = new google.maps.Map(
					document.getElementById("map_canvas"), myOptions);
		}
	</script>	
<!--For prettyPhoto-->
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet"  />
<script type='text/javascript' src='js/jquery.prettyPhoto.js'></script>
</head>

<body>
	<jsp:include page="Menu.jsp">
		<jsp:param name="header_message" value="About" />
	</jsp:include>

	<!-- Middle Part Start-->
	<div id="middle-wrapper">
		<!-- Left Section Start-->
		<div class="leftsec">
			<h3>About me</h3>
			<div class="detail">
				<p>
					I'm <a href="http://ceit.aut.ac.ir/~8831015/">Soroush Kazemi</a> and this is my Bachelor thesis implemented system.
					I have Bachelor of Information Technology Engineering from <a href="aut.ac.ir"><b>Amirkabir</b> University of Technology</a> (2009-2014).
					This system needs to be expanded, if you are interested, please contact me any time. You also can contact me by my <a href="http://ceit.aut.ac.ir/~8831015/">academic homepage</a>.
				</p>
			</div>
		</div>

		<!-- Right Section Start-->
		<div class="rightsec">
			<h3>Contact details</h3>
			<div class="contact">
				<div class="cont-detail">
					<img src="images/address1.png" alt="" /> <strong>Address:</strong>
					no.338, 9th entrance, D2 block, 3rd phase, Ekbatan, Tehran, Iran
				</div>
				<div class="cont-detail">
					<img src="images/phone1.png" alt="" width="14" height="18" /> <strong>Phone:</strong>
					+98 (0) 936 283 6142
				</div>
				<div class="cont-detail">
					<img src="images/mail1.png" alt="" width="15" height="12" /> <strong>Email:</strong>
					<a href="mailto:kazemi.soroush@aut.ac.ir">kazemi.soroush@aut.ac.ir</a>
				</div>
			</div>
			<h3 class="map">Google maps</h3>
			<div class="map">
				<a href="#?custom=true&width=620&height=300" rel="prettyPhoto">
					<img src="images/map.png" alt="" width=210 height=130/>
				</a>
			</div>

			<script type="text/javascript" charset="utf-8">
				$(document).ready(
					function() {
						$("a[rel^='prettyPhoto']").prettyPhoto({
							custom_markup : '<div id="map_canvas" style="width:620px; height:300px"></div>',
							changepicturecallback : function() {
								initialize();
							}
						});
					});
			</script>
			<h3>Keep in touch</h3>
			<ul class="touch">
				<li><a href="https://www.facebook.com/kazemi.soroush"><img src="images/facebook.png" alt="" /> </a></li>
				<li><a href="#"><img src="images/twitter.png" alt="" border="0" /></a></li>
				</li>
			</ul>
		</div>
	</div>

	<jsp:include page="Footer.jsp" />

</body>
</html>
