<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
	<script src="assets/js/validator.js"></script>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 		<br>
			<%@include file="errorbox.jsp" %>
		<br>
		<fieldset class="fieldset-form">
			<legend>Registrazione</legend>
			<br>
			<form action="ARegistrazione" method="post" class="form-w1 center" onsubmit="return validateReg()">
				<label for="nome">Nome</label>
				<br>
				<input type="text" id="nome" name="nome" size="32" placeholder="Nome" required autofocus>
				<p id="errorname" style="color:red"></p>
				<br>
				<label for="cognome">Cognome</label>
				<br>
				<input type="text" id="cognome" name="cognome" size="32" placeholder="Cognome" required autofocus>
				<p id="errorsurname" style="color:red"></p>
				<br>
				<label for="email">Email</label>
				<br>
				<input type="email" id="email" name="email" size="64" placeholder="Email" required autofocus>
				<br>
				<label for="password">Password</label>
				<br>
				<input type="password" id="password" name="password" size="64" placeholder="Password" required autofocus>
				<br>
				<label for="password2">Conferma password:</label>
				<br>
				<input type="password" id="password2" name="password2" size="64" placeholder="Conferma Password" required autofocus>
				<p id="password2error" style="color:red"></p>
				<br>
				<label for="data">Data di nascita:</label>
				<br>
				<input type="date" id="data" name="data" required autofocus>
				<br>
				<label for="indirizzo">Indirizzo:</label>
				<br>
				<input type="text" id="indirizzo" name="indirizzo" size="64" placeholder="Indirizzo, Civico" required autofocus>
				<br>
				<input type="submit" value="Registrati" size="32">
				<br>
        	</form>
        </fieldset>
    </div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>