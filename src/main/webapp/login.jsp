<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 		
 		<%@include file="errorbox.jsp" %>
 		
		<fieldset class="fieldset-form">
			<legend>Login</legend>
			<br>
			<form action="ALogin" method="post" class="form-w1 center">
				<label for="email">Email</label>
				<br>
				<input type="email" id="email" name="email" size="64" placeholder="Email" required>
				<br>
				<label for="password">Password</label>
				<br>
				<input type="password" id="password" name="password" size="64" placeholder="Password" required>
				<br>
				<input type="submit" value="Accedi">
				<br>
				<!-- <div class="form-error"></div> -->
			</form>
			<div>
				<a href="registrazione.jsp" class="form-a">Non hai ancora un account? Registrati</a>
			</div>
			<br>
			<br>
		</fieldset>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>