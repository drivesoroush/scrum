<%@page import="myjava.TaskManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String theAction = request.getParameter("theAction");
	String project_id = request.getParameter("project_id");
	String product_backlog_id = request.getParameter("product_backlog_id");
	TaskManager taskManager = new TaskManager();
	String error = "";
	
	if("addTask".equals(theAction)){
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		String user_id = request.getParameter("user_id");
		if(name == null || name == "" || 
				name == null || name == "" ||
				description == null || description == "" ||
				user_id == null || user_id == "")
		{
			error = "canAddtask";
		}
		else
			taskManager.addTask(name, description, Integer.parseInt(user_id), Integer.parseInt(product_backlog_id));
	}else if("removeTask".equals(theAction))
	{
		String id = request.getParameter("id");
		taskManager.removeTask(Integer.parseInt(id));
	}else if("setTaskDone".equals(theAction))
	{
		String id = request.getParameter("id");
		taskManager.setTaskDone(Integer.parseInt(id));
	}
	
	if(!error.equals(""))
		response.sendRedirect("Tasks.jsp?error="+error+"&product_backlog_id="+product_backlog_id);
	else
		response.sendRedirect("Tasks.jsp?product_backlog_id="+product_backlog_id);
%>
</body>
</html>