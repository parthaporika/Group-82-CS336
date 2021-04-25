<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Autobid</title>
</head>
<body>

	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
	
	Statement st = con.createStatement();
	HttpSession sess = request.getSession();
	String login = (String) sess.getAttribute("LOGIN");

	String auctionNum = "" + 456789;
	String upperLimit = request.getParameter("upperLimit");
	String bidIncrement = request.getParameter("bidIncrement");
	Float initialBid = Float.parseFloat(request.getParameter("initialBid"));
	
	PreparedStatement qry1 = con.prepareStatement("INSERT INTO bids VALUES (?, ?, ?, True, ?, ?)");
	
	qry1.setString(1, upperLimit);
	qry1.setString(2, login);
	qry1.setString(3, auctionNum);
	qry1.setString(4, "" + initialBid);
	qry1.setString(5, bidIncrement);
	
	qry1.executeUpdate();
	
	String seller = "";
	PreparedStatement sellerQry = con.prepareStatement("SELECT p.login FROM posts p WHERE p.auction_number = ?");
	sellerQry.setString(1, auctionNum);
	ResultSet rset1 = sellerQry.executeQuery();
	
	while (rset1.next()){
		seller = rset1.getString("login");
	}
	
	PreparedStatement qry2 = con.prepareStatement("INSERT INTO bidHistory values (?, ?, ?, True, ?)");
	qry2.setString(1, login);
	qry2.setString(2, seller);
	qry2.setString(3, auctionNum);
	qry2.setString(4, "" + initialBid);
	
	qry2.executeUpdate();
	
	float current_price = 0f;
	float lower_bound = 0f;
	
	PreparedStatement qry3 = con.prepareStatement("SELECT current_price, lower_bound FROM electronics WHERE auction_number = ?");
	qry3.setString(1, auctionNum);
	ResultSet rset2 = qry3.executeQuery();
	while (rset2.next()){
		current_price = Float.parseFloat(rset2.getString("current_price"));
		lower_bound = Float.parseFloat(rset2.getString("lower_bound"));
	}
	
	float min_newprice = current_price + lower_bound;
	
	String formerWinner = "";
	PreparedStatement fwQuery = con.prepareStatement("SELECT login FROM bids WHERE auction_number = ? AND bidamount = ?");
	fwQuery.setString(1, auctionNum);
	fwQuery.setString(2, "" + current_price);
	ResultSet fwRset = fwQuery.executeQuery();
	while (fwRset.next()){
		formerWinner = fwRset.getString("login");
	}
	
	PreparedStatement qry4 = con.prepareStatement("UPDATE electronics SET current_price = ? WHERE auction_number = ?");
	qry4.setString(2, auctionNum);
	
	PreparedStatement qry5 = con.prepareStatement("INSERT INTO staffMessage values (?, 'admin@gmail.com', ?, 'You have been outbidded', ?)");
	qry5.setString(1, formerWinner);
	
	PreparedStatement qry6 = con.prepareStatement("SELECT COUNT(*) AS total FROM staffmessage");
	ResultSet rset3 = qry6.executeQuery();
	int messageID = 0;
	while (rset3.next()){
		messageID = Integer.parseInt(rset3.getString("total")) + 1;
	}
	qry5.setString(2, "" + messageID);
	
	String message = "We regret to inform you that your current bid in auction #" + auctionNum + " has been outbidded. Please raise your upper limit or set up another manual bid.";
	qry5.setString(3, message);
	
	PreparedStatement qry7 = con.prepareStatement("SELECT * FROM bids WHERE auction_number = ? AND isAutomatic = '1' AND upper_limit <= ? AND login not in (SELECT login FROM bids WHERE login = ?)");
	qry7.setString(1, auctionNum);
	qry7.setString(2, "" + min_newprice);
	qry7.setString(3, login);
	
	PreparedStatement qry8 = con.prepareStatement("UPDATE bids SET bidamount = ? WHERE auction_number = ? AND login = ?");
	qry8.setString(2, auctionNum);
	
	if (initialBid > min_newprice){
		
		String winner = login;
		float winningBid = initialBid;
		boolean newIncrement = true;
		ResultSet rset7 = qry7.executeQuery();
		while (newIncrement){
			while (rset7.next()){
				String currentUser = rset7.getString("login");
				Float newBidAmount = Float.parseFloat(rset7.getString("bidamount")) + Float.parseFloat(rset7.getString("bidincrement"));
				if (newBidAmount <= Float.parseFloat(rset7.getString("upper_limit"))){
					newIncrement = true;
					qry8.setString(1, "" + newBidAmount);
					qry8.setString(3, currentUser);
					qry8.executeUpdate();
					if (newBidAmount > winningBid + lower_bound){
						winner = currentUser;
						winningBid = newBidAmount;
					}
				}
			}
			qry7.setString(2, "" + winningBid);
			qry7.setString(3, winner);
			newIncrement = false;
			rset7 = qry7.executeQuery();
		}
		
		qry4.setString(1, "" + winningBid);
		qry4.executeUpdate();
		
		if (!formerWinner.equals(winner) && !formerWinner.equals("")){
			qry5.executeUpdate();
		} else {
			if (!formerWinner.equals("")){
				out.println("<br>You have to bid even higher</br>");
			}
		}
	} else {
		System.out.println(min_newprice);
	}
	
	
	%>
</body>
</html>