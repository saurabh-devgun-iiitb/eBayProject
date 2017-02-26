<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
		String itemId = request.getParameter("id");
		System.out.println("verify "+itemId);
        try {
			DBConnection conn = new DBConnection();
            PreparedStatement ps = conn.connect().prepareStatement("DELETE FROM carts WHERE cart_user_id = ? AND cart_item_id = ?");
            ps.setInt(1, Integer.parseInt((String) session.getAttribute("surrogate")));
            ps.setInt(2, Integer.parseInt(itemId));
            System.out.println(ps.toString());
            ps.execute();
            ps.close();
            conn.disconnect();
            response.sendRedirect("getCart");
        }
	    catch(Exception e){
	        e.printStackTrace();
	    }
    
%>