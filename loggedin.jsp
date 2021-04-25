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
			
			boolean loggedin = false;
			HttpSession sess = request.getSession();
			String login = (String) sess.getAttribute("LOGIN");
			
			if (login != null){
				out.println("<b>You are already logged in</b>");
			} else {
        	
        		Statement st = con.createStatement();
        		String user = request.getParameter("userName");
        		String pass = request.getParameter("password");
        		PreparedStatement qry1 = con.prepareStatement("SELECT * FROM staff WHERE staff.email = ? AND staff.slogin = ?");
        		qry1.setString(1, user);
        		qry1.setString(2, pass);
        		String qry2;
        		ResultSet rset1 = qry1.executeQuery();
        		ResultSet rset2;
        		if (!rset1.isBeforeFirst()){
        			qry2 = "SELECT * FROM endUser WHERE endUser.email = '" + user + "' AND endUser.login = '" + pass + "'";
        			rset2 = st.executeQuery(qry2);
        			if (rset2.isBeforeFirst()){
        				loggedin = true;
        				sess.setAttribute("ACCESS", "user");
        			}
        		} else {
        			//add staff indicator and whether or not that staff is an admin indicator for the session
        			loggedin = true;
        			while (rset1.next()){
            			if (rset1.getString("isAdmin").equals("0")){
            				sess.setAttribute("ACCESS", "rep");
            			} else {
            				sess.setAttribute("ACCESS", "admin");
            			}
        			}
        			
        		}
        	
        		if (loggedin == true){
        			sess.setAttribute("LOGIN", pass);
        			String redirect = (String) sess.getAttribute("ACCESS");
        			
        			if (redirect.equals("rep")){
        				response.sendRedirect("customer-rep.jsp");
        			} else if (redirect.equals("admin")){
        				response.sendRedirect("admin.jsp");
        			} else {
        				response.sendRedirect("profile.jsp");
        			}
        		} else {
        			out.println("Log-in has failed");
        		}
			}
        %> 
    </body>
</html>