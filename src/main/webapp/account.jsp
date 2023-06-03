<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
    <style>
        fieldset {
        	display: none;
        }

        .show_cont {
          color: white;
          display: contents;
        }
	</style>
    <script>
        function showcont(contToShow, contToHide, contToHide2) {
        	contToShow = document.getElementById(contToShow);
        	contToHide = document.getElementById(contToHide);
        	contToHide2 = document.getElementById(contToHide2);
          var userInput = fieldsetToShow.querySelector("input");
          contToShow.classList.add("show_cont");
          contToHide.classList.remove("show_cont");
          contToHide2.classList.remove("show_cont");

          setTimeout(function () {
            userInput.focus();
          }, 500);
        }
      </script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>

	<%@include file="loginerror.jsp" %>  
	
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 	
 		<div class="user-div">
 		
			<div class="sidebar">
	  			<a class="active " onclick="showcont('account', 'metodi', 'ordini')" href="#home">Gestione account</a>
	  			<a href="#news" onclick="showcont('metodi', 'account' ,'ordini')">Metodi di pagamento</a>
	  			<a href="#contact" onclick="showcont('ordini', 'metodi', 'account')">Ordini</a>
			</div>
			
			<div class="content center">
				<fieldset id="account">
					<form action="" >
					<label for="nome">Nome:</label>
					<br>
					<label for="cognome">Cognome:</label>
					<br>
					<label for="data">Data di nascita:</label>
					<br>
					<label for="ind">Indirizzo:</label>
					<br>
					<label for="email">Email:</label>
					<br>
					<label for="pass">Password:</label>
					</form>
				</fieldset>
				
				<fieldset id="metodi">
					<form action="" >
						<p>Prova</p>
					</form>
				</fieldset>	
				
				<fieldset id="ordini">
					<form action="" id="ordini">
						<p>Prova1</p>
					</form>
				</fieldset>
			</div>
		
		
		
		</div>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>