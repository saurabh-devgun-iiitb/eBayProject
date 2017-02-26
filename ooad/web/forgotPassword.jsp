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
	<title>Password Recovery</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	
</head>
<body>	

  <!-- for success modal after a user registers -->
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
						Recover your password
					</div>
					<s:form action="forgotPassword" method="post" class="form-horizontal">
  						<div class="panel-body">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
    							<div >
      								<s:textfield theme="bootstrap" class="form-control" placeholder="Enter your email" name="email"/>
		    					</div>
  							</div>
  							<div class="form-group" style="padding-left:15px; padding-right:15px">
    							An email will be sent to your id , with your password.
  							</div>
						  
						  						
						<div class="">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
					    	<s:submit name="Get Password" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
					    	</div>
						</div>            				
            				</div>
            				<div align="center">
            				<%
            					String result = (String) request.getParameter("success");
            					System.out.println("Result = "+result);
            					if(result.equals("true"))
            					{
            				%>
            				Your password has been sent to your email id. <a href="index.jsp">Click here </a>to continue.
            				<%
            					}
            					else if(result.equals("wrong"))
            					{
            				%>
            				<font color = "red">Email id NOT REGISTERED. Please enter a valid email id.</font>
            				<%
            					}
            				%>
            				
            				
            				</div>
            				<br>
					</s:form>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
</body>
</html>