<%@page import="model.finalExam01"%>
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
	ArrayList<finalExam01> result = new ArrayList<finalExam01>();
	Double weight = Double.parseDouble(request.getParameter("weight"));
	System.out.println("Hello");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT items_id,item_id FROM items WHERE item_weight >= "+weight+" AND is_deal_item = 1");
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			
			DBConnection dbConnection2 = new DBConnection();
			PreparedStatement ps2 = dbConnection2.connect().prepareStatement("SELECT * FROM deals WHERE deal_item_one = "+rs.getInt(1)+" OR "+"deal_item_two = "+rs.getInt(1)+" OR "+"deal_item_free = "+rs.getInt(1));
			ResultSet rs2 = ps2.executeQuery();
			
			if(rs2.next())
					{
						DBConnection dbConnection3 = new DBConnection();
						PreparedStatement ps3 = dbConnection3.connect().prepareStatement("SELECT item_id FROM items WHERE items_id = "+rs2.getInt(4));
						ResultSet rs3 = ps3.executeQuery();	
						if(rs3.next())
						{
							result.add(new finalExam01(rs.getString(2),rs2.getString(1),rs3.getString(1)));
						}
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
				<h4>Final Exam 01 Report</h4>
			</div>
			<table class="table table-hover">
	    		<thead>	
	    			<tr class="row text-center">
						<td class="col-md-3"><div class="form-control">Item Id</div></td>
						<td class="col-md-6"><div class="form-control">Deal Item Id</div></td>
						<td class="col-md-6"><div class="form-control">Free Item Id</div></td>
					</tr>
				</thead>
				<tbody>
					<% for(finalExam01 s: result)
					{
					%>
						<tr class="row">
							<td class="col-md-3">
								<input  type="text" disabled="disabled" 
										class="form-control text-center" 
										value=<%=s.getItem_id() %>>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value=<%=s.getDeal_id() %>>
							</td>
							<td class="col-md-6">
								<input  type="text" disabled="disabled" 
										class="form-control" 
										value=<%=s.getFree_item_id() %>>
							</td>
						</tr>
					<%} %>
				</tbody>
	    	</table>
		</div>
	</div>
	</div>