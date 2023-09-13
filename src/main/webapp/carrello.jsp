<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
</head>

<body>

	<%@include file="loginerror.jsp" %>

 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 	
 		<%@ page import="it.project.model.Carrello,it.project.model.GameModel,it.project.bean.GameBean" %>
 		<%
 		
 			Carrello carrello;
 			if(request.getSession().getAttribute("cart") != null)
 			{
 				carrello = (Carrello) request.getSession().getAttribute("cart");
 				GameBean bean;
 				int product = 1;
 				for(String key : carrello.getProducts().keySet())
 				{
 					bean = new GameModel().doRetrieveByKey(key);
 					if(bean == null) {
 						out.print("console.log('Errore durante il caricamento del prodotto'"+key+")");
 						continue;
 					}
 					String idp = "id"+String.valueOf(product);
 					String qp = "q"+String.valueOf(product);
 					out.print("<li class=\"gameinfo\">");
		    		out.print("<img src=\"" + bean.getPreview() + "\">");
		    		out.print("<aside>");
		    		out.print("<h4>" + bean.getName()+"</h4>");
		    		out.print("<p> Costo: " + bean.getPrice() + "<br>" + bean.getDescription() + "</p>");
		    		out.print("</aside>");
		    		out.print("Quantità<br><input type=\"number\" width=\"10%\">");
		    		out.print("<br>");
		    		out.print("</li>");
 				}
 				
 				
 			}
 		
 		%>
 		
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>