<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
</head>

<body>
 	<%@include file="header.jsp" %>  
 	
 	<div class="first-container">
 		<div class="shop-bar" style="">
			<form>
				<label for="search">Cerca un gioco: </label>
				<input type="text" id="search" name="search" placeholder="Inserisci il nome del gioco">
				<input type="submit" value="Cerca">
			</form>
		</div>
		
		<br><br><br>
		
		<%@page import="java.util.Collection,it.project.bean.GameBean,it.project.model.GameModel" %>
			<ul class="gameszone">
				<%
					Collection<GameBean> games = new GameModel().doRetrieveAll("ASC");
				    if(!games.isEmpty())
				    {
				    	for(GameBean game : games)
				    	{
				    		out.println("<li class=\"gameinfo\">");
				    		out.println("<img src=\"" + game.getPreview() + "\">");
				    		out.println("<aside>");
				    		out.println("<h4>" + game.getName()+"</h4>");
				    		out.println("<p> Costo: " + game.getPrice() + "<br>" + game.getDescription() + "</p>");
				    		out.println("</aside>");
				    		out.println("<button onclick=\"setValue('"+new GameModel().doRetrieveKey(game.getName())+"')\">Add to Cart</button>");
				    		out.println("<br>");
				    		out.println("</li>");
				    	}
				    	
				    }
				%>
			</ul>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>