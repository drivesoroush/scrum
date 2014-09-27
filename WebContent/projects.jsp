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

<html>
<head>
<%
if (user_session.getUser() == null){
	response.sendRedirect("/scrum");
	return;
}
GroupManager grpmng = new GroupManager();
ArrayList<Group> groups = grpmng.getAllGroup();
ProjectManager prmng = new ProjectManager();
ArrayList<Project> projects= prmng.getAllProject();
String error = request.getParameter("error");
%>
<script>
function addProject(){
	var theForm = self.document.forms[0];
	var select_groups = document.getElementById("select_groups");
	theForm.group_id.value = select_groups.options[select_groups.selectedIndex].value;
	theForm.theAction.value = "addProject";
	theForm.submit();
}
function removeproject(id){
	var theForm = self.document.forms[0];
	theForm.id.value =	id;
	theForm.theAction.value = "removeProject";
	theForm.submit();
}
</script>
<title>Projects</title>
</head>

<body>
<!-- Header Start-->
<jsp:include page="Menu.jsp" >
	<jsp:param name="header_message" value="Main menu" />
</jsp:include>


<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
	
		<div class="one_half">
			<h1>Add new Project</h1>
			<div class="respond">
				<form method="post" action="ProjectProcessing.jsp">
					<input type="hidden" name="theAction" />
					<input type="hidden" name="id" />
					<input type="hidden" name="group_id" />
					
					<label>Name<span> *</span></label>
					<span><input type="text" name="name" /></span>
	
					<label>Vision<span> *</span></label>
					<span><input type="text" name="vision" /></span>
	
					<label>Description<span> *</span></label>
					<span><input type="text" name="description" /></span>
	
					<label>Time (days)<span> *</span></label>
					<span><input type="text" name="time" /></span>
	
					<% if ("cantAddProject".equals(error)) { %>
					<div class="error">Please fill out all required fields.</div>
					<% } %>
					
					<div class="one_half">
						<label>Group<span> *</span></label>
						<select id="select_groups">
							<% for(int i = 0;i<groups.size();i++){ %>
							<option value="<%=groups.get(i).getId()%>"><%=groups.get(i).getName()%></option>
							<% } %>
						</select>
					</div>
					
					<div class="clear"></div>
					
					<div class="one_half column-last">
						<a href="javascript:addProject();" class="btn readmore flleft green_btn">Add project</a>
					</div>
					
				</form>
			</div>
		</div>
		
		<div class="one_half column-last">
			<h1>Projects</h1>
			<table class="tabular">
				<tr>
					<td>Name</td>
					<td>Vision</td>
					<td>Description</td>
					<td>Date created</td>
					<!-- <td>Creator id</td> -->
					<td>Time</td>
					<!-- <td>ID</td> -->
					<td>Group name</td>
					<td></td>
				</tr>
			<% for(int i=0;i<projects.size();i++) { %>
				<% if(user_session.isAdmin() || prmng.checkUserIn(user_session.getUser().getId(),projects.get(i).getId())) { %>
				<tr>
					<td><a href="project.jsp?project_id=<%=projects.get(i).getId()%>"><%=projects.get(i).getName() %></a></td>
					<td><%=projects.get(i).getVision() %></td>
					<td><%=projects.get(i).getDescription() %></td>
					<td><%=projects.get(i).getDate_created() %></td>
					<%-- <td><%=projects.get(i).getCreatorId() %></td> --%>
					<td><%=projects.get(i).getTime() %></td>
					<%-- <td><%=projects.get(i).getId() %></td> --%>
					<td><%=projects.get(i).getGroup().getName() %></td>
					<td><a href="javascript:removeproject(<%=projects.get(i).getId()%>);">delete</a></td>
				</tr>
				<% } %>
			<% } %>
			</table>
		</div>
	
	</div>
</div>

<jsp:include page="Footer.jsp" />

</body>
</html>
