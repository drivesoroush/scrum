<%@page import="myjava.Group"%>
<%@page import="myjava.GroupManager"%>
<%@page import="myjava.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.UserManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script>
function addUser() {
	var theForm = self.document.forms[0];
	theForm.theAction.value = "addUser";
	theForm.submit();
}
function removeUser(id) {
	var theForm = self.document.forms[0];
	theForm.id.value = id;
	theForm.theAction.value = "removeUser";
	theForm.submit();
}
function assignUserToGroup() {
	var theForm = self.document.forms[0];
	var select_groups = document.getElementById("select_groups");
	var select_users = document.getElementById("select_users");
	theForm.group_id.value = select_groups.options[select_groups.selectedIndex].value;
	theForm.user_id.value = select_users.options[select_users.selectedIndex].value;
	theForm.theAction.value = "assignUserToGroup";
	theForm.submit();
}
</script>
<%
if (user_session.getUser() == null) {
	response.sendRedirect("/scrum");
	return;
}
GroupManager grpmng = new GroupManager();
ArrayList<Group> groups = grpmng.getAllGroup();
UserManager usrmng = new UserManager();
ArrayList<User> users = usrmng.getAllUsers();
String error = request.getParameter("error");
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Users</title>
</head>

<body>
	<!-- Header Start-->
	<jsp:include page="Menu.jsp">
		<jsp:param name="header_message" value="Users" />
	</jsp:include>

	<!-- Middle Part Start-->
	<div id="middle-wrapper">
		<div class="typo">
			<div class="one_half">
				<h1>Add new user</h1>
				<div class="respond">
					<form method="post" action="UserProcessing.jsp">
						<input type="hidden" name="theAction" />
						<input type="hidden" name="id" />
						<input type="hidden" name="user_id" />
						<input type="hidden" name="group_id" />
						
						<label>Name<span> *</span></label>
						<span><input type="text" name="name" /></span>
						<label>Family<span> *</span></label>
						<span><input type="text" name="fname" /></span>
						<label>Email<span> *</span></label>
						<span><input type="text" name="email" /></span>
						
						<a href="javascript:addUser();" class="btn readmore flleft green_btn">Add User</a>
						<br>
						<br>
						<% if ("cantAddUser".equals(error)) { %>
						<div class="error">User already registered.</div>
						<% } else if ("cantAddUserDetailIsEmpty".equals(error)) { %>
						<div class="error">Please fill all required fields.</div>
						<% } %>
					</form>
				</div>

				<h1>Assign User to Group</h1>
				<div class="respond">
					<label>Group</label>
					<select id="select_groups">
					<% for (int i = 0; i < groups.size(); i++) { %>
					<option value="<%=groups.get(i).getId()%>"><%=groups.get(i).getName()%></option>
					<% } %>
					</select>
					<label>User</label> <select id="select_users">
					<% for (int i = 0; i < users.size(); i++) { %>
					<option value="<%=users.get(i).getId()%>"><%=users.get(i).getEmail()%></option>
					<% } %>
					</select>
					<br>
					<a href="javascript:assignUserToGroup()" class="btn readmore flleft green_btn" style="margin-top: 10px;">Assign</a>
					<br>
					<br>
					<br>
					<% if ("cantAddToGroup".equals(error)) { %>
					<div class="error">User already assigned to this group.</div>
					<% } else if ("cantAssignUserToGroup".equals(error)) { %>
					<div class="error">Can't assign user to group.</div>
					<% } %>
					
				</div>
			</div>

			<div class="one_half column-last">
				<h1>Users</h1>
				<table class="tabular">
					<tr>
						<td>Name</td>
						<td>Family</td>
						<td>Email</td>
						<td>Date created</td>
						<td></td>
					</tr>
					<% for (int i = 0; i < users.size(); i++) { %>
					<tr>
						<td><%=users.get(i).getName()%></td>
						<td><%=users.get(i).getFname()%></td>
						<td><%=users.get(i).getEmail()%></td>
						<td><%=users.get(i).getDate_created()%></td>
						<td><a href="javascript:removeUser(<%=users.get(i).getId()%>);">delete</a></td>
					</tr>
					<% } %>
				</table>

			</div>
		</div>
	</div>

	<jsp:include page="Footer.jsp" />

</body>
</html>