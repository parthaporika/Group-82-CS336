<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://127.0.0.1:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "Garethbale11");
		
        int auctionnum = Integer.parseInt(request.getParameter("auctionnum"));
        float bidamount = Float.parseFloat(request.getParameter("bidamount"));
        
        PreparedStatement newBid = con.prepareStatement("INSERT INTO bids VALUES (0, login, ?, false, ?)");
        newBid.setInt(1, auctionnum);
        newBid.setFloat(2, bidamount);
         
        newBid.executeUpdate();
        %>
	</body>
</html>