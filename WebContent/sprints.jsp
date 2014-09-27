<%@page import="myjava.Sprint"%>
<%@page import="myjava.Priority"%>
<%@page import="myjava.ProductBacklogManager"%>
<%@page import="myjava.ProductBacklog"%>
<%@page import="myjava.Group"%>
<%@page import="myjava.GroupManager"%>
<%@page import="myjava.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.UserManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Sprints</title>
<script>
function doneProductBacklog(id) {
	var theForm = self.document.forms[0];
	theForm.id.value =  id;
	theForm.theAction.value = "doneProductBacklog";
	theForm.submit();	
}
function addProductBacklog() {
	var theForm = self.document.forms[0];
	theForm.theAction.value = "addProductBacklog";
	var select_priority = document.getElementById("select_priority");
	theForm.priority.value = select_priority.options[select_priority.selectedIndex].value;
	theForm.submit();
}
function removeProductBacklog(id) {
	var theForm = self.document.forms[0];
	theForm.id.value =  id;
	theForm.theAction.value = "removeProductBacklog";
	theForm.submit();
}
function removeProductBacklogFromSprint(id) {
	var theForm = self.document.forms[0];
	theForm.id.value =  id;
	theForm.theAction.value = "removeProductBacklogFromSprint";
	theForm.submit();
}
function goToSprint(id) {
	var theForm = self.document.forms[0];
	console.log(id);
	console.log(theForm);
	
	theForm.id.value = id;
	theForm.theAction.value = "goToSprint";
	theForm.submit();
}
function startSprint() {
	var theForm = self.document.forms[0];
	theForm.theAction.value = "startSprint";
	theForm.submit();
}
function finishSprint() {
	var theForm = self.document.forms[0];
	theForm.theAction.value = "finishSprint";
	theForm.submit();
}
</script>
<%
if (user_session.getUser() == null) {
	response.sendRedirect("/scrum");
	return;
}
String pid = request.getParameter("project_id");
if (pid == null || "".equals(pid)) {
	response.sendRedirect("/scrum/projects.jsp");
	return;
}
ArrayList<String> priority = new Priority().getAllPriority();
int project_id = Integer.parseInt(request.getParameter("project_id"));
ProductBacklogManager productManager = new ProductBacklogManager();
Sprint sprint = productManager.checkCurrentSprint(project_id);
ArrayList<ProductBacklog> productsBacklog = productManager.getAllProductBacklog(project_id);
ArrayList<ProductBacklog> productsBacklogInSprint = productManager.getAllProductBacklogInCurrentSprint(project_id);
ArrayList<ProductBacklog> productsBacklogNotCompleted = productManager.getAllProductBacklogNotComplete(project_id);
ArrayList<Sprint> sprints = productManager.getAllSprint(project_id);
%>
</head>

<body>
<!-- Header Start-->
<jsp:include page="Menu.jsp" >
	<jsp:param name="project_id" value="<%=project_id %>" />
	<jsp:param name="header_message" value="Sprints" />
</jsp:include>

<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
		
		<div class="one_half">
			<% if (productsBacklog.size() <= 0) { %>
			<div>There's no product backlog. (<a target="blank" href="productBacklog.jsp?project_id=<%=project_id%>">create one</a>)</div>
			<% } else { %>
			<h1>Product Backlogs in project</h1>
			<table class="tabular">
				<tr>
					<td>Name</td>
					<td>Desc.</td>
					<td>Value</td>
					<td>Date created</td>
					<% if (sprint.getStarted() == 0) { %>
					<td></td>
					<% } %>
					<td></td>
				</tr>
				<% for (int i = 0; i < productsBacklog.size(); i++) { %>
				<tr class="priority_<%=productsBacklog.get(i).getPriority()%>">
					<td><%=productsBacklog.get(i).getName() %></td>
					<td><%=productsBacklog.get(i).getDescription()%></td>
					<td><%=productsBacklog.get(i).getValue() %></td>
					<td><%=productsBacklog.get(i).getDate_created() %></td>
					<% if (sprint.getStarted() == 0) { %>
					<td><a href="javascript:goToSprint(<%=productsBacklog.get(i).getId()%>);">Go to sprint</a></td>
					<% } %>
					<td><a href="Tasks.jsp?product_backlog_id=<%=productsBacklog.get(i).getId()%>"><img src="./images/task.png" class="scrum-icon"/></a></td>
				</tr>
				<% } %>
			</table>
			<% } %>
		
			<% if (productsBacklogInSprint.size() > 0) { %>
			<h1>Product Backlogs In Current Sprint</h1>
			<table class="tabular">
				<tr>
					<td>Name</td>
					<td>Desc.</td>
					<td>Value</td>
					<td>Date created</td>
					<% if (sprint.getStarted() == 0) { %>
					<td></td>
					<% } %>
					<td>Task</td>
				</tr>
				
				<% for (int i = 0; i < productsBacklogInSprint.size(); i++) { %>
				<tr class="priority_<%=productsBacklogInSprint.get(i).getPriority()%>">
					<td><%=productsBacklogInSprint.get(i).getName() %></td>
					<td><%=productsBacklogInSprint.get(i).getDescription()%></td>
					<td><%=productsBacklogInSprint.get(i).getValue() %></td>
					<td><%=productsBacklogInSprint.get(i).getDate_created() %></td>
					<% if (sprint.getStarted() == 0) { %>
					<td><a href="javascript:removeProductBacklogFromSprint(<%=productsBacklogInSprint.get(i).getId()%>);">delete</a></td>
					<% } %>
					<td>
						<a href="Tasks.jsp?product_backlog_id=<%=productsBacklogInSprint.get(i).getId()%>">
							<img src="./images/task.png" class="scrum-icon"/>
						</a>
					</td>
					<% if (sprint.getStarted() == 1 && productsBacklogInSprint.get(i).getIs_all_task_done() && productsBacklogInSprint.get(i).getIs_done() != 1) { %>
					<td>
						<a href="javascript:doneProductBacklog(<%=productsBacklogInSprint.get(i).getId()%>);">done</a>
					</td>
					<% } %>
				</tr>
				<% } %>
			</table>
			<% } %>
			
			<% if (sprint.getStarted() == 0 && productsBacklogInSprint.size() > 0) { %>
			<div><a href="javascript:startSprint()">Start Sprint</a></div>
			<% } else if (productsBacklogInSprint.size() > 0) { %>
			<div>Sprint is started. (<a href="javascript:finishSprint()">Finish sprint</a>)</div>
			<% } else { %>
			<div>Sprint has no product backlogs and it isn't started.</div>
			<% } %>
			
		</div>
		
		<form method="post" action="ProductBacklogProcessing.jsp">
			<input type="hidden" name="theAction" />
			<input type="hidden" name="id" />
			<input type="hidden" value="<%=project_id%>" name="project_id" />
			<input type="hidden" name="priority" />
			
		</form>
				
		<div class="one_half column-last">
			<% if (sprints.size() > 0) { %>
			<h1>Sprints</h1>
			<table class="tabular">
				<tr>
					<td>#</td>
					<td>Done</td>
					<td>Date created</td>
					<td>Date started</td>
					<!-- <td>Current</td> -->
				</tr>
				<% for (int i = 0; i < sprints.size(); i++) { %>
				<tr>
					<td><a href="Sprint.jsp?id=<%=sprints.get(i).getId()%>&project_id=<%=project_id%>">Sprint <%=i + 1%></a></td>
					<td>
					<% if (sprints.get(i).getIs_done() == 1) { %>
					<img src="./images/done.png" class="scrum-icon"/>
					<% } %>
					</td>
					<td><%=sprints.get(i).getDate_created() %></td>
					<td><%=sprints.get(i).getDate_started() %></td>
					<%-- <td><%=sprints.get(i).getIs_current() %></td> --%>
				</tr>
				<% } %>
			</table>
			<% } else { %>
			<a>There is no sprints.</a>
			<% } %>
		</div>
	</div>
</div>

<!-- Footer Part Start-->
<jsp:include page="Footer.jsp" />

</body>
</html>
