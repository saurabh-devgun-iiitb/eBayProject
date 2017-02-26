<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scaling=1.0">
<title>raps.in</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="fa/css/font-awesome.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<style type="text/css">
.header {
	font-size: 12px;
	padding-top: 5px;
}

.thumbnail {
	width: 260px;
	height: 180px;
	overflow: hidden; /* contain images within thumbnail boundaries */
	border: 0; /* removes Bootstrap's default border */
	box-shadow: 0 12px 12px -10px #c4c4c4;
	-webkit-box-shadow: 0 17px 22px -20px #c4c4c4;
	-moz-box-shadow: 0 12px 12px -10px #c4c4c4;
}

.thumbnail img {
	width: 100%;
	height: auto;
} /* to keep proportions */
.thumbnails p {
	text-align: center;
	padding: 10px;
} /* captions can be styled with an inline element */
</style>
<script type="text/javascript">
	$(function() {
		$("#header").load("header");
		$('[data-toggle="tooltip"]').tooltip();
	});

	$(document).ready(function() {
		$('.carousel').carousel();
	});
</script>
</head>
<body>
<%!String log=""; %>
<%
	String result = request.getParameter("success");
	String userid = (String) session.getAttribute("userid");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT log_message FROM logs WHERE logs_id = (SELECT MAX(logs_id) FROM logs)");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			log = rs.getString(1);
		System.out.println("Add Deal result=" + result + "--------- " + log);
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
	
	<div id="header"></div>
<% 	 	
				String usertype = "3";
				if((String) session.getAttribute("usertype") != null)
					usertype = (String) session.getAttribute("usertype");
	%>
	<div id="header">
	</div>
	
	<nav class="nav navbar-default" style="border-bottom: 1px solid #CBCCCA;">
		<div class="container header">
			<ul class="navbar-left header-nav" style="margin-bottom: 5px;">
			<%if(usertype.equals("1")){ %>
				<li>Welcome ,<a href="userAccount.jsp?success=none"> <s:property value="#session.username"/> </a>!</li>
			<%} else
				%>
			<%if(usertype.equals("2")){ %>
				<li>Welcome ,<a href="sellerAccount.jsp?success=none"> <s:property value="#session.username"/> </a>!</li>
			<%}%>
		 <%	        
				if (userid != null ) { 
	            	System.out.println("user != null");
	            	if( usertype == "1" || usertype == "2") {
	     %>
	     				<li><a href="registerPage2">Register</a></li>
	     <%			}
				}
	       %>
				
				<li><a href="#" data-toggle="modal" data-target="#myModal">Deals </a></li>
		<%	        
				if (userid != null ) { 
	            	System.out.println("user != null");
	            	if( usertype == "1") {
	     %>
	     				<li><a href="registerSellerPage">Sell</a></li>
	     <%			}
	            	else if( usertype == "2") {
	     %>
	     				<li><a href="addItemPage">Sell</a></li>
	     <%   		}
	     	}
	     	else    {
	            System.out.println("user == null");
	      %>
						<li><a href="loginPage.jsp?v=s">Sell</a></li>
	      <%      
	        }
    %>			<!-- <li><a href="#">Sell </a></li> -->
				<li><a href="trackOrder.jsp">Track My Order</a></li>
			</ul>
			<ul class="navbar-right header-nav" style="margin-bottom: 5px;">
				<li><a href="#" data-toggle="modal" data-target="#myModal">My eBay </a></li>
				<li><a href="#" data-toggle="modal" data-target="#myModal"> My PaisaPay </a></li>
				<li><a href="#"><i class="fa fa-bell"></i> </a></li>
				<li><a href="#"><i class="fa fa-search"></i></a></li>
				<li><a href="getCart"><i class="fa fa-shopping-cart"></i></a></li>
				<li><a href="logOut"> Logout </a></li>
			</ul>
		</div>
	</nav>

	<div class="container" style="margin-top: 5%">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 style="text-align: center">Add Deal</h3>
					</div>
					<div class="panel-body">
						<form action="addDeal" id="selectDealForm" method="post"
							class="form-horizontal">
							<div class="form-group">
								<label class="control-label col-md-3" for="dealInsert">Select
									Item One : </label>
								<div class="col-md-7">
									<s:select class=" form-control" list="itemList"
										listValue="%{itemId + ' ' + itemName}" listKey="%{surrogateItemId}"
										name="aditya" headerKey="-1"
										headerValue="Select Item" id="One">
									</s:select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3" for="dealInsert">Select
									item Two : </label>
								<div class="col-md-7">
									<s:select class=" form-control" list="itemList"
										listValue="%{itemId + ' ' + itemName}" listKey="%{surrogateItemId}"
										name="aditya2" headerKey="-1"
										headerValue="Select Item" id="Two">
									</s:select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3" for="dealInsert">Select
									item Three: </label>
								<div class="col-md-7">
									<s:select class=" form-control" list="itemList"
										listValue="%{itemId + ' ' + itemName}" listKey="%{surrogateItemId}"
										name="rahul" headerKey="-1"
										headerValue="Select Item" id="Three">
									</s:select>
								</div>
							</div>



							<div class="panel-footer">
								<div class="row">
									<div class="col-md-10"></div>
									<div class="col-md-2">
										<button type="submit" class="btn btn-success"
											data-toggle="modal" data-target=".bs-example-modal-sm" id="addDealButton">Add</button>
									</div>
								</div>
							</div>


						</form>
					</div>

				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
<!-- 	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" -->
<!-- 		aria-labelledby="myLargeModalLabel"> -->
<!-- 		<div class="modal-dialog modal-sm"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				Deal Added Successfully !!!! -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

<script>
// $(document).ready(function() {
//     $('#selectDealForm')
//         .find('[name="aditya"]')
//             .selectpicker()
//             .change(function(e) {
//                 // revalidate the color when it is changed
//                 $('#selectDealForm').formValidation('revalidateField', 'aditya');
//             })
//             .end()
//         .find('[name="aditya2"]')
//             .selectpicker()
//             .change(function(e) {
//                 // revalidate the color when it is changed
//                 $('#selectDealForm').formValidation('revalidateField', 'aditya2');
//             })
//             .end()
//             .find('[name="rahul"]')
//             .selectpicker()
//             .change(function(e) {
//                 // revalidate the color when it is changed
//                 $('#selectDealForm').formValidation('revalidateField', 'rahul');
//             })
//             .end()
//         .formValidation({
//             framework: 'bootstrap',
//             excluded: ':disabled',
//             icon: {
//                 valid: 'glyphicon glyphicon-ok',
//                 invalid: 'glyphicon glyphicon-remove',
//                 validating: 'glyphicon glyphicon-refresh'
//             },
//             fields: {
// //                 aditya: {
// //                     validators: {
// //                         callback: {
// //                             message: 'Please choose 2-4 colors you like most',
// //                             callback: function(value, validator, $field) {
// //                                 // Get the selected options
// //                                 var options = validator.getFieldElements('colors').val();
// //                                 return (options != null && options.length >= 2 && options.length <= 4);
// //                             }
// //                         }
// //                     }
// //                 },
//                 aditya: {
//                     validators: {
//                         notEmpty: {
//                             message: 'Please select your native language.'
//                         }
//                     }
//                 },
//                 aditya2: {
//                     validators: {
//                         notEmpty: {
//                             message: 'Please select your native language.'
//                         }
//                     }
//                 },
//                 rahul: {
//                     validators: {
//                         notEmpty: {
//                             message: 'Please select your native language.'
//                         }
//                     }
//                 }
//             }
//         });
// });

function validateText(id)
		{
			if($("#"+id).val() == "-1")
			{
				var div = $("#"+id).closest("div");
				div.removeClass("has-success");
				div.addClass("has-error has-feedback");
				$("#glypcn"+id).remove();
				
				return false;
			}
			else
			{
				var div = $("#"+id).closest("div");
				$("#glypcn"+id).remove();
				div.removeClass("has-error");
				div.addClass("has-success has-feedback");
				
				return true;
			}
		}
		
		$(document).ready(
		
				function()
				{
					$("#addDealButton").click(function()
						{
						 	if(!validateText("One")) {
								return false;
							}
							if(!validateText("Two"))
							{
								return false;		
							}
							if(!validateText("Three"))	{
								return false;
							}
							
							$("form#selectDealForm").submit();
						});
				}
		);
</script>

</body>

</html>