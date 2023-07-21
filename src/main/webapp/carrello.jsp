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
 	
 		<%@ page import="it.project.model.Carrello" %>
 		<%
 		
 			Carrello carrello;
 			if(request.getSession().getAttribute("cart") != null)
 			{
 				carrello = (Carrello) request.getSession().getAttribute("cart");
 				for(String key : carrello.getProducts().keySet())
 				{
 					out.print(key + "<br>");
 				}
 			}
 		
 		%>
 		
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>