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
		HttpSession sess = request.getSession();
	    String login = (String) sess.getAttribute("LOGIN");
		
        int auctionnum = Integer.parseInt(request.getParameter("auctionnum"));
        float bidamount = Float.parseFloat(request.getParameter("bidamount"));
        
        Statement st1 = con.createStatement();
        String qry3 = "SELECT MAX(bidamount) FROM bids WHERE auction_number = " + auctionnum + "";
		ResultSet rset1 = st1.executeQuery(qry3);
		float currbid = rset1.getFloat("MAX(bidamount)");
		
		Statement st2 = con.createStatement();
        String qry = "SELECT lower_bound FROM electronics WHERE auction_number = " + auctionnum + "";
		ResultSet rset2 = st2.executeQuery(qry);
		float lowbound = rset2.getFloat("lower_bound");
		Statement st = con.createStatement();
	
		if (lowbound+currbid > bidamount){
			out.println("Bid has to be greater than or equal to" + lowbound+currbid+"");
		}else{
	        PreparedStatement newBid = con.prepareStatement("INSERT INTO bids VALUES (0, login, ?, false, ?)");
	        newBid.setInt(1, auctionnum);
	        newBid.setFloat(2, bidamount);
	         
	        newBid.executeUpdate();
	        
	        PreparedStatement update = con.prepareStatement("UPDATE electronics SET current_price = " + bidamount +" WHERE auction_number = "+ auctionnum + "");
	        update.executeUpdate();
	        
	        String qry2 = "SELECT login FROM posts WHERE auction_number = " + auctionnum + "";
			ResultSet rset = st.executeQuery(qry2);
			String seller = rset.getString("login");
			
			PreparedStatement newBidHist = con.prepareStatement("INSERT INTO bidHistory VALUES (?, ?, ?, true, ?)");
	        newBidHist.setString(1, login);
	        newBidHist.setString(2, seller);
	        newBidHist.setInt(3, auctionnum);
	        newBidHist.setFloat(4, bidamount);
	        
	        newBidHist.executeUpdate();
		}
        %>
	</body>
</html>