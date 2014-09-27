<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myjava.RoleManager"%>
<%@page import="myjava.ProjectManager"%>
<%@page import="myjava.Project"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
	<link rel="shortcut icon" href="images/thumb.png">
</head>

<jsp:useBean id="user_session" class="myjava.UserAccount" scope="session"></jsp:useBean>
<jsp:useBean id="project_session" class="myjava.Project" scope="session"></jsp:useBean>

<%
ProjectManager prmng = new ProjectManager();
ArrayList<Project> projects= prmng.getAllProject();

boolean project_loaded = false;
String project_id = "";
String header_message = request.getParameter("header_message");

if (user_session.getUser() == null) {
	response.sendRedirect("/scrum");
} else {
	project_id = request.getParameter("project_id");

	if (project_id != null && project_id != "") {
		project_session = new ProjectManager().getProjectById(Integer.parseInt(project_id));
		project_loaded = true;
	}

	if (project_loaded) {
		RoleManager roleManager = new RoleManager();
		user_session.getUser().setRoles( roleManager.getRolesByUserId(user_session.getUser().getId(), Integer.parseInt(project_id)));
		if (user_session.getUser().getRoles().contains("product_owner")) {
			user_session.setProductOwner(true);
		}
		if (user_session.getUser().getRoles().contains("team_member")) {
			user_session.setTeamMember(true);
		}
		if (user_session.getUser().getRoles().contains("scrum_master")) {
			user_session.setScrumMaster(true);
		}
	}
}
%>

<body>
	<!-- Header Start-->
	<div class="header-wrapper1">
		<div id="header">
			<a target="_blank" href="http://ceit.aut.ac.ir/~8831015/" id="logo">
				<img src="images/logo.png" alt="" style="width: 120px;" />
			</a>
			<!-- Top Menu Start-->
			<div id="primary-nav">
				<ul>
					<% if (user_session.getUser() != null) { %>
					<% if (project_loaded) { %>
					<li><a href="#" class="sf-with-ul">Menu</a>
						<ul class="sub-menu">
							<li><a href="project.jsp?project_id=<%=project_id%>"><span>Project</span></a></li>
							<li><a href="chart.jsp?project_id=<%=project_id%>"><span>Chart</span></a></li>
							<li><a href="productBacklog.jsp?project_id=<%=project_id%>"><span>Product backlog</span></a></li>
							<li><a href="sprints.jsp?project_id=<%=project_id%>"><span>Sprint</span></a></li>
						</ul>
					</li>
					<% } %>
					<% if (user_session.isAdmin()) { %>
					<li><a href="groups.jsp"><span>Groups</span></a></li>
					<li><a href="users.jsp"><span>Users</span></a></li>
					<li><a href="projects.jsp">Projects</a>
						<ul class="sub-menu">
							<% for(Project project : projects) { %>
							<li>
								<a href="project.jsp?project_id=<%=project.getId()%>"><span><%=project.getName() %></span></a>
							</li>
							<% } %>
						</ul>
					</li>
					<% } %>
					<% } %>
					
					<% if (user_session.getUser() != null) { %>
					<li><a href="Logout.jsp"><span>Logout</span></a></li>
					<% } %>
					<li><a href="about.jsp"><span>About</span></a></li>
				</ul>

				<!-- END #primary-nav -->
			</div>
		</div>
		<div class="title">
			<span>
			<%=header_message%><% if (project_loaded) { %> - <%=project_session.getName()%><% } %>
			</span>
		</div>
	</div>

</body>
</html>
