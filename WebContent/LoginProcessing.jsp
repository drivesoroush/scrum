<%@page import="myjava.UserManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
<%
UserManager userManager = new UserManager();
String email = request.getParameter("email");
String password = request.getParameter("password");
if (userManager.chechUserLogin(email, password)) {
	user_session.setUser(userManager.getUserByEmail(email));
	user_session.setAdmin(userManager.isAdminUserByEmail(email));
	response.sendRedirect("/scrum/projects.jsp");
} else {
	response.sendRedirect("/scrum?error=true");
}
%>
