<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
</head>
<body>
<%
String usertype = (String) session.getAttribute("usertype");
double vat = 0.0;
if(usertype == null || !usertype.equals("0"))
	response.sendRedirect("index1");
else
{
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT user_id FROM users WHERE user_email = 'admin'");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			vat = Double.parseDouble(rs.getString(1));
	}
	catch(Exception e) {
		
	}
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
						Update VAT
					</div>
					<s:form action="VATAction" id="VATForm" method="post" class="form-horizontal">
					
							<div class="panel-body">
  							<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">Current VAT value</label>
	    							<div class="col-sm-8">
	      								<input type="text" class="form-control" disabled value="<%=vat %> %">
			    						
			    					</div>
	  						</div>
		
								<div class="form-group">
	    							<label for="id" class="col-sm-3 control-label">Enter new VAT %</label>
	    							<div class="col-sm-8">
	      								<s:textfield theme="bootstrap" class="form-control" id="vat" name="vat" placeholder="VAT"/>
			    					</div>
			    					</div>
	  							<div class="">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
					    	<s:submit value="Update" id="VATbutton" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
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
			if($("#"+id).val() == null || $("#"+id).val() == "" || !($("#"+id).val() >=0.0 && $("#"+id).val() <=100.0))
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
					$("#VATbutton").click(function()
						{	
							
							if(!validateText("vat"))
							{
								return false;
							}
							$("form#userRegisterForm").submit();
						});
				}
		);
	</script>

</body>
</html>