<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="s" uri="/struts-tags" %>    

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scaling=1.0">
	<title>raps.in</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
 	<script src="js/jquery-2.1.1.min.js"></script>
</head>
<body>

		<nav class="navbar navbar-inverse navbar-static-top">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
     				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
      						data-target="#navbar-collapse-1" aria-expanded="false">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
			      	</button>
      				<a class="navbar-brand active" href="index1">RApS.in</a>
      			</div>

			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="navbar-collapse-1">
				   	<ul class="nav navbar-nav navbar-right">
				        <li><a href="index1">Logout</a></li>				        
			      	</ul>
			  	</div><!-- /.navbar-collapse -->
  			</div><!-- /.container -->
		</nav>

<div class="row">
	<div class="col-md-2" style="padding-left: 20px;">
		<ul class="nav nav-pills nav-stacked text-center">
			<li><a href="admin">List Categories</a></li>
	        <li><a href="listSubCategoryPage">List Sub-Categories</a></li>
	        <li><a href="addCategory.jsp">Add Category</a></li>
	        <li><a href="addSubCategoryPage">Add Sub-Category</a></li>
	        <li><a href="editCategoryPage">Edit Category</a></li>
	        <li><a href="editSubCategoryPage">Edit Sub-Category</a></li>
	   	    <li class="active"><a href="deleteCategoryPage">Remove Category</a></li>
	   	    <li><a href="deleteSubCategoryPage">Remove Sub-Category</a></li>
		</ul>
	</div>
    <div class="col-md-10">
		<div class="row">
			<div class="col-md-10">
				<div class="well text-center">
					<h4>Delete Category</h4>
				</div>
<%
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
%>

				<form class="form-horizontal" action="deleteCategory" method="post">
				
<%		if(categoryId != 0)
		{
			String categoryName = request.getParameter("categoryName");
%>
					<div class="form-group">
						<label class="col-sm-3 control-label">Category ID</label>
						<div class="col-sm-9">
							<input type="hidden" class="form-control" name="categoryId" value='<%=categoryId %>'>
							<input disabled="disabled" type="text" class="form-control" name="catId" value='<%=categoryId %>'>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">Category Name</label>
						<div class="col-sm-9">
							<input type="hidden" class="form-control" name="categoryName" value='<%=categoryName %>'>
							<input type="text" class="form-control" disabled="disabled" name="catName" value='<%=categoryName %>'>
						</div>
					</div>
				
<%
		}
		else {
%>				
					<div class="form-group">
						<label for="categoryId" class="col-sm-3 control-label">Category Name</label>
						<div class="col-sm-9">
							<select class="form-control" name="categoryId">
								<option value='0'>None</option>
								<s:iterator>
									<s:if test='(!(categoryName.equals("Other")))'>
										<option value='<s:property value="categoryId"/>'><s:property value="categoryName"/></option>
									</s:if>
								</s:iterator>
							</select>
						</div>
					</div>
			
<%
		}
%>					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-9">
							<button type="submit" class="btn btn-danger">Delete</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-2">
			</div>
			
		</div>
	</div>
</div>

<script src="js/bootstrap.min.js"></script>

</body>
</html>