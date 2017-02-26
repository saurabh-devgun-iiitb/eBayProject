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
		
		try {
		
			DBConnection conn = new DBConnection();
			
			String sql =  "UPDATE buyers " 
						+ "SET buyer_status = 2 "
						+ "WHERE buyers_id = " + buyersId;
		    
			PreparedStatement ps = conn.connect().prepareStatement(sql);
		    ps.execute();
		    ps.close();
		    conn.disconnect();
		    	
		    response.sendRedirect("sellerTrackOrder.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
%>