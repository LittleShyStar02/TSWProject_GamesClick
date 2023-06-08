<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

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
				<br><br>
				<input type="text" id="nome" name="nome" placeholder="Nome" required autofocus>
				<p id="errorname" style="color:red"></p>
				<br><br>
				<label for="cognome">Cognome</label>
				<br><br>
				<input type="text" id="cognome" name="cognome" placeholder="Cognome" required autofocus>
				<p id="errorsurname" style="color:red"></p>
				<br><br>
				<label for="email">Email</label>
				<br><br>
				<input type="email" id="email" name="email" placeholder="Email" required autofocus>
				<br><br>
				<label for="password">Password</label>
				<br><br>
				<input type="password" id="password" name="password" placeholder="Password" required autofocus>
				<br><br>
				<label for="password2">Conferma password:</label>
				<br><br>
				<input type="password" id="password2" name="password2" placeholder="Conferma Password" required autofocus>
				<p id="password2error" style="color:red"></p>
				<br><br>
				<label for="data">Data di nascita:</label>
				<br><br>
				<input type="date" id="data" name="data" required autofocus>
				<br><br>
				<label for="indirizzo">Indirizzo:</label>
				<br><br>
				<input type="text" id="indirizzo" name="indirizzo"placeholder="Indirizzo, Civico" required autofocus>
				<br><br>
				<input type="submit" value="Registrati">
				<br><br>
        	</form>
        </fieldset>
    </div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>