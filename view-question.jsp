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
	String id = request.getParameter("id");
	
	PreparedStatement qry = con.prepareStatement("SELECT q.question, q.closed, q.answer FROM question q WHERE q.questionid = ?");
	
	qry.setString(1, id);
	
	ResultSet rset = qry.executeQuery();
	
	if (rset.isBeforeFirst()){
		while (rset.next()){
		 	out.println("<br>Question: " + rset.getString("question") + "</br>");
		 	if (rset.getString("closed").equals("1")){
		 		if (rset.getString("answer") == null){
		 			out.println("<br>Submitter closed post before there could be an answer</br>");
		 		} else {
		 			out.println("<br>Answer: " + rset.getString("answer") + "</br>");
		 		}
		 	} else {
		 		out.print("<form action = 'respond-question.jsp' method = post><input type = 'hidden' name = 'id' value = '" + id + "'><div class='textbox'> <input type='text' placeholder='Answer' name='answer' value=''></div><input name='btn' type='submit' value='Enter'></form>");
		 	}
		}
	} else {
		out.println("<b>The link does not appear to work. Please try again.</b>"); 
	}
	%>
</body>
</html>