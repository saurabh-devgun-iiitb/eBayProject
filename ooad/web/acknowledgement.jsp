<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>Acknowledgement</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body>

	<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>

	


<div class="container">
  <h2 align="center">Acknowledgement & References</h2>
  
  <%
	try {
				   
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT * FROM acknowledgement");
		ResultSet rs = ps.executeQuery();
%>
  
  <div class="panel-group">

    <div class="panel panel-primary">
      <div class="panel-heading" align="center">Acknowledgement</div>
      <%		while(rs.next()) {
%>
     <div class="panel-body"><b><%=rs.getString(3) %></b></div>
      <div class="panel-body"><%=rs.getString(2) %></div>
     <%		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
    </div>
     <%
	try {
				   
		DBConnection dbConnection = new DBConnection();
		String sql = "SELECT * FROM ref";
		PreparedStatement ps1 = dbConnection.connect().prepareStatement(sql);
		ResultSet rs1 = ps1.executeQuery();
%>
     <div class="panel panel-primary">
      <div class="panel-heading" align="center">References </div>
      <% while(rs1.next()){
    	  %>
       <div class="panel-body"><b><%=rs1.getString(3) %></b> </div>
      <div class="panel-body"><a href="<%=rs1.getString(2) %>"><%=rs1.getString(2) %></a> </div>
      <%		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
    </div>

      </div>
</div>
<nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
		</ul>
	</nav>

	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

</body>
</html>