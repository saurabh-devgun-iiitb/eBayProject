<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	String result = "";
	if(!request.getParameter("bId").isEmpty())
	{
		int buyersId = Integer.parseInt(request.getParameter("bId"));
		int sellersId = Integer.parseInt(request.getParameter("sId"));
		double money = Double.parseDouble(request.getParameter("m"));
		
		try {
		
			DBConnection conn = new DBConnection();
			
			String sql =  "UPDATE buyers " 
						+ "SET buyer_status = 3 "
						+ "WHERE buyers_id = " + buyersId;
		    
			PreparedStatement ps = conn.connect().prepareStatement(sql);
		    ps.execute();
		    ps.close();
		    conn.disconnect();
		    
		    sql =  "UPDATE users " 
					+ "SET user_balance = user_balance - " + money + " "
					+ "WHERE user_type = 0";
	    
			ps = conn.connect().prepareStatement(sql);
		    ps.execute();
			ps.close();
			conn.disconnect();
			
			sql =  "UPDATE users " 
					+ "SET user_balance = user_balance + " + money + " "
					+ "WHERE users_id = (SELECT seller_id FROM sellers WHERE sellers_id = "  + sellersId + " )";
	    
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