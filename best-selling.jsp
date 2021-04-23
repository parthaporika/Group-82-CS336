<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Best Selling Report</title>
</head>
<body>
	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	Statement st = con.createStatement();
	PreparedStatement qry = con.prepareStatement("SELECT t1.item_name FROM (SELECT e.item_name, COUNT(*) AS sold FROM electronics e WHERE isSold = '1' GROUP BY item_name) t1 WHERE t1.sold IN (SELECT MAX(t2.sold) FROM (SELECT e.item_name, COUNT(*) AS sold FROM electronics e WHERE isSold = '1' GROUP BY item_name) t2)");
	//PreparedStatement qry = con.prepareStatement("SELECT t1.seller FROM (SELECT bh.seller, COUNT(*) AS num FROM bidHistory bh WHERE bh.isBuyer = '1' GROUP BY bh.seller) t1 WHERE t1.num = (SELECT MAX (t1.num) FROM (SELECT bh.seller, COUNT(*) AS num FROM bidHistory bh WHERE bh.isBuyer = '1' GROUP BY bh.seller) t1 )");
	ResultSet rset = qry.executeQuery();
	if (!rset.isBeforeFirst()){
		out.println("No official bids have gone through yet.");
	} else {
		while (rset.next()){
			out.println("<br>" + rset.getString("item_name") + "</br>");
		}
	}
	
	%>
</body>
</html>