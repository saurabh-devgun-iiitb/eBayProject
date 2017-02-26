<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@page import="dao.implementaion.PaymentDAOImplementation"%>
<%@page import="model.AttributeList"%>
<%@page import="model.Seller"%>
<%@page import="model.ItemDetails"%>
<%@page import="model.Item"%>
<%@page import="action.ItemAction"%>
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
	
		.form-control[disabled] {
			background-color: #5CB85C;
		}
	</style>
</head>
<%  
	/* String itemId = "", addr = "";
	int quantity = 0;
		try {
			itemId = request.getParameter("id");
			quantity = Integer.parseInt(request.getParameter("qty"));
			addr = request.getParameter("addr");
		}
		catch(Exception e) {
			response.sendRedirect("home.jsp");
		}
		String userId = (String) session.getAttribute("userid");
        if (userId != null ) 
            System.out.println("user != null");            
        
        else    {
            System.out.println("user == null");
            response.sendRedirect("loginPage.jsp?v=ro&id=" + itemId + "&qty=" + quantity);
        }
   */      
%>
<body>
	<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>
	<%
			
	/* 		ItemAction itemAction = new ItemAction();
			ItemDetails itemDetails = itemAction.getItem(itemId);
			Item item = itemDetails.getItem();
			Seller seller = itemDetails.getSeller();
			
			double balance = new PaymentDAOImplementation().getBalance(userId);
	*/		
			double vat = 0.0;
			DBConnection dbConnection = new DBConnection();
			PreparedStatement ps = dbConnection.connect().prepareStatement("select user_name from users where user_email='admin'");
			ResultSet rs1 = ps.executeQuery();
			if(rs1.next()) 
				vat = Double.parseDouble(rs1.getString(1));
			rs1.close();
			ps.close();
			dbConnection.disconnect();
			
			double balance = new PaymentDAOImplementation().getBalance((String) session.getAttribute("userid"));
			System.out.println("Bal = " + balance);
			dbConnection = new DBConnection();
			PreparedStatement ps1 = dbConnection.connect().prepareStatement("select c.*, i.* from items i, carts c where c.cart_item_id = i.items_id AND c.cart_user_id = " + session.getAttribute("surrogate"));
			ResultSet rs = ps1.executeQuery();
			
			/* double totPrice = (item.getItemPrice() * quantity * (vat - item.getItemDiscount())/100.0) + 
								(item.getItemPrice() * quantity);
			
			String tPrice = String.format("%.2f", totPrice);
			
			double totalPrice = Double.parseDouble(tPrice); */
	 	
	%>
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<ul class="nav nav-tabs">
				<li role="presentation"><a href="reviewCart">Review Order</a></li>
				<li role="presentation" class="active"><a href="">Payment</a></li>
			</ul>
			<!-- <h3 style="padding-left: 20px;">Review Order</h3>
			<br> -->
			<br>
			<div class="row thumbnail" style="margin-left: 0px; margin-top: -23px; padding-top: 30px;">
				<div class="col-md-3" style="padding: 10px 30px; border-right: dashed 1px;">
					<ul class="nav nav-pills nav-stacked">
						<li role="presentation"><a href="#debit-card">Debit Card</a></li>
						<li role="presentation"><a href="#">Credit Card</a></li>
						<li role="presentation"><a href="#">Net Banking</a></li>
						<li role="presentation" class="active"><a href="#wallet">Wallets</a></li>
					</ul>		
				</div>
				<div class="col-md-9" style="padding: 10px 30px;">
					<table class="table">
						<caption class="text-center"><strong>Payment Reciept</strong></caption>
						<tbody>
							<tr>
						</tbody>
					</table>
					<ul style="list-style-type: none;">
						<li>
							<div class="col-md-1">
								<strong>S. No.</strong>
							</div>
							<div class="col-md-3">
								<strong>Item Name</strong>
							</div>
							<div class="col-md-1">
								<strong>&times;</strong>
							</div>
							<div class="col-md-1">
								<strong>Qty</strong>
							</div>
							<div class="col-md-2">
								<strong>Amount</strong>
							</div>
							<div class="col-md-2">
								<strong>Disc %</strong>
							</div>
							<div class="col-md-2">
								<strong>To Pay</strong> <!-- *rs.getInt("cart_quantity")*(1-rs.getDouble("item_discount")/100) -->
							</div>
						</li>
					</ul>
					<br>
					<div class="clearfix"></div>
					<br>
					<ul style="list-style-type: none;">
	<%		double totalPrice = 0.0;
			double vatPrice = 0.0;
			int i = 1;
			while(rs.next()) {
				vatPrice += rs.getDouble("cart_price");//*rs.getInt("cart_quantity");
				totalPrice += rs.getDouble("cart_price")*(1-rs.getDouble("item_discount")/100);//*rs.getInt("cart_quantity")*(1-rs.getDouble("item_discount")/100);	
	%>
						<li>
							<div class="col-md-1">
								<%=i++ %>
							</div>
							<div class="col-md-3">
								<%=rs.getString("item_name") %>
							</div>
							<div class="col-md-1">
								&times;
							</div>
							<div class="col-md-1">
								<%=rs.getInt("cart_quantity") %>
							</div>
							<div class="col-md-2">
								<%=String.format("%.2f", rs.getDouble("cart_price")) %>
							</div>
							<div class="col-md-2">
								<%=rs.getDouble("item_discount") %>
							</div>
							<div class="col-md-2">
								<%=String.format("%.2f", rs.getDouble("cart_price")*(1-rs.getDouble("item_discount")/100)) %>
							</div>
							<div class="clearfix"></div>
							<br>
						</li>	
										
							
							 
	<%		}
	%>				</ul>
						<br>
						<br>
						<br>
					
					<p class="pull-right">Total = <strong id="totalPriceLabel"><i class='fa fa-inr'></i> <%=String.format("%.2f",totalPrice) %></strong></p>
					<div class="clearfix"></div>
					<p class="pull-right">VAT = <strong id="totalPriceLabel"><i class='fa fa-inr'></i> <%=String.format("%.2f",vatPrice*(vat/100)) %></strong></p>
					<div class="clearfix"></div>
					<p class="pull-right">Bill Amount = <strong id="totalPriceLabel"><i class='fa fa-inr'></i> <%=String.format("%.2f", totalPrice + vatPrice*(vat/100)) %></strong></p>
					<div class="clearfix"></div>
					<div id="debit-card" class="hidden">
						<h4><strong>Enter Debit Card Details</strong></h4>
						<p>Your card details will be safe and secure and will not be shared with the seller(s).</p>
							<div class="form-group col-md-6">
								<label>Debit Card Number</label> 
								<input type="text" class="form-control" placeholder="XXXX-XXXX-XXXX-XXXX" maxlength="16">
							</div>
							<div class="form-group col-md-6">
								<label>Card Holder Name <small>(as it appears on card)</small></label> 
								<input type="text" class="form-control" placeholder="Name">
							</div>
							<div class="form-group col-md-6">
								<label>Valid till</label> 
								<div>
									<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
										<input type="text" class="form-control" placeholder="MM">
									</div>
									<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
										<input type="text" class="col-md-6 form-control" placeholder="YYYY">
									</div>
								</div>
							</div>
							<div class="form-group col-md-6">
								<label>CVV <small>(3-digit card verification number)</small></label>
								<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
									<input type="password" class="form-control" maxlength="3">
								</div>
							</div>
					</div>
					<div id="wallet">
						<div class="form-group col-md-6">
							<label>Current Wallet Balance</label> 
							<input type="text" class="form-control" disabled="disabled" value="<%=String.format("%.2f", balance) %>">
						</div>
					</div>
						<form action="paymentCart" method="post">
							<input type="hidden" name="totalPrice" value="<%=totalPrice + vatPrice*(vat/100) %>">
							<div class="form-group">
								<p>.</p>
								<hr>
								<p class="col-md-8 text-right"><small>In the next step you will be redirected to 3D secure verification</small></p>
								<div class="col-md-4">
					<% 	if(balance >= totalPrice + vatPrice*(vat/100) )  {
					%>			<button type="submit" class="btn btn-success form-control">Pay Now</button>
					<%	} else {
					%>			<button type="button" disabled="disabled" class="btn btn-success form-control">Pay Now</button>
					<%	}
					%>
					</div>
								<hr>
								<br>
							</div>
						</form>
							
				</div>
			</div>
			<br>
			<br>
		</div>
		<div class="col-md-1">
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
	
</body>
</html>