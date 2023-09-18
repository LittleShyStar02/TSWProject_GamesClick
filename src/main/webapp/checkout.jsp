<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
</head>

<body>
	
	<%@ page import="it.project.model.Carrello,it.project.model.GameModel,it.project.bean.GameBean,it.project.bean.MethodBean,it.project.model.MethodModel,java.util.Collection" %>

	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 		
 		<div class="checkout-content center">
 		
 			<%
 				Carrello cart = (Carrello) request.getSession().getAttribute("cart");
 				double price = 0.0;
 				double amount;
 				
 				GameBean game;
 				out.print("<ul class=\"gameszone\">");
 				for(String key : cart.getProducts().keySet())
 				{
 					game = new GameModel().doRetrieveByKey(key);
 					if(game == null) {
						out.print("console.log('Errore durante il caricamento del prodotto'"+key+")");
						continue;
					}
 					
 					amount = game.getPrice()*cart.getProducts().get(key);
 					price += amount;
 					out.print("<li class=\"gameinfo\">");
	    			out.print("<img src=\"" + game.getPreview() + "\">");
	    			out.print("<aside>");
	    			out.print("<h4>" + game.getName()+"</h4>");
	    			out.print("<p>" + game.getDescription() + "</p>");
	    			out.print("</aside>");
	    			out.print("<p>Prezzo "+amount+"€ </p>");
	    			out.print("</li>");
 				}
 				out.print("</ul>");
 				out.println("<br><br>");
 				out.println("<p class=\"checkout-text\">Totale   " + price+"</p>");
 			
 			%>
 			<br><br><br>
 			<form action="CompleteOrder" method="POST">
 				<input type="hidden" id="selected" name="selected">
 				<label>Seleziona il metodo di pagamento</label>
 				<br><br>
 				<%
 					String name;
 					Collection<MethodBean> coll = new MethodModel().doRetrieveAll("ASC");
 					coll = coll.stream().filter(b -> b.getEmail().equals(request.getSession().getAttribute("userEmail"))).toList();
 					int method = 1;
 					String m = "method";
 					for(MethodBean bean : coll)
 					{
 						String tmp = m+String.valueOf(method);
 						name = bean.getName();
 						out.print("<input type=\"radio\" id=\""+tmp+"\" name=\""+tmp+"\" value=\""+name+"\">");
 						out.print("<label for=\""+tmp+"\">"+name+"</label><br>");
 						method++;
 					}
 					
 				%>
 				<br><br>
 				<input class="qsubmit" type="submit" value="Completa Acquisto">
 			</form> 
 		
 		</div>
 		
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>