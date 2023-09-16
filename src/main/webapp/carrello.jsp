<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
	<script src="assets/js/carrello.js"></script>
</head>

<body>

	<%@ page import="it.project.model.Carrello,it.project.model.GameModel,it.project.bean.GameBean" %>
	
	<%@include file="loginerror.jsp" %>

	<%
		Carrello cart = (Carrello) request.getSession().getAttribute("cart");
		if(cart == null || cart.isEmpty())
		{
			request.getSession().setAttribute("userMessage", "Il carrello è vuoto. Per eseguire un acquisto, aggiungi dei prodotti nel carrello");
		}
	
	%>

 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center" style="justify-content: unset">
 	
 		<%@include file="errorbox.jsp" %>
 		
 		<form method="POST" class="carrelloform" id="carrelloform" name="carrelloform">
 		
 			
 			<%
 			
 				if(cart != null && !cart.isEmpty())
 				{
 					out.print("<ul class=\"gameszone\">");
 					GameBean bean;
 					int product = 1;
 					for(String key : cart.getProducts().keySet())
 					{
 						bean = new GameModel().doRetrieveByKey(key);
 						if(bean == null) {
 							out.print("console.log('Errore durante il caricamento del prodotto'"+key+")");
 							continue;
 						}
 						String idp = "id"+String.valueOf(product);
 						String qp = "q"+String.valueOf(product);
 						String dp = "del"+String.valueOf(product);
 						out.print("<li class=\"gameinfo\">");
 	    				out.print("<img src=\"" + bean.getPreview() + "\">");
 	    				out.print("<aside>");
 	    				out.print("<h4>" + bean.getName()+"</h4>");
 	    				out.print("<p> Costo: " + bean.getPrice() + "<br>" + bean.getDescription() + "</p>");
 	    				out.print("</aside>");
 	    				out.print("<input type=\"hidden\" name=\"" + idp + "\" id=\"" + idp + "\" value=\"" + key + "\">");
 	    				out.print("Quantità <br><input type=\"number\" class=\"qinput\" value=\"" + cart.getQuantity().get(key) + "\" name=\"" + qp + "\" id=\"" + qp + "\">");
 	    				out.print("<br>");
 	    				out.print("<input type=\"submit\" class=\"qremove\" value=\"X\" onclick=\"deleteGame('" + key + "')\">");
 	    				out.print("</li>");
 					}
 					out.print("</ul>");
 					
 					out.print("<br><br>");
 					out.print("<input type=\"submit\" class=\"qsubmit\" value=\"Elimina il carrello\" onclick=\"cartDelete()\">");
 					out.print("<input type=\"submit\" class=\"qsubmit\" value=\"Prosegui con l'acquisto\" onclick=\"goToCheckOut()\">");
 				}
 		
 			%>
 		
 		</form>
 		
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>