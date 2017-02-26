<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>Sign In</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	
</head>
<body>	

  <!-- for success modal after a user registers -->
  
  
  <%! 
	String log = "";
 %>
<%
	String result = request.getParameter("success");
	
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT log_message FROM logs WHERE logs_id = (SELECT MAX(logs_id) FROM logs)");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			log = rs.getString(1);
		System.out.println("register --------- " + log);
	}
	catch(Exception e) {
		
	}
%>
<%
String reviewOrder = request.getParameter("ro");
System.out.println("Review order in sign in ="+reviewOrder);
String itemId = request.getParameter("id");
String quantity = request.getParameter("qty");
%>
<%
String check = request.getParameter("check");
System.out.println("Check in Sign In ="+check);
if(check != null && check.equals("reviewOrderFailed"))
		{
			reviewOrder = (String) session.getAttribute("reviewOrder");
			itemId = (String) session.getAttribute("itemId");
 			quantity =(String) session.getAttribute("quantity");	
		
		}
%>

<%
String trackOrder = request.getParameter("to");
%>

<div class="modal fade" id="success" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
<%
	if(result != null && result.equals("true")) {	
%>
				<div class="modal-header modal-header-success">
<%
	} else if(result != null && result.equals("false")) {	
%>
				<div class="modal-header modal-header-danger">
<%		
	}
%>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3>
						<i class="glyphicon glyphicon-thumbs-up"></i> <%=log+". Login to continue." %>
					</h3>
				</div>
			</div>
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
<script type="text/javascript">
		
				$(document).ready(function() {
					
<%
	if(result != null && (result.equals("true") || result.equals("false"))) {	
%>
					$("#success").modal('show');
<%
	} else {
%>		
					$("#success").modal('hide');
<%		
	}
%>
				});
</script>
<script src="js/bootstrap.min.js"></script>
		


	
		<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>
		
		<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Sign in
					</div>
					<s:form action="signIn" id="registerForm" method="post" class="form-horizontal">
  						<div class="panel-body">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
    							<div >
      								<s:textfield theme="bootstrap" class="form-control" placeholder="Email" name="email"/>
		    					</div>
  							</div>
						  
						  	<div class="form-group" style="padding-left:15px; padding-right:15px">
							    <div class="">
							    	<s:password class="form-control" theme="bootstrap" name="password" placeholder="Password"/>
							    </div>
  							</div>
  						 	<% if(reviewOrder != null && reviewOrder.equals("true"))
  								{ 
  									System.out.println("Review order is true in signIn");
  							%>		
  									<div class="">
										<div class="form-group" style="padding-left:15px; padding-right:15px">
  											<input type="hidden" name="reviewOrder" value="<%=reviewOrder %>">
  											<input type="hidden" name="itemId" value="<%=itemId %>">
  											<input type="hidden" name="quantity" value="<%=quantity %>">
  										</div>
  									</div>	
  											
  							<%
  										}
  							%>	 
  							<% if(trackOrder != null)
  								{ 
  									System.out.println("Track order is true in signIn");
  							%>		
  									<div class="">
										<div class="form-group" style="padding-left:15px; padding-right:15px">
  											<input type="hidden" name="trackOrder" value="<%=trackOrder %>">
  										</div>
  									</div>	
  											
  							<%
  										}
  							%>	 							
						
						<div class="">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
					    	<s:submit name="Register" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
					    	</div>
						</div>
						 <div class="checkbox pull-left" >
            				<label>
                				<input type="checkbox"> Stay signed in
            				</label>
            				</div>
            				<div class="pull-right">
            				 <a href="forgotPassword.jsp?success=none">Forgot your password?</a>
            				</div>
            				
            				</div>
            			
					</s:form>
				</div>
			</div>
		</div>
	</div>
	<%String seller = request.getParameter("success");
	   System.out.println("sucess in sign in ="+seller);
		if(seller !=null && seller.equals("registered"))
		{
	%>
	<div align="center">
	<font color="green">Seller Registration Successful. Please Sign In to continue.</font>
	</div>
	
	<%
		}
	%>
	
	<%if(check != null && check.equals("reviewOrderFailed"))
	 {
	%>
	<div align="center">
	<font color="red">Invalid email id or password. Please try again !.</font>
	</div>
	<%
		}
	%>
	<%if(trackOrder != null && trackOrder.equals("trackOrderFailed"))
	 {
	%>
	<div align="center">
	<font color="red">Invalid email id or password. Please try again for tracking order !</font>
	</div>
	<%
		}
	%>


</body>
</html>