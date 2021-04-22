<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
</head>
<body>

<%
	HttpSession sess = request.getSession();
	String login = (String) sess.getAttribute("LOGIN");
	if (login != null){
		sess.setAttribute("LOGIN", null);
		response.sendRedirect("login.html");
	} else {
		out.println("<b>You are already logged out</b>");
	}
%>

</body>
</html>