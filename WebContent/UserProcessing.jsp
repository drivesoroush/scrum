<%@page import="myjava.UserManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
boolean cantAddToGroup = true;
boolean cantAddUser = true;

UserManager usrmng = new UserManager();
String theAction = request.getParameter("theAction");
String error = "";

if ("addUser".equals(theAction)) {
	String name = request.getParameter("name");
	String fname = request.getParameter("fname");
	String email = request.getParameter("email");
	
	if (name == null || name == "" || fname == null || fname == "" || email == null || email == "") {
		error = "cantAddUserDetailIsEmpty";
	} else {
		cantAddUser = usrmng.addUser(name, fname, email);
	}
} else if ("removeUser".equals(theAction)) {
	String id = request.getParameter("id");
	usrmng.removeuser(Integer.parseInt(id));
} else if ("assignUserToGroup".equals(theAction)) {
	String user_id = request.getParameter("user_id");
	String group_id = request.getParameter("group_id");
	
	if (user_id == null || user_id == "" || group_id == null || group_id == "") {
		error = "cantAssignUserToGroup";
	} else {
		cantAddToGroup = usrmng.addUserToGroup(Integer.parseInt(user_id), Integer.parseInt(group_id));
	}
}

if (!error.equals("")) {
	response.sendRedirect("/scrum/users.jsp?error=" + error);
} else if (!cantAddToGroup) {
	response.sendRedirect("/scrum/users.jsp?error=cantAddToGroup");
} else if (!cantAddUser) {
	response.sendRedirect("/scrum/users.jsp?error=cantAddUser");
} else {
	response.sendRedirect("/scrum/users.jsp");
}
%>
