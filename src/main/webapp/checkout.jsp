<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
	<script>
		function select(id)
		{
			document.getElementById('selected').value = id;
		}
	</script>
</head>

<body>
	
	<%@ page import="it.project.model.Carrello,it.project.model.GameModel,it.project.bean.GameBean,it.project.bean.MethodBean,it.project.model.MethodModel,java.util.Collection" %>

	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 		
 		<div class="checkout-content center">
 		
 			<%
 				Carrello cart = (Carrello) request.getSession().getAttribute("cart");
 				double price = 0.0;
 				
 				GameBean game;
 				for(String key : cart.getProducts().keySet())
 				{
 					game = new GameModel().doRetrieveByKey(key);
 					if(game == null) continue;
 					price += game.getPrice()*cart.getProducts().get(key);
 					out.print("<p class=\"checkout-text\">"+cart.getProducts().get(key)+"x"+game.getName()+" - €"+game.getPrice()*cart.getProducts().get(key)+"</p><br>");
 				}
 				out.println("<br><br>");
 				out.println("<p class=\"checkout-text\">Totale   " + price+"</p>");
 			
 			%>
 			<br><br><br>
 			<form action="CompleteOrder" method="POST">
 				<input type="hidden" id="selected" name="selected">
 				<label>Seleziona il metodo di pagamento</label><br>
 				<%
 					String name;
 					Collection<MethodBean> coll = new MethodModel().doRetrieveAll("ASC");
 					coll = coll.stream().filter(b -> b.getEmail().equals(request.getSession().getAttribute("userEmail"))).toList();
 					for(MethodBean bean : coll)
 					{
 						name = bean.getName();
 						out.print("<input type=\"radio\" id=\""+name+"\" name=\""+name+"\" onclick=\"select('"+name+"')\">");
 						out.print("<label for=\""+name+"\">"+name+"</label><br>");
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