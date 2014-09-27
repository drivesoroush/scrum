<%@page import="java.awt.image.SampleModel"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="myjava.Project"%>
<%@page import="myjava.ProjectManager"%>
<%@page import="myjava.ProductBacklogManager"%>
<%@page import="myjava.Chart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name = "viewport" content = "initial-scale = 1, user-scalable = no">
	<link href="css/style.css" rel="stylesheet" type="text/css" />
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
	<!--For images carousel-->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<!--For Portfolio-->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="js/jquery.quicksand.js"></script>
	<script type="text/javascript" src="js/setting.js"></script>
	<!--For Menu-->
	<script type='text/javascript' src='js/superfish3d36.js?ver=3.3.1'></script>
	<script type='text/javascript' src='js/jquery.custom5152.js?ver=1.0'></script>
	<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
	<script type='text/javascript' src='js/jquery-ui-1.8.5.custom.min.js'></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
			
	<title>Scrum project management system</title>
	<script src="js/Chart.js"></script>
</head>

<body>
<!-- Header Start-->
<jsp:include page="Menu.jsp" >
	<jsp:param name="header_message" value="Product Backlog" />
</jsp:include>

<%

	int project_id = Integer.parseInt(request.getParameter("project_id"));
	ProjectManager projectManager = new ProjectManager();
	Project project = projectManager.getProjectById(project_id);
	Date start = project.getDate_created();
	Calendar c = Calendar.getInstance();
	c.setTime(start);
	c.add(Calendar.DATE, project.getTime());
	Date finish = c.getTime();
	
	int sum = projectManager.getSumValueProjectById(project_id);
	
	Chart chart = new ProductBacklogManager().getAllProductBacklogComplete(project_id);
	String lable = "\""+project.getDate_created()+"\",";
	for(int i=0;i<chart.getDates().size();i++)
	{
		lable = lable + "\"" + chart.getDates().get(i) + "\"";
		lable+=",";
	}
	lable = lable + "\""+finish+"\"";
	
	
	String data = sum+",";
	for(int i=0;i<chart.getValues().size();i++)
	{
		data += chart.getValues().get(i);
		if(i!=chart.getDates().size()-1)
		{
			data+=",";
		}
	}
	
	
	
	String constant_data = "";
	int sum_data = sum;
	for(int i=0;i<chart.getValues().size()+1;i++)
	{
		constant_data = constant_data+ "" + sum_data;
		sum_data = sum_data - ((sum*chart.getValues().size())/project.getTime());
		constant_data+=",";
	}
	constant_data += "0";
	
	int myWidth = 0;
	if(chart.getDates().size()<20)
		myWidth = 400;
	else if(chart.getDates().size()<40)
		myWidth = 600;
	else if(chart.getDates().size()<60)
		myWidth = 800;
	else if(chart.getDates().size()<80)
		myWidth = 1000;
	else if(chart.getDates().size()<100)
		myWidth = 1200;
	else if(chart.getDates().size()<120)
		myWidth = 1400;
%>

<!-- Middle Part Start-->
<div id="middle-wrapper">
	<div class="typo">
	<canvas id="canvas" height="450" width="<%=myWidth%>"></canvas>
	<script>
		var lineChartData = {
			labels : [<%=lable%>],
			datasets : [
				{
					fillColor : "rgba(220,220,220,0.5)",
					strokeColor : "rgba(0,187,0,0.5)",
					pointColor : "rgba(220,220,220,1)",
					pointStrokeColor : "#fff",
					data : [<%=data%>]
				}
				,
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					data : [<%=constant_data%>]
				}/* ,
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					data : [100,80,60,40,30,20,0]
				} */
			]
			
		}

	var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Line(lineChartData);
	
	</script>
	
	
	</div>
</div>


<!-- Footer Part Start-->
<jsp:include page="Footer.jsp" />

</body>
</html>