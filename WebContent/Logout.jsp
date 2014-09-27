<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
<jsp:useBean id="project_session" class="myjava.Project" scope="session"></jsp:useBean>

<title>Insert title here</title>
</head>
<body>
	<%
		user_session.setUser(null);
		project_session = null;
		response.sendRedirect("/scrum");
	%>
</body>
</html>