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
        	
        	Statement st = con.createStatement();
        	String user = request.getParameter("userName");
        	String pass = request.getParameter("password");
        	PreparedStatement qry1 = con.prepareStatement("SELECT * FROM staff WHERE staff.email = ? AND staff.slogin = ?");
        	qry1.setString(1, user);
        	qry1.setString(2, pass);
        	String qry2;
        	ResultSet rset1 = qry1.executeQuery();
        	ResultSet rset2;
        	boolean loggedin = false;
        	if (!rset1.isBeforeFirst()){
        		qry2 = "SELECT * FROM endUser WHERE email = '" + user + "' AND endUser.login = '" + pass + "'";
        		rset2 = st.executeQuery(qry2);
        		if (rset1.isBeforeFirst()){
        			loggedin = true;
        		}
        	} else {
        		loggedin = true;
        	}
        	
        	if (loggedin == true){
        		out.println("<b>" + user + " is logged in</b>"); 
        	} else {
        		out.println("Log-in has failed");
        	}
        %> 
    </body>
</html>