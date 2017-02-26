<%@page import="model.Dynamic_User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<script src="js/jquery-ui.min.js"></script>
</head>
<body>

<%
	ArrayList<Dynamic_User> buyer = new ArrayList<Dynamic_User>();
	ArrayList<Dynamic_User> seller = new ArrayList<Dynamic_User>();
	System.out.println("Hello");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT user_id,user_name,user_type FROM users");
		ResultSet rs = ps.executeQuery();
		System.out.println("Hello");
		while(rs.next())
		{		
			System.out.println("In");
			if(rs.getInt(3)==1)
			{
			   buyer.add(new Dynamic_User(rs.getString(1),rs.getString(2)));
			   System.out.println("Buyer Added");
			}
			else
				if(rs.getInt(3)==2)
				{
				   seller.add(new Dynamic_User(rs.getString(1),rs.getString(2)));
				   System.out.println("Seller Added");
				}
				
		}
			
	}
	catch(Exception e) {
		e.printStackTrace();
		
	}
%>

<div class="container">
		<div class="row">
		<div class="col-md-11">
			<div class="well text-center">
				<h4>Report</h4>
			</div>
			<table class="table table-hover">
	    		<thead>	
	    			<tr class="row text-center">
						<td class="col-md-3"><div class="form-control">Buyer ID</div></td>
						<td class="col-md-6"><div class="form-control">Buyer Name</div></td>
					</tr>
				</thead>
				<tbody>
					<% for(Dynamic_User s: buyer)
					{
					%>
						<tr class="row">
							<td class="col-md-3">
								<input  type="text" disabled="disabled" 
										class="form-control text-center" 
										value=<%=s.getId() %>>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value=<%=s.getName() %>>
							</td>
						</tr>
					<%} %>
				</tbody>
	    	</table>
		</div>
	</div>
	</div>
	<br><br>
	<div class="container">
		<div class="row">
		<div class="col-md-11">
			<div class="well text-center">
				<h4>Seller Report</h4>
			</div>
			<table class="table table-hover">
	    		<thead>	
	    			<tr class="row text-center">
						<td class="col-md-3"><div class="form-control">Seller ID</div></td>
						<td class="col-md-6"><div class="form-control">Seller Name</div></td>
					</tr>
				</thead>
				<tbody>
					<% for(Dynamic_User s: seller)
					{
					%>
						<tr class="row">
							<td class="col-md-3">
								<input  type="text" disabled="disabled" 
										class="form-control text-center" 
										value=<%=s.getId() %>>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value=<%=s.getName() %>>
							</td>
						</tr>
					<%} %>
				</tbody>
	    	</table>
		</div>
	</div>
	</div>

</body>
</html>