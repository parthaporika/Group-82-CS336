<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Q & A</title>
</head>
<body>

	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");

	HttpSession sess = request.getSession();
	String login = (String) sess.getAttribute("LOGIN");

	Statement st = con.createStatement();
	String answer = (String) request.getParameter("answer");
	String id = (String) request.getParameter("id");
	
	PreparedStatement qry = con.prepareStatement("UPDATE question SET answer = ?, responder = ?, closed = '1' WHERE questionid = ?");
	
	qry.setString(1, answer);
	qry.setString(2, login);
	qry.setString(3, id);
	
	PreparedStatement qry2 = con.prepareStatement("SELECT closed, answer, question FROM question WHERE questionid = ?");
	qry2.setString(1, id);
	
	ResultSet rset = qry2.executeQuery();
	
	if (rset.isBeforeFirst()){
		while (rset.next()){
			String question = rset.getString("question");
		 	out.println("<br>Question: " + question + "</br>");
		 	if (rset.getString("closed").equals("true")){
		 		if (rset.getString("answer") == null){
		 			out.println("<br>Submitter closed post before there could be an answer</br>");
		 		} else {
		 			out.println("<br>Answer: " + rset.getString("answer") + "</br>");
		 		}
		 	} else {
		 		qry.executeUpdate();
		 		out.println("<br>Answer: " + answer + "</br>");
		 	}
		}
	} else {
		out.println("<b>There was an issue responding to the question.</b>"); 
	}
	%>
</body>
</html>