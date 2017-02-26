<%-- 
    Document   : login
    Created on : 16 Jun, 2014, 7:36:20 AM
    Author     : Rahul
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.ConnectException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
<%      
		String user = request.getParameter("userName");
        String pwd = request.getParameter("password");
        String itemId = request.getParameter("id");
		int quantity = Integer.parseInt(request.getParameter("qty"));
        String value = request.getParameter("v");
		try  {
                 
			DBConnection conn = new DBConnection();
			
			String sql =  "SELECT * " 
						+ "FROM users "
						+ "WHERE user_email='" + user + "' "
						+ "AND user_password='" + pwd + "'";
		    
    		System.out.println(sql);
            
			PreparedStatement ps = conn.connect().prepareStatement(sql);
		    ResultSet rs = ps.executeQuery();		
		    
		    if(rs.next()) {
		    		
				    session.setAttribute("USERID",rs.getString("user_id"));
                    session.setAttribute("USERTYPE", "" + rs.getInt(6));
				    Cookie ck=new Cookie("USERID","" + rs.getString("user_id"));
                    ck.setMaxAge(100000);
                    response.addCookie(ck);
                    if(rs.getInt("user_type") == 0)
                        response.sendRedirect("admin");
                    else {
                    	if(value.equals("ro")) {
                    		System.out.println("Login Successful");
                    		response.sendRedirect("reviewOrder.jsp?id=" + itemId + "&qty=" + quantity);
                    	}
                    	else if(value.equals("s")) {
                    		if(rs.getInt(6) == 2)
                    			response.sendRedirect("addItemPage");
                    		else
                    			response.sendRedirect("registerSellerPage");
                    	}
                   		else 
                    		response.sendRedirect("home.jsp");
                    	//response.sendRedirect(request.getHeader("referer"));
                    }
                    	
                 }
			
		   }
         catch(Exception e){
             e.printStackTrace();
             response.sendRedirect("login.html");
         }

%>

    </body>
</html>
