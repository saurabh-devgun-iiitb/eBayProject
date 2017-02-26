<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>  
    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>raps.in</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<style type="text/css">
	
		.header {
		    font-size: 12px;
		    padding-top: 5px;
		}
		
		.thumbnail {
		    width: 260px;
		    height: 300px;
		    overflow: hidden; /* contain images within thumbnail boundaries */
		    border: 0; /* removes Bootstrap's default border */
		    box-shadow: 0 12px 12px -10px #c4c4c4;
		    -webkit-box-shadow: 0 17px 22px -20px #c4c4c4;
		    -moz-box-shadow: 0 12px 12px -10px #c4c4c4;
		}
		.thumbnail img { width:100%; height:auto; } /* to keep proportions */
		.thumbnails p { text-align: center; padding: 10px; } /* captions can be styled with an inline element */
		
	</style>
	
	<script type="text/javascript">
	
		$(function(){
		    $("#header").load("header"); 
		    $("#itemCarousel").load("itemCarousel.jsp"); 
	    });	
		
		$(document).on('mouseenter', '[data-toggle="tab"]', function () {
		  	$(this).tab('show');
		});
		
	</script>
</head>
<body>
	<div id="header">
	</div>
	<nav class="nav navbar-default" style="border-bottom: 1px solid #CBCCCA;">
		<div class="container header">
			<ul class="navbar-left header-nav" style="margin-bottom: 5px;">
				<li><a href="#">Sign in</a></li>
				<li><a href="#">Register</a></li>
				<li><a href="#">Deals </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal">Sell </a></li>
				<li><a href="#">Track My Order</a></li>
			</ul>
			<ul class="navbar-right header-nav" style="margin-bottom: 5px;">
				<li><a href="#" data-toggle="modal" data-target="#myModal">My eBay </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal"> My PaisaPay </a></li>
				<li><a href="#"><i class="fa fa-bell"></i> </a></li>
				<li><a href="#"><i class="fa fa-search"></i></a></li>
				<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
			</ul>
		</div>
	</nav>
	
	<% String itemId = request.getParameter("itemId"); %>
	
	
</body>
</html>