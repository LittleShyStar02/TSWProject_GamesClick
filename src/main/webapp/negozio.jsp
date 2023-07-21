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
				<label for="search" style="font-size: 18px;display: block:">Cerca un gioco: </label>
				<input type="text" id="search" name="search" placeholder="Inserisci il nome del gioco" style="height: 18px;width: 200px;">
				<input type="submit" value="Cerca" style="width: 50px;height: 22px;display: block:">
			</form>
		</div>
		
		<br><br><br>
		
		<%@page import="java.util.Collection,it.project.bean.GameBean,it.project.model.GameModel" %>
			<ul class="gameszone">
				<%
					Collection<GameBean> games = new GameModel().doRetrieveAll("ASC");
				    String button = null,start;
				    if(request.getSession().getAttribute("userEmail") == null) button = "Locked";
				    
				    start = request.getParameter("start_name");
				    if(start.equals("NoFilter")) start = "";
				    
				    if(!games.isEmpty())
				    {
				    	for(GameBean game : games)
				    	{
				    		if(button == null)
				    		{
				    			button = "<a href=\"AddCart?gamename="+game.getName()+"\">Add To Cart</a>";
				    		}
				    		if(game.getName().startsWith(start))
				    		{
				    			out.print("<li class=\"gameinfo\">");
					    		out.print("<img src=\"" + game.getPreview() + "\">");
					    		out.print("<aside>");
					    		out.print("<h4><a href=\"game.jsp?gamename="+game.getName()+"\" style=\"color: red;\">" + game.getName()+"</a></h4>");
					    		out.print("<p> Costo: " + game.getPrice() + "<br>" + game.getDescription() + "</p>");
					    		out.print("</aside>");
					    		out.print("<button>"+button+"</button>");
					    		out.print("<br>");
					    		out.print("</li>");
				    		}
				    	}
				    	
				    }
				%>
			</ul>
		
	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>