<%@page import="myjava.User"%>
<%@page import="myjava.RoleType"%>
<%@page import="myjava.Group"%>
<%@page import="myjava.GroupManager"%>
<%@page import="myjava.ProjectManager"%>
<%@page import="myjava.Project"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.Project"%>
<%@page import="myjava.DB"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%
if (user_session.getUser() == null) {
	response.sendRedirect("/scrum");
	return;
}
String project_id = request.getParameter("project_id");
if (project_id == null || "".equals(project_id)) {
	response.sendRedirect("/scrum/projects.jsp");
	return;
}
ProjectManager prmng = new ProjectManager();
Project project = prmng.getProjectById(Integer.parseInt(project_id));
Group group = project.getGroup();
RoleType type = new RoleType();
ArrayList<User> users = group.getUsers();
String error = request.getParameter("error");
%>
<script>
function assignRoleToUser() {
	var theForm = self.document.forms[0];
	var select_roles = document.getElementById("select_roles");
	var select_users = document.getElementById("select_users");
	theForm.role_type.value =  select_roles.options[select_roles.selectedIndex].value;
	theForm.user_id.value =  select_users.options[select_users.selectedIndex].value;
	theForm.theAction.value = "assignRoleToUser";
	theForm.submit();
}
function unassignRoleToUser() {
	var theForm = self.document.forms[0];
	var select_roles = document.getElementById("select_roles");
	var select_users = document.getElementById("select_users");
	theForm.role_type.value =  select_roles.options[select_roles.selectedIndex].value;
	theForm.user_id.value =  select_users.options[select_users.selectedIndex].value;
	theForm.theAction.value = "unassignRoleToUser";
	theForm.submit();
}
</script>
<title>Project specifications</title>
</head>

<body>
<!-- Header Start-->
<jsp:include page="Menu.jsp" >
	<jsp:param name="project_id" value="<%=project_id %>" />
	<jsp:param name="header_message" value="Project" />
</jsp:include>

<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
		<div class="two_third">
			<h1>Specifications of project</h1>
			<table class="tabular">
				<tr>
					<td>Name</td>
					<td>Vision</td>
					<td>Description</td>
					<td>Date created</td>
					<td>Time</td>
					<td>Group name</td>
				</tr>
				<tr>
					<td><%=project.getName() %></td>
					<td><%=project.getVision() %></td>
					<td><%=project.getDescription() %></td>
					<td><%=project.getDate_created() %></td>
					<td><%=project.getTime() %></td>
					<td><%=project.getGroup().getName() %></td>		
				</tr>
			</table>
			
			
			<h1>Specifications of group in this project</h1>
			<table class="tabular">
				<tr>
					<td>Name</td>
					<td>Description</td>
					<td>Date created</td>
				</tr>
				<tr>
					<td><%=group.getName() %></td>
					<td><%=group.getDescription() %></td>
					<td><%=group.getDate_created()%></td>
				</tr>
				<tr>
					<td colspan=3>
					<% if (group.getUsers().size() > 0) { %>
						<table class="tabular">
							<% for (int j = 0; j < group.getUsers().size(); j++) { %>
							<% if (j == 0){ %>
								<tr>
									<td colspan=5><%=group.getName() %>'s Member</td>
								</tr>
								<tr>
									<td>Name</td>
									<td>Family</td>
									<td>Email</td>
									<td>Date created</td>
									<td>Roles</td>
								</tr>
							<% } %>
							<tr>
								<td><%=group.getUsers().get(j).getName() %></td>
								<td><%=group.getUsers().get(j).getFname() %></td>
								<td><%=group.getUsers().get(j).getEmail() %></td>
								<td><%=group.getUsers().get(j).getDate_created() %></td>
								<td>
								<% ArrayList<String> roles = prmng.getRolesOfUser(project.getId(), group.getUsers().get(j).getId()); %>
								<% if (roles.size() > 0) { %>
								<%=prmng.getRolesOfUser(project.getId(), group.getUsers().get(j).getId()).toString() %>
								<% } else { %>
								[no roles]
								<% } %>
								</td>
							</tr>
							<% } %>
						</table>
						<% } else { %>
						There are no users in this group.
						<% } %>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="one_third column-last">
			<% if (user_session.isAdmin() || user_session.isScrumMaster()) { %>
			<h1>Assign role to user</h1>
			<div class="respond">
				<form method="post" action="ProjectProcessing.jsp">
					<input type="hidden" name="theAction" />
					<input type="hidden" name="user_id" />
					<input type="hidden" name="role_type" />
					<input type="hidden" value="<%=project_id %>" name="project_id" />
				
					<table>
						<tr>
							<td>Role</td>
							<td>
								<select id="select_roles">
									<% for (int i = 0; i < type.getAllTypes().size(); i++) { %>
									<option value="<%=type.getAllTypes().get(i)%>"><%=type.getAllTypes().get(i)%></option>
									<% } %>
								</select>
							</td>
						</tr>
						<tr>
							<td>User</td>
							<td>
								<select id="select_users">
									<% for (int i = 0; i < users.size(); i++) { %>
									<option value="<%=users.get(i).getId()%>"><%=users.get(i).getEmail() %></option>
									<% } %>
								</select>
							</td>
						</tr>
						<tr>
							<td><a href="javascript:assignRoleToUser()" class="btn readmore flleft green_btn">Assign</a></td>
							<td><a href="javascript:unassignRoleToUser()" class="btn readmore flleft green_btn">Un-assign</a></td>
						</tr>
					</table>
					<% if ("cantAssignRole".equals(error)) { %>
					<div class="error">User already has the role in this project.</div>
					<% } else if ("userNotDefined".equals(error)) { %>
					<div class="error">User not defined.</div>
					<% } else if ("roleTypeNotDefined".equals(error)) { %>
					<div class="error">Role type not defined.</div>
					<% } else if ("userAlreadyHasRole".equals(error)) { %>
					<div class="error">User already has role.</div>
					<% } else if ("userIsProductOwner".equals(error)) { %>
					<div class="error">In this project, user has "Product Owner" Role. He/she can't be "Scrum Master" too.</div>
					<% } else if ("userIsScrumMaster".equals(error)) { %>
					<div class="error">In this project, user has "Scrum Master" Role. He/she can't be "Product Owner" too.</div>
					<% } else if ("unknownError".equals(error)) { %>
					<div class="error">Unknown error.</div>
					<% } %>
				</form>
			</div>
			<%} %>
		</div>
	</div>
</div>

<jsp:include page="Footer.jsp" />

</body>
</html>
