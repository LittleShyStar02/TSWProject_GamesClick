<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container">
		<h1>Assistenza</h1>
		<fieldset>
		<legend>Contattaci! Ti riponderemo al più presto!</legend>
      		<form>
				<label for="email">Email account</label>
				<input type="text" name="email" required>
				<label for="object">Oggetto</label>
				<input type="text" name="object" required>
				<label for="note">Richiesta</label>
				<textarea name="note" cols="30" rows="10" required></textarea>
				<input type="submit" value="Invia Richiesta">
			</form>
		</fieldset>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>