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
			<legend><h1 style="color: red">Registrazione</h1></legend>
			<br>
			<form class="center">
				<label for="nome">Nome</label>
				<input type="text" id="nome" name="nome" placeholder="Nome" required>
				<br>
				<label for="cognome">Cognome</label>
				<input type="text" id="cognome" name="cognome" placeholder="Cognome" required>
				<br>
				<label for="email">Email</label>
				<input type="email" id="email" name="email" placeholder="Email" required>
				<br>
				<label for="password">Password</label>
				<input type="password" id="password" name="password" placeholder="Password" required>
				<br>
				<label for="conferma_password">Conferma password:</label>
				<input type="password" id="conferma_password" name="conferma_password" placeholder="Conferma Password" required>
				<br>
				<label for="data_di_nascita">Data di nascita:</label>
				<input type="date" id="data_di_nascita" name="data_di_nascita" required>
				<br>
				<input type="submit" value="Registrati">
				<br>
				</fieldset>
        	<!-- <div class="form-error"></div> -->
       	 	</form>
    </div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>