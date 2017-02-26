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
	
		.header {
		    font-size: 12px;
		    padding-top: 5px;
		}
		
		.item-title {
			/* font-size: 18px; */
			font-weight: bold;
			color: #333;
			line-height: normal;
			margin: 0px;
			padding: 0px;
			font-family: Trebuchet,"Trebuchet MS";
		}
		
		.item-subtitle {
			font-size: 12px;
			color: #777 !important;
			margin: 0px;
			padding: 0px;
			font-weight: normal;
			line-height: normal;
		}
		
		.form-group {
			margin-bottom: 0px;
		}
		
		.form-group > label , .form-group > .buy-option > label {
			font-weight: 100;
			text-align: right;
		}
		
		.form-group > strong , .form-group > .buy-option > strong {
			padding-left: 0px;
		}
		
		.form-group > input {
			padding-left: 5px;
			width: 10%;
		}
		
		.buy-option {
		    background-color: #E2E2E2;
		    margin-left: 20px;
		    margin-right: 20px;
		    padding-top: 20px;
		    margin-top: 10px;
		}
		
		.buy-option > label {
			margin-left: -10px;
		}
		
		.progress {
			margin-bottom: 0px;
		}
	</style>
	
	<script type="text/javascript">
	
		/* $(function(){
		    $("#header").load("header"); 
		});	
		
		$(document).on('mouseenter', '[data-toggle="tab"]', function () {
		  	$(this).tab('show');
		}); */
		
	</script>
</head>
<%-- <%! 
	public static String toTitleCase(String givenString) {
	//	System.out.println("Start " + givenString);
	    String[] arr = givenString.split(" ");
	    StringBuffer sb = new StringBuffer();
	
	    for (int i = 0; i < arr.length; i++) {
	        sb.append(Character.toUpperCase(arr[i].charAt(0)))
	            .append(arr[i].substring(1)).append(" ");
	    }          
	  //  System.out.println("End " + givenString);
	    return sb.toString().trim();
	}
%> --%>
<body>
	<div id="header">
	</div>
	
	<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>
	<%
			String itemId = request.getParameter("itemId");
			ItemAction itemAction = new ItemAction();
			ItemDetails itemDetails = itemAction.getItem(itemId);
			Item item = itemDetails.getItem();
			Seller seller = itemDetails.getSeller();
			int count = seller.getSellerOneStar() + seller.getSellerTwoStar() + seller.getSellerThreeStar() +
					seller.getSellerFourStar() + seller.getSellerFiveStar();		
			if(count ==0)
				count =1;
			
			double avg = (1*seller.getSellerOneStar() + 2*seller.getSellerTwoStar() + 3*seller.getSellerThreeStar() +
						4*seller.getSellerFourStar() + 5*seller.getSellerFiveStar())/count;
			
		//	System.out.print("item id = " + item.getItemWarrantyPeriod());
	%>
		
		<br>
	<div class="container">
		<p>Listed in category : 
			<strong><%=itemDetails.getCategory().getCategoryName() %></strong> 
			&emsp;<i class="fa fa-angle-right"></i>&emsp;
			<%=itemDetails.getSubCategory().getSubCategoryName() %>
		 </p>
	</div>
	<div class="row" style="padding-left: 30px; padding-right: 10px;">	
		<div class="col-md-4 thumbnail">
			<img style="padding: 20px;" src="showPicture.jsp?image=<%=item.getItemPictureString() %>" class="img-responsive">
		</div>
		<div class="col-md-8" style="padding-left: 20px;">
		<form action="CartAction" method="post">
			<input type="hidden" id="itemId" name="itemId" value="<%=item.getItemId() %>">
			<h2 class="item-title"><%=item.getItemName() %></h2>	
			<h2 class="item-subtitle"><%=item.getItemWarrantyPeriod().toUpperCase() %> SELLER WARRANTY</h2>	
			<hr style="margin-top: 10px;">
			<div class="col-md-7">
				<div class="form-horizontal">
					<%	 	if(item.getItemCondition() != null || item.getItemCondition() != "") {
					%>
					<div class="form-group">
						<label class="col-md-3">Item Condition:</label>
						<strong class="col-md-9"><%=(item.getItemCondition()) %></strong>
					</div>
					<%		}
					%>
					<%	 	if(item.getItemDiscount() != 0) {
					%>
					<div class="form-group">
						<label class="col-md-3">Discount:</label>
						<strong class="col-md-9"><%=(item.getItemDiscount()) %> %</strong>
					</div>
					<%		}
					%>
					<div class="form-group">
						<label class="col-md-3">Quantity : </label>
						<input class="col-md-3" id="quantity" name="itemQuantityToPurchase" value="1">
						<label class="col-md-6">
							<%=item.getItemQuantityAvailable() %> available
							&nbsp;/&nbsp;
							<a href="#"><%=item.getItemSold() %> sold</a>
						</label>
					</div>
					<div class="form-group">
						<div class="buy-option">
							<label class="col-md-3">Price : </label>
							<strong class="col-md-3"><i class='fa fa-inr'></i> <%=item.getItemPrice() %></strong>
							<div class="col-md-6">
								<a href="#" onclick="buy()" type="button" class="btn btn-primary">Buy It Now</a>
								<div class="clearfix"></div>
								<br>
								<button type="submit" class="btn btn-primary" >Add To Cart&emsp; 
									<i class="fa fa-shopping-cart"></i>
									<!--  data-toggle="modal" data-target="#myModal"-->
							 	</button>
								  
								<%-- <a href="cart.jsp?id=<%=item.getItemId() %>" type="button" class="btn btn-primary">Add To Cart&emsp; 
									<i class="fa fa-shopping-cart"></i>
								</a> --%>
							</div>
							<div class="clearfix"></div>
							<br>
						</div>
					</div>
					<div class="clearfix"></div>
					<h4><strong style="padding-left: 10px;">Description</strong></h4>
					<%		if(item.getItemBrand().length() > 0 ) {
					%>
					<div class="form-group">
						<label class="col-md-3">Brand  : </label>
						<strong class="col-md-9"><%=(item.getItemBrand()) %></strong>
					</div>
					<%		} 	if(item.getItemColor().length() > 0 ) { 
					%>
					<div class="form-group">
						<label class="col-md-3">Color  : </label>
						<strong class="col-md-9"><%=item.getItemColor() %></strong>
					</div>
					<%		} 	if(item.getItemWeight().length() > 0 ) {
					%>
					<div class="form-group">
						<label class="col-md-3">Weight  : </label>
						<strong class="col-md-9"><%=item.getItemWeight() %></strong>
					</div>
					<%		}
					%>
				<%		if(itemDetails.getAttributeLists() != null) {
							for(AttributeList attributeList: itemDetails.getAttributeLists()) {
				%>
					<div class="form-group">
						<label class="col-md-3"><%=(attributeList.getAttributeKey()) %>  : </label>
						<strong class="col-md-9"><%=(attributeList.getAttributeValue()) %></strong>
					</div>
				<%			}
						}
				%>	
				</div>
			</div>
			<div class="col-md-5 thumbnail">
				<!-- <div class="text-center">
					<h3>Seller Information</h3>
				</div> -->
				<%-- <div class="form-group">
					<label class="col-md-6">Seller ID : </label>
					<strong class="col-md-6"><%=seller.getSellerId() %></strong>
				</div> --%>
				<br>
				<div class="form-group">
					<label class="col-md-6">Seller Name : </label>
					<div class="col-md-6">
						<strong><%=seller.getSellerName() %></strong>
					</div>
				</div>
				<%-- <div class="clearfix"></div>
				<div class="form-group">
					<label class="col-md-6">Contact No : </label>
					<strong class="col-md-6"><%=seller.getSellerContactNo() %></strong>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">
					<label class="col-md-6">Email : </label>
					<strong class="col-md-6"><%=seller.getSellerEmail() %></strong>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">
						<label class="col-md-6">Nature of Business : </label>
					<strong class="col-md-6"><%=seller.getSellerNOB() %></strong>
				</div> --%>
				<div class="clearfix"></div>
				<!-- <hr> -->
				<div class="form-group">
					<label class="col-md-6 control-label">Average Rating :</label>
					<div class="col-md-6">
						<strong><%=String.format("%.2f", avg) %></strong>
						<p>Based on <%=count %> ratings</p>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">	
					<label class="col-md-6 control-label">5 star : </label>
					<div class="col-md-6">
						<div class="progress">
							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=seller.getSellerFiveStar()*100/count %>"
								aria-valuemin="0" aria-valuemax="100"
								style="color: black; width: <%=seller.getSellerFiveStar()*100/count %>%;"><%=seller.getSellerFiveStar() %></div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="form-group" style="margin-top: 0px;">	
					<label class="col-md-6 control-label">4 star : </label>
					<div class="col-md-6">
						<div class="progress">
							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=seller.getSellerFourStar()*100/count %>"
								aria-valuemin="0" aria-valuemax="100"
								style="color: black; width: <%=seller.getSellerFourStar()*100/count %>%;"><%=seller.getSellerFourStar() %></div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">	
					<label class="col-md-6 control-label">3 star : </label>
					<div class="col-md-6">
						<div class="progress">
							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=seller.getSellerThreeStar()*100/count %>"
								aria-valuemin="0" aria-valuemax="100"
								style="color: black; width: <%=seller.getSellerThreeStar()*100/count %>%;"><%=seller.getSellerThreeStar() %></div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">	
					<label class="col-md-6 control-label">2 star : </label>
					<div class="col-md-6">
						<div class="progress">
							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=seller.getSellerTwoStar()*100/count %>"
								aria-valuemin="0" aria-valuemax="100"
								style="color: black; width: <%=seller.getSellerTwoStar()*100/count %>%;"><%=seller.getSellerTwoStar() %></div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="form-group">	
					<label class="col-md-6 control-label">1 star : </label>
					<div class="col-md-6">
						<div class="progress">
							<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=seller.getSellerOneStar()*100/count %>"
								aria-valuemin="0" aria-valuemax="100"
								style="color: black; width: <%=seller.getSellerOneStar()*100/count %>%;"><%=seller.getSellerOneStar() %></div>
						</div>
					</div>
				</div>
			</div>
		</form>
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
	
		function buy() {
			window.location.href = "reviewOrder.jsp?id=" + $('#itemId').val() + "&qty=" + $('#quantity').val();
		}
	</script>
</body>
</html>