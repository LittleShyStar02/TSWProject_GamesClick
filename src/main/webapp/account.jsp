<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

<head lang="it">
	<%@include file="head.jsp" %>
    <style>
        .hidecont {
          display: none;
        }
        
        .showcont {
        	color: white;
        	display: contents;
        }
	</style>
    <script src="assets/js/account.js"></script>
</head>

<body>
	<%@ page import="it.project.bean.UserBean,it.project.model.UserModel,it.project.Utility" %>
	<%@include file="loginerror.jsp" %>  
	
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 	
 		<%@include file="errorbox.jsp" %>
 		
 		<ul style="list-style-type: none;">
 			<li><button class="account-page-button" onclick="visualize('userprofile');">Profilo</button></li>
 			<li><button class="account-page-button">Metodi di pagamento</button></li>
 			<li><button class="account-page-button">Ordini</button></li>
 		</ul>
 		
 		<br><br>
 		
 		<div id="userprofile" class="hidecont">
 		
 			<fieldset class="fieldset-form" style="border: none;">
 				<legend>Le tue info</legend>
 				
 				<%
 					String uemail = (String) request.getSession().getAttribute("userEmail");
 					UserBean ub = new UserModel().doRetrieveByKey(email);
 					out.print("<p>");
 					out.print("Nome: " + ub.getName() + "<br>");
 					out.print("Cognome: " + ub.getSurname() + "<br>");
 					out.print("Email: " + ub.getEmail() + "<br>");
 					out.print("Data Di Nascita: " + Utility.dateToString(ub.getBornDate()) + "<br>");
 					out.print("Indirizzo: " + ub.getAddress() + "<br>");
 					out.print("</p>");
 				%>
 			</fieldset>
 		
 		</div>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>