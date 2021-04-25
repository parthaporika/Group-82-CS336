<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
</head>
<body>

<input id = 'browse' name='btn' type='submit' value='Browse'>


<form action = 'messages.jsp' method = 'post'>
	<input name='btn' type='submit' value='Messages'>
</form>

<form action = 'q-and-a.jsp' method = 'post'>
	<input name='btn' type='submit' value='Q & A'>
</form>

<form action = 'logout.jsp' method = 'post'>
	<input name='btn' type='submit' value='Log Out'>
</form>

<script type="text/javascript">
    document.getElementById("browse").onclick = function () {
        location.href = "browse.html";
    };
</script>

</body>
</html>