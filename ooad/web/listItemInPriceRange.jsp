<%@page import="model.Item"%>
<%@page import="action.ItemAction"%>
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
	<link href="css/style.css" rel="stylesheet">
	<link href="owl-carousel/owl.carousel.css" rel="stylesheet">
 	<link href="owl-carousel/owl.theme.css" rel="stylesheet">
	<link href="owl-carousel/owl.transitions.css" rel="stylesheet">
 	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="owl-carousel/owl.carousel.min.js"></script>
	
	<style type="text/css">
	    #owl-demo .item{
	      margin: 3px;
	    }

	    #owl-demo .item img{
	      display: block;
	      width: 100%;
	      height: 200px;
	    }
	</style>

	<script type="text/javascript">
	    $(document).ready(function() {
	     
    		var owl = $("#owl-demo");
	    	
	      	owl.owlCarousel({
	     
	          autoPlay: 300000, //Set AutoPlay to 3 seconds
	     
	          /* items : 3,
	          itemsDesktop : [1199,3],
	          itemsDesktopSmall : [979,3] */
	      
		      items : 3, //10 items above 1000px browser width
		      itemsDesktop : [1000,3], //5 items between 1000px and 901px
		      itemsDesktopSmall : [900,3], // betweem 900px and 601px
		      itemsTablet: [600,2], //2 items between 600 and 0
		      itemsMobile : false, // itemsMobile disabled - inherit from itemsTablet option
		      
		      navigation:true,
		      navigationText: [
		        "<i class='icon-chevron-left icon-white'>Previous</i>",
		        "<i class='icon-chevron-right icon-white'>Next</i>"
		        ],
		 
	      });
	     
	      $(".next").click(function(){
	    	    owl.trigger('owl.next');
    	  })
    	  
    	  $(".prev").click(function(){
    	    	owl.trigger('owl.prev');
    	  })
	    });
	</script>
</head>
<body>
				<nav class="navbar navbar-default">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
     				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
      						data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
			      	</button>
      		</div>

			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      		<ul class="nav navbar-nav">
						<li><h4>Exam 01 OOAD</h4></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h5>Student Name : Rahul Kumar</h5></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h4>&emsp;</h4></li>
				    	<li><h5>Student Roll No : MT2015088</h5></li>
				   	</ul>
				   	<br>
				   	<div class="panel-heading" style="text-align: center;">
		<%
			
			double from = Double.parseDouble(request.getParameter("from"));
			double to = Double.parseDouble(request.getParameter("to"));
			    		
			ItemAction itemAction = new ItemAction();
			ArrayList<Item> items = itemAction.getItemsInRange(from, to);
		
		%>
						
					</div>
					<form action="listItemInPriceRange.jsp" method="get" class="form-horizontal">
  						<div class="panel-body">
							<div class="form-group">
    							<label class="col-sm-3 control-label">Price</label>
    							<div class="col-sm-8">
      							</div>
  							</div>
						  	<div class="form-group">
    							<label class="col-sm-3 control-label">From</label>
    							<div class="col-sm-4">
      								<input type="text" class="form-control" name="from" value="<%=from %>">
								</div>
  							</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">To</label>
						    	<div class="col-sm-4">
							    	<input type="text" class="form-control" name="to" value="<%=to %>">
							   		<span id="err"> </span>
							    </div>
						  	</div>
							<div class="form-group">
							    <label class="col-sm-6 control-label"></label>
						    	<div class="col-sm-4">
							    	<button type="submit" id="submitBtn" class="btn btn-success">Submit</button>
							    </div>
						  	</div>
						</div>
				</form>
				
			  	</div><!-- /.navbar-collapse -->
  			</div><!-- /.container -->
		</nav>
		
		
<div class="row">
	<div class="col-md-2">
	</div>
    <div class="col-md-8">
		<div class="well text-center">
			<h5>Result items with Price Range</h5>
			<h4>From  : <i class="fa fa-inr"></i><%=from %>&emsp;To : <i class="fa fa-inr"></i><%=to %></h4>
			
		</div>
		<div id="owl-demo" class="owl-carousal">
	      	<% 
	      			for(int i = 0; i < items.size(); i++ )
	      			{
	      	%>
	      		 <div class="item">
					<div class="thumbnail">
			 		 	<img src='showPicture.jsp?image=<%=items.get(i).getItemPictureString() %>' class="img-responsive">
	      				<div class="caption">
							<table class="table" style="border-width : 0px; border-top-style: none;">
		    				<tr>
		    					<td>Item ID</td>
		    					<td><strong><%=items.get(i).getItemId() %></strong></td>
		    				</tr>
							<tr>
								<td>Seller ID</td>
								<td><strong><%=items.get(i).getSellerID() %></strong></td>
							</tr>
							<tr>
								<td>Price</td>
								<td><strong><i class="fa fa-inr"></i> <%=items.get(i).getItemPrice() %></strong></td>
							</tr>
							<tr>
								<td>Advertising Item</td>
								<td><strong><%=items.get(i).getItemAdvertisement() %></strong></td>
							</tr>
							<tr class="success">
								<td colspan="2" class="text-right"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-primary" role="button">Buy Now</a></td>
							</tr>
		    				</table>
	      				</div>
					</div>
			 	</div>
 <%
	      			}
 %>		</div>
	</div>
    <div class="col-md-2">
	</div>
    </div>

<br>
<br>

<div class="row text-center">
	<a href="exam.html" class="btn btn-primary">Previous</a>
	<a href="index1" class="btn btn-primary">Home</a>
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
