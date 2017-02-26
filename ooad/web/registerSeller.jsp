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
	<title>Register Seller</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<%-- <script type="text/javascript">
		$(function(){
		    $("#header").load("header");
		});	
		$(document).on('mouseenter', '[data-toggle="tab"]', function () {
		  	$(this).tab('show');
		});
	</script> --%>
</head>
<body>
<%-- <%! 
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
	
	<div id="header">
	</div>
	<br>
	<br> --%>
	<!-- <nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
		</ul>
	</nav> -->
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
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Register As A Seller
					</div>
					<form action="registerSeller" id="registerForm" method="post" class="form-horizontal">
						<div class="panel-body">
  					<%
  							if(session.getAttribute("userid") == null) {		
					%>			<div class="form-group">
									<label for="regUser" class="col-sm-3 control-label">Registered User</label>
	  								<div class="col-md-8">
										<select id="regUser" class="form-control" onchange="show()">
											<option value="0">None</option>
											<option value="1">Yes</option>
											<option value="2">No</option>
										</select>
	  								</div>
	  							</div>
	  							<div id="user" class="hidden">
									<div class="text-center">
		  								<a href="signIn.jsp?success=none">Sign In</a>	first and then register as a seller
		  							</div>
					<%
							}
							else {
					%>
								<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">Seller Id</label>
	    							<div class="col-sm-8">
	      								<input type="text" class="form-control" disabled value="<%=session.getAttribute("userid") %>">
			    						<input type="hidden" class="form-control" name="userId" value="<%=session.getAttribute("userid") %>">
			    					</div>
	  							</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Seller Email</label>
							    	<div class="col-sm-8">
								    	<input type="text" class="form-control" disabled value="<%=session.getAttribute("email") %>">
								    	<input type="hidden" class="form-control" name="userEmail" value="<%=session.getAttribute("email") %>">
								    </div>
							  	</div>
							  	<div class="form-group">
								    <label for="name" class="col-sm-3 control-label">Seller Name</label>
							    	<div class="col-sm-8">
								    	<input type="text" class="form-control" disabled value="<%=session.getAttribute("username") %>">
								    	<input type="hidden" class="form-control" name="userName" value="<%=session.getAttribute("username") %>">
								    </div>
							  	</div>
					<%
							}
					%>
							</div>									<!-- user -->
  					
  							<div id="seller" class="hidden">
								<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">Seller Id</label>
	    							<div class="col-sm-8">
	      								<input type="text" class="form-control" id="sellerId" name="sellerId" placeholder="Seller ID" onkeyup="verifySeller()">
										<span id="err"> </span>
			    					</div>
	  							</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Seller Email</label>
							    	<div class="col-sm-8">
								    	<input type="email" class="form-control" id="sellerEmail" name="sellerEmail" placeholder="example@abc.com" onkeyup="verifyEmail()">
								    	<span id="emailErr"> </span>
								    </div>
							  	</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Seller Password</label>
							    	<div class="col-sm-8">
								    	<input type="password" class="form-control" id="sellerPassword" name="sellerPassword" placeholder="">
								    </div>
							  	</div>
							  	<div class="form-group">
								    <label for="name" class="col-sm-3 control-label">Seller Name</label>
							    	<div class="col-sm-8">
								    	<input type="text" class="form-control" id="sellerName" name="sellerName" placeholder="Seller Name">
								    </div>
							  	</div>
							</div>									<!-- seller -->
						<%
							if(session.getAttribute("userid") == null) {
						%>		<div id="other" class="hidden">
						<%	}
							else {
						%>		<div id="other">
						<%	}
						%>		
								<div class="form-group">
								    <label for="address" class="col-sm-3 control-label">Seller Address</label>
							    	<div class="col-sm-8">
								          <textarea rows="5" class="form-control" id="sellerAddress" name="sellerAddress"></textarea>
								    </div>
	  							</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Contact No</label>
							    	<div class="col-sm-8">
								    	<input type="text" class="form-control" id="sellerContactNo" name="sellerContactNo" maxlength="9">
								    </div>
							  	</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Nature of Business</label>
							    	<div class="col-sm-8">
								    	<select class="form-control" id="sellerNOB" name="sellerNOB">
								    		<option value="1">Whole Sale</option>
								    		<option value="2">Old</option>
							    		</select>
								    </div>
							  	</div>
							  	<div class="form-group">
								    <label class="col-sm-3 control-label">Seller Category</label>
							    	<div class="col-sm-8">
							    		<select class="form-control" id="sellerCategoryId" name="sellerCategoryId">
							    			<option value="0">None</option>
							    			<s:iterator>
							    				<option value='<s:property value="categoryId"/>'><s:property value="categoryName"/></option>
							    			</s:iterator>
							    		</select>
								    </div>
							  	</div>
							</div>
		  				
		  			<%
			  			if(session.getAttribute("userid") != null &&
			  					Integer.parseInt((String) session.getAttribute("usertype")) == 1) {
			  		%>		
  						<div id="regBtn" class="panel-footer">
			  		<%
		  				}
			  			else {
			  		%>
			  			<div id="regBtn" class="panel-footer hidden">
			  		<%		
			  			}
		  			%>	
							<div class="row">
								<div class="col-md-11">
									<div class="pull-right">
										<button type="submit" id="registerBtn" class="btn btn-success">Register</button>
									</div>
								</div>
								<div class="col-md-1">
								</div>
							</div>
						</div>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">404 Not Found</h4>
        </div>
        <div class="modal-body">
          <p>Site Under Construction..!!</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
    </div>

	<script>
		
		function show() {
			if($('#regUser').val() == 1) {
				$('#user').removeClass("hidden");
				$('#seller').addClass("hidden");
				$('#other').addClass("hidden");
				$('#regBtn').addClass("hidden");
			}
			else if($('#regUser').val() == 2) {
				$('#user').addClass("hidden");
				$('#seller').removeClass("hidden");
				$('#other').removeClass("hidden");
				$('#regBtn').removeClass("hidden");
			}
			else {
				$('#user').addClass("hidden");
				$('#seller').addClass("hidden");
				$('#other').addClass("hidden");
			}	
		}
	
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
					$("#registerBtn").click(function()
						{
							verifySeller();
							verifyEmail();
							if(!validateText("sellerId") )
							{
								return false;
							}	
							if(!validateText("sellerName"))
							{
								return false;
							}
							if(!validateText("sellerAddress"))
							{
								return false;
							}
							if(!validateText("res")) 
							{
								return false;
							}
							if(!validateText("resEmail")) 
							{
								return false;
							}
							$("form#registerForm").submit();
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
		
		function verifySeller()
		{
			var key = document.getElementById("sellerId").value;
			var urls = "ajax/verifySeller.jsp?sellerId=" + key;
			
			ajax(urls, "err");
		}
		
		function verifyEmail()
		{
			var key = document.getElementById("sellerEmail").value;
			var urls = "ajax/verifyEmail.jsp?email=" + key;
			
			ajax(urls, "emailErr");
		}
		
	</script>
	
	<script src="js/bootstrap.min.js"></script>

</body>
</html>