<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	String result = "";
	if(!request.getParameter("r").isEmpty())
	{
		int rating = Integer.parseInt(request.getParameter("r"));
		int itemId = Integer.parseInt(request.getParameter("iid"));
		int sellersId = Integer.parseInt(request.getParameter("sId"));
		
		try {
		
			DBConnection conn = new DBConnection();
			
			String sql = "";
			String star = "";
			
			switch(rating) {
			case 1 :	star = "seller_one_star";
			break;
			case 2 :	star = "seller_two_star";
			break;
			case 3 :	star = "seller_three_star";
			break;
			case 4 :	star = "seller_four_star";
			break;
			case 5 :	star = "seller_five_star";
			break;
			
			}
			 
			sql = "SELECT " + star + " FROM sellers WHERE sellers_id=" + sellersId;
			
			PreparedStatement ps = conn.connect().prepareStatement(sql);
		    ResultSet rs = ps.executeQuery();
		    if(rs.next()) {
		    	rating = rs.getInt(1);
		    }
		    ps.close();
		    conn.disconnect();
		    
		    rating ++;
		    
		    sql =  "UPDATE sellers " 
					+ "SET " + star + " = " + rating + " "
					+ "WHERE sellers_id = " + sellersId;
	    
			ps = conn.connect().prepareStatement(sql);
		    ps.execute();
			ps.close();
			conn.disconnect();
			sql =  "UPDATE buyers " 
					+ "SET is_seller_rated = 1 "
					+ "WHERE buyer_seller_id = (SELECT seller_id FROM sellers WHERE sellers_id = " + sellersId + ") AND buyer_item_id = " + itemId;
	    
			ps = conn.connect().prepareStatement(sql);
		    ps.execute();
			ps.close();
			conn.disconnect();
				
		    response.sendRedirect("trackOrder.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
%>