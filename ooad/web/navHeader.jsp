<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    

	<nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0px; border-bottom: 1px solid #B2B2B2;">
  			<div class="container">
    		<!-- Brand and toggle get grouped for better mobile display -->
    			<div class="navbar-header">
     				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
      						data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
			      	</button>
      				<a class="navbar-brand active" href="index1">RApS.in</a>
      				<!--  <a class="navbar-brand" href="#">
                <img src="http://placehold.it/150x50&text=Logo" alt="">
            </a> -->
    			</div>
			
			<%
				String userid = (String) session.getAttribute("userid");
				String user_type = (String) session.getAttribute("usertype");
	        %>
			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      		<ul class="nav navbar-nav">
						<li>
			<%	        
					if (userid == null || !user_type.equals("2")) { 
		         
	     %>
	     				<li><a href="registerSellerPage">Register <small>(seller)</small></a></li>
	     <%			}
			
	       %>
						
							
				    	<li>
				    		<a data-toggle="tab" href="#category">Shop By Category</a> 
			    		</li>
			    		<li>
		    				<a data-toggle="tab" href="#empty">
		    					<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
	    					</a>
	    				</li>
	    				<li>
	    				<a href="finalExam01.jsp">Final Exam-01</a>
	    				</li>
				   	</ul>
					<form action="searchItem.jsp">
				   	<ul class="nav navbar-nav navbar-right">
				    	<li style="padding-top: 8px;">
				    		<input type="text" class="form-control" name="searchText" placeholder="Search ...">
						</li>
						<li style="padding-top: 8px;">
							<select class="form-control" name="selectedCategory">
							    	<option>All Categories</option>
							    <s:iterator>	
							    	<option><s:property value="categoryName"/></option>
							    	<s:iterator value="subCategories">
							    		<s:if test="subCategoryName != ''">
							    		<option><s:property value="subCategoryName"/></option>
							    		</s:if>
							    	</s:iterator>
								</s:iterator>
							    </select>
						</li>
						<!-- <li><a href="search.jsp">Search</a></li> -->
						<li style="padding-top: 8px;"><input type="submit" value="Search" class="btn btn-primary form-control"></li>
				 <%  //String user_type = (String) session.getAttribute("usertype");
	         if (user_type != null && user_type.equals("2")) { 
	            System.out.println("Seller Logged in");            
	     %>				
	     				
	     				<li class="dropdown">
				      		<a href="#" class="dropdown-toggle active" data-toggle="dropdown">Item Management <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="addItemPage">Add Item</a></li>
								<li><a href="deleteItemPage">Delete Item</a></li>
								<li><a href="updateItem.jsp">Update Item</a></li>
								<li><a href="addDealPage">Add Deals</a></li>
								<li><a href="deleteDealPage">Delete Deals</a></li>
							</ul>
						</li>
	     <%   
	     	}
	         else
	         {
	        	 System.out.println("User type = "+user_type); 
	         }
	      %>
		<%--        <li class="dropdown">
				      		<a href="#" class="dropdown-toggle active" data-toggle="dropdown">Item Management <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="addItemPage">Add Item</a></li>
								<li><a href="deleteItemPage">Delete Item</a></li>
							</ul>
						</li>
						<li><a href="#" data-toggle="modal" data-target="#myModal">Login</a></li>
						
				   	</ul>
				   	
				   	</form>
			  	  	
				   	<ul class="nav navbar-nav navbar-right">
				    	<li style="padding-top: 8px;">
				    		<input type="text" class="form-control" placeholder="Search ...">
						</li>
						<li style="padding-top: 8px;">
							<select class="form-control">
							    	<option>All Categories</option>
							    <s:iterator>	
							    	<option><s:property value="categoryName"/></option>
							    	<s:iterator value="subCategories">
							    		<s:if test="subCategoryName != ''">
							    		<option><s:property value="subCategoryName"/></option>
							    		</s:if>
							    	</s:iterator>
								</s:iterator>
							    </select>
						</li>
				        
		<%  //String user_type = (String) session.getAttribute("usertype");
	         if (user_type != null && user_type.equals("2")) { 
	            System.out.println("Seller Logged in");            
	     %>				
	     				
	     				<li class="dropdown">
				      		<a href="#" class="dropdown-toggle active" data-toggle="dropdown">Item Management <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="addItemPage">Add Item</a></li>
								<li><a href="deleteItemPage">Delete Item</a></li>
							</ul>
						</li>
	     <%   
	     	}
	         else
	         {
	        	 System.out.println("User type = "+user_type); 
	         }
	      %> --%>
		<%--  <%  String user_id = (String) session.getAttribute("userid");
	         if (user_id != null ) { 
	            System.out.println("user != null");            
	     %>
	     				<li><a href="logout.jsp">Logout</a></li>
	     <%   
	     	}
	     	else    {
	            System.out.println("user == null");
	      %>
						<li><a href="loginPage.jsp?v=h">Login</a></li>
	      <%      
	        }
    %>			 --%>	
				   	</ul>
			  	  	<div class="tab-content">
				    	<div id="empty" class="tab-pane-fade">
				    	</div>
					    <div id="category" class="tab-pane fade">
					      	<table class="table">
								<tbody>
									<tr>
									<s:iterator>
										<s:if test="categoryId % 3 == 1">
										<td>
											<h4><s:property value="categoryName"/></h4>
											<ul>
											  	<s:iterator value="subCategories">
												  	<li style="list-style-type: none;">
												  		<a href="listItem.jsp?subCategoryId=<s:property value='subCategoryId'/>">
												  			<s:property value="subCategoryName"/>
											  			</a>
										  			</li>
											  	</s:iterator>
										  	</ul>	
									  	</td>
									  	</s:if>
									</s:iterator>
									</tr>
									<tr>	
					  				<s:iterator>
										<s:if test="categoryId % 3 == 2">
										<td>
											<h4><s:property value="categoryName"/></h4>
											<ul>
											  	<s:iterator value="subCategories">
												  	<li style="list-style-type: none;">
												  		<a href="listItem.jsp?subCategoryId=<s:property value='subCategoryId'/>">
												  			<s:property value="subCategoryName"/>
											  			</a>
										  			</li>
											  	</s:iterator>
										  	</ul>	
									  	</td>
										</s:if>
									</s:iterator>
									</tr>
									<tr>
									<s:iterator>
										<s:if test="categoryId % 3 == 0">
											<td>
											<h4><s:property value="categoryName"/></h4>
											<ul>
											  	<s:iterator value="subCategories">
												  	<li style="list-style-type: none;">
												  		<a href="listItem.jsp?subCategoryId=<s:property value='subCategoryId'/>">
												  			<s:property value="subCategoryName"/>
											  			</a>
										  			</li>
											  	</s:iterator>
										  	</ul>	
									  	</td>
										</s:if>
									</s:iterator>
									</tr>
								</tbody>
							</table>
					    </div>
				    </div>
			  	</div><!-- /.navbar-collapse -->
  			</div><!-- /.container -->
		</nav>