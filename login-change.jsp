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

	String ogpass = (String) request.getParameter("pass1");
	String newpass = (String) request.getParameter("pass2");
	String user = (String) request.getParameter("userName");
	
	Statement st = con.createStatement();
	PreparedStatement qry = con.prepareStatement("UPDATE endUser SET login = ? WHERE login = ? AND email = ?");
	qry.setString(1, ogpass);
	qry.setString(2, newpass);
	qry.setString(3, user);
	
	int num = qry.executeUpdate();
	if (num > 0){
		out.println("<br>The password for " + user + " has been successfully updated</br>");
	} else {
		out.println("<br>The password for " + user + " could not be successfully updated</br>");
	}
%>
</body>
</html>