<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
		
        String user = request.getParameter("userName");
        String pass = request.getParameter("password");
        
        PreparedStatement newUser = con.prepareStatement("INSERT INTO endUser VALUES (?, true, false, ?)");
        newUser.setString(1, user);
        newUser.setString(2, pass);
         
        newUser.executeUpdate();
        %>
	</body>
</html>