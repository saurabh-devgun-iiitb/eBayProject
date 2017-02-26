<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
	String result = "";
	if(!request.getParameter("userId").isEmpty())
	{
		String userId = request.getParameter("userId");
        try {
			DBConnection conn = new DBConnection();
            PreparedStatement ps = conn.connect().prepareStatement("SELECT * FROM users WHERE user_id = ?");
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
			{
            	result = "<font color=red>User Id NOT Available</font><input type='hidden' id='resUser' value='' >";
			}
            else
            {
            	result = "<font color=green>User Id Available</font><input type='hidden' id='resUser' value='Valid' >";
            }
            rs.close();
            ps.close();
            conn.disconnect();
        }
	    catch(Exception e){
	        e.printStackTrace();
	    	result = "";
	    }
        out.println(result);
	}
	else
		out.println("");
%>