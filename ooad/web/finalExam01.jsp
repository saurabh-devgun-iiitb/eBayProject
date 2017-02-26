<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Final Exam 01</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-2.1.1.min.js"></script>
</head>
<body>
<br><br><br>

<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align: center;">
						Student Name :- Anubhav Sharma &emsp; Roll Number :- MT2015022
					</div>
					<s:form action="finalExam01Result.jsp" id="finalExam01Form" method="post" class="form-horizontal">
  						<div class="panel-body">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
    							<div >
      								<s:textfield theme="bootstrap" class="form-control" placeholder="Enter weight" name="weight"/>
		    					</div>
  							</div>
						  
						  	
						<div class="">
							<div class="form-group" style="padding-left:15px; padding-right:15px">
					    	<s:submit name="Submit" theme="bootstrap" cssClass="btn btn-large btn-block btn-success pull-right"/>
					    	</div>
						</div>
            				
            				</div>
            			
					</s:form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>