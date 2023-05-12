<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
		<fieldset class="fieldset-form">
			<legend>Login</legend>
			<br>
			<form class="form-w1 center">
				<label for="email">Email</label>
				<br>
				<input type="email" id="email" name="email" size="64" placeholder="Email">
				<br>
				<label for="password">Password</label>
				<br>
				<input type="password" id="password" name="password" size="64" placeholder="Password">
				<br>
				<input type="submit" value="Accedi">
				<br>
				<!-- <div class="form-error"></div> -->
			</form>
			<div>
				<a href="#" class="form-a">Non hai ancora un account? Registrati</a>
			</div>
			<br>
			<div>
				<a href="#" class="form-a">Ho dimenticato la password</a>
			</div>
			<br>
		</fieldset>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>