<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Auction History</title>
</head>
<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
		HttpSession sess = request.getSession();
		String login = request.getParameter("user");
		
		PreparedStatement qry = con.prepareStatement("SELECT bh.auction_number AS Auction_Participation FROM bidHistory bh WHERE bh.buyer = ? OR bh.seller = ?;");
		qry.setString(1, login);
		qry.setString(2, login);
		
		ResultSet rset = qry.executeQuery();
		if (rset.isBeforeFirst()){
			out.println("<table><tr><td>Auction #</td></tr>");
			while (rset.next()){
				out.println("<tr><td>" + rset.getString("Auction_Participation") + "</tr></td>");
			}
			out.println("</table>");
		} else {
			out.println("This user has never participated in an auction");
		}
	
	%>
</body>
</html>