<%@page import="myjava.ProductBacklog"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.Sprint"%>
<%@page import="myjava.ProductBacklogManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Scrum project management system</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
<!--For images carousel-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<!--For Portfolio-->
<script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/jquery.quicksand.js"></script>
<script type="text/javascript" src="js/setting.js"></script>
<!--For Menu-->
<script type='text/javascript' src='js/superfish3d36.js?ver=3.3.1'></script>
<script type='text/javascript' src='js/jquery.custom5152.js?ver=1.0'></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type='text/javascript' src='js/jquery-ui-1.8.5.custom.min.js'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script>
	$(document).ready(function() {
		$("#accordion").accordion();
	});
</script>
</head>
<%
String sprint_id = request.getParameter("id");
int project_id = Integer.parseInt(request.getParameter("project_id"));
ProductBacklogManager productManager = new ProductBacklogManager();
Sprint sprint = productManager.getSprintById(Integer.parseInt(sprint_id),project_id);
ArrayList<ProductBacklog> productsBacklog = productManager.getAllProductBacklogInSprint(Integer.parseInt(sprint_id),project_id);
%>
<body>
	<div class="header-wrapper1">
		<!-- Header Start-->
		<jsp:include page="Menu.jsp" >
			<jsp:param name="project_id" value="<%=project_id %>" />
			<jsp:param name="header_message" value="Sprint" />
		</jsp:include>
		
		<!-- Middle Part Start-->
		<div id="middle-wrapper">
			<div class="typo">
				<h1>Product Backlogs In Sprint <%=sprint.getId() %></h1>
				<table class="tabular">
					<tr>
						<td>Name</td>
						<td>Desc.</td>
						<td>Value</td>
						<td>Date created</td>
						<td></td>
					</tr>
					<%for(int i=0;i<productsBacklog.size();i++){ %>
					<tr class="Priority_<%=productsBacklog.get(i).getPriority()%>">
						<td><%=productsBacklog.get(i).getName() %></td>
						<td><%=productsBacklog.get(i).getDescription()%></td>
						<td><%=productsBacklog.get(i).getValue() %></td>
						<td><%=productsBacklog.get(i).getDate_created() %></td>
						<td><a href="Tasks.jsp?product_backlog_id=<%=productsBacklog.get(i).getId()%>"><img src="./images/product_backlog/task.png"/></a></td>
					</tr>
					<%} %>
				</table>
			</div>
		</div>
		
		<!-- Footer Part Start-->
		<jsp:include page="Footer.jsp" />
		
	</div>
</body>
</html>