<%@page import="java.sql.ResultSet"%>
<%@page import="dao.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.implementaion.UserDAOImplementation"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.User"%>
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
	
</head>
<%  	String itemId;
		int quantity;
		String check = request.getParameter("check");
		if(check!=null && check.equals("true"))
		{
				itemId = (String) session.getAttribute("itemId");
				quantity = Integer.parseInt((String) session.getAttribute("quantity"));	
			
		}
		else
			{		 itemId = request.getParameter("id");
			 		quantity = Integer.parseInt(request.getParameter("qty"));
			}

		String userId = (String) session.getAttribute("userid");
        if (userId != null ) 
            System.out.println("user != null");            
        
        else    {
            System.out.println("user == null");
            response.sendRedirect("signIn.jsp?sucees=none&ro=true&id=" + itemId + "&qty=" + quantity);
        }
        
%>
<%! 
	public static String toTitleCase(String givenString) {
	    String[] arr = givenString.split(" ");
	    StringBuffer sb = new StringBuffer();
	
	    for (int i = 0; i < arr.length; i++) {
	        sb.append(Character.toUpperCase(arr[i].charAt(0)))
	            .append(arr[i].substring(1)).append(" ");
	    }          
	    return sb.toString().trim();
	}
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
			
			ItemAction itemAction = new ItemAction();
			ItemDetails itemDetails = itemAction.getItem(itemId);
			
			User user = new UserDAOImplementation().getUser(userId);
			
			Item item = itemDetails.getItem();
			Seller seller = itemDetails.getSeller();
			
			double vat = 0.0;
			DBConnection dbConnection = new DBConnection();
			PreparedStatement ps = dbConnection.connect().prepareStatement("select user_id from users where user_email='admin'");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vat = Double.parseDouble(rs.getString(1));
			}
			
			if(item == null)
			System.out.println("Not null item");
	%>
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<ul class="nav nav-tabs">
				<li role="presentation" class="active"><a href="#">Review Order</a></li>
				<li role="presentation"><a href="">Payment</a></li>
			</ul>
			<!-- <h3 style="padding-left: 20px;">Review Order</h3>
			<br> -->
			<br>
			<div class="row thumbnail" style="margin-left: 0px; margin-top: -23px; padding-top: 30px;">
			<form action="payment.jsp" method="post">
				<div class="col-md-8" style="padding-left: 50px; border-right: dashed 1px;">
					<h4><strong>Your item(s) will be delivered to this address</strong></h4>
					<hr>
					<input type="hidden" name="id" value="<%=itemId %>">
					<h5><strong><%=user.getUserName() %></strong></h5>
					<div class="form-group">
						<textarea rows="3" class="form-control" name="addr" placeholder="Address ..."></textarea>
					</div>
					<br>
					<hr style="border-top: dotted 1px;" />
					<h4><strong>Your order details - 1 item(s)</strong></h4>
					<hr>
					<div class="alert alert-success alert-dismissible" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<div class="form-horizontal">
							<div class="form-group">
								<label class="col-md-3 control-label">Item Name : </label>
								<div class="col-md-6">
									<label class="control-label" style="font-weight: 400"><%=item.getItemName() %></label>	
									<%-- <input type="text" class="form-control" disabled="disabled" value="<%=item.getItemName() %>"> --%>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Quantity : </label>
								<div class="col-md-3">
									<input type="hidden" id="qtyAvail" value="<%=item.getItemQuantityAvailable() %>">
									<input class="form-control" id="quantity" type="text" name="qty" value="<%=quantity %>" onkeyup="setPrice()">
								</div>
								<div class="btn-group col-md-3" role="group">
									<button type="button" onclick="add()" class="btn btn-default">+</button>
									<button type="button" onclick="minus()" class="btn btn-default">-</button>
								</div>
								<div class="col-md-3">
									<span id="err"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Unit Price : </label>
								<div class="col-md-6">
									<input type="hidden" id="price" value="<%=item.getItemPrice() %>">
									<label class="control-label" style="font-weight: 400"><i class='fa fa-inr'></i> <%=item.getItemPrice() %></label>	
									<%-- <input class="form-control" disabled="disabled" type="text" name="price" value="$ <%=item.getItemPrice() %>"> --%>
								</div>   
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Discount : </label>
								<div class="col-md-6">
									<input type="hidden" id="discount" value="<%=item.getItemDiscount() %>">
									<label class="control-label" style="font-weight: 400"><%=item.getItemDiscount() %> %</label>	
								</div>   
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Discount Price : </label>
								<div class="col-md-6">
									<label class="control-label" style="font-weight: 400"><i class='fa fa-inr'></i> <%= item.getItemPrice()*(item.getItemDiscount()/100.0) %> </label>	
								</div>   
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">VAT : </label>
								<div class="col-md-6">
									<input type="hidden" id="vat" value="<%=vat %>">
									<label class="control-label" style="font-weight: 400"><%=String.format("%.2f",vat) %> %</label>	
								</div>   
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">VAT Price: </label>
								<div class="col-md-6">
									<label class="control-label" style="font-weight: 400"><i class='fa fa-inr'></i> <%= String.format("%.2f", item.getItemPrice()*(vat/100.0)) %> </label>	
								</div>   
							</div>
						</div>	
					</div>
					<br>
					<hr style="border-top: dotted 1px;" />
					<br>
					<div class="text-right">
					<%
						double discount = item.getItemPrice()*(item.getItemDiscount()/100.0);
					%>	
							<h4>Grand Total </h4><h2 id="totalPrice"><i class='fa fa-inr'></i> <%=item.getItemPrice() %></h2>
					</div>
					<br>
				</div>
				<div class="col-md-4" style="padding-right: 25px;">
					<button type="submit" style="padding: 30px 0px;" class="btn btn-primary btn-block">Proceed To Pay</button>
					<!-- <a type="button" href="#" onclick="pay()" style="padding: 30px 0px;" class="btn btn-primary btn-block">Proceed To Pay</a> -->
				</div>
		</form>		
			</div>
			<br>
			<br>
		</div>
		<div class="col-md-2">
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
	
	<script type="text/javascript">
	
		$(document).ready(function (){
			setPrice();	
		});
		
		function setPrice() {
			var price = $('#price').val() * $('#quantity').val() * (($('#vat').val() - $('#discount').val())/100.0);
			price += $('#price').val() * $('#quantity').val();
			$('#totalPrice').html("<i class='fa fa-inr'></i> " + price.toFixed(2));
		}
		
		/* function setPrice() {
			var price = $('#price').val() * $('#quantity').val();
			$('#totalPrice').html("Rs " + price);
		} */
		
		function add() {
			var qty = $('#quantity').val();
			var qtyAvail = $('#qtyAvail').val();
			if(qty <= qtyAvail) {
				qty++;
				$('#quantity').val(qty);
				setPrice();	
				$('#err').html("");
			}
			else {
				$('#err').html("<font color='red'>No more items in stock</font>");
			}
		}
		
		function minus() {
			
			var qty = $('#quantity').val();
			if(qty > 1) {
				qty--;
				$('#quantity').val(qty);
				setPrice();
				$('#err').html("");
			}
			else {
				$('#err').html("<font color='red'>Quantity cannot be less than one</font>");
			}
		}
		
		function pay() {
			window.location.href = "payment.jsp?id=" + $('#itemId').val() + "&qty=" + $('#quantity').val();
		}
	</script>
</body>
</html>