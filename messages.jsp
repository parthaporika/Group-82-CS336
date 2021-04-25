<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Messages</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	Statement st = con.createStatement();
	HttpSession sess = request.getSession();
	String login = (String) sess.getAttribute("LOGIN");
	if (login == null){
		out.println("<b>You are not logged in</b>");
	} else {
		out.println("<b>" + login + "'s messages</b>");
		PreparedStatement qry = con.prepareStatement("SELECT messenger, mtitle FROM staffMessage WHERE recipient = ?");
		qry.setString(1, login);
		ResultSet rset = qry.executeQuery();
		
		if (rset.isBeforeFirst()){
			out.println("<table><tr><td>From</td><td>Message</td></tr>");
			while (rset.next()){
				out.println("<tr><td>" + rset.getString("messenger") + "</td><td>" + rset.getString("mtitle") + "</td></tr>");
			}
			out.println("</table>");
		} else {
			out.println("<b>You have no new messages</b>");
		}
	}
%>
</body>
</html>