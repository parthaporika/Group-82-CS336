<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<body>
<%
HttpSession sess = request.getSession();
String access = (String) sess.getAttribute("ACCESS");
if (access != "admin"){
	response.sendRedirect("denied.html");
}
%>
	<div class="create_crep-box">

		<h1>Admin Page</h1>
        
		<p>Create Customer rep Account </p>
		<form action = "createaccount.jsp" method = "post">
            <input type = "hidden" name = "isStaff" value = "1">
			<div class="textbox">
				<input type="text" placeholder="Username" name="userName" value="">
			</div>

		<div class="textbox">
			<input type="text" placeholder="Password" name="password" value="">
		</div>

		<div>
		<input name="btn" type="submit" value="Enter">
		<div class="divider"></div>

        </form>
        
        
        <br>
        
        <h2>Generate Sales Report</h2>
        <p>Earnings per...</p>
        <form action = "earnings-per.jsp" method = "post">
        <div class="textbox">
				<input type="text" placeholder="Item name" name="itemName" value="">
			</div>
            
             <div class="textbox">
				<input type="text" placeholder="item type (Laptop,...etc)" name="model" value="">
			</div>
            
             <div class="textbox">
				<input type="text" placeholder="End User login" name="userName" value="">
			</div>
            
            <div>
		<input name="btn" type="submit" value="Enter">
		<div class="divider"></div>
		</form>
        
        
        <br>
        
        <p>Total Earnings</p>
        <form action = "total-earnings.jsp" method = "post">
			<input name="btn" type="submit" value="Enter">
			<div class="divider"></div>
		</form>
        
        
        <p> Best Selling Item </p>
        <form action = "best-selling.jsp" method = "post">
        	<div>
			<input name="btn" type="submit" value="Enter">
			<div class="divider"></div>
			</div>
		</form>
        
        <p> Best Buyer</p>
        <form action = "best-buyer.jsp" method = "post">
			<input name="btn" type="submit" value="Enter">
			<div class="divider"></div>
		</form>

	</div>
</body>
</html>
