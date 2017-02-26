<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    		
<div class="carousel slide" id="myCarousel">
	<div class="carousel-inner">
<%
	try {
		
		Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.parse(sdf.format(date));
        
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT * FROM items WHERE item_adv = 1 AND item_advertisement_from <= ? AND item_advertisement_to >= ? AND item_quantity_available > 0");
		ps.setDate(1, new java.sql.Date(date.getTime()));
		ps.setDate(2, new java.sql.Date(date.getTime()));
		ResultSet rs = ps.executeQuery();
		ArrayList<String> itemId = new ArrayList<String>();
		ArrayList<String> itemName = new ArrayList<String>();
		ArrayList<String> itemDesc = new ArrayList<String>();
		ArrayList<Double> itemPrice = new ArrayList<Double>();
		ArrayList<String> itemImage = new ArrayList<String>();
		ArrayList<String> itemSeller = new ArrayList<String>();
		ArrayList<Double> itemDiscount = new ArrayList<Double>();
		
		int c1 = 0, c2 = 0 ;

		while(rs.next()) {
			
			itemId.add(rs.getString("item_id"));
			itemName.add(rs.getString("item_name"));
			itemPrice.add(rs.getDouble("item_price"));
			itemImage.add(rs.getString("item_picture"));
			itemDesc.add(rs.getString("item_desc"));
			itemSeller.add(rs.getString("item_seller_id"));
			itemDiscount.add(rs.getDouble("item_discount"));
			
			if(c2 % 3 == 0) {

				if(c1 == 0) {
					
%>
				<div class="item active">
					<ul class="thumbnails" style="list-style-type: none;">
<%
				}
				if(c1 != 0) {
				
%>
					</ul>
				</div>
				<div class="item">
					<ul class="thumbnails" style="list-style-type: none;">                
<%				
				}
			
				
				c1 ++;
%>
						<li class="col-md-4">
		                        <div class="thumbnail">
		                        	<a data-toggle="modal" data-target="#myModal<%=rs.getString(2) %>"><img src="showPicture.jsp?image=<%=rs.getString(6) %>" class="img-responsive"></a>
		                        </div>
			      				<div class="caption">
									<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td><strong><%=rs.getString(2) %></strong></td>
				    				</tr>
									<tr>
										<td>NAME</td>
										<td><strong><a href="item.jsp?itemId=<%=rs.getString(2) %>"><%=rs.getString(3) %></a></strong></td>
									</tr>
									<tr>
										<td>PRICE</td>
										<td><strong><i class='fa fa-inr'></i> <%=rs.getDouble(5) %></strong></td>
									</tr>
									<tr>
										<td>DISCOUNT</td>
										<td><strong><%=rs.getDouble("item_discount") %> %</strong></td>
									</tr>
									<tr class="success">
										<td colspan="2" class="text-right"><a href="reviewOrder.jsp?id=<%=rs.getString(2) %>&qty=1" class="btn btn-primary" role="button">Buy Now</a></td>
									</tr>
			    					</table>
			    				</div>
		                    </li>
<%				
			}
				
			
			if(c2 % 3 != 0) {
			
%>
		                    <li class="col-md-4">
		                        <div class="thumbnail">
		                        	<a data-toggle="modal" data-target="#myModal<%=rs.getString(2) %>"><img src="showPicture.jsp?image=<%=rs.getString(6) %>" class="img-responsive"></a>
		                        </div>
			      				<div class="caption">
									<table class="table" style="border-width : 0px; border-top-style: none;">
				    				<tr>
				    					<td>ID</td>
				    					<td><strong><%=rs.getString(2) %></strong></td>
				    				</tr>
									<tr>
										<td>NAME</td>
										<td><strong><a href="item.jsp?itemId=<%=rs.getString(2) %>"><%=rs.getString(3) %></a></strong></td>
									</tr>
									<tr>
										<td>Price</td>
										<td><strong><i class='fa fa-inr'></i> <%=rs.getDouble(5) %></strong></td>
									</tr>
									<tr>
										<td>DISCOUNT</td>
										<td><strong></i> <%=rs.getDouble("item_discount") %> %</strong></td>
									</tr>
									<tr class="success">
										<td colspan="2" class="text-right"><a href="reviewOrder.jsp?id=<%=rs.getString(2) %>&qty=1" class="btn btn-primary" role="button">Buy Now</a></td>
									</tr>
			    					</table>
			    				</div>
		                    </li>
				
<%				

			}
			c2 ++;
			
		}
%>
		                </ul>
		          </div>
		        </div>
		       <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
		    </div>
<%

		for(int i = 0; i < itemId.size(); i ++ ) {
	
%>		
			<div class="modal fade" id="myModal<%=itemId.get(i) %>" tabindex="-1" role="dialog">
				<div class="modal-dialog modal-lg">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4><%=itemName.get(i) %></h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<img src="showPicture.jsp?image=<%=itemImage.get(i) %>" class="img-responsive">		
								</div>
								<div class="col-md-6">
									<table class="table" style="border-width : 0px; border-top-style: none;">
					    				<tr>
					    					<td>ID</td>
					    					<td><strong><%=itemId.get(i) %></strong></td>
					    				</tr>
										<tr>
											<td>Name</td>
											<td><strong><a href="item.jsp?itemId=<%=itemId.get(i) %>"><%=itemName.get(i) %></a></strong></td>
										</tr>
										<tr>
											<td>Description</td>
											<td><strong><%=itemDesc.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Seller Name</td>
											<td><strong><%=itemSeller.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Price</td>
											<td><strong><i class='fa fa-inr'></i> <%=itemPrice.get(i) %></strong></td>
										</tr>
										<tr>
											<td>Discount</td>
											<td><strong> <%=itemDiscount.get(i) %> %</strong></td>
										</tr>
										<tr class="success">
											<td colspan="2" class="text-right"><a href="reviewOrder.jsp?id=<%=itemId.get(i) %>&qty=1" class="btn btn-primary" role="button">Buy Now</a></td>
										</tr>
				    				</table>	
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>	

<script type="text/javascript">
	
		function buy() {
			window.location.href = "reviewOrder.jsp?id=" + $('#itemId').val() + "&qty=1";
		}
	
	</script>
    