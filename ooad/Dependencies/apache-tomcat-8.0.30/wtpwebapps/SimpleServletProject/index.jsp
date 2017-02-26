<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Krishna</title>
</head>

<%!
public void jspInit(){
	String defaultUser = getServletConfig().getInitParameter("defaultUser");
	ServletContext context = getServletContext();
	context.setAttribute("defaultUser",defaultUser);
	System.out.println("Krishna");
}
%>
<body>
<!-- <jsp:useBean id=..... -->
The value in Servlet Context is : <%=getServletContext().getAttribute("defaultUser") %>
<%
String userName= request.getParameter("name");
if(userName != null){
	session.setAttribute("sessionObj",userName);
	application.setAttribute("applicationObj",userName);
	pageContext.setAttribute("app", userName, pageContext.PAGE_SCOPE);
}

%>
Hi Bro
<%!int p=5; 
int add (int i, int p)
{
	return i+p;	
}%>
<%
int i=5;
int j=2;
int k = add(i,j);
%>
<%=i+j+k %>
<%for(i=0;i<5;i++){ %>
	<br>Value of i:<%=i %>
<%} %>
<%for(i=0;i<5;i++)
	out.println("<br>"+i);	
%>
<%@include file="/add.jsp" %>
The time is <%=new Date()%> 

<br>
User name in the request object is: <%=userName %>
<br> User name in session Obj is : <%=session.getAttribute("sessionObj") %>
<br> User Name in application context obj is : <%=application.getAttribute("applicationObj") %>
<br> User name in app context thru PageContext is : <%=pageContext.getAttribute("app") %>

</body>
</html>