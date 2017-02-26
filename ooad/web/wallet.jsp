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
		}); */	
		
	</script>
	<style type="text/css">
span {
    display: inline-block;
}
.subOrdTimeLine {
    /* width: 725px; */
   /*  margin-top: 15px; */
    margin-left: 18px;
}
.subOrdTimeLine .statusCircle.greenStatusCircle {
    background-color: #4CAF50;
    border: 3px solid #4CAF50;
}
.subOrdTimeLine .statusCircle.greyStatusCircle {
    background-color: #9C9B9B;
    border: 3px solid #9C9B9B;
}
.subOrdTimeLine .statusCircle {
    border: 3px solid #E3E3E3;
    border-radius: 50px;
    position: absolute;
    padding-top: 0px;
    width: 18px;
    height: 18px;
}	
.subOrdTimeLine .statusLine.greenStatusLine {
    border-top: 3px solid #4CAF50;
}
.subOrdTimeLine .statusLine.greyStatusLine {
    border-top: 3px solid #9C9B9B;
}
.subOrdTimeLine .statusLine {
    width: 44%;
    border-top: 3px solid #E3E3E3;
    vertical-align: middle;
    margin-left: 23px;
    margin-bottom: 3px;
    margin-right: 5px;
}
.timeLineText {
    padding-bottom: 15px;
    margin-left: 18px;
    /* width: 725px; */
}
.timeLineText .timelineStatusText:first-child {
    text-align: left;
}
.timelineStatusText.timelineText3:nth-child(2) {
    text-align: center;
}
.timelineStatusText.timelineText3:nth-child(3) {
    text-align: right;
}
.timeLineText .timelineStatusText {
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
			double balance = new PaymentDAOImplementation().getBalance(userid);
			
	%>
	<div class="container">
		<ol class="breadcrumb" style="background: none;">
			<li><a href="index1">Home</a></li>
			<li class="active">Payments</li>
		</ol>
		<hr>
		<div class="row">
			<div class="col-md-2" style="border-right: 1px dotted #000;">
				<p style="font-size: 18 px;"><strong>MY ACCOUNT</strong></p>
				<p><i class="fa fa-file-text"></i>&emsp;ORDERS</p>
				<p>&emsp;&emsp;<a href="trackOrder.jsp">&nbsp;Orders</a></p>	
				<%if(usertype.equals("2"))
					{
					%>
				<p><i class="fa fa-ship"></i>&emsp;SELLS</p>
				<p>&emsp;&emsp;<a href="sellerTrackOrder.jsp">&nbsp;Sells</a></p>	
				 <%
				 	}
				 	%>	
				<p><i class="fa fa-money"></i>&emsp;PAYMENTS</p>
				<p>&emsp;&emsp;<a href="#">&nbsp;Wallet</a></p>	
			</div>
			<div class="col-md-10" style="padding-left: 40px;">
				<p style="font-size: 18px; color: #CE1F24; border-bottom: 2px solid #D0D0D0;"><strong>MY WALLET</strong></p>
				<div class="thumbnail" style="padding: 20px 20px;">
					<h4>Your Wallet : <strong style="color: green;"><i class='fa fa-inr'></i>&nbsp;<%=String.format("%.2f", balance) %></i> </strong></h4>
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
</body>
</html>