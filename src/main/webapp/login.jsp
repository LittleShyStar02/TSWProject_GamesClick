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
			<legend><h1 style="color: red">Login</h1></legend>
			<br>
			<form class="center">
				<label for="email">Email</label>
				<br>
				<input type="email" id="email" name="email" placeholder="Email">
				<br>
				<label for="password">Password</label>
				<br>
				<input type="password" id="password" name="password" placeholder="Password">
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
		</fieldset>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>