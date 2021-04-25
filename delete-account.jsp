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

	String login = (String) request.getParameter("userName");
	
	Statement st = con.createStatement();
	PreparedStatement qry = con.prepareStatement("DELETE FROM endUser WHERE login = ?");
	qry.setString(1, login);
	
	int num = qry.executeUpdate();
	if (num > 0){
		out.println("<br>" + login + "has been successfully deleted</br>");
	} else {
		out.println("<br>" + login + "could not be deleted</br>");
	}
%>
</body>
</html>