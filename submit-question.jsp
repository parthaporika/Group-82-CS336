<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://localhost:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "root");
		HttpSession sess = request.getSession();
		
        String question = request.getParameter("question");
        String login = (String) sess.getAttribute("LOGIN");
        
        PreparedStatement newQuestion = con.prepareStatement("INSERT INTO question VALUES (?, ?, null, ?, null, false)");
        
        PreparedStatement qry = con.prepareStatement("SELECT COUNT(*) AS total FROM question");
        ResultSet rset = qry.executeQuery();
    	int questionID = 0;
    	while (rset.next()){
    		questionID = Integer.parseInt(rset.getString("total")) + 1;
    	}
    	
    	newQuestion.setString(1, "" + questionID);
        newQuestion.setString(2, login);
        newQuestion.setString(3, question);
        	
        try {
        		int result = newQuestion.executeUpdate();
        		out.println("<script type='text/javascript'>alert('You're question has been posted');</script>");
        } catch (Exception e){
        		out.println("<script type='text/javascript'>alert('The question could not be posted');</script>");
        }
        
        response.sendRedirect("q-and-a.jsp");
        %>
	</body>
</html>