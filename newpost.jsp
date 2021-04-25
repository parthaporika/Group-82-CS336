<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
	<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://127.0.0.1:3306/auction";
		Connection con = DriverManager.getConnection(connectionUrl, "root", "Garethbale11");
		
		String datetime = request.getParameter("closingdate");
		System.out.println(datetime);
        float minprice = Float.parseFloat(request.getParameter("minprice"));
        String brand = request.getParameter("brand");
        String color = request.getParameter("color");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        float initprice = Float.parseFloat(request.getParameter("initprice"));
        String name = request.getParameter("name");
        float mininc = Float.parseFloat(request.getParameter("mininc"));
        String procpower = request.getParameter("procpower");
        String memory = request.getParameter("memory");
        String lens = request.getParameter("lens");
        String megapixels = request.getParameter("megapixels");
        String decibels = request.getParameter("decibels");
        String frequency = request.getParameter("frequency");
        String device = request.getParameter("device");
        
        boolean iscomp = false;
        boolean iscamera = false;
        boolean isspeaker = false;
        if (device.equals("computer")){
        	iscomp = true;
        }else if (device.equals("camera")){
        	iscamera = true;
        }else{
        	isspeaker = true;
        }
        
        HttpSession sess = request.getSession();
	    String login = (String) sess.getAttribute("LOGIN");
	    Statement st1 = con.createStatement();
        String qry3 = "SELECT MAX(auction_number) FROM posts";
		ResultSet rset1 = st1.executeQuery(qry3);
		rset1.next();
		int curnum = rset1.getInt("MAX(auction_number)");
        int nextnum = curnum+1;
        Timestamp ts = Timestamp.valueOf(datetime);
        
        PreparedStatement newPost = con.prepareStatement("INSERT INTO posts VALUES (?, ?, ?, ?, ?)");
        newPost.setDate(1, null);
        newPost.setTimestamp(2, ts);
        newPost.setFloat(3, minprice);
        newPost.setString(4, login);
        newPost.setInt(5, nextnum);
         
        newPost.executeUpdate();
        
        PreparedStatement newElec = con.prepareStatement("INSERT INTO electronics VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, false, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        newElec.setFloat(1, initprice);
        newElec.setString(2, brand);
        newElec.setFloat(3, mininc);
        newElec.setString(4, color);
        newElec.setString(5, model);
        newElec.setInt(6, year);
        newElec.setFloat(7, initprice);
        newElec.setString(8, name);
        newElec.setInt(9, nextnum);
        newElec.setString(10, procpower);
        newElec.setString(11, lens);
        newElec.setString(12, memory);
        newElec.setString(13, megapixels);
        newElec.setString(14, decibels);
        newElec.setString(15, frequency);
        newElec.setBoolean(16, iscamera);
        newElec.setBoolean(17, iscomp);
        newElec.setBoolean(18, isspeaker);
        
        newElec.executeUpdate();
        out.println("New Post Added!");
        %>
	</body>
</html>