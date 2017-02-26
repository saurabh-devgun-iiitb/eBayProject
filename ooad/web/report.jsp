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
<title>Generate Report</title>

</head>
<body>


    <nav class="navbar navbar-static-top" style="margin-top: 10px;">
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="admin">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>


	<div class="container" style="margin-top: 120px;">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Generate Report
					</div>
				<s:form name="reportForm" action="reportAction" method="post" namespace="/" enctype="multipart/form-data" class="form-horizontal">
  					<div class="panel-body">
						<div class="form-group">
						    <label class="col-sm-3 control-label">Category Name</label>
					    	<div class="col-sm-8">
						    	<select class="form-control" id="category" name="categoryId" onchange="getSubCategory()">
									<option value='0'>None</option>
									<s:iterator>
										<option value='<s:property value="categoryId"/>'><s:property value="categoryName"/></option>
									</s:iterator>
								</select>
						    </div>
					  	</div>
						<div class="form-group">
						    <label class="col-sm-3 control-label">Sub-Category Name</label>
					    	<div id="getSubCategory" class="col-sm-8">
					    		<select class="form-control" id="subCategory">
									<option>None</option>
								</select>
						    </div>
					  	</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-md-11">
								<div class="pull-right">
								    <button type="submit" id="addItemButton" class="btn btn-success">Generate Report</button>
								</div>
							</div>
							<div class="col-md-1"></div>
						</div>
					</div>
				</s:form>
				</div>
			</div>
		</div>
	</div>
	
 <script src="js/bootstrap.min.js"></script>
		
  <script type="text/javascript">
  function ajax(urls, result)
	{
		var xmlhttp;
		if (window.XMLHttpRequest)
	 	{
		  	xmlhttp=new XMLHttpRequest();
	  	}
		else
	  	{
		  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	}
		xmlhttp.onreadystatechange=function()
	  	{
		  	if (xmlhttp.readyState==4)
	    	{
		  		document.getElementById(result).innerHTML=xmlhttp.responseText;
		  	}
	  	}
		xmlhttp.open("GET",urls,true);
		xmlhttp.send();
	} 
	
		function getSubCategory()
		{
		/*
			var x = document.getElementById("category").selectedIndex;
		    var y = document.getElementById("category").options;
			var key = y[x].index + 1;
		*/	
			var e = document.getElementById("category");
			var key = $('select[name="categoryId"]').val();		//e.options[e.selectedIndex].value;
			
			var urls = "ajax/getSubCategories2.jsp?categoryId=" + key
			
			ajax(urls, "getSubCategory");
			
			document.getElementById("catId").innerHTML = key;
		
			document.getElementById("subCategory").options[0].selected = 'selected';
			fillDetails();
		}
		
		function fillDetails()
		{
			var e = document.getElementById("subCategory");
			var key = e.options[e.selectedIndex].value;
			document.getElementById("subCatId").innerHTML = key;
			
		}
		
	</script>	

</body>
</html>