<%@page import="myjava.Sprint"%>
<%@page import="myjava.Priority"%>
<%@page import="myjava.ProductBacklogManager"%>
<%@page import="myjava.ProductBacklog"%>
<%@page import="myjava.Group"%>
<%@page import="myjava.GroupManager"%>
<%@page import="myjava.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.UserManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount"
	scope="session"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Product-Backlogs</title>
<script>
function doneProductBacklog(id) {
	var theForm = self.document.forms[0];
	theForm.id.value = id;
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
	theForm.id.value = id;
	theForm.theAction.value = "removeProductBacklog";
	theForm.submit();
}
function removeProductBacklogFromSprint(id) {
	var theForm = self.document.forms[0];
	theForm.id.value = id;
	theForm.theAction.value = "removeProductBacklogFromSprint";
	theForm.submit();
}
function goToSprint(id) {
	var theForm = self.document.forms[0];
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

String error = request.getParameter("error");
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
	<jsp:include page="Menu.jsp">
		<jsp:param name="project_id" value="<%=project_id%>" />
		<jsp:param name="header_message" value="Product Backlog" />
	</jsp:include>

	<!-- Middle Part Start-->
	<div id="middle-wrapper">
		<div class="typo">
		
			<div class="one_half">
				<% if (user_session.isAdmin() || user_session.isProductOwner()) { %>
				<h1>Add new Product Backlog</h1>
	
				<div class="respond">
					<form method="post" action="ProductBacklogProcessing.jsp">
						<input type="hidden" name="theAction" />
						<input type="hidden" name="id" />
						<input type="hidden" value="<%=project_id%>" name="project_id" />
						<input type="hidden" name="priority" />
	
						<label>Name<span> *</span></label>
						<span><input type="text" name="name" /></span>
	
						<label>Description<span> *</span></label>
						<span><input type="text" name="description" /></span>
	
						<label>Priority</label>
						<select id="select_priority">
							<% for (int i = 0; i < priority.size(); i++) { %>
							<option value="<%=priority.get(i)%>"><%=priority.get(i)%></option>
							<% } %>
						</select>
	
						<label>Value<span> *</span></label>
						<span><input type="text" name="value" /></span>
	
						<a href="javascript:addProductBacklog();" class="btn readmore flleft green_btn">Add Product Backlog</a>
						<% if ("cantAddProductBacklog".equals(error)) { %>
						<br>
						<br>
						<div class="error">Please fill out all required fields.</div>
						<% } %>
					</form>
				</div>
				<% } %>
				
				<% if (productsBacklog.size() > 0) { %>
				<h1>Product-Backlogs</h1>
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
					<tr class="priority_<%=productsBacklog.get(i).getPriority()%>" title="<%=productsBacklog.get(i).getPriority()%> priority">
						<td><%=productsBacklog.get(i).getName()%></td>
						<td><%=productsBacklog.get(i).getDescription()%></td>
						<td><%=productsBacklog.get(i).getValue()%></td>
						<td><%=productsBacklog.get(i).getDate_created()%></td>
						<% if (sprint.getStarted() == 0) { %>
						<td><a href="javascript:goToSprint(<%=productsBacklog.get(i).getId()%>);">Go to sprint</a></td>
						<% } %>
						<td>
							<a href="Tasks.jsp?product_backlog_id=<%=productsBacklog.get(i).getId()%>">
								<img src="./images/task.png" class="scrum-icon"/>
							</a>
						</td>
					</tr>
					<% } %>
				</table>
				<% } %>
			</div>
	
			<div class="one_half column-last">
				<% if (productsBacklogNotCompleted.size() > 0) { %>
				<h1>Not completed Product-Backlogs</h1>
				<table class="tabular">
					<tr>
						<td>Name</td>
						<td>Desc.</td>
						<td>Value</td>
						<td>Date created</td>
						<td>Task</td>
					</tr>
					<% for (int i = 0; i < productsBacklogNotCompleted.size(); i++) { %>
					<tr class="priority_<%=productsBacklogNotCompleted.get(i).getPriority()%>" title="<%=productsBacklogNotCompleted.get(i).getPriority()%> priority">
						<td><%=productsBacklogNotCompleted.get(i).getName()%></td>
						<td><%=productsBacklogNotCompleted.get(i).getDescription()%></td>
						<td><%=productsBacklogNotCompleted.get(i).getValue()%></td>
						<td><%=productsBacklogNotCompleted.get(i).getDate_created()%></td>
						<td>
							<a href="Tasks.jsp?product_backlog_id=<%=productsBacklogNotCompleted.get(i).getId()%>">
								<img src="./images/task.png" class="scrum-icon"/>
							</a>
						</td>
					</tr>
					<% } %>
				</table>
				<% } else { %>
				<div>All Product Backlogs are completed in this project.</div>
				<% } %>
			</div>
			
		</div>
	</div>

	<!-- Footer Part Start-->
	<jsp:include page="Footer.jsp" />

</body>
</html>
