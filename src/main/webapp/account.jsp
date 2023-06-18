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
 	
 	<div class="first-container center" style="justify-content: unset">
 	
 		<%@include file="errorbox.jsp" %>
 		
 		<ul class="admin-ul" style="list-style-type: none;">
 			<li><button class="account-button" onclick="visualize('userprofile')">Profilo</button></li>
 			<li><button class="account-button" onclick="visualize('payments')">Metodi di pagamento</button></li>
 			<li><button class="account-button" onclick="visualize('orders')">Ordini</button></li>
 		</ul>
 		
 		<br><br>
 		
 		<%
 			String uemail = (String) request.getSession().getAttribute("userEmail");
 		%>
 		
 		<div id="userprofile" class="hidecont">
 		
 			<fieldset class="fieldset-form" style="border: none;">
 				<legend style="color: orange;">Le tue info</legend>
 				
 				
 				
 				<%
 					UserBean ub = new UserModel().doRetrieveByKey(email);
 					out.print("<p style=\"font-size: 18px;\">");
 					out.print("Nome: " + ub.getName() + "<br>");
 					out.print("Cognome: " + ub.getSurname() + "<br>");
 					out.print("Email: " + ub.getEmail() + "<br>");
 					out.print("Data Di Nascita: " + Utility.dateToString(ub.getBornDate()) + "<br>");
 					out.print("Indirizzo: " + ub.getAddress() + "<br>");
 					out.print("</p>");
 				%>
 			</fieldset>
 		
 		</div>
 		
 		<div id="payments" class="hidecont">
 		
 			<fieldset class="fieldset-form" style="border: none;">
 			
 				<legend style="color: orange;font-size: 18px;">Aggiungi Metodo di Pagamento</legend>
 				<form>
 					
 					<label for="payname"></label>
 					<input type="text" id="payname" name="payname">
 					<label for="payinfo"></label>
 					<input type="text" id="payinfo" name="payinfo">
 					<%
 						out.print("<input type=\"text\" id=\"payname\" name=\"payname\" value=\"" + uemail +"\">");
 					%>
 					
 				</form>
 			
 			</fieldset>
 		
 		</div>
 		
 		<div id="orders" class="hidecont">
 		
 			
 		
 		</div>
 		
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>