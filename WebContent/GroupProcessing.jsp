<%@page import="myjava.GroupManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
boolean canRemoveGroup = true;
boolean canAddGroup = true;

GroupManager manager = new GroupManager();
String theAction = request.getParameter("theAction");
String error = "";

System.out.println(theAction);

if ("addGroup".equals(theAction)) {
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	if (name == null || name == "" || description == null || description == "") {
		error = "cantAddGroup";
	} else {
		canAddGroup = manager.addGroup(name, description);
	}
} else if ("removeGroup".equals(theAction)) {
	String id = request.getParameter("id");
	canRemoveGroup = manager.removeGroup(Integer.parseInt(id));
} else if ("removeUserFromGroup".equals(theAction)) {
	String user_id = request.getParameter("user_id");
	String group_id = request.getParameter("group_id");
	manager.removeUserFromGroup(Integer.parseInt(user_id), Integer.parseInt(group_id));
}

if (!error.equals("")) {
	response.sendRedirect("/scrum/groups.jsp?error=" + error);
} else if (!canRemoveGroup) {
	response.sendRedirect("/scrum/groups.jsp?error=GroupInProject");
} else if (!canAddGroup) {
	response.sendRedirect("/scrum/groups.jsp?error=GroupAlreadyExists");
} else {
	response.sendRedirect("/scrum/groups.jsp");
}
%>
