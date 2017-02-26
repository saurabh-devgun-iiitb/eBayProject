<%@page import="dao.implementaion.PaymentDAOImplementation"%>
<%@page import="dao.implementaion.ItemDAOImplementation"%>
<%@page import="model.Buyer"%>
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
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>Track Order</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<script src="js/jquery-ui.min.js"></script>
	<script type="text/javascript">
		/* $(function(){
		    $("#header").load("header");
		    $(".datepicker").datepicker();
		});	 */
		
	</script>
	<style type="text/css">
		span {
		    display: inline-block;
		}
		.order-timeline {
		    margin-left: 18px;
		}
		.order-timeline .status-circle.green-status-circle {
		    background-color: #4CAF50;
		    border: 3px solid #4CAF50;
		}
		.order-timeline .status-circle.grey-status-circle {
		    background-color: #9C9B9B;
		    border: 3px solid #9C9B9B;
		}
		.order-timeline .status-circle {
		    border: 3px solid #E3E3E3;
		    border-radius: 50px;
		    position: absolute;
		    padding-top: 0px;
		    width: 18px;
		    height: 18px;
		}	
		.order-timeline .status-line.greenstatus-line {
		    border-top: 3px solid #4CAF50;
		}
		.order-timeline .status-line.greystatus-line {
		    border-top: 3px solid #9C9B9B;
		}
		.order-timeline .status-line {
		    width: 44%;
		    border-top: 3px solid #E3E3E3;
		    vertical-align: middle;
		    margin-left: 23px;
		    margin-bottom: 3px;
		    margin-right: 5px;
		}
		.timeline-text {
		    padding-bottom: 15px;
		    margin-left: 18px;
		    /* width: 725px; */
		}
		.timeline-text .timeline-status-text:first-child {
		    text-align: left;
		}
		.timeline-status-text.timeline-text3:nth-child(2) {
		    text-align: center;
		}
		.timeline-status-text.timeline-text3:nth-child(3) {
		    text-align: right;
		}
		.timeline-text .timeline-status-text {
		    width: 32%;
		    text-align: center;
		    font-size: 14px;
		    padding-top: 2px;
		    text-transform: capitalize;
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
	<div id="header">
	</div>
	<br>
	<br>
	<%
			String userid = (String) session.getAttribute("userid");
    		String usertype = (String) session.getAttribute("usertype");
			ArrayList<Buyer> buyers = new ItemDAOImplementation().getOrderHistory(userid);

	%>
	<div class="container">
		<ol class="breadcrumb" style="background: none;">
			<li><a href="#">Home</a></li>
			<!-- <li><a href="#">My Account</a> -->
			<li class="active">Orders</li>
		</ol>
		<hr>
		<div class="row">
			<div class="col-md-2" style="border-right: 1px dotted #000;">
				<p style="font-size: 18 px;"><strong>MY ACCOUNT</strong></p>
				<p><i class="fa fa-file-text"></i>&emsp;ORDERS</p>
				<p>&emsp;&emsp;<a href="#">&nbsp;Orders</a></p>	
				<%if(usertype.equals("2"))
					{
					%>
				<p><i class="fa fa-ship"></i>&emsp;SELLS</p>
				<p>&emsp;&emsp;<a href="sellerTrackOrder.jsp">&nbsp;Sells</a></p>	
				 <%
				 	}
				 	%>
				<p><i class="fa fa-money"></i>&emsp;PAYMENTS</p>
				<p>&emsp;&emsp;<a href="wallet.jsp">&nbsp;Wallet</a></p>	
			</div>
			<div class="col-md-10" style="padding-left: 40px;">
				<p style="font-size: 18px; color: #CE1F24; border-bottom: 2px solid #D0D0D0;"><strong>MY ORDERS</strong></p>
			<%
				for(Buyer buyer : buyers) {
			%>
					<div class="thumbnail" style="padding: 20px 20px;">
						<div class="col-md-4">
							<h6>Order ID : <%=buyer.getBuyerSurrogateId() %>&nbsp;(<strong><%=buyer.getBuyerItemQuantity() %> items</strong>)</h6>
							<%-- <small>Placed on </small> --%>
						</div>
						<div class="col-md-8 text-right" style="padding-right: 20px;">
							<%-- <div class="form-group" style="margin-bottom: 0px;">
								<label>Rate Seller : <%=buyer.getBuyerSellerName() %></label>
							</div> --%>
			<%	if(buyer.getBuyerStatus() == 3 && buyer.getIsSellerRated() == 0) {
			%>				<div class="form-group" style="margin-bottom: 0px;">
								<label>Rate Seller : <%=buyer.getBuyerSellerName() %></label>
							</div>
							<div class="form-group" style="margin-bottom: 0px;">
			<%		for(int i=1; i<=5; i++) {
						if(i <= buyer.getBuyerSellerRating()) {
			%>					<a href="rateSeller.jsp?iid=<%=buyer.getBuyerItemId() %>&r=<%=i %>&sId=<%=buyer.getBuyerSellerSurrogateId() %>"><i class="fa fa-star"></i></a>
			<%			}
						else {
			%>
								<a href="rateSeller.jsp?iid=<%=buyer.getBuyerItemId() %>&r=<%=i %>&sId=<%=buyer.getBuyerSellerSurrogateId() %>"><i class="fa fa-star-o"></i></a>
			<%			}
					}
			%>				</div>
			<%	}
			    else if(buyer.getBuyerStatus() == 3 && buyer.getIsSellerRated() == 1) {
			%>
							<div class="form-group" style="margin-bottom: 0px;">
								<label>Average Rating : <%=buyer.getBuyerSellerName() %></label>
							</div>
							<div class="form-group" style="margin-bottom: 0px;">
			<%		for(int i=1; i<=5; i++) {
						if(i <= buyer.getBuyerSellerRating()) {
			%>					<i class="fa fa-star"></i>
			<%			}
						else {
			%>
								<i class="fa fa-star-o"></i>
			<%			}
					}
			%>				</div>
			<%	}
			%>		</div>
					<div class="clearfix"></div>
						<hr style="margin-top: 5px;">
						<div class="col-md-2">
							<img alt="" src="showPicture.jsp?image=<%=buyer.getBuyerImageName() %>" width="100px;" height="120px;">
						</div>
						<div class="col-md-10">
							<h4><%=buyer.getBuyerItemName() %></h4>
						</div>
						<div class="col-md-3">
			<%		if(buyer.getBuyerStatus() == 2) {
			%>			<a href="itemDelivered.jsp?bId=<%=buyer.getBuyerSurrogateId() %>&sId=<%=buyer.getBuyerSellerSurrogateId() %>&m=<%=buyer.getBuyerMoneyPaid() %>" type="button" class="btn btn-primary">Delivered</a>
			<%		}
			%>			</div>
						<div class="col-md-9 text-right">
							<h4><i class="fa fa-inr"></i>&nbsp;<%=buyer.getBuyerMoneyPaid() %></h4>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-6" style="padding-top: 8px;">
							<p>Status : <span style="color: green;">
			<%		if(buyer.getBuyerStatus() == 1) {
			%>								Item Placed
			<%		} else if(buyer.getBuyerStatus() == 2) {
			%>								Dispatched
			<%		} else if(buyer.getBuyerStatus() == 3) {
			%>								Delivered Successfully
			<%		} else if(buyer.getBuyerStatus() == 4) {
			%>								Order Cancelled
			<%		} 
			%>							</span>
							</p>
						</div>
						<div class="col-md-6 text-right" style="padding-right: 20px;">
							<%-- <p>Delivered On : <span style="color: green;"></span></p> --%>
						</div>
						<hr style="border-top: dotted 1px; margin-top: 40px;" />
						<div class="order-timeline">
			<%		if(buyer.getBuyerStatus() == 1) {
			%>				<span class="status-circle green-status-circle"></span>
							<span class="status-line greystatus-line"></span>
							<span class="status-circle grey-status-circle"></span>
							<span class="status-line greystatus-line"></span>
							<span class="status-circle grey-status-circle"></span>
			<%		} else if(buyer.getBuyerStatus() == 2) {
			%>				<span class="status-circle green-status-circle"></span>
							<span class="status-line greenstatus-line"></span>
							<span class="status-circle green-status-circle"></span>
							<span class="status-line greystatus-line"></span>
							<span class="status-circle grey-status-circle"></span>
			<%		} else if(buyer.getBuyerStatus() == 3) {
			%>				<span class="status-circle green-status-circle"></span>
							<span class="status-line greenstatus-line"></span>
							<span class="status-circle green-status-circle"></span>
							<span class="status-line greenstatus-line"></span>
							<span class="status-circle green-status-circle"></span>				
			<%		} 
			%>			
						</div>
						<div class="timeline-text">
							<span class="timeline-status-text timeline-text3">PLACED</span>
							<span class="timeline-status-text timeline-text3">DISPATCHED</span>
							<span class="timeline-status-text timeline-text3">DELIVERED</span>							
						</div>
					</div>
			<%	}
			%>	
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
</body>
</html>