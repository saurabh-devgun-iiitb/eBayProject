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
	
		/* .thumbnail {
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
		 */
	</style>
	
	<script type="text/javascript">
	
		$(function(){
		    $("#header").load("header"); 
		});	
		
		
	</script>
</head>
<body>
	<% 	 		String userid = (String) session.getAttribute("userid");
				//String itemid = (String) request.getParameter("id");
				String usertype = "3";
				if((String) session.getAttribute("usertype") != null)
					usertype = (String) session.getAttribute("usertype");
	%>
	<div id="header">
	</div>
	
	<nav class="nav navbar-default" style="border-bottom: 1px solid #CBCCCA;">
		<div class="container header">
			<ul class="navbar-left header-nav" style="margin-bottom: 5px;">
			<%if(usertype.equals("1")){ %>
				<li>Welcome ,<a href="userAccount.jsp?success=none"> <s:property value="#session.username"/> </a>!</li>
			<%} else
				%>
			<%if(usertype.equals("2")){ %>
				<li>Welcome ,<a href="sellerAccount.jsp?success=none"> <s:property value="#session.username"/> </a>!</li>
			<%}%>
		 <%	        
				if (userid != null ) { 
	            	System.out.println("user != null");
	            	if( usertype == "1" || usertype == "2") {
	     %>
	     				<li><a href="registerPage2">Register</a></li>
	     <%			}
				}
	       %>
				
				<li><a href="#" data-toggle="modal" data-target="#myModal">Deals </a></li>
		<%	        
				if (userid != null ) { 
	            	System.out.println("user != null");
	            	if( usertype == "1") {
	     %>
	     				<li><a href="registerSellerPage">Sell</a></li>
	     <%			}
	            	else if( usertype == "2") {
	     %>
	     				<li><a href="addItemPage">Sell</a></li>
	     <%   		}
	     	}
	     	else    {
	            System.out.println("user == null");
	      %>
						<li><a href="loginPage.jsp?v=s">Sell</a></li>
	      <%      
	        }
    %>			<!-- <li><a href="#">Sell </a></li> -->
				<li><a href="trackOrder.jsp">Track My Order</a></li>
			</ul>
			<ul class="navbar-right header-nav" style="margin-bottom: 5px;">
				<li><a href="#" data-toggle="modal" data-target="#myModal">My eBay </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal"> My PaisaPay </a></li>
				<li><a href="#"><i class="fa fa-bell"></i> </a></li>
				<li><a href="#"><i class="fa fa-search"></i></a></li>
				<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
				<li><a href="logOut"> Logout </a></li>
			</ul>
		</div>
	</nav>
	
<br>
<br>

<div class="container">
	<div class="thumbnail" style="border-width: 10px;">
		<h3 style="padding-left: 20px;">Items in your cart</h3>
		<hr>
		<div id="empty" class="hidden" style="padding-left: 20px;">
			<strong>Your shopping cart is empty, but it doesn't have to be.</strong>
			<p>There are a lot of great deals waiting for you. Start shopping and look for the "add to cart" button.</p>
			<p>You can add several items to your cart from different seller and pay for them at once.</p>
			<a href="index1">Start Shopping</a>
		</div>
		<div id="not-empty">
			<div class="pull-right" style="padding-right: 20px;">
				<a href="" class="btn btn-default" style="border-bottom: 2px outset grey;">Shop More</a>
				&emsp;
				<a href="" class="btn btn-primary" style="border-bottom: 2px outset grey;">Place Order</a>
			</div>
			<div class="clearfix"></div>
			<hr>
			<div id="items" style="padding: 10px 20px;">
			<s:iterator value="cart_items_list">
				<div id='<s:property value="cart_item_id"/>' class="alert alert-success alert-dismissible" role="alert">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;&emsp;</span>
					</button>
					<p>From <s:property value="cart_seller_name"/></p>
					<br>
					<table>
						<tbody>
							<tr style="vertical-align: top">
								<td class="col-md-1">
									<div class="checkbox">
										<label> <input type="checkbox">
										</label>
									</div>
								</td>
								<td class="col-md-1">
									<div class="thumbnail" style="width: 100px; margin-left: 0px;">
										<img src="showPicture.jsp?image=<s:property value='cart_item_picture'/>" class="img-responsive">
									</div>
								</td>
								<td class="col-md-5">
									<p class="text-capitalize"><s:property value="cart_item_name"/></p>
								</td>
								<td class="col-md-2 text-center">
									<div class="form-group text-center">
										<p>Quantity </p>
										<div class="">
											<!-- <input type="hidden" id="qtyAvail"
												value="item.getItemQuantityAvailable()"> -->
										</div>
										<div class="btn-group" role="group">
											<button type="button" onclick="minus()" class="btn btn-default">-</button>
										 	<button type="button" class="btn btn-default" id="quantity" type="button" name="qty"><s:property value="cart_quantity"/></button>
											<button type="button" onclick="add()" class="btn btn-default">+</button>
										</div>
									</div>
								</td>
								<td class="col-md-3 text-center">
									<i class='fa fa-inr'></i> <s:property value="cart_item_price"/>
								</td>
							</tr>
						</tbody>
					</table>	
				</div>
			</s:iterator>	
			</div>
		</div>
		<br>
		<br>
	</div>
</div>

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
