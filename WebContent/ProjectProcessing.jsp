<%@page import="myjava.RoleManager"%>
<%@page import="myjava.ProjectManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String theAction = request.getParameter("theAction");
ProjectManager prmng = new ProjectManager();
boolean canAssignRole = true;
String error = "";

if ("addProject".equals(theAction)) {
	String name = request.getParameter("name");
	String Description = request.getParameter("description");
	String vision = request.getParameter("vision");
	String time = request.getParameter("time");
	String group_id = request.getParameter("group_id");
	if (name == "" || Description == "" || vision == "" || time == "" || group_id == "") {
		error = "cantAddProject";
	} else {
		prmng.addProject(name, vision, Description, Integer.parseInt(time), Integer.parseInt(group_id));
	}
} else if ("removeProject".equals(theAction)) {
	String id = request.getParameter("id");
	prmng.removeProject(Integer.parseInt(id));
} else if ("assignRoleToUser".equals(theAction)) {
	String user_id = request.getParameter("user_id");
	String role_type = request.getParameter("role_type");
	String project_id = request.getParameter("project_id");
	RoleManager manager = new RoleManager();
	if (user_id == "") {
		error = "userNotDefined";
	} else if (role_type == "") {
		error = "roleTypeNotDefined";
	} else {
		int ret = manager.assignUserToRoleInProject( Integer.parseInt(user_id), Integer.parseInt(project_id), role_type );
		switch (ret) {
		case 0:
			canAssignRole = true;
			break;
		case 1:
			canAssignRole = false;
			error = "userIsScrumMaster";
			break;
		case 2:
			canAssignRole = false;
			error = "userIsProductOwner";
			break;
		case 3:
			canAssignRole = false;
			error = "userAlreadyHasRole";
			break;
		default:
			canAssignRole = false;
			error = "unknownError";
			break;
		}
	}
} else if ("unassignRoleToUser".equals(theAction)) {
	String user_id = request.getParameter("user_id");
	String role_type = request.getParameter("role_type");
	String project_id = request.getParameter("project_id");
	RoleManager manager = new RoleManager();
	if (user_id == "") {
		error = "userNotDefined";
	} else {
		manager.unassignUserToRoleInProject( Integer.parseInt(user_id), Integer.parseInt(project_id), role_type );
	}
}

if (!error.equals("")) {
	response.sendRedirect("/scrum/project.jsp?error=" + error + "&project_id=" + request.getParameter("project_id"));
} else if ("assignRoleToUser".equals(theAction) || "unassignRoleToUser".equals(theAction)) {
	if (canAssignRole) {
		response.sendRedirect("/scrum/project.jsp?project_id=" + request.getParameter("project_id"));
	} else {
		response.sendRedirect("/scrum/project.jsp?error=cantAssignRole&project_id=" + request.getParameter("project_id"));
	}
} else {
	response.sendRedirect("/scrum/projects.jsp");
}
%>
