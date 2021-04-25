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

	<form action = "customer-rep.jsp" method = "post">
		<input id = "return" name="btn" type="submit" value="Homepage">
	</form>

	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
	
		String auctNum = (String) request.getParameter("auctnum");
		String user = (String) request.getParameter("userName");
		
		Statement st = con.createStatement();
		PreparedStatement qry = con.prepareStatement("DELETE FROM bids WHERE auction_number = ? AND login = ?");
		qry.setString(1, auctNum);
		qry.setString(2, user);
		
		int num = qry.executeUpdate();

		if (num > 0){
			out.println("<br>The bid has been successfully deleted</br>");
		} else {
			out.println("<br>The bid could not be deleted</br>");
		}
		
	%>

	

</body>
</html>