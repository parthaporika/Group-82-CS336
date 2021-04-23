<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Total Earnings</title>
</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
	
		Statement st = con.createStatement();
		PreparedStatement qry = con.prepareStatement("SELECT sum(price_sold) AS Total_Earnings FROM electronics WHERE isSold = '1'");
		
		ResultSet rset = qry.executeQuery();
		if (!rset.isBeforeFirst()){
			out.println("<br>$0</br>");
		} else {
			while (rset.next()){
				if (rset.getString("Total_Earnings") == null){
					out.println("<br>$0</br>");
				} else {
					out.println("<br>" + rset.getString("Total_Earnings") + "</br>");
				}
			}
		}
	%>
</body>
</html>