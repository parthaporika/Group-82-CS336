<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Email Change</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	String ogemail = (String) request.getParameter("userName1");
	String newemail = (String) request.getParameter("userName2");
	
	Statement st = con.createStatement();
	PreparedStatement qry = con.prepareStatement("UPDATE endUser SET email = ? WHERE email = ?");
	qry.setString(1, newemail);
	qry.setString(2, ogemail);
	
	int num = qry.executeUpdate();
	if (num > 0){
		out.println("<br> " + ogemail + "has been successfully updated to " + newemail + "</br>");
	} else {
		out.println("<br> " + ogemail + "could not be updated to " + newemail + "</br>");
	}
%>
</body>
</html>