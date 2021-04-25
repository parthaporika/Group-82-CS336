<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Representative</title>
</head>
<body>
<%
	HttpSession sess = request.getSession();
	String access = (String) sess.getAttribute("ACCESS");
	if (access != "rep"){
		response.sendRedirect("denied.html");
	}
%>
<h1>Customer Rep Page</h1>
<p>Search Questions</p>
	<form action = "questions.jsp" method = "post">
			<div class="textbox">
				<input type="text" placeholder="Keyword" name="question" value="">
			</div>
            
             <div>
			<input name="btn" type="submit" value="Enter">
			<div class="divider" ></div>
        
        	<br>
        <p> Browse Questions </p>
		<button class="button button1" type="submit">Browse</button>
	</form>


<h2> Edit Account info </h2>

	<p> Change End User login </p>
	<form action = "login-change.jsp" method = "post">
		<div class="textbox">
				<input type="text" placeholder="Email" name="userName" value="">
		</div>
    	<div class="textbox">
			<input type="text" placeholder="Current login" name="pass1" value="">
		</div>
        
    	<p> to </p>
    	<div class="textbox">
			<input type="text" placeholder="New login" name="pass2" value="">
		</div>
    	<input name="btn" type="submit" value="Enter">
    </form>
		<div class="divider"></div>
        
<br>

<p> Change End User email </p>

	<form action = "email-change.jsp" method = "post">
		<div class="textbox">
				<input type="text" placeholder="Current email" name="userName1" value="">
		</div>
        
		<p> to </p>
		<div class="textbox">
			<input type="text" placeholder="New email" name="userName2" value="">
		</div>
    	<input name="btn" type="submit" value="Enter">
    </form>
		<div class="divider"></div>
        
  
<br>

<h3> Delete End User Account </h3>
<p> Warning: Once an account is deleted it can not be undone. Please proceed with caution </p>

	<form action = "delete-account.jsp" method = "post">
		<div class="textbox">
			<input type="text" placeholder="Account Login" name="userName" value="">
		</div>
       <input name="btn" type="submit" value="Delete">
    </form>
	<div class="divider"></div>


<h3> Delete Auction</h3>
<p> Warning: Once an auction is deleted it can not be undone. Please proceed with caution </p>

	<form action = 'delete-auction.jsp' method = 'post'>
		<div class="textbox">
				<input type="text" placeholder="Auction Number" name="auctnum" value="">
			</div>

 <input name="btn" type="submit" value="Delete">
		<div class="divider"></div>
		</form>

<h3> Delete Bid</h3>
<p> Warning: Once a bid is deleted it can not be undone. Please proceed with caution </p>

	<form action = 'delete-bid.jsp' method = 'post'>
		<div class="textbox">
				<input type="text" placeholder="Auction Number" name="auctnum" value="">
			</div>
		<div class="textbox">
				<input type="text" placeholder="Login Info" name="userName" value="">
		</div>
	
        

 <input name="btn" type="submit" value="Delete">
		<div class="divider"></div>
		</form>



<form action = 'logout.jsp' method = 'post'>
	<input name='btn' type='submit' value='Log Out'>
</form>

</body>
</html>
