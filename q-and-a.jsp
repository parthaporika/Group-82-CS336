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

	<form action = "questions.jsp" method = "post">
			<div class="textbox">
				<input type="text" placeholder="Keyword" name="question" value="">
			</div>
            
             <div>
			<input name="btn" type="submit" value="Search">
			<div class="divider" ></div>
	</form>
	
	<form action = "submit-question.jsp" method = "post">
			<div class="textbox">
				<input type="text" placeholder="Keyword" name="question" value="">
			</div>
            
             <div>
			<input name="btn" type="submit" value="Ask">
			<div class="divider" ></div>
	</form>

	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	String connectionUrl = "jdbc:mysql://localhost:3306/auction";
	Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
	
	PreparedStatement qry = con.prepareStatement("SELECT * FROM question");
	
	ResultSet rset = qry.executeQuery();
	
	if (rset.isBeforeFirst()){
		out.println("<table><tr><td>Question</td><td>Status</td></tr>");
		while (rset.next()){
			String stat = "open";
			if (rset.getString("closed") == "true"){
				stat = "closed";
			}
			out.println("<tr><td>"+ rset.getString("question") + "</td><td>" + stat + "</td></tr>");
		}
		out.println("</table>");
	} else {
		out.println("<b>No questions have been posted</b>"); 
	}
	%>
</body>
</html>