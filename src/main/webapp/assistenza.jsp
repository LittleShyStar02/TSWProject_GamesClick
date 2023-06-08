<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
	<script type="text/javascript">
		function doAlert()
		{
			alert("Richiesta inviata correttamente");
		}
	</script>
</head>

<body>
 	<%@include file="header.jsp" %>
 	 
 	<div class="first-container center">
 		<h1 style="color: rgb(255,0,255);">Assistenza</h1>
		<fieldset class="fieldset-form">
		<legend style="font-size: 28px;">Contattaci! Ti riponderemo al più presto!</legend>
		<br>
      		<form name="formAssistenza" method="post" onsubmit="doAlert()" class="form-w1 center">
				<label for="email">Email</label>
				<br><br>
				<input type="text" name="email" size="64" placeholder="Email" required>
				<br><br>
				<label for="object">Oggetto</label>
				<br><br>
				<input type="text" name="object" size="64" placeholder="Oggetto" required>
				<br><br>
				<label for="note">Richiesta</label>
				<br><br>
				<textarea class="textarea-lock" name="note" placeholder="Inserisci il testo qui..." required></textarea>
				<br><br>
				<input type="submit" value="Invia Richiesta">
				<br><br>
			</form>
		</fieldset>
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>