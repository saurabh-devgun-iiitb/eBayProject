<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Log In</title>
</head>
<body>
 
    <jsp:include page="signIn.jsp?success=none"></jsp:include>  
    <div align="center">
    <font color = "Red" >Invalid email or password! Please Try Again.</font>
    </div>

</body>
</html>