<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
	String result = "";
	if(!request.getParameter("email").isEmpty())
	{
		String email = request.getParameter("email");
		String oldEmail = (String) session.getAttribute("email");
		//System.out.println("verify "+email);
        try {
			DBConnection conn = new DBConnection();
            PreparedStatement ps = conn.connect().prepareStatement("SELECT * FROM users WHERE user_email = ? AND user_email <> ?");
            ps.setString(1, email);
            ps.setString(2, oldEmail);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
			{
            	//System.out.println("Invalid");
            	result = "<font color=red>This email id is already registered. Try a new one.</font><input type='hidden' id='resEmail1' value='' >";
			}
            else
            {
            	//System.out.println("Valid");
            	result = "<font color=green>Email Id Available</font><input type='hidden' id='resEmail1' value='Valid' >";
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