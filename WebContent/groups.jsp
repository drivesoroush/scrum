<%@page import="myjava.Group"%>
<%@page import="myjava.GroupManager"%>
<%@page import="myjava.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.UserManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function addGroup() {
	var theForm = self.document.forms[0];
	theForm.theAction.value = "addGroup";
	theForm.submit();
}
function removeGroup(id) {
	var theForm = self.document.forms[0];
	theForm.id.value = id;
	theForm.theAction.value = "removeGroup";
	theForm.submit();
}
function removeUserFromGroup(user_id, group_id) {
	var theForm = self.document.forms[0];
	theForm.user_id.value = user_id;
	theForm.group_id.value = group_id;
	theForm.theAction.value = "removeUserFromGroup";
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
String error = request.getParameter("error");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Projects</title>
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
<title>Groups</title>
</head>

<body>
	<jsp:include page="Menu.jsp">
		<jsp:param name="header_message" value="Groups" />
	</jsp:include>

	<!-- Middle Part Start-->
	<div id="middle-wrapper">
		<div class="typo">
			<div class="one_half">
				<div class="respond">
					<h1>Add new Group</h1>
					<form method="POST" action="GroupProcessing.jsp">
						<input type="hidden" name="theAction" />
						<input type="hidden" name="id" />
						<input type="hidden" name="user_id" />
						<input type="hidden" name="group_id" />
						
						<label>Name</label>
						<span><input type="text" name="name" /></span>
						
						<label>Description</label>
						<span><input type="text" name="description" /></span>
						
						<a href="javascript:addGroup();" class="btn readmore flleft green_btn">Add Group</a>
						<br>
						<br>
						<% if ("cantAddGroup".equals(error)) { %>
						<div class="error">Please fill out all required fields.</div>
						<% } else if ("GroupAlreadyExists".equals(error)) { %>
						<div class="error">A group already exists with this name.</div>
						<% } %>
					</form>
				</div>
			</div>

			<div class="one_half column-last">
				<h1>Groups</h1>
				<table class="tabular">
					<% if ("GroupInProject".equals(error)) { %>
					<tr>
						<td colspan="2">This group in use in project. You can't delete this.</td>
					</tr>
					<% } %>
					<% for (int i = 0; i < groups.size(); i++) { %>
					<% if (i == 0) { %>
					<tr>
						<td>Name</td>
						<td>Description</td>
						<!-- <td>ID</td> -->
						<td>Date Created</td>
						<td></td>
					</tr>
					<% } %>
					<tr>
						<td><%=groups.get(i).getName()%></td>
						<td><%=groups.get(i).getDescription()%></td>
						<!-- <td><%=groups.get(i).getId()%></td> -->
						<td><%=groups.get(i).getDate_created()%></td>
						<td><a href="javascript:removeGroup(<%=groups.get(i).getId()%>);">delete</a></td>
					</tr>
					<tr>
						<td colspan="4">
							<% if (groups.get(i).getUsers().size() <= 0) { %>
							<div>This group has no members.</div>
							<% } else { %>
							<table class="tabular">
							<% for (int j = 0; j < groups.get(i).getUsers().size(); j++) { %>
								<% if (j == 0) { %>
								<tr>
									<td colspan="5"><%=groups.get(i).getName()%>'s Member</td>
								</tr>
								<tr>
									<td>Name</td>
									<td>Family</td>
									<td>Email</td>
									<td>Date Created</td>
									<td></td>
								</tr>
								<% } %>
								<tr>
									<td><%=groups.get(i).getUsers().get(j).getName()%></td>
									<td><%=groups.get(i).getUsers().get(j).getFname()%></td>
									<td><%=groups.get(i).getUsers().get(j).getEmail()%></td>
									<td><%=groups.get(i).getUsers().get(j).getDate_created()%></td>
									<td>
										<a href="javascript:removeUserFromGroup(<%=groups.get(i).getUsers().get(j).getId()%>,<%=groups.get(i).getId()%>);">
											un-assign user from group
										</a>
									</td>
								</tr>
							<% } %>
							</table>
							<% } %>
						</td>
					</tr>
					<% } %>
				</table>
			</div>

		</div>
	</div>

	<jsp:include page="Footer.jsp" />

</body>
</html>