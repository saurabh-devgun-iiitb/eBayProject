<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/project.css" rel="stylesheet"/>
<title>Buy 2 Get One</title>
<style>

</style>
</head>
<body>

<nav class="navbar navbar-default navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
    				
     				<a class="navbar-brand active" href="index1">RApS.in</a>
    			</div>
  			</div><!-- /.container -->
		</nav>
<div class="container-fluid" style="margin-top:10px;text-align:center;color:gray;font-size:40px;">
BUY 2 GET 1 DEAL
</div>

<hr style="border:1px solid gray; border-width:1px">

<div class="container-fluid" style="margin-top:10px">
	
	<s:iterator> 
		
	</br>     <!--iterate over the array list-->
	    <s:iterator >     	    
	    <form action="">
	    <div class="row" style="margin:5px;border:2px solid gray">
	    	<div class="col-sm-3" style="padding:20px; margin:10px;">
				<div class="item_container">
	      		<img src="showPicture.jsp?image=<s:property value="item_one.item_picture"/>" style="width:100%;height:100%;margin-top:0px"/></br>
	      		</div>
	      		</br>
	      		<label style="width:100px;">Item id</label>
	      		
	      		<s:property value="item_one.item_id"/> </br>
	      			        	<label style="width:100px;">Item Name</label>
	      		<s:property value="item_one.item_name"/></br> 
	        		        	<label style="width:100px;">Item Desc</label>
	        	<s:property value="item_one.item_desc"/></br>
	        		        	<label style="width:100px;">Item Price</label>
	        	<s:property value="item_one.item_price"/></br>
	        	</div>
	        
	       		 <div class="col-sm-3" style="padding:20px; margin:10px;">	
	        	<div class="item_container">
	        	<img src="showPicture.jsp?image=<s:property value="item_two.item_picture"/>" style="width:100%;height:100%;margin-top:0px"/></br>
	           
	           	</div>
	           	</br>
	           		        	<label style="width:100px;">Item ID</label>
	           	<s:property value="item_two.item_id"/> </br>
	        		        	<label style="width:100px;">Item Name</label>
	        	<s:property value="item_two.item_name"/> </br>
	        		        	<label style="width:100px;">Item Desc</label>
	        	<s:property value="item_two.item_desc"/></br>
	        		        	<label style="width:100px;">Item Price</label>
	        	<s:property value="item_two.item_price"/></br>
	        	</div>
	        
	        	<div class="col-sm-3" style="padding:20px; margin:10px;">
	        	<div class="item_container">
	        `	
	        	
	        	<img src="showPicture.jsp?image=<s:property value="item_three.item_picture"/>" style="width:100%;height:100%;margin-top:0px;"><img src="images/FreeBadge.png" id="ins"/></img></br>
	        	
	        	</div>
	        	</br>
	        		        	<label style="width:100px;">Item id</label>

	        	<s:property value="item_three.item_id"/></br>
	        	
	       	        	<label style="width:100px;">Item Name</label>
				<s:property value="item_three.item_name"/> </br>
	        	
	        		        	<label style="width:100px;">Item Desc</label>
	        	
	        	<s:property value="item_three.item_desc"/></br>
	        	
	        		        	<label style="width:100px;">Item Price</label>
	        	
	        	<s:property value="item_three.item_price"/></br>
	        	
	        	</div>
	        	
	        	<div class="col-sm-2" style="margin-top:5%;position:relative">
	        	<button class="btn btn-primary">Add to Cart</button>
<!--	<button class="btn btn-primary">Buy</button> -->
	        	</div> 	
	      </div>
	      </form>
	    </s:iterator>
	
</s:iterator>
</div>
</body>
</html>