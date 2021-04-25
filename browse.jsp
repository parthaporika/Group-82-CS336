<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Browsing</title>
</head>
<body>

<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	Statement st = con.createStatement();
	String itemName = request.getParameter("item");
	int itemType = Integer.parseInt(request.getParameter("browse"));
	float below = 1000000000;
	float above = 0;
	String belowString = request.getParameter("below");
	String aboveString = request.getParameter("above");
	if (itemName == ""){
		itemName = "%";
	} else {
		itemName = "%" + itemName + "%";
	}
	try {
		below = Float.parseFloat(belowString);
	} 
	catch (Exception e){
		below = 1000000000;
	}
	try{
		above = Float.parseFloat(aboveString);
	} catch (Exception e) {
		above = 0;
	}
	PreparedStatement qry;
	
	if (itemType == 0){
		qry = con.prepareStatement("SELECT e.item_name, e.auction_number, IF (isSold = '1', 'Sold', e.current_price) AS Current_Bid FROM electronics e, posts p WHERE e.auction_number = p.auction_number AND e.isCamera = 1 AND e.current_price < ? AND e.current_price > ? AND e.item_name LIKE ?");
	} else if (itemType == 1){
		qry = con.prepareStatement("SELECT e.item_name, e.auction_number, IF (isSold = '1', 'Sold', e.current_price) AS Current_Bid FROM electronics e, posts p WHERE e.auction_number = p.auction_number AND e.isLaptop = 1 AND e.current_price < ? AND e.current_price > ? AND e.item_name LIKE ?");
	} else if (itemType == 2){
		qry = con.prepareStatement("SELECT e.item_name, e.auction_number, IF (isSold = '1', 'Sold', e.current_price) AS Current_Bid FROM electronics e, posts p WHERE e.auction_number = p.auction_number AND e.isSpeaker = 1 AND e.current_price < ? AND e.current_price > ? AND e.item_name LIKE ?");
	} else {
		qry = con.prepareStatement("SELECT e.item_name, e.auction_number, IF (isSold = '1', 'Sold', e.current_price) AS Current_Bid FROM electronics e, posts p WHERE e.auction_number = p.auction_number AND e.current_price < ? AND e.current_price > ? AND e.item_name LIKE ?");
	}
	
	qry.setString(1, String.valueOf(below));
	qry.setString(2, String.valueOf(above));
	qry.setString(3, itemName);
	
	ResultSet rset = qry.executeQuery();
	String itemName2;
	
	if (rset.isBeforeFirst()){
		out.println("<table><tr><td>Name</td><td>Current Bid</td></tr>");
		while (rset.next()){
			itemName2 = rset.getString("item_name");
			out.println("<tr><td><a href = auctions.jsp?name="+ itemName2.replace(' ', '+') + "&auctNum=" + rset.getString("auction_number") + ">" + itemName2 + "</a></td><td>" + rset.getString("Current_Bid") + "</td></tr>");
		}
		out.println("</table>");
	} else {
		out.println("<b>" + itemName + " does not exist</b>"); 
	}
	
%>

</body>
</html>