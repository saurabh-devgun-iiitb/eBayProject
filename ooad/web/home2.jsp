<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
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
		    height: 180px;
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
	        $('[data-toggle="tooltip"]').tooltip();
		});	
	
		$(document).ready(function() {
		    $('.carousel').carousel();
	  	});
	</script>
</head>
<body>

	<div id="header">
	</div>
	<nav class="nav navbar-default" style="border-bottom: 1px solid #B2B2B2;">
		<div class="container header">
			<ul class="navbar-left header-nav" style="margin-bottom: 5px;">
				<li><a href="#">Sign in</a></li>
				<li><a href="#">Register</a></li>
				<li><a href="#">Deals </a></li>
				<li><a href="#">Sell </a></li>
				<li><a href="#">Track My Order</a></li>
			</ul>
			<ul class="navbar-right header-nav" style="margin-bottom: 5px;">
				<li><a href="#">My eBay </a></li>
				<li><a href="#"> My PaisaPay </a></li>
				<li><a href="#"><i class="fa fa-bell"></i> </a></li>
				<li><a href="#"><i class="fa fa-search"></i></a></li>
				<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
			</ul>
		</div>
	</nav>
	
	<%
	try {
				   
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT * FROM items");
		ResultSet rs = ps.executeQuery();
		ArrayList<String> itemId = new ArrayList<String>();
		ArrayList<String> itemName = new ArrayList<String>();
		ArrayList<String> itemDesc = new ArrayList<String>();
		ArrayList<Double> itemPrice = new ArrayList<Double>();
		ArrayList<String> itemImage = new ArrayList<String>();
		ArrayList<String> itemSeller = new ArrayList<String>();
		
%>

<div class="row" style="margin-top: 10px;">
	<div class="col-md-2">
	</div>
    <div class="col-md-8">
		<div class="well text-center">
			<h3>Advertisements</h3>
		</div>
		<div class="row-fluid">
    		<div class="carousel slide" id="myCarousel">
    			<div class="carousel-inner">
<%		
		
		int c1 = 0, c2 = 0 ;

		while(rs.next()) {
			
			itemId.add(rs.getString(2));
			itemName.add(rs.getString(3));
			itemPrice.add(rs.getDouble(5));
			itemImage.add(rs.getString(6));
			itemDesc.add(rs.getString(4));
			itemSeller.add(rs.getString(10));
			
			if(c2 % 3 == 0) {

				if(c1 == 0) {
					
%>
				<div class="item active">
					<ul class="thumbnails">
<%
				}
				if(c1 != 0) {
				
%>
					</ul>
				</div>
				<div class="item">
					<ul class="thumbnails">                
<%				
				}
			
				
				c1 ++;
%>
						<li class="col-md-4">
		                        <div class="thumbnail">
		                        	<a data-toggle="modal" data-target="#myModal<%=rs.getString(2) %>"><img src="showPicture.jsp?image=<%=rs.getString(6) %>" class="img-responsive"></a>
		                        </div>
			      				<div class="caption">
									<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td><strong><%=rs.getString(2) %></strong></td>
				    				</tr>
									<tr>
										<td>NAME</td>
										<td><strong><%=rs.getString(3) %></strong></td>
									</tr>
									<tr>
										<td>Price</td>
										<td><strong>$ <%=rs.getDouble(5) %></strong></td>
									</tr>
									<tr class="success">
										<td colspan="2" class="text-right"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-primary" role="button">Buy Now</a></td>
									</tr>
			    					</table>
			    				</div>
		                    </li>
<%				
			}
				
			
			if(c2 % 3 != 0) {
			
%>
		                    <li class="col-md-4">
		                        <div class="thumbnail">
		                        	<a data-toggle="modal" data-target="#myModal<%=rs.getString(2) %>"><img src="showPicture.jsp?image=<%=rs.getString(6) %>" class="img-responsive"></a>
		                        </div>
			      				<div class="caption">
									<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td><strong><%=rs.getString(2) %></strong></td>
				    				</tr>
									<tr>
										<td>NAME</td>
										<td><strong><%=rs.getString(3) %></strong></td>
									</tr>
									<tr>
										<td>Price</td>
										<td><strong>$ <%=rs.getDouble(5) %></strong></td>
									</tr>
									<tr class="success">
										<td colspan="2" class="text-right"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-primary" role="button">Buy Now</a></td>
									</tr>
			    					</table>
			    				</div>
		                    </li>
				
<%				

			}
			c2 ++;
			
		}
%>
		                </ul>
		          </div>
		        </div>
		       <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
		    </div>
		</div>
	</div>	
    <div class="col-md-2">
	
	</div>
    
</div>
<%

		for(int i = 0; i < itemId.size(); i ++ ) {
	
%>		
			<div class="modal fade" id="myModal<%=itemId.get(i) %>" tabindex="-1" role="dialog">
				<div class="modal-dialog modal-lg">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4><%=itemName.get(i) %></h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<img src="showPicture.jsp?image=<%=itemImage.get(i) %>" class="img-responsive">		
								</div>
								<div class="col-md-6">
									<table class="table" style="border-width : 0px; border-top-style: none;">
					    				<tr>
					    					<td>ID</td>
					    					<td><strong><%=itemId.get(i) %></strong></td>
					    				</tr>
										<tr>
											<td>Name</td>
											<td><strong><%=itemName.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Description</td>
											<td><strong><%=itemDesc.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Seller Name</td>
											<td><strong><%=itemSeller.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Price</td>
											<td><strong>$ <%=itemPrice.get(i) %></strong></td>
										</tr>
										<tr class="success">
											<td colspan="2" class="text-right"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-primary" role="button">Buy Now</a></td>
										</tr>
				    				</table>	
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>	
 		<!-- Display individual item -->
		<%-- 	<div class="modal fade" id="myModalItem" role="dialog">
				<div class="modal-dialog modal-lg">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4><%=rs.getString(2) %></h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<img src="showPicture.jsp?image=<%=rs.getString(4) %>" class="img-responsive">		
								</div>
								<div class="col-md-6">
									<table class="table" style="border-width : 0px; border-top-style: none;">
					    				<tr>
					    					<td>ID</td>
					    					<td><strong><%=rs.getString(1) %></strong></td>
					    				</tr>
										<tr>
											<td>Name</td>
											<td><strong><%=rs.getString(2) %></strong></td>
										</tr>
										<tr>
											<td>Description</td>
											<td><strong><%=rs.getString(5) %></strong></td>
										</tr>
										<tr>
											<td>Seller Name</td>
											<td><strong><%=rs.getString(6) %></strong></td>
										</tr>
										<tr>
											<td>Price</td>
											<td><strong>$ <%=rs.getDouble(3) %></strong></td>
										</tr>
										<tr class="success">
											<td colspan="2" class="text-right"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-primary" role="button">Buy Now</a></td>
										</tr>
				    				</table>	
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
	 --%>

<footer class="site-footer">
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<h2>Contact Address</h2>
				<address>
				    <b>RApS</b><br/>
					#26/c, IIIT Bangalore,Electronic City	<br>
					Bangalore,<br>
					India.
				</address>
			</div>
		</div>
		<div class="bottom-footer">
			<div class="col-md-5">
				<p align="left"><a href="acknowledgement.jsp">Acknowledgement and References</a></p>
			</div>
			<div class="col-md-7">
				<ul class="footer-nav">
					<li><a href="index1">Home</a></li>
					<li><a href="#" data-toggle="modal" data-target="#myModal" >Contact</a></li>
					<!-- <li><a href="#">Blog</a></li>
					<li><a href="#">Link</a></li> -->
				</ul>
			</div>
		</div>
	</div>
</footer>

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

</body>
</html>
