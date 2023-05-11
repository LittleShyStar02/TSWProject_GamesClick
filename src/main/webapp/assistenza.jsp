<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 		<h1 style="color:red">Assistenza</h1>
		<fieldset class="fieldset-form">
		<legend>Contattaci! Ti riponderemo al più presto!</legend>
		<br>
      		<form class="center">
				<label for="email">Email account</label>
				<input type="text" name="email" required>
				<label for="object">Oggetto</label>
				<input type="text" name="object" required>
				<br>
				<label for="note">Richiesta</label>
				<textarea name="note" cols="30" rows="10" required></textarea>
				<br>
				<input type="submit" value="Invia Richiesta">
				<br>
			</form>
		</fieldset>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>