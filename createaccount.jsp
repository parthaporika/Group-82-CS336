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
		
        String user = request.getParameter("userName");
        String pass = request.getParameter("password");
        int isStaff = Integer.parseInt(request.getParameter("isStaff"));
        
        if (user == null || pass == null || user.equals("") || pass.equals("")){
        	out.println("<br>An account cannot be created with empty values. Please try again.</br>");
        	out.println("<input id = 'back' type='submit' name = 'btn' value = 'Back'><script>document.getElementById('back').onclick = function () {location.href = 'regform.html';};</script>");
        } else {
	        if (isStaff == 1){
	        	PreparedStatement newStaff = con.prepareStatement("INSERT INTO staff VALUES (?, ?, null, false)");
	            
	        	newStaff.setString(1, user);
	        	newStaff.setString(2, pass);
	        	
	        	try {
	        		int result = newStaff.executeUpdate();
	        		out.println("<h1>The account for customer rep " + user + " was successfully created</h1>");
	        		sess.setAttribute("ACCESS", "rep");
	        		sess.setAttribute("LOGIN", user);
	        	} catch (Exception e){
	        		out.println("<h1>There was an issue with creating the account for " + user + " with the password " + pass + "</h1>");
	        	}
	        	
	        	
	        } else {
	        	PreparedStatement newUser = con.prepareStatement("INSERT INTO endUser VALUES (?, true, false, ?)");
	        
	        	newUser.setString(1, user);
	        	newUser.setString(2, pass);
	        	
	        	try {
	        		int result = newUser.executeUpdate();
	        		sess.setAttribute("ACCESS", "user");
	        		sess.setAttribute("LOGIN", pass);
	        		response.sendRedirect("profile.jsp");
	        	} catch (Exception e){
	        		out.println("<h1>There was an issue with creating the account for " + user + " with the password " + pass + "</h1>");
	        	}
	        	
	        	
	        }
        }
        %>
	</body>
</html>