<%@page import="dao.implementaion.CartDAOImplementation"%>
<%@page import="model.Cart"%>
<%@page import="java.util.ArrayList"%>
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
<%  /* 	String itemId;
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
        } */
        
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

			/* ArrayList<Cart> carts = new ArrayList<Cart>();
			
    		carts = new CartDAOImplementation().getCartItem(Integer.parseInt((String) session.getAttribute("userid")));
    		 */		
			/* ItemAction itemAction = new ItemAction();
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
			System.out.println("Not null item"); */
	%>
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<ul class="nav nav-tabs">
				<li role="presentation" class="active"><a href="#">Review Order</a></li>
				<li role="presentation"><a href="">Payment</a></li>
			</ul>
			<!-- <h3 style="padding-left: 20px;">Review Order</h3>
			<br> -->
			<br>
			<div class="row thumbnail" style="margin-left: 0px; margin-top: -23px; padding-top: 30px;">
				<div class="col-md-8" style="padding-left: 50px; border-right: dashed 1px;">
					<%-- <input type="hidden" name="id" value="<%=itemId %>"> --%>
					<%-- <h5><strong><%=session.getAttribute("username") %></strong></h5>
					<br> --%>
					<hr style="border-top: dotted 1px;" />
					<%-- <h4><strong>Your order details - 1 item(s)</strong></h4>
					<hr>
					 --%>
				<s:iterator value="cart_items_list">
			<form id="cart" action="deleteReviewCartItem" method="post">
				<s:set var="free" value="cart_quantity-(cart_item_price/item_price)" />		
				<div id='<s:property value="cart_item_id"/>' class="alert alert-success alert-dismissible" role="alert">
					<button type="submit" class="close"> <%-- onclick="deleteItem('<s:property value="cart_item_id"/>')" --%>
						<span aria-hidden="true">&times;&emsp;</span>
					</button>
					<p>From <s:property value="cart_seller_name"/></p>
					<br>
					<input type="hidden" name="id" value="<s:property value="cart_item_id"/>">
					<input type="hidden" name="qty" value="<s:property value="cart_quantity"/>">
					<table>
						<tbody>
							<tr style="vertical-align: top">
								<!-- <td class="col-md-1">
									<div class="checkbox">
										<label> <input type="checkbox">
										</label>
									</div>
								</td> -->
								<td class="col-md-1">
									<div class="thumbnail" style="width: 100px; margin-left: 0px;">
										<img src="showPicture.jsp?image=<s:property value='cart_item_picture'/>" class="img-responsive">
									</div>
								</td>
								<td class="col-md-5">
									<p class="text-capitalize"><s:property value="cart_item_name"/></p>
									<s:if test="%{#free > 0}">
										<br><i class="fa fa-thumbs-up"></i>&emsp;<img alt="" src="images/FreeBadge.png" width="50px">&emsp;&times;&emsp;<strong><s:property value="#free"/></strong>
									</s:if>
								</td>
								<td class="col-md-3 text-center">
									<div class="form-group text-center">
										<p>Quantity </p>
										<div class="">
											<!-- <input type="hidden" id="qtyAvail"
												value="item.getItemQuantityAvailable()"> -->
										</div>
										<div class="input-group">
											<input type="text" class="form-control" id="qty<s:property value="cart_item_id"/>" name="qty<s:property value="cart_item_id"/>" value="<s:property value="cart_quantity"/>"> 
											<span class="input-group-btn">
												<button id="<s:property value="cart_item_id"/>" type="button" class="btn btn-default" type="button" onclick="update('<s:property value="cart_item_id"/>')">Update</button>
											</span>
										</div>
										<span id="err<s:property value="cart_item_id"/>"></span>	
										<%-- <div class="input-group">
											<input type="text" class="form-control" id="qty<s:property value="cart_item_id"/>" name="qty<s:property value="cart_item_id"/>" value="<s:property value="cart_quantity"/>"> 
											<span class="input-group-btn">
												<button id="<s:property value="cart_item_id"/>" type="button" class="btn btn-default" type="button" onclick="update('<s:property value="cart_item_id"/>')">Update</button>
											</span>
										</div>
										 --%><%-- <div class="btn-group" role="group">
											<button id="qty<s:property value="cart_item_id"/>" name="qty" class="btn btn-default" type="button" ><s:property value="cart_quantity"/></button>
										 	<button id="update<s:property value="cart_item_id"/>" type="button" class="btn btn-default" type="button" onclick="add('<s:property value="cart_item_id"/>')">Update</button>
										</div> --%>
											<%-- <button id="minus<s:property value="cart_item_id"/>" type="button" onclick="minus('<s:property value="cart_quantity"/>','<s:property value="cart_item_id"/>')" class="btn btn-default">-</button> --%>
											<%-- <button id="add<s:property value="cart_item_id"/>" type="button" onclick="add('<s:property value="cart_quantity"/>','<s:property value="cart_item_id"/>')" class="btn btn-default">+</button> --%>
									</div>
								</td>
								<td class="col-md-3 text-center">
									<i class='fa fa-inr'></i> <s:property value="cart_item_price"/>
								</td>
							</tr>
						</tbody>
					</table>	
				</div>
			</form>
		</s:iterator>	
					</div>
			<form action="payCart" method="post">		
				<h4 class="col-md-4" style="padding-right: 25px;"><strong>Your item(s) will be delivered to this address</strong></h4>
				<hr>
				<div class="col-md-4 form-group">
					<textarea rows="5" class="form-control" name="address" placeholder="Address ..."></textarea>
				</div>
				<div class="col-md-4" style="padding-right: 25px;">
					<button id="proceed" type="submit" style="padding: 30px 0px;" class="btn btn-primary btn-block">Proceed To Pay</button>
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
			  		if(xmlhttp.responseText.length == 18) {
			  			document.getElementById("err"+result).innerHTML="<font color=red>This much quantity not available</font>";
			 			$('#proceed').prop("disabled", "disabled");
		 	 		}	
			 		else
			  			window.location.replace("reviewCart");
			  	}
		  	}
			xmlhttp.open("GET",urls,true);
			xmlhttp.send();
		}
		
		function update(id)
		{
			/* alert('#qty'+id);
			alert($('#qty'+id).val()); */
		
			var urls = "ajax/updateCartItem.jsp?id=" + id + "&qty=" + $('#qty'+id).val();
			ajax(urls, id);
		}
	</script>
</body>
</html>