<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Invalid Delete</title>
</head>
<body>
 
    <jsp:include page="deleteItem.jsp?success=none"></jsp:include>  
    <div align="center">
    <font color = "Red" >This item does not belong to you. Please enter a valid item to delete.</font>
    </div>

</body>
</html>