<%@page import="myjava.ProductBacklogManager"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String theAction = request.getParameter("theAction");
ProductBacklogManager productBacklogManager = new ProductBacklogManager();
boolean canAssignRole = true;
String project_id = request.getParameter("project_id");
String error = "";

if("addProductBacklog".equals(theAction)){
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String priority = request.getParameter("priority");
	String value = request.getParameter("value");
	if (name == "" || name == "" || description == "" || value == "") {
		error = "cantAddProductBacklog";
	}
	else
		productBacklogManager.addProductBacklog(name, description, priority, Integer.parseInt(value),Integer.parseInt(project_id));
} else if("removeProductBacklog".equals(theAction)) {
	String id = request.getParameter("id");
	productBacklogManager.removeProductBacklog(Integer.parseInt(id),Integer.parseInt(project_id));
} else if("goToSprint".equals(theAction)) {
	String id = request.getParameter("id");
	productBacklogManager.addProductBacklogToSprint(Integer.parseInt(id),Integer.parseInt(project_id));
} else if("removeProductBacklogFromSprint".equals(theAction)) {
	String id = request.getParameter("id");
	productBacklogManager.removeProductBacklogFromSprint(Integer.parseInt(id),Integer.parseInt(project_id));
} else if("startSprint".equals(theAction)) {
	productBacklogManager.startSprint(Integer.parseInt(project_id));
} else if("finishSprint".equals(theAction)) {
	productBacklogManager.finishSprint(Integer.parseInt(project_id));
} else if("doneProductBacklog".equals(theAction)) {
	String id = request.getParameter("id");
	productBacklogManager.setDoneProductBacklog(Integer.parseInt(id));
}

if(!error.equals("")) {
	response.sendRedirect("/scrum/productBacklog.jsp?error="+error+"&project_id="+project_id);
} else {
	response.sendRedirect("/scrum/productBacklog.jsp?project_id="+project_id);
}
%>
