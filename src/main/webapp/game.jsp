<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>

<!DOCTYPE html>

<html>

<head>
	<%@include file="head.jsp" %>
</head>

<body>
	<%@ page import="java.util.Collection,java.sql.SQLException,it.project.bean.GameBean,it.project.bean.ConsoleBean,it.project.bean.CategoryBean,it.project.model.CategoryModel,it.project.model.GameModel,it.project.model.EsecuzioneGiocoModel,it.project.model.CategoriaGiocoModel" %>
	
	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center">
 	
 		<%
 			String name = request.getParameter("gamename");
 			if(name == null) request.getServletContext().getRequestDispatcher("/negozio.jsp").forward(request, response);
 			GameBean game = new GameModel().doRetrieveByKey(name);
 		%>
 		
 		
 		<div style="width: 90%;">
 			<h2><% out.print(game.getName()); %></h2>
 			<section class="gamesec">
 				<img class="gameimg" src="<% out.print(game.getPreview()); %>" alt="Errore di visualizzazione immagine">
 				<br><br>
 				<aside class="asidegame">
 				<p>
 					Prezzo: <% out.print(game.getPrice()); %><br>
 					Età minima: <% out.print(game.getMinAge()); %><br>
 					
 					<br><br>
 					
 					Console:<br>
 					<%
 						try
 						{
 							Collection<ConsoleBean> console = EsecuzioneGiocoModel.doRetrieveByGame(name);
 							if(!console.isEmpty())
 							{
 								for(ConsoleBean con : console)
 								{
 									out.print("- " + con.getName() + "<br>");
 								}
 							}
 						}
 						catch(SQLException e){}
 					%>
 					
 					<br><br>
 					
 					Categoria:<br>
 					<%
 						try
 						{
 							Collection<CategoryBean> category = CategoriaGiocoModel.doRetrieveByGame(name);
 							if(!category.isEmpty())
 							{
 								for(CategoryBean cat : category)
 								{
 									out.print("- " + cat.getName() + "<br>");
 								}
 							}
 						}
 						catch(SQLException e){}
 					%>
 				</p>
 				</aside>
 			</section>
 			<h2>Descrizione</h2><br>
 			<p><% out.print(game.getDescription()); %></p>
 			
 			<%
 				if(request.getSession().getAttribute("userEmail") != null)
 				{
 					//code
 				}
 			%>
 			
 		</div>
 	
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>