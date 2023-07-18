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
			<form action="CercaProdotto" method="post">
				<label for="search" style="font-size: 18px;">Cerca un gioco: </label>
				<input type="text" id="search" name="search" placeholder="Inserisci il nome del gioco" style="height: 18px;width: 200px;">
				<input type="submit" value="Cerca" style="width: 50px;height: 22px;">
			</form>
		</div>
		
		<br><br><br>
		
		<%@page import="java.util.Collection,it.project.bean.GameBean,it.project.model.GameModel" %>
			<ul class="gameszone">
				<%
					Collection<GameBean> games = new GameModel().doRetrieveAll("ASC");
				    String button,start;
				    if(request.getSession().getAttribute("userEmail") != null) button = "Add to Cart";
				    else button = "Locked";
				    
				    start = request.getParameter("start_name");
				    if(start.equals("NoFilter")) start = "";
				    
				    if(!games.isEmpty())
				    {
				    	for(GameBean game : games)
				    	{
				    		if(game.getName().startsWith(start))
				    		{
				    			out.println("<li class=\"gameinfo\">");
					    		out.println("<img src=\"" + game.getPreview() + "\">");
					    		out.println("<aside>");
					    		out.println("<h4><a href=\"game.jsp?gamename="+game.getName()+"\" style=\"color: red;\">" + game.getName()+"</a></h4>");
					    		out.println("<p> Costo: " + game.getPrice() + "<br>" + game.getDescription() + "</p>");
					    		out.println("</aside>");
					    		
					    		out.println("<button onclick=\"setValue('"+new GameModel().doRetrieveKey(game.getName())+"')\">"+button+"</button>");
					    		out.println("<br>");
					    		out.println("</li>");
				    		}
				    	}
				    	
				    }
				%>
			</ul>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>