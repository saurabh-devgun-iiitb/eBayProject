<%@page import="java.util.Enumeration"%>
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
	<script type="text/javascript">
		$(function(){
		    $("#header").load("header"); 
		});	
	</script>
</head>
<body>
<%! String val = ""; %>
	<div id="header">
	</div>
	<nav class="nav navbar-default" style="border-bottom: 1px solid #CBCCCA;">
		<div class="container header">
			<ul class="navbar-left header-nav" style="margin-bottom: 5px;">
				<li><a href="#">Sign in</a></li>
				<li><a href="#">Register</a></li>
				<li><a href="#">Deals </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal">Sell </a></li>
				<li><a href="#">Track My Order</a></li>
			</ul>
			<ul class="navbar-right header-nav" style="margin-bottom: 5px;">
				<li><a href="#" data-toggle="modal" data-target="#myModal">My eBay </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal"> My PaisaPay </a></li>
				<li><a href="#"><i class="fa fa-bell"></i> </a></li>
				<li><a href="#"><i class="fa fa-search"></i></a></li>
				<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
			</ul>
		</div>
	</nav>
	<!-- Back Button -->

	<nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>


	<%
		int subCategoryId = Integer.parseInt(request.getParameter("subCategoryId"));
		String res = "";
		int c = 0;
		String[] brands = request.getParameterValues("brand");
		for(int i=0; i<brands.length; i++) {
			System.out.println(brands[i]);
			if(i == 0)
				res += "item_brand='" + brands[i] + "'";
			else
				res += " OR item_brand='" + brands[i] + "'";
		}
	%>
	<br>
	<br>
		<input type="hidden" id="subCategoryId" value="<%=subCategoryId %>">
	
	
	<div class="container">
		<div class="row">                  
	 	<div class="col-md-2">
	 		<!-- <button type="button" onclick="fun()">Submit</button> -->
	 		<% 
		try{
		DBConnection db=new DBConnection();
		String[] value = {"brand"};	//,"color","weight"};
		String sql = "";
		PreparedStatement ps;
		ResultSet rs;
		for(int i=0; i<value.length; i++) {
			sql = "select item_" + value[i] + " from items";
			System.out.println(sql);
			ps=db.connect().prepareStatement(sql);
			rs=ps.executeQuery();
	%>
			<div id="<%=value[i] %>">
				<h5><%=value[i] %></h5>
					<ul style="list-style: none;">
	<%
			while(rs.next()){
				boolean flag = false;
				for(String brand: brands) {
//					System.out.println(rs.getString(1)+" ---- "+brand);
					
					if(rs.getString(1)!=null){
						if(!rs.getString(1).equals("") && rs.getString(1).equalsIgnoreCase(brand))
						{
							flag = true;
							break;
						}
						else 
							flag = false;
					}
				}
				if(flag == true) {
		%>	
					<li><input type="checkbox" name="<%=value[i]%>" checked="checked" onclick="fun()" value="<%=rs.getString(1)%>">&emsp;<%=rs.getString(1)%></li>
							
		<%		} else if(flag == false && rs.getString(1) != null && !rs.getString(1).equals("")) { %>
					<li><input type="checkbox" name="<%=value[i]%>" onclick="fun()" value="<%=rs.getString(1)%>">&emsp;<%=rs.getString(1)%></li>
		<%			
				}
			}
		%>				</ul>	

	<%	
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
				
					<form action="" method="post">
						
	<%
	

		DBConnection ds=new DBConnection();
		String _sql="SELECT * from items WHERE item_subcat_id=" + subCategoryId + " AND (" + res + ") AND item_quantity_available > 0";
		System.out.println(_sql);
		PreparedStatement _ps=ds.connect().prepareStatement(_sql);
		rs=_ps.executeQuery();
	
		int i = 0;
			ArrayList<Item> items= new ArrayList();
			while(rs.next()){
				Item item=new Item();
				item.setItemId(rs.getString("item_id"));
				item.setItemName(rs.getString("item_name"));
				item.setItemDescription(rs.getString("item_desc"));
				item.setItemPrice(rs.getInt("item_price"));
				item.setItemPictureString(rs.getString("item_picture"));
			
				items.add(item);
			}
			
			
			
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
										<td><strong><i class="fa fa-inr"></i> <%=item.getItemPrice() %></strong></td>
									</tr>
									<tr>
										<td>Discount</td>
										<td><strong><%=item.getItemDiscount() %> %</strong></td>
									</tr>
									<tr class="success">
										<td class="text-right">
											<a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-success" role="button">Buy Now</a>
										</td>
										<td class="text-right">
											<a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-default" role="button">Add to Cart</a>
										</td>
									</tr>
			    				</table>
								</div>
							</div>
						</div>
						<div class="clearfix visible-md-block"></div>
	<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>				</form>
			
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
<script> 

var res = "";
var c = 0;

	function fun(){
	
		$.each($("input[name='brand']:checked"), function(){            
			//alert($(this).val());
			res += "&brand=" + $(this).val();
	    });
		if(res == "")
			window.location.href="listItem.jsp?subCategoryId="+$('#subCategoryId').val();
		else
			window.location.href="listItemBrand.jsp?subCategoryId="+$('#subCategoryId').val()+res;
	
}
	
</script>
</body>
</html>