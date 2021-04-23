<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
		
		String itemName = (String) request.getParameter("itemName");
		String model = (String) request.getParameter("model");
		String userName = (String) request.getParameter("userName");
		
		Statement st = con.createStatement();
		PreparedStatement qry;
		
		if (itemName != null){
			qry = con.prepareStatement("SELECT sum(e.price_sold) FROM electronics e WHERE e.item_name = ?");
			qry.setString(1, itemName);
		} else if (model != null){
			if (model == "laptop"){
				qry = con.prepareStatement("SELECT sum(e.price_sold) AS Laptop_Earnings FROM electronics e WHERE isLaptop = '1'");
			} else if (model == "camera"){
				qry = con.prepareStatement("SELECT sum(e.price_sold) AS Camera_Earnings FROM electronics e WHERE isCamera = '1'");
			} else if (model == "speaker"){
				qry = con.prepareStatement("SELECT sum(e.price_sold) AS Speaker_Earnings FROM electronics e WHERE isSpeaker = '1'");
			} else {
				qry = con.prepareStatement("");
			}
		} else {
			qry = con.prepareStatement("SELECT DISTINCT bh.seller, e.price_sold, e.item_name FROM bidHistory bh, electronics e WHERE e.auction_number = bh.auction_number AND bh.seller = ?");
			qry.setString(1, userName);
		}
		try {
			ResultSet rset = qry.executeQuery();
		} catch (Exception e){
			
		}
		
	%>
		
</body>
</html>