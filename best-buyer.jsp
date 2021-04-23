<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Best Buyer Report</title>
</head>
<body>
	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	Statement st = con.createStatement();
	PreparedStatement qry = con.prepareStatement("SELECT t1.buyer FROM (SELECT bh.buyer, COUNT(*) AS num FROM bidHistory bh WHERE bh.isBuyer = '1' GROUP BY bh.buyer) t1 WHERE t1.num = (SELECT MAX(t1.num) FROM (SELECT bh.buyer, COUNT(*) AS num FROM bidHistory bh WHERE bh.isBuyer = '1' GROUP BY bh.buyer) t1)");
	ResultSet rset = qry.executeQuery();
	
	if (!rset.isBeforeFirst()){
		out.println("No official bids have gone through yet.");
	} else {
		while (rset.next()){
			out.println("<br>" + rset.getString("buyer") + "</br>");
		}
	}
	
	
	%>
</body>
</html>