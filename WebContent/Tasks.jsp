<%@page import="myjava.ProjectManager"%>
<%@page import="myjava.UserManager"%>
<%@page import="myjava.User"%>
<%@page import="myjava.Task"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.ProductBacklog"%>
<%@page import="myjava.ProductBacklogManager"%>
<%@page import="myjava.TaskManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
	function addTask(){
		var theForm = self.document.forms[0];
		var select_user = document.getElementById("select_user");
		theForm.user_id.value =  select_user.options[select_user.selectedIndex].value;
		theForm.theAction.value = "addTask";
		theForm.submit();
	}
	function removeTask(id){
		var theForm = self.document.forms[0];
		theForm.id.value =  id;
		theForm.theAction.value = "removeTask";
		theForm.submit();
	}
	function setTaskDone(id){
		var theForm = self.document.forms[0];
		theForm.id.value =  id;
		theForm.theAction.value = "setTaskDone";
		theForm.submit();
	}
</script>
</head>
<%
	int product_backlog_id = Integer.parseInt(request.getParameter("product_backlog_id"));
	TaskManager taskManager = new TaskManager();
	ProjectManager projectManager = new ProjectManager();
	ProductBacklogManager productbacklogManager = new ProductBacklogManager();
	ProductBacklog productBacklog = productbacklogManager.getProductBacklogById(product_backlog_id);
	ArrayList<Task> tasks = taskManager.getTasksOfProductBacklog(product_backlog_id);
	ArrayList<User> users = projectManager.getProjectById(productBacklog.getProject_id()).getGroup().getUsers();
	boolean isNotCurrentSprint = productbacklogManager.checkProductBcklogInCurrentSprint(product_backlog_id);
%>
<body>
<!-- Header Start-->
<div class="header-wrapper1">

<jsp:include page="Menu.jsp" >
	<jsp:param name="project_id" value="<%=productBacklog.getProject_id() %>" />
	<jsp:param name="header_message" value="Tasks" />
</jsp:include>

<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
		<%if(isNotCurrentSprint && productBacklog.getIs_done()!=1){ %>
		<h1>Add Task to this product backlog.(<%=productBacklog.getName() %>)</h1>
		<div class="respond">
			<form method="POST" action="TaskProcessing.jsp">
				<input type="hidden" name="id" />
				<input type="hidden" name="theAction" />
				<input type="hidden" name="user_id" />
				<input type="hidden" value="<%=productBacklog.getProject_id() %>" name="project_id" />
				<input type="hidden" value="<%=product_backlog_id %>" name="product_backlog_id" />
				<table>
					<tr>
						<td>
							<label>Name</label>
							<span><input type="text" name="name" /></span>
						</td>
						<td>
							<label>Description</label>
							<span><input type="text" name="description" /></span>
						</td>
						<td>
							<label>User</label>
							<select id="select_user">
							<%for(int i = 0;i<users.size();i++){ %>
								<option value="<%=users.get(i).getId()%>"  ><%=users.get(i).getEmail() %></option>
							<%} %>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<a href="javascript:addTask();" class="btn readmore flleft green_btn">Add task</a>
						</td>
					</tr>
				</table>
				
			</form>
		</div>
		<%} %>
		
		<%if(tasks.size()>0){ %>
		<h1>tasks</h1>
		<table class="tabular">
			<tr>
				<td>Name</td>
				<td>Desc.</td>
				<td>User</td>
				<td>Product backlog name</td>
				<td>Date created</td>
				<td>Remove</td>
				<td>Done</td>
			</tr>
			<%for(int i=0;i<tasks.size();i++){ %>
			<tr>
				<td><%=tasks.get(i).getName() %></td>
				<td><%=tasks.get(i).getDescription()%></td>
				<td><%=tasks.get(i).getUser().getEmail() %></td>
				<td><%=tasks.get(i).getProduct_backlog().getName() %></td>
				<td><%=tasks.get(i).getDate_created() %></td>
				<%if(tasks.get(i).getIs_done()==0){ %>
				<td><a href="javascript:removeTask(<%=tasks.get(i).getId()%>);"><img src="images/delete.png"/></a></td>
				<td><a href="javascript:setTaskDone(<%=tasks.get(i).getId()%>);"><img src="images/done.png"/></a></td>
				<%} else {%>
				<td></td>
				<td></td>
				<%} %>
			</tr>
			<%} %>
			</table>
		<%}else{ %>
			<div>There are no tasks.</div>
		<%} %>
	</div>
</div>

<!-- Footer Part Start-->
<jsp:include page="Footer.jsp" />

</div>
</body>
</html>