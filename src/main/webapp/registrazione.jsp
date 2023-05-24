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
			<legend>Registrazione</legend>
			<br>
			<%@include file="errorbox.jsp" %>
			<br>
			<form action="ARegistrazione" method="post" class="form-w1 center">
				<label for="nome">Nome</label>
				<br>
				<input type="text" id="nome" name="nome" size="32" placeholder="Nome" required>
				<br>
				<label for="cognome">Cognome</label>
				<br>
				<input type="text" id="cognome" name="cognome" size="32" placeholder="Cognome" required>
				<br>
				<label for="email">Email</label>
				<br>
				<input type="email" id="email" name="email" size="64" placeholder="Email" required>
				<br>
				<label for="password">Password</label>
				<br>
				<input type="password" id="password" name="password" size="64" placeholder="Password" required>
				<br>
				<label for="password2">Conferma password:</label>
				<br>
				<input type="password" id="password2" name="password2" size="64" placeholder="Conferma Password" required>
				<br>
				<label for="data">Data di nascita:</label>
				<br>
				<input type="date" id="data" name="data" required>
				<br>
				<label for="indirizzo">Indirizzo:</label>
				<br>
				<input type="text" id="indirizzo" name="indirizzo" size="64" placeholder="Indirizzo, Civico" required>
				<br>
				<input type="submit" value="Registrati" size="32">
				<br>
        		<!-- <div class="form-error"></div> -->
        	</form>
        </fieldset>
    </div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>