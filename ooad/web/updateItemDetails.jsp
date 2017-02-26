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
	<title>Add Item</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="fa/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<script src="js/jquery-ui.min.js"></script>
	<script type="text/javascript">
		$(function(){
		    $(".datepicker").datepicker();
		});	
	</script>
</head>
<body>
<%! 
	String log = "";
%>
<%
	String result = request.getParameter("success");
	String userid = (String) session.getAttribute("userid");
	try {
		DBConnection dbConnection = new DBConnection();
		PreparedStatement ps = dbConnection.connect().prepareStatement("SELECT log_message FROM logs WHERE logs_id = (SELECT MAX(logs_id) FROM logs)");
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			log = rs.getString(1);
		System.out.println("add Item --------- " + log);
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
			
	<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>

	<div id="header">
	</div>
	<br>
	<br>
	<nav>
		<ul class="pager pull-left" style="margin: 0px; padding-left: 20px;">
			<li><a href="index1">Back</a></li>
			<!--  <li><a href="#">Next</a></li> -->
		</ul>
	</nav>


	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Add Item
					</div>
				<s:form name="itemForm" action="updateItemDetails" method="post" namespace="/" enctype="multipart/form-data" class="form-horizontal">
  					<div class="panel-body">
						<div class="form-group">
						    <label class="col-sm-3 control-label">Seller Id</label>
					    	<div class="col-sm-8">
						    	<input type="hidden" class="form-control" name="seller.sellerId" value="<%=userid %>">
						    	<input type="text" class="form-control" disabled="disabled" id="sellerId" value="<%=userid %>">
						    	<span id="err"> </span>
						    </div>
					  	</div>
						<div class="form-group">
						    <label class="col-sm-3 control-label">Category Name</label>
					    	<div class="col-sm-8">
						    	<input type="text" class="form-control" disabled value='<s:property value="itemDetails.category.categoryName"/>'>
						    </div>
					  	</div>
						<div class="form-group">
						    <label class="col-sm-3 control-label">Sub-Category Name</label>
					    	<div id="getSubCategory" class="col-sm-8">
				    			<input type="text" class="form-control" disabled value='<s:property value="itemDetails.subCategory.subCategoryName"/>'>
						    </div>
					  	</div>
					  	<div class="form-group">
   							<label class="col-sm-3 control-label">Item Id</label>
   							<div class="col-sm-8">
     								<div class="input-group">
									  	<span class="input-group-addon" id="sId"><%=userid %></span>
									  	<span class="input-group-addon" id="catId"><s:property value="itemDetails.category.categoryId"/></span>
									  	<span class="input-group-addon" id="subCatId"><s:property value="itemDetails.subCategory.subCategoryId"/></span>
									  	<input type="text" class="form-control" id="itemId" name="item.itemId" disabled value='<s:property value="itemDetails.item.itemId"/>' placeholder="Item ID"  onkeyup="verifyItem()">
									  	<input type="hidden" class="form-control" name="item.itemId" value='<s:property value="itemDetails.item.itemId"/>' placeholder="Item ID"  onkeyup="verifyItem()">
									</div>
									<span id="err1"></span>
							</div>
						</div>
					  	<div class="form-group">
						    <label for="name" class="col-sm-3 control-label">Item Name</label>
					    	<div class="col-sm-8">
						    	<input type="text" class="form-control" id="itemName" name="item.itemName" value='<s:property value="itemDetails.item.itemName"/>' placeholder="Item Name">
						    </div>
					  	</div>
					  	<div class="form-group">
						    <label for="address" class="col-sm-3 control-label">Description</label>
					    	<div class="col-sm-8">
						          <textarea rows="2" class="form-control" id="itemDescription" name="item.itemDescription" ><s:property value="itemDetails.item.itemDescription"/></textarea>
						    </div>
						</div>
						<div class="form-group">
						    <label for="name" class="col-sm-3 control-label">Picture</label>
					    	<div class="col-sm-8">
					    		<img src="showPicture.jsp?image=<s:property value='itemDetails.item.itemPictureString'/>" class="img-responsive">
					    		<input type="file" name="item.itemPicture" id="itemPicture" value=''>
						    </div>
					  	</div>
						<div class="form-group">
						    <label for="name" class="col-sm-3 control-label">Price</label>
					    	<div class="col-sm-8">
						    	<input type="text" class="form-control" id="itemPrice" name="item.itemPrice"  value='<s:property value="itemDetails.item.itemPrice"/>' onkeyup="setAdvtCost()"/>
						    </div>
					  	</div>
					  	<div class="form-group">
						    <label class="col-sm-3 control-label">Discount</label>
					    	<div class="col-sm-8">
						    	<input type="text" class="form-control" id="itemDiscount" name="item.itemDiscount"  value='<s:property value="itemDetails.item.itemDiscount"/>' />
						    </div>
					  	</div>
					  	<div class="form-group">
						    <label class="col-sm-3 control-label">Quantity Available</label>
					    	<div class="col-sm-8">
						    	<input type="text" class="form-control" id="itemQuantityAvailable" name="item.itemQuantityAvailable"  value='<s:property value="itemDetails.item.itemQuantityAvailable"/>' />
						    </div>
					  	</div>
						<div class="form-group">
						    <label class="col-sm-3 control-label">Warranty Period</label>
					    	<div class="col-sm-8">
								<div class="input-group">
									<input type="text" class="form-control" style="z-index: 0;" id="itemWarrantyPeriod" name="item.itemWarrantyPeriod"  value='<s:property value="itemDetails.item.itemWarrantyPeriod"/>'>
									<%-- <div class="input-group-btn">
										<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
											Period <span class="caret"></span>
										</button>
										<!-- <ul class="dropdown-menu dropdown-menu-right">
											<li>Year(s)</li>
											<li>Month(s)</li>
										</ul> -->
									</div> --%>
								</div>
							</div>
					  	</div>
					  	<div class="form-group">
					  		<label for="name" class="col-sm-3 control-label">Advertising Item</label>
					    	<div class="col-sm-8">
						    	<div class="radio">
						    	<s:if test= "itemDetails.item.itemAdvertisement == 1">
						    	 	<label>
								    	<input type="radio" name="item.itemAdvertisement" checked id="itemAdvertisement" value="Yes" onclick="show(1)"> Yes
								  	</label>
								  	&emsp;
							  	 	<label>
								    	<input type="radio" name="item.itemAdvertisement" id="itemAdvertisement" value="No" onclick="show(0)"> No
								  	</label>
							  	</s:if>
							  	<s:else>
							  	 	<label>
								    	<input type="radio" name="item.itemAdvertisement" id="itemAdvertisement" value="Yes" onclick="show(1)"> Yes
								  	</label>
								  	&emsp;
							  	 	<label>
								    	<input type="radio" name="item.itemAdvertisement" checked id="itemAdvertisement" value="No" onclick="show(0)"> No
								  	</label>
							  	</s:else>
						  		</div>
						    </div>
					  	</div>
					  	<div id="advt-detail" class="hidden">
					  		<div class="form-group">
							    <label class="col-sm-3 control-label">Advertisement From</label>
						    	<div class="col-sm-8">
							    	<input type="text" class="form-control datepicker" id="itemAdvtFrom" name="item.itemAdvtFrom" />
							    </div>
						  	</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">Advertisement To</label>
						    	<div class="col-sm-8">
							    	<input type="text" class="form-control datepicker" id="itemAdvtTo" name="item.itemAdvtTo" />
							    </div>
						  	</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">Advertisement Cost</label>
						    	<div class="col-sm-8">
						 	    	<input type="hidden" id="itemAdvtCost1" class="form-control" name="item.itemAdvtCost"  />
								   	<input type="text" class="form-control" id="itemAdvtCost2" disabled="disabled"  name="item.itemAdvtCost"  value='<s:property value="itemDetails.item.itemAdvtCost"/>'/>
							    </div>
						  	</div>
						</div> 
						<hr>
						<div class="text-center">
							<h4><strong>Item specifics</strong></h4>
						</div>
						<div id="item-specifics">
							<div class="form-group">
							    <label class="col-sm-3 control-label">Color</label>
						    	<div class="col-sm-8">
							    	<input type="text" class="form-control" id="itemColor" name="item.itemColor"  value='<s:property value="itemDetails.item.itemColor"/>'/>
							    </div>
						  	</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">Condition</label>
						    	<div class="col-sm-8">
						    		<select class="form-control" id="itemCondition" name="item.itemCondition">
										<option value="">None</option>
										<option>New</option>
										<option>Old</option>
									</select>
							    </div>
						  	</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">Weight</label>
						    	<div class="col-sm-8">
									<div class="input-group">
										<input type="text" class="form-control" style="z-index: 0;" id="itemWeight" name="item.itemWeight"  value='<s:property value="itemDetails.item.itemWeight"/>'>
										<%-- <div class="input-group-btn">
											<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
												Unit <span class="caret"></span>
											</button>
											<!-- <ul class="dropdown-menu dropdown-menu-right">
												<li><a href="#">Kg (s)</a></li>
												<li><a href="#">g (s)</a></li>
												<li><a href="#">lb (s)</a></li>
											</ul> -->
										</div> --%>
									</div>
								</div>
						  	</div>
						  	<div class="form-group">
							    <label class="col-sm-3 control-label">Brand</label>
						    	<div class="col-sm-8">
							    	<input type="text" class="form-control" id="itemBrand" name="item.itemBrand"  value='<s:property value="itemDetails.item.itemBrand"/>' />
							    </div>
						  	</div>
							<div class="form-group">
							    <label class="col-sm-3 control-label">Expiry Date</label>
						    	<div class="col-sm-8">
							    	<input type="text" class="form-control datepicker" id="itemExpiryDate" name="item.itemExpiryDate"  value='<s:property value="itemDetails.item.itemExpiryDate"/>'/>
							    </div>
						  	</div>
						  	
				<s:set var="j" value="0"/>
				<s:iterator value="itemDetails.attributeLists">
						<div class="form-group"> 
							<div class="col-sm-3"> 
								<input type="text" class="form-control text-right" name="attributeLists[<s:property value='j' />].attributeKey" value='<s:property value="attributeKey" />' />
							</div>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="attributeLists[<s:property value='j' />].attributeValue" value='<s:property value="attributeValue" />' /> 
							</div> 
						</div> 
						<s:set var="j" value="%{#j+1}"/>
				</s:iterator>
						<input type="hidden" id = "count" value = '<s:property value = "j"/>'> 
							<div class="form-group" id="add">
							    <label class="col-sm-3 control-label sr-only"></label>
						    	<div class="col-sm-8">
							    	<button type="button" id="addMore" onclick="add()" class="btn btn-primary col-md-3 text-right">Add More ...</button>
							    </div>
						  	</div>
						  	<span id="err3"></span>
						</div>
										  	
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-md-11">
								<div class="pull-right">
								    <button type="submit" id="addItemButton" class="btn btn-success">Submit</button>
								</div>
							</div>
							<div class="col-md-1"></div>
						</div>
					</div>
				</s:form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
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
	
	<script src="js/bootstrap.min.js"></script>

		<script>
	
		var days = 1;
		
		$("#itemAdvtFrom").datepicker({
		    minDate: 0,
		    maxDate: '+1Y+6M',
		    onSelect: function (dateStr) {
		        var min = $(this).datepicker('getDate'); // Get selected date
		        $("#itemAdvtFrom").datepicker('option', 'minDate', min || '0'); // Set other min, default to today
		        setAdvtCost();
		    }
		});

		$("#itemAdvtTo").datepicker({
		    minDate: '0',
		    maxDate: '+1Y+6M',
		    onSelect: function (dateStr) {
		        var max = $(this).datepicker('getDate'); // Get selected date
		        $('.datepicker').datepicker('option', 'maxDate', max || '+1Y+6M'); // Set other max, default to +18 months
		        var start = $("#itemAdvtFrom").datepicker("getDate");
		        var end = $("#itemAdvtTo").datepicker("getDate");
		        days = (end - start) / (1000 * 60 * 60 * 24);
		        setAdvtCost();
		    }
		});

		var count = $("#count").val();
		
		function add() {
			//alert(count);
			count ++;
			if(count == 5) {
				$('#err3').html('<font color="red">You Cant Add More Attributes !!!</font>');
				$('#add').addClass('hidden');
			}
			else {
				var field = '<div class="form-group">' + 
								'<div class="col-sm-3">' + 
									'<input type="text" class="form-control text-right" id="key' + count + '" name="attributeLists[' + (count-1) + '].attributeKey" />' +
								'</div>' +
								'<div class="col-sm-8">' + 
									'<input type="text" class="form-control" id="value' + count + '" name="attributeLists[' + (count-1) + '].attributeValue" />' + 
								'</div>' + 
							'</div>'; 
				$(field).insertBefore('#add');
			}
		}
		
		function show(c) {
			if(c == 1) {
				$('#advt-detail').removeClass("hidden");
			}
			else {
				$('#advt-detail').addClass("hidden");
			}
		}
		
		function setAdvtCost() {
			var val = $('#itemPrice').val() * 0.05 * days;
			$('#itemAdvtCost1').val(val);
			$('#itemAdvtCost2').val(val);

		
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
					$("#addItemButton").click(function()
						{
						/* 	if(!validateText("sellerId")) {
								return false;
							}
							if(!validateText("res1"))
							{
								return false;		
							}
							if(!validateText("itemId"))	{
								return false;
							}
							if(!validateText("res2"))
							{
								return false;		
							}
							if(!validateText("itemName")) {
								return false;
							}
							if(!validateText("itemDescription")) {
								return false;
							}
							if(!validateText("itemPicture")) {
								return false;
							}
							if(!validateText("itemPrice")) {
								return false;
							}
							if(!validateText("itemAdvertisement")) {
								return false;
							}  */	
							$("form#itemForm").submit();
						});
				}
		);
	</script>


	<!-- Fetch the data from db onchange  -->
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
			var urls = "ajax/verifySeller2.jsp?sellerId=" + key;
			
			ajax(urls, "err");
			
			document.getElementById("sId").innerHTML = key;
		}
	
		function verifyItem()
		{
			var key = document.getElementById("itemId").value;
			var urls = "ajax/verifyItem2.jsp?itemId=" + key;
			
			ajax(urls, "err1");
			
			/* document.getElementById("sId").innerHTML = key; */
		}
		
		function getSubCategory()
		{
		/*
			var x = document.getElementById("category").selectedIndex;
		    var y = document.getElementById("category").options;
			var key = y[x].index + 1;
		*/	
			var e = document.getElementById("category");
			var key = $('select[name="item.categoryId"]').val();		//e.options[e.selectedIndex].value;
			
			var urls = "ajax/getSubCategories.jsp?categoryId=" + key
			
			ajax(urls, "getSubCategory");
			
			document.getElementById("catId").innerHTML = key;
		
			document.getElementById("subCategory").options[0].selected = 'selected';
			fillDetails();
		}
		
		function fillDetails()
		{
			var e = document.getElementById("subCategory");
			var key = e.options[e.selectedIndex].value;
			document.getElementById("subCatId").innerHTML = key;
			
		}
		
	</script>	
</body>
</html>