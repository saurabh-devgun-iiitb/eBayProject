<%@page import="dao.DBConnection"%>
<%@page import="model.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
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
<%! 
// 	public static String toTitleCase(String givenString) {
// 	//	System.out.println("Start " + givenString);
// 	    String[] arr = givenString.split(" ");
// 	    StringBuffer sb = new StringBuffer();
	
// 	    for (int i = 0; i < arr.length; i++) {
// 	        sb.append(Character.toUpperCase(arr[i].charAt(0)))
// 	            .append(arr[i].substring(1)).append(" ");
// 	    }          
// 	  //  System.out.println("End " + givenString);
// 	    return sb.toString().trim();
// 	}
%>

	<%
		int subCategoryId = Integer.parseInt(request.getParameter("subCategoryId"));
		
		ItemAction itemAction = new ItemAction();
		ArrayList<Item> items = itemAction.getItems(subCategoryId);
		String loginCheckForCart;
		if(session.getAttribute("username") == null)
			loginCheckForCart = "false";
		else
			loginCheckForCart = "true";
		
	%>
	<br>
	<br>
	<input type="hidden" id="subCategoryId" value="<%=subCategoryId %>">
	
	<div class="container">
		<div class="row">                  
	 	<div class="col-md-2">
	 		<% 
		
		DBConnection db=new DBConnection();
		String[] value = {"Brand"};	//,"color","weight"};
		String sql = "";
		PreparedStatement ps;
		ResultSet rs;
		for(int i=0; i<value.length; i++) {
			sql = "select distinct item_" + value[i] + " from items";
			System.out.println(sql);
			ps=db.connect().prepareStatement(sql);
			rs=ps.executeQuery();
	%>
			<div id="<%=value[i] %>">
				<h5><%=value[i] %></h5>
				
	<%
			while(rs.next()){
	%>		<ul style="list-style: none;">
			
	<%			
				System.out.println("=="+rs.getString(1)+"--");
				if(rs.getString(1)!=null){
					if(!rs.getString(1).equals("")){
	%>
					<li><input type="checkbox" id="<%=value[i]%>" name="<%=value[i]%>" onclick="fun()" value="<%=rs.getString(1)%>">&emsp;<%=rs.getString(1) %></li>
	<%				}
				}
	%>
<%-- 				else if(rs.getString(1)!=""){
	%>
					<li><input type="checkbox" id="<%=value[i]%>" name="<%=value[i]%>" onclick="fun()" value="<%=rs.getString(1)%>">&emsp;<%=rs.getString(1) %></li>
	<%
				}
	%>
 --%>					</ul>	
	
	<%		
			}
			ps.close();
			rs.close();
			db.disconnect();
			
	%>
			</div>
	<%		
		}	
	%>
		</div>
		<div class="col-md-10">
				<s:iterator>
						
	<%
			int i = 0;
			for(Item item : items) {
				i ++;
				
	%>
						<form action="CartAction" method="post">
	
						<div class="col-sm-6 col-md-4">
							<div class="thumbnail">
								<img alt="image<%=i %>" src="showPicture.jsp?image=<%=item.getItemPictureString() %>" class="img-responsive" width="500px;">
								<div class="caption">
								<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td>
				    						<strong><%=item.getItemId() %></strong>
				    						<input type="hidden" name="itemId" value="<%=item.getItemId() %>"/>
				    						<input type="hidden" name="itemQuantityToPurchase" value="1"/>
			    						</td>
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
										<td><strong><i class="fa fa-inr"></i> <%=item.getItemPrice() %></strong></td>
									</tr>
									<tr>
										<% System.out.println("Discount = "+item.getItemDiscount()); %>
										<td>Discount</td>
										<td><strong><%=item.getItemDiscount() %> %</strong></td>
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
						</form>
						<div class="clearfix visible-md-block"></div>
	<%
			}
	%>				
			</s:iterator>
		</div>
		
		</div>
	</div>
	<div class="container"><!-- 
  <h2>Modal Example</h2>
  Trigger the modal with a button
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>
 -->
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
<script> function fun(){
	
	var arr = [];
	$.each($("input[name='brand']:checked"), function(){            
    //  	alert($(this).val());
		arr.push($(this).val());
    });
	/* alert($('#brand').is(':checked')); */
	window.location.href="listItemBrand.jsp?subCategoryId="+$('#subCategoryId').val()+"&brand="+arr;

}
</script>
</body>
</html>