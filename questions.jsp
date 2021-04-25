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

	Statement st = con.createStatement();
	String question = request.getParameter("question");
	if (question == ""){
		question = "%";
	} else {
		question = "%" + question + "%";
	}
	
	PreparedStatement qry = con.prepareStatement("SELECT q.questionid, q.question, q.closed FROM question q WHERE q.question LIKE ?");
	
	qry.setString(1, String.valueOf(question));
	
	ResultSet rset = qry.executeQuery();
	
	if (rset.isBeforeFirst()){
		out.println("<table><tr><td>Question</td><td>Status</td></tr>");
		while (rset.next()){
			String stat = "open";
			if (rset.getString("closed").equals("1")){
				stat = "closed";
			}
			out.println("<tr><td><a href = view-question.jsp?id="+ rset.getString("questionid") + ">" + rset.getString("question") + "</a></td><td>" + stat + "</td></tr>");
		}
		out.println("</table>");
	} else {
		out.println("<b>No question matches that result</b>"); 
	}
	%>
</body>
</html>