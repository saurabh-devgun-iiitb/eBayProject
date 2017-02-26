<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@page import="model.Seller"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Account Management</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>

<%! 
	String log = "";
 %>
<%
	String result = request.getParameter("success");
	System.out.println("Result ="+result);
	
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT log_message FROM logs WHERE logs_id = (SELECT MAX(logs_id) FROM logs)");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			log = rs.getString(1);
		System.out.println("User Update --------- " + log);
		ps.close();
	}
	catch(Exception e) {
		System.out.println("Got an exception "+e);
	}
%>
	<div class="modal fade" id="success" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
<%
	if(result.equals("true")) {	System.out.println("hi");
%>
				<div class="modal-header modal-header-success">
<%
	} else if(result.equals("false")) {	
%>
				<div class="modal-header modal-header-danger">
<%		
	}
%>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3>
						<i class="glyphicon glyphicon-thumbs-up"></i> <%=log %>
					</h3>
				</div>
			</div>
		</div>
		<!-- /.modal-dialog -->
	</div>
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

<%
Seller seller = new Seller();
String email = (String) session.getAttribute("email");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT * FROM users,sellers WHERE user_email = ? AND (users.users_id = sellers.seller_id)");
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{	
			seller.setSurrogateSellerId(rs.getInt(1));
			seller.setSellerId(rs.getString(2));
			seller.setSellerName(rs.getString(3));
			seller.setSellerEmail(rs.getString(4));
			seller.setSellerPassword(rs.getString(5));	
			seller.setSellerAddress(rs.getString(11));
			seller.setSellerContactNo(rs.getString(12));
			
			
		}
		ps.close();
	}
	catch(Exception e) {
		System.out.println("Got an exception "+e);
		
	}

%>
<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>
		<br><br><br>

	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Update Account
					</div>
					<s:form action="SellerAccountUpdate" id="UserAccountUpdateForm" method="post" class="form-horizontal">
					
							<div class="panel-body">
  							<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">User Id</label>
	    							<div class="col-sm-8">
	      								<input type="text" class="form-control" disabled value="<%=seller.getSellerId() %> "/>
			    						
			    					</div>
	  						</div>
	  						<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">User Name</label>
	    							<div class="col-sm-8">
	      								<input type="text" id="sellerName" name="sellerName" class="form-control" value="<%=seller.getSellerName() %> "/>
			    						
			    					</div>
	  						</div>
	  						<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">User Email</label>
	    							<div class="col-sm-8">
	      								<input type="text" id="sellerEmail" name="sellerEmail" class="form-control" value="<%=seller.getSellerEmail() %>" onkeyup="verifyEmail()"/>
	      								<span id="emailErr"> </span>
			    						
			    					</div>
	  						</div>
	  						<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">User Password</label>
	    							<div class="col-sm-8">
	      								<input type="text" id="sellerPassword" name="sellerPassword" class="form-control" value="<%=seller.getSellerPassword() %> "/>
			    						
			    					</div>
	  						</div>
	  						<div class="form-group">
								    <label for="address" class="col-sm-3 control-label">Seller Address</label>
							    	<div class="col-sm-8">
								          <input type="text" class="form-control" id="sellerAddress" name="sellerAddress" value="<%=seller.getSellerAddress()%>"/>
								    </div>
	  							</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Contact No</label>
							    	<div class="col-sm-8">
								    	<input type="text" class="form-control" id="sellerContactNo" name="sellerContactNo" maxlength="9" value="<%=seller.getSellerContactNo() %>">
								    </div>
							  	</div>
	  						<div>	
	  								<input type="hidden" name="sellerId" value="<%=seller.getSellerId() %>"/>
	  								<input type="hidden" name="surrogateSellerId" value="<%=seller.getSurrogateSellerId() %>"/>
								  						
	  						</div>
	  							<div class="">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
					    	<s:submit value="Update" id="Accountbutton" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
					    	</div>
					    	<div>
					    	<a href="deleteSeller.jsp">Click here</a> to delete your account.
					    	</div>
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
			console.log(id + " value=" + $("#"+id).val());
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
		
		var flag = false;
		
		$(document).ready(
		
				function()
				{
					$("#Accountbutton").click(function()
						{	
							
							verifyEmail();
							$("form#UserAccountUpdateForm").submit();
							
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
					//console.log("Hello response");
			  		document.getElementById(result).innerHTML=xmlhttp.responseText;
			  		if(!validateText("sellerName"))
					{
						return false;
					}
					if(!validateText("sellerEmail"))
					{
						return false;
					}
					if(!validateText("sellerPassword"))
					{
						return false;
					}
					if(!validateText("sellerAddress")) 
					{
						return false;
					}
					if(!validateText("sellerContactNo")) 
					{
						return false;
					}
					if(!validateText("resEmail1")) 
					{
						return false;
					}
					
					
			
			  	}
		  	}
			xmlhttp.open("GET",urls,true);
			xmlhttp.send();
		}
		
		function verifyEmail()
		{
			var key = document.getElementById("sellerEmail").value;
			var urls = "ajax/verifyEmailUpdate.jsp?email=" + key;
			
			ajax(urls, "emailErr");
			
		}
		
	</script>
	
	

</body>
</html>