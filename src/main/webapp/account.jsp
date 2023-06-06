<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
    <style>
        .showcont {
        	display: contents;
        }

        .hidecont {
          display: none;
        }
	</style>
    <script src="assets/js/account.js"></script>
</head>

<body>

	<%@include file="loginerror.jsp" %>  
	
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 	
 		<%@include file="errorbox.jsp" %>
 		
 		<div class="account-user-div">
 		
			<div class="account-sidebar">
	  			<a href="#" class="active " onclick="visualize('profile')">Gestione account</a>
	  			<a href="#" onclick="visualize('pmethod')">Metodi di pagamento</a>
	  			<a href="#" onclick="visualize('orders')">Ordini</a>
			</div>
			
			<div class="account-content">
				
				<div id="profile" class="hidecont">
				
					<%@ page import="it.project.bean.UserBean,it.project.model.UserModel,it.project.Utility" %>
					<%
						String aemail = (String) request.getSession().getAttribute("userEmail");
						UserBean userbean = new UserModel().doRetrieveByKey(email);
						out.print("<form action=\"Account\" method=\"post\" class=\"center\" onsubmit=\"checkInfo()\">");
						out.print("<label for=\"nome\">Nome: </label>");
						out.print("<input type=\"text\" id=\"nome\" name=\"nome\" size=\"32\" placeholder=\"Nome\" value=\"" + userbean.getName() + "\" required autofocus readonly>");
						out.print("<p id=\"errorname\" style=\"color:red\"></p>");
						out.print("<br>");
						out.print("<label for=\"cognome\">Cognome: </label>");
						out.print("<input type=\"text\" id=\"cognome\" name=\"cognome\" size=\"32\" placeholder=\"Cognome\" value=\"" + userbean.getSurname() + "\" required autofocus readonly>");
						out.print("<p id=\"errorsurname\" style=\"color:red\"></p>");
						out.print("<br>");
						out.print("<label for=\"data\">Data di nascita: </label>");
						out.print("<input type=\"date\" id=\"data\" name=\"data\" value=\"" + Utility.dateToMysql(userbean.getBornDate()) + "\" required autofocus readonly>");
						out.print("<br>");
						out.print("<label for=\"indirizzo\">Indirizzo: </label>");
						out.print("<input type=\"text\" id=\"indirizzo\" name=\"indirizzo\" size=\"32\" placeholder=\"Indirizzo, Civico\" value=\"" + userbean.getAddress() + "\" required autofocus readonly>");
						out.print("<br>");
						out.print("<input type=\"button\" value=\"Modifica\" size=\"16\" onclick=\"unlockFields()\">");
						out.print("<input type=\"submit\" value=\"Salva\" size=\"16\">");
						out.print("<br>");
						out.print("</form>");
					%>
				</div>
				
				<div id="pmethod" class="hidecont">
				
				</div>
				
				<div id="orders" class="hidecont">
				</div>
				
			</div>
		
		
		
		</div>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>