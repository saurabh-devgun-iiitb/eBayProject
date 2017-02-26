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
	<title>Register</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	
</head>
<body>

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
<div class="modal fade" id="success" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
<%
	if(result.equals("true")) {	
%>
				<div class="modal-header modal-header-success">
<%
	} else if(result.equals("false")) {	
%>
				<div class="modal-header modal-header-danger">
<%		
	}
%>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3>
						<i class="glyphicon glyphicon-thumbs-up"></i> <%=log %>
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
	if(result.equals("true") || result.equals("false")) {	
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
						Register <small>(user)</small>
					</div>
					<s:form action="registerUser" id="userRegisterForm" method="post" class="form-horizontal">
  						<div class="panel-body">
						  	<div class="form-group" style="padding-left:15px; padding-right:15px">
							    <div class="">
							    	<s:textfield id="userId" class="form-control" theme="bootstrap" name="id" placeholder="User Id" onkeyup="verifyUser()"/>
							    	<span id="userErr"> </span>
							    </div>
						  	</div>
							<div class="form-group" style="padding-left:15px; padding-right:15px">
    							<div >
    								<s:textfield id="email" theme="bootstrap" class="form-control" placeholder="Email" name="email" onkeyup="verifyEmail()"/>
    								<span id="emailErr"> </span>
		    					</div>
  							</div>
						  	<div class="form-group" style="padding-left:15px; padding-right:15px">
							    <div class="">
							    	<s:password id="password" class="form-control" theme="bootstrap" name="password" placeholder="Password"/>
							    </div>
  							</div>
  							<div class="form-group">
							    <div class="col-sm-6">
							    	<s:textfield id="fName" class="form-control" theme="bootstrap" name="firstName" placeholder="First Name"/>
							    </div>
							    <div class="col-sm-6">
							    	<s:textfield id="lName" class="form-control" theme="bootstrap" name="lastName" placeholder="Last Name"/>
							    </div>
  							</div>
						</div>
						<div class="">
							<div class="form-group" style="padding-left:30px; padding-right:30px">
					    	<s:submit name="Register" id="userRegistrationButton" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
					    	</div>
						</div>
					</s:form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	
		function validateText(id)
		{	
			if($("#"+id).val() == null || $("#"+id).val() == "")
			{
				var div = $("#"+id).closest("div");
				div.removeClass("has-success");
				div.addClass("has-error has-feedback");
				$("#glypcn"+id).remove();
				div.append('<span id="glypcn'+id+'" class="glyphicon glyphicon-remove form-control-feedback"></span>');
				return false;
			}
			else
			{
				var div = $("#"+id).closest("div");
				$("#glypcn"+id).remove();
				div.removeClass("has-error");
				div.addClass("has-success has-feedback");
				div.append('<span id="glypcn'+id+'" class="glyphicon glyphicon-ok form-control-feedback"></span>');
				return true;
			}
			
		}
		
		$(document).ready(
		
				function()
				{
					$("#userRegistrationButton").click(function()
						{	
							verifyUser();
							verifyEmail();
							if(!validateText("password"))
							{
								return false;
							}
							if(!validateText("fName"))
							{
								return false;
							}
							if(!validateText("lName"))
							{
								return false;
							}
							
							if(!validateText("resUser")) 
							{	
								return false;
							}
							if(!validateText("resEmail")) 
							{
								return false;
							}
							$("form#userRegisterForm").submit();
						});
				}
		);
	</script>
	
	<script type="text/javascript">
		
		function ajax(urls, result)
		{
			var xmlhttp;
			if (window.XMLHttpRequest)
	 	 	{
			  	xmlhttp=new XMLHttpRequest();
		  	}
			else
		  	{
			  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  	}
			xmlhttp.onreadystatechange=function()
		  	{
			  	if (xmlhttp.readyState==4)
		    	{
			  		document.getElementById(result).innerHTML=xmlhttp.responseText;
			  	}
		  	}
			xmlhttp.open("GET",urls,true);
			xmlhttp.send();
		}
		
		function verifyUser()
		{
			var key = document.getElementById("userId").value;
			var urls = "ajax/verifyUser.jsp?userId=" + key;
			
			ajax(urls, "userErr");
		}
		
		function verifyEmail()
		{
			var key = document.getElementById("email").value;
			var urls = "ajax/verifyEmail.jsp?email=" + key;
			
			ajax(urls, "emailErr");
		}
		
	</script>
	
	<script src="js/bootstrap.min.js"></script>


</body>
</html>