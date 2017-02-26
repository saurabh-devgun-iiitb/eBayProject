<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@page import="com.sun.net.httpserver.Authenticator.Success"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>Delete Item</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	
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

	<nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Update Item
					</div>
				<form action="updateItem" method="post" class="form-horizontal">
  					<div class="panel-body">
						<div class="form-group">
   							<label for="id" class="col-sm-2 control-label">Item Id</label>
   							<div class="col-sm-10">
   								<input type="text" class="form-control" id="itemId" name="itemId" placeholder="Item ID" onkeyup="verifyItem()">
   							</div>
 							</div>
					  	<div class="form-group">
						    <label for="name" class="col-sm-2 control-label">Item Name</label>
					    	<div class="col-sm-10">
						    	<input type="text" id="itemName" class="form-control" name="itemName" disabled="disabled">
						    </div>
					  	</div>
				  	</div>
					<div class="panel-footer">
					    <button type="submit" class="btn btn-success">Update</button>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <p>Site Under Construction..!!</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
					var response = xmlhttp.responseText; 
				 	if(response != "")
				 	{
				 		document.getElementById(result).disabled = false;
				 		document.getElementById(result).value = response;
				 	}
				 	else
			 	 		document.getElementById(result).disabled = true;
				}
		  	}
			xmlhttp.open("GET",urls,true);
			xmlhttp.send();
		}
		
		function verifyItem()
		{
			var key = document.getElementById("itemId").value;
			var urls = "ajax/verifyItem.jsp?itemId=" + key;
			
			ajax(urls, "itemName");
		}
	
		function getSubCategory()
		{
			var x = document.getElementById("category").selectedIndex;
		    var y = document.getElementById("category").options;
			var key = y[x].index + 1;
			var urls = "ajax/getSubCategories.jsp?categoryId=" + key
	
			ajax(urls, "subCategory");
		}
	</script>
</body>
</html>