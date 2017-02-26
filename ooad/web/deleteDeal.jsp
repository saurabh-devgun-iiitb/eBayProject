<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Deals</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scaling=1.0">
<title>raps.in</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="fa/css/font-awesome.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scaling=1.0">
<title>raps.in</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="fa/css/font-awesome.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<style>
th {
	width: 250px;
	/* border:1px solid gray; */
	text-align: center;
}

td {
	width: 250px;
	/* border:1px solid gray; */
	text-align: center;
}

input[type="text"] {
	text-align: center;
	background: transparent;
	border: none;
}
</style>

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
	<%!String log=""; %>
	<%
	String result = request.getParameter("success");
	String userid = (String) session.getAttribute("userid");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT log_message FROM logs WHERE logs_id = (SELECT MAX(logs_id) FROM logs)");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			log = rs.getString(1);
		System.out.println("Delete Deal result=" + result + "--------- " + log);
	}
	catch(Exception e) {
		
	}
%>
	<div class="modal fade" id="success" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<%
	if(result.equals("true")) {	
%>
				<div class="modal-header modal-header-success">
					<%
	} else if(result.equals("false")) {	
%>
					<div class="modal-header modal-header-danger">
						<%		
	}
%>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h3>
							<i class="glyphicon glyphicon-thumbs-up"></i>
							<%=log %>
						</h3>
					</div>
				</div>
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<script type="text/javascript">
		
				$(document).ready(function() {
					
<%
	if(result.equals("true") || result.equals("false")) {	
%>
					$("#success").modal('show');
<%
	} else {
%>		
					$("#success").modal('hide');
<%		
	}
%>
				});
			</script>



		<div class="container" style="margin-top: 5%">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 style="text-align: center">Delete Deal</h3>
						</div>

						<div class="panel-body">

							<table class="table">
								<thead>
									<tr>
										<th>Deal Id</th>
										<th>Item One</th>
										<th>Item Two</th>
										<th>Item Free</th>
										<th>Delete</th>
									</tr>
								</thead>
							</table>

							<s:iterator value="deleteDealList">


								<form action="dealDelete">
									<table class="table">
										<tr class="success">

											<td><input type="text"
												value="<s:property value="surrogateDealId"/>"
												name="surrogateDealId" readonly /></td>
											<td><s:property value="dealItemOneName" /></td>
											<td><s:property value="dealItemTwoName" /></td>
											<td><s:property value="dealItemFreeName" /></td>
											<td><button type="submit" class="btn btn-info">Delete</button></td>

										</tr>
									</table>
								</form>
							</s:iterator>

						</div>
					</div>
				</div>

				<div class="col-md-1"></div>
			</div>
		</div>
</html>