<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container">
		<form>
			<label for="search">Cerca un gioco: </label>
			<input type="text" id="search" name="search" placeholder="Inserisci il nome del gioco">
			<input type="submit" value="Cerca">
			<!-- <div class="form-error"></div> -->
		</form>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>