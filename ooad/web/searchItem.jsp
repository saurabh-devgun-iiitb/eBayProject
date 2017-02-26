<%@page import="java.util.ArrayList"%>
<%@page import="action.ItemAction"%>
<%@page import="model.Item"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String searchText=request.getParameter("searchText");
  String searchCategory=request.getParameter("selectedCategory");
  System.out.println(searchText.equals(""));
  System.out.println(searchText +"              "+searchCategory);
  
  
  ItemAction itemAction = new ItemAction();
  System.out.println("TEst in SeacrhItem1");
	ArrayList<Item> items = itemAction.searchItems(searchText,searchCategory);
	 System.out.println("TEst in SeacrhItem2");
	 String loginCheckForCart;
		if(session.getAttribute("username") == null)
			loginCheckForCart = "false";
		else
			loginCheckForCart = "true";
  %>
  
  <!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>raps.in</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
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
	
	<!-- Back Button -->

	<nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>
	<br>
	<br>
	<div class="container">
		<div class="row">
					<form action="" method="post">
						
	<%
           if(!items.isEmpty()){	
			int i = 0;
			for(Item item : items) {
				i ++;
	%>
						<div class="col-sm-6 col-md-4">
							<div class="thumbnail">
								<img alt="image<%=i %>" src="showPicture.jsp?image=<%=item.getItemPictureString() %>" class="img-responsive" width="500px;">
								<div class="caption">
								<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td>
				    						<strong><%=item.getItemId() %></strong></td>
				    				</tr>
									<tr>
										<td>Name</td>
										<td><strong><a href="item.jsp?itemId=<%=item.getItemId() %>"><%=item.getItemName() %></a></strong></td>
									</tr>
									<tr>
										<td>Desc</td>
										<td><strong><%=item.getItemDescription() %></strong></td>
									</tr>
									<tr>
										<td>Price</td>
										<td><strong>$ <%=item.getItemPrice() %></strong></td>
									</tr>
									<tr class="success">
										<td class="text-right">
											<a href="reviewOrder.jsp?id=<%=item.getItemId() %>&qty=1" class="btn btn-primary" role="button">Buy Now</a>
										</td>
										<% if(loginCheckForCart.equals("true")){ %>
										<td class="text-right">
											<button type="submit" class="btn btn-default" role="button">Add to Cart</button>
										</td>
										<%} %>
									</tr>
			    				</table>
								</div>
							</div>
						</div>
						<div class="clearfix visible-md-block"></div>
	<%
			}
           }
           else{
        	   %>
        	   <p class="bg-danger">No Match Found......!!!!!</p>
        	   
        	   <%
           }
	%>				</form>
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
	<script>
function siteUnderConstructionFunction() {
    alert("Site is Under Construction..!");
}
</script>
<script src="js/bootstrap.min.js"></script>   


</body>
</html>