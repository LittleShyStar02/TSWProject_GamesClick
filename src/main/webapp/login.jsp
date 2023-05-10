<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container">
		<h1>Login</h1>
		<form class="left">
			<label for="email">Email</label>
			<input type="email" id="email" name="email" placeholder="Email">
			<label for="password">Password</label>
			<input type="password" id="password" name="password" placeholder="Password">
			<input type="submit" value="Accedi">
			<!-- <div class="form-error"></div> -->
		</form>
		<div>
			<p>Non hai ancora un account?</p>
			<a href="#">Registrati</a>
		</div>
		<div>
			<a href="#">Ho dimenticato la password</a>
		</div>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>