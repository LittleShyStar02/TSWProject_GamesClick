<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>

<!DOCTYPE html>

<html lang="it">

<head>
	<%@include file="head.jsp" %>
	<script>
	
		function dateASC()
		{
			document.getElementById('date').value = 'ASC';
		}
		
		function dateDESC()
		{
			document.getElementById('date').value = 'DESC';
		}
		
	</script>
</head>

<body>

	<%@include file="loginerror.jsp" %>
	<%@include file="header.jsp" %>  
 	
 	<div class="first-container center" style="justify-content: unset">
 	
 		
 		<h3>Filtri</h3>
 		<form action="OrdersVisualizer" method="POST" id="orderform">
 			<%
 				String date = request.getParameter("odate");
 				if(date == null)
 				{
 					out.print("<input type=\"hidden\" id=\"date\" name=\"date\" value=\"ASC\">");
 				}
 				else
 				{
 					out.print("<input type=\"hidden\" id=\"date\" name=\"date\" value=\""+date+"\">");
 				}
 			%>
 			<input type="submit" class="qsubmit" id="dateasc" name="dateasc" value="Data ASC" onclick="dateASC()">
 			<input type="submit" class="qsubmit" id="datedesc" name="datedesc" value="Data DESC" onclick="dateDESC()">
 			<br><br><br>
 			<%
 				UserBean user = new UserModel().doRetrieveByKey(email);
 				String fclient = request.getParameter("client");
 				if(user.isAdmin())
 				{
 					out.print("<input type=\"text\" class=\"order-text\" id=\"username\" name=\"username\" value=\""+fclient+"\">");
 					out.print("<input type=\"submit\" class=\"qsubmit\">");
 				}
 				else
 				{
 					out.print("<input type=\"hidden\" id=\"username\" name=\"username\" value=\"NoFilter\">");
 				}
 				
 			%>
 		</form>
 		
 		<br><br>
 		
 		<%@ page import="it.project.Utility,java.util.ArrayList,java.util.List,it.project.bean.UserBean,it.project.model.UserModel,java.util.Collection,it.project.model.Carrello,it.project.model.GameModel,it.project.bean.GameBean,it.project.bean.AcquistoBean,it.project.model.AcquistoModel" %>
 		<% 
 			String dateorder = request.getParameter("odate");
 			String name = request.getParameter("client");
 			
 			AcquistoModel amodel = new AcquistoModel();
 			GameModel gmodel = new GameModel();
 			UserModel umodel = new UserModel();
 			
 			Collection<AcquistoBean> acoll = amodel.doRetrieveAll(dateorder);
 			List<AcquistoBean> list = new ArrayList<>();
 			
 			if(!user.isAdmin())
 			{
 				int id = umodel.doRetrieveKey((String)request.getSession().getAttribute("userEmail"));
 				list = acoll.stream().filter(ac -> ac.getIDUtente() == id).toList();
 				
 			}else {
 				if(!name.equals("NoFilter"))
 	 			{
 	 				for(AcquistoBean bean : acoll)
 	 	 			{
 	 	 				String usermail = umodel.doRetrieveEmailById(bean.getIDUtente());
 	 	 				if(usermail.startsWith(name)) list.add(bean);
 	 	 			}
 	 			}else list = acoll.stream().toList();
 			}
 		
 			out.print("<ul class=\"gameszone\">");
 			
 			UserBean ubean;
 			GameBean gbean;
 			for(AcquistoBean bean : list)
 			{
 				ubean = umodel.doRetrieveByKey(umodel.doRetrieveEmailById(bean.getIDUtente()));
 				gbean = gmodel.doRetrieveByKey(gmodel.doRetrieveNameById(bean.getIDGioco()));
 				
 				out.print("<li class=\"gameinfo\">");
    			out.print("<img src=\"" + gbean.getPreview() + "\">");
    			out.print("<aside>");
    			out.print("<h4>" + gbean.getName()+"</h4>");
    			if(user.isAdmin()) out.print("<p> Utente: " + ubean.getEmail() + "</p>");
    			out.print("<p> Data Acquisto: " + Utility.dateToString(bean.getDate()) + "</p>");
    			out.print("<p> Quantità: " + bean.getQuantity() + "</p>");
    			out.print("<p> Prezzo originale: " + gbean.getPrice() + "</p>");
    			out.print("</aside>");
    			out.print("<p> Totale<br>"+gbean.getPrice()*bean.getQuantity()+"€ </p>");
    			out.print("</li>");
 			}
 			
 			out.print("</ul>");
 		%>
 		
 	</div>
 	
 	<%@include file="footer.jsp" %>
</body>

</html>