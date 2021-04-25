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
		System.out.println("HERE "+login+" HERE");
	    
        int auctionnum = Integer.parseInt(request.getParameter("auctionnum"));
        float bidamount = Float.parseFloat(request.getParameter("bidamount"));
        
        Statement st1 = con.createStatement();
        String qry3 = "SELECT current_price FROM electronics WHERE auction_number = " + auctionnum + "";
		ResultSet rset1 = st1.executeQuery(qry3);
		rset1.next();
		float currbid = rset1.getFloat("current_price");
		
		Statement st2 = con.createStatement();
        String qry = "SELECT lower_bound FROM electronics WHERE auction_number = " + auctionnum + "";
		ResultSet rset2 = st2.executeQuery(qry);
		rset2.next();
		float lowbound = rset2.getFloat("lower_bound");
		Statement st = con.createStatement();
	
		if (lowbound+currbid > bidamount){
			out.println("Bid has to be greater than or equal to" + lowbound+currbid+"");
		}else{
			Statement st3 = con.createStatement();
	        String qry4 = "SELECT bidamount FROM bids WHERE auction_number = " + auctionnum + " AND login = "+login+"";
			ResultSet rset4 = st3.executeQuery(qry4);
			if (rset4.isBeforeFirst()){
				PreparedStatement update1 = con.prepareStatement("UPDATE bids SET bidamount = " + bidamount +" WHERE auction_number = "+ auctionnum + " AND login = "+login+"");
		        update1.executeUpdate();
			}else{
				PreparedStatement newBid = con.prepareStatement("INSERT INTO bids VALUES (0, ?, ?, false, ?, 0)");
		        newBid.setString(1, login);
		        newBid.setInt(2, auctionnum);
		        newBid.setFloat(3, bidamount);
		         
		        newBid.executeUpdate();
			}
	        
	        PreparedStatement update = con.prepareStatement("UPDATE electronics SET current_price = " + bidamount +" WHERE auction_number = "+ auctionnum + "");
	        update.executeUpdate();
	        
	        String qry2 = "SELECT login FROM posts WHERE auction_number = " + auctionnum + "";
			ResultSet rset = st.executeQuery(qry2);
			rset.next();
			String seller = rset.getString("login");
			
			PreparedStatement newBidHist = con.prepareStatement("INSERT INTO bidHistory VALUES (?, ?, ?, true, ?)");
	        newBidHist.setString(1, login);
	        newBidHist.setString(2, seller);
	        newBidHist.setInt(3, auctionnum);
	        newBidHist.setFloat(4, bidamount);
	        
	        newBidHist.executeUpdate();
	        out.println("Your bid was entered!");
		}
        %>
	</body>
</html>