<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Welcome to Scrum project management system</title>
	<link href="css/style.css" rel="stylesheet" type="text/css" />
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
	<!--For images carousel-->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<!--For Portfolio-->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="js/jquery.quicksand.js"></script>
	<script type="text/javascript" src="js/setting.js"></script>
	<!--For Menu-->
	<script type='text/javascript' src='js/superfish3d36.js?ver=3.3.1'></script>
	<script type='text/javascript' src='js/jquery.custom5152.js?ver=1.0'></script>
	<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
	<script type='text/javascript' src='js/jquery-ui-1.8.5.custom.min.js'></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
	<% String error = request.getParameter("error"); %>
</head>
<body>
<!-- Header Start-->
<jsp:include page="Menu.jsp" >
	<jsp:param name="header_message" value="Welcome" />
</jsp:include>


<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
	<div class="respond">
		<form method="post" action="LoginProcessing.jsp" id="login-form">

			<label>Email</label>
			<span><input type="text" name="email"/></span>

			<label>Password</label>
			<span><input type="password" name="password"/></span>

			<a href="javascript:$('#login-form').submit();" class="btn readmore flleft green_btn">Sign in</a>
			<br>
			<br>
			<br>
			<%if("true".equals(error)) { %>
			<div style="color:red;font-size:smaller">Email or Password is invalid.</div>
			<%} %>
		</form>
	</div>
	</div>
</div>

<!-- Footer Part Start-->
<jsp:include page="Footer.jsp" />

</body>
</html>