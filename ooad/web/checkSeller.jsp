<%@page import="dao.implementaion.UserDAOImplementation"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%

	String userId = (String) session.getAttribute("userid");
    if (userId != null ) { 
       System.out.println("user != null");
       
    }
 	else    {
       System.out.println("user == null");
    }

    User user = new UserDAOImplementation().getUser(userId);

	if(user.getUserType() == 1) { 
		
	}
	else {
		
	}
		


%>