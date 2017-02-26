<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>Add Item</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<script src="js/jquery-ui.min.js"></script>
<title>Report Result</title>

</head>
<body>


    <nav class="navbar navbar-static-top" style="margin-top: 10px;">
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="reportPage">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>


		<div class="container">
		<div class="row">
		<div class="col-md-11">
			<div class="well text-center">
				<h4>Report</h4>
			</div>
			<table class="table table-hover">
	    		<thead>	
	    			<tr class="row text-center">
						<td class="col-md-3"><div class="form-control">Item ID</div></td>
						<td class="col-md-6"><div class="form-control">Item Name</div></td>
						<td class="col-md-3"><div class="form-control">Seller Name</div></td>
					</tr>
				</thead>
				<tbody>
					<s:iterator>
						<tr class="row">
							<td class="col-md-3">
								<input  type="text" disabled="disabled" 
										class="form-control text-center" 
										value='<s:property value="item_id"/>'>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value='<s:property value="item_name"/>'>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value='<s:property value="seller_name"/>'>
							</td>
						</tr>
					</s:iterator>
				</tbody>
	    	</table>
		</div>
	</div>
	</div>

	

</body>
</html>