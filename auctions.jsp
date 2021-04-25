<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<%
	String titleName = (String) request.getParameter("name");
	out.println("<title>" + titleName + " Auction</title>");
%>
</head>
	<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
		HttpSession sess = request.getSession();
		
		String auctNum = (String) request.getParameter("auctNum");
		String itemName = (String) request.getParameter("name");
		
		out.println("<h1>" + itemName + "</h1>");
		
		Statement st = con.createStatement();
		PreparedStatement qry1 = con.prepareStatement("SELECT end_time FROM posts WHERE auction_number = ? AND end_time <= (SELECT Now())");
		qry1.setString(1, auctNum);
		
		PreparedStatement qry2 = con.prepareStatement("SELECT isSold FROM electronics WHERE auction_number = ?");;
		qry2.setString(1, auctNum);
		
		ResultSet rset1 = qry1.executeQuery();
		ResultSet rset2 = qry2.executeQuery();
		
		PreparedStatement qry3 = con.prepareStatement("UPDATE electronics SET price_sold = current_price, isSold = '1' WHERE auction_number = ?");
		qry3.setString(1, auctNum);
		
		PreparedStatement qry4 = con.prepareStatement("INSERT INTO staffMessage VALUES (?, admin@gmail.com, ?, ?, ?)");
		
		PreparedStatement qry5 = con.prepareStatement("SELECT COUNT(*) AS total FROM staffmessage");
		ResultSet rset3 = qry5.executeQuery();
		int messageID = 0;
		while (rset3.next()){
			messageID = Integer.parseInt(rset3.getString("total")) + 1;
		}
		qry4.setString(2, "" + messageID);
		
		float current_price = 0f;
		float lower_bound = 0f;
		String winner = "";
		String brand = "";
		String model = "";
		
		PreparedStatement qry6 = con.prepareStatement("SELECT current_price, lower_bound, brand, model FROM electronics WHERE auction_number = ?");
		qry6.setString(1, auctNum);
		ResultSet rset6 = qry6.executeQuery();
		
		while (rset6.next()){
			current_price = Float.parseFloat(rset6.getString("current_price"));
			lower_bound = Float.parseFloat(rset6.getString("lower_bound"));
			model = rset6.getString("model");
			brand = rset6.getString("brand");
		}
		
		if (rset1.isBeforeFirst()){
			while (rset2.next()){
				if (rset2.getString("isSold") == "0"){
					PreparedStatement winnerQuery = con.prepareStatement("SELECT login FROM bids WHERE auction_number = ? AND bidamount = ?");
					winnerQuery.setString(1, auctNum);
					winnerQuery.setString(2, "" + current_price);
					ResultSet winnerSet = winnerQuery.executeQuery();
					while (winnerSet.next()){
						winner = winnerSet.getString("login");
						qry4.setString(1, winner);
						if (current_price >= lower_bound){
							qry3.executeUpdate();
							qry4.setString(3, "Congratulations! You won an auction!");
							qry4.setString(4, "Your bid for the item " + itemName + " has won auction #" + auctNum + "! Congratulations!");
						} else {
							qry4.setString(3, "Auction Expired");
							qry4.setString(4, "Even though your bid for " + itemName + " was the highest. It was not enough to win auction #" + auctNum + ". Try again next time.");
						}
						
						qry4.executeUpdate();
					}
				}
			}
		
		} else {
			out.println("<input id = 'bid' name='btn' type='submit' value='Make Automatic Bid'><script type='text/javascript'>document.getElementById('bid').onclick = function () { location.href = 'automatic-bidding.html';};</script>");
		}
		
		PreparedStatement similarQry = con.prepareStatement("SELECT DISTINCT e.item_name, e.auction_number, IF (isSold = '1', 'SOLD', e.current_price) AS Current_Bid FROM electronics e, posts p WHERE p.auction_number = e.auction_number AND (e.brand = ? OR e.model = ?) AND e.auction_number NOT in (SELECT auction_number FROM electronics WHERE auction_number = ?)");
		similarQry.setString(1, brand);
		similarQry.setString(2, model);
		similarQry.setString(3, auctNum);
		ResultSet similarSet = similarQry.executeQuery();
		
		String itemName2 = "";
		
		if (similarSet.isBeforeFirst()){
			out.println("<h3>Similar Items</h3>");
			out.println("<table><tr><td>Name</td><td>Current Bid</td></tr>");
			while(similarSet.next()){
				itemName2 = similarSet.getString("item_name");
				out.println("<tr><td><a href = auctions.jsp?name="+ itemName2.replace(' ', '+') + "&auctNum=" + similarSet.getString("auction_number") + ">" + itemName2 + "</a></td><td>" + similarSet.getString("Current_Bid") + "</td></tr>");
			}
			out.println("</table>");
		}
		
        %>
	</body>
</html>