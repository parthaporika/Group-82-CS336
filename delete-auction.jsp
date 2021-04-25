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
		
		Statement st = con.createStatement();
		PreparedStatement qry1 = con.prepareStatement("DELETE FROM posts WHERE auction_number = ?");
		qry1.setString(1, auctNum);
		
		int num = qry1.executeUpdate();

		PreparedStatement qry2 = con.prepareStatement("DELETE FROM electronics WHERE auction_number = ?");
		qry2.setString(1, auctNum);
		
		qry2.executeUpdate();
		
		PreparedStatement qry3 = con.prepareStatement("DELETE FROM bids WHERE auction_number = ?");
		qry3.setString(1, auctNum);
		
		qry3.executeUpdate();
		if (num > 0){
			out.println("<br>Auction #" + auctNum + " has been successfully deleted</br>");
		} else {
			out.println("<br>Auction #" + auctNum + " could not be deleted</br>");
		}
		
	%>

	

</body>
</html>