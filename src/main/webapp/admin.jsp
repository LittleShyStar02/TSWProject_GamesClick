<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <!DOCTYPE html>

  <html>

  <head>
    <%@include file="head.jsp" %>
    <style>
        .hidecont {
          display: none;
        }

        .showcont {
          color: white;
          display: contents;
        }
	</style>
    <script src="assets/js/admin.js"></script>
  </head>

  <%
  	String onload = "visualize({first},{second},{type})";
  	if(request.getParameter("first") != null) onload = onload.replace("{first}","'"+request.getParameter("first")+"'");
  	else onload = onload.replace("{first}","''");
  	
  	if(request.getParameter("second") != null) onload = onload.replace("{second}","'"+request.getParameter("second")+"'");
  	else onload = onload.replace("{second}","''");
  	
  	if(request.getParameter("type") != null) onload = onload.replace("{type}","'"+request.getParameter("type")+"'");
  	else onload = onload.replace("{type}","''");
  	
  %>

  <body onload=<% out.print("\"" + onload + "\""); %>>
  	<%@ page import="java.sql.SQLException,it.project.bean.UserBean,it.project.model.UserModel" %>
  	<%
  		String adminemail = (String) request.getSession().getAttribute("userEmail");
		String message = null;
		
		try
		{
			if(adminemail != null)
			{
				UserBean userAdmin = new UserModel().doRetrieveByKey(adminemail);
				if(!userAdmin.isAdmin())
				{
					message = "Non hai il permesso di accedere alla pagina di amministrazione";
				}
			}
			else
			{
				message = "Non puoi accedere a questa pagina se non sei autenticato";
			}
		}
		catch(SQLException e)
		{
			message = "Errore durante l'accesso alla pagina di amministrazione";
		}
		if(message != null)
		{
			request.getSession().setAttribute("userMessage", message);
			request.getServletContext().getRequestDispatcher("/Home").forward(request, response);
		}
  	%>
  	
    <%@include file="header.jsp" %>

      <div class="first-container center" style="justify-content: unset;">

		<%@include file="errorbox.jsp" %>
		<br>
		
        <fieldset class="fieldset-form" style="right: 3%;width: 90%;border: none;padding: 2%">
          <legend style="font-size: 20px;color: pink;">Cosa vuoi aggiornare?</legend>
          <form action="AdminPanel" method="post" id="firstForm">
          	<input type="text" id="firstToShow" name="firstToShow" style="display: none;">
          	<input type="text" id="secondToShow" name="secondToShow" style="display: none;">
          	<input type="text" id="dataType" name="dataType" style="display: none;">
            <ul class="admin-ul">
              <li><input type="submit" value="Categorie Giochi" class="admin-binput" onclick="setParameter('firstForm','searchthing',null,'category')"></li>
              <li><input type="submit" value="Console" class="admin-binput" onclick="setParameter('firstForm','searchthing',null,'console')"></li>
              <li><input type="submit" value="Giochi" class="admin-binput" onclick="setParameter('firstForm','searchthing',null,'game')"></li>
              <li><input type="button" value="Amministratori" class="admin-binput" onclick="visualize('actionadmin',null,null)"></li>
              <li><input type="submit" value="Cerca Utente" class="admin-binput" onclick="setParameter('firstForm','searchthing',null,'user')"></li>
            </ul>
          </form>
        </fieldset>
        <br>
        
        <div id="searchthing" class="hidecont">
          <br>
          <fieldset class="fieldset-form" style="padding: 2%;border: none">
          	<legend id="search_type_text" style="font-size: 20px;color: pink;"></legend>
          	<form action="AdminPanel" method="post" id="secondForm" class="adminManager" onsubmit="setParameter('secondForm','searchthing',getFromType(),getInputDataType())">
          		<input type="text" id="firstToShow2" name="firstToShow" style="display: none;">
          		<input type="text" id="secondToShow2" name="secondToShow" style="display: none;">
          		<input type="text" id="dataType2" name="dataType" style="display: none;">
          		<input type="text" id="input_datatype" name="input_datatype" style="display: none;">
          		<label for="search_datatype" id="label_datatype"></label>
          		<br>
          		<input type="text" id="search_datatype" name="search_datatype" size=32 required>
          		<input type="submit" value="Trova" class="admin-binput">
          		<div id="catinfo" class="hidecont">
        			Categoria
        		</div>
        
        		<div id="coninfo" class="hidecont">
        			Console
        		</div>
        
       	 		<div id="gameinfo" class="hidecont">
        			Game
        		</div>
          	</form>
          </fieldset>
        </div>
        
        <div id="userinfo" class="hidecont">
        	<%@ page import="java.text.SimpleDateFormat,it.project.Utility" %>
        	<%
        	
        		String search_mail = request.getParameter("search_datatype");
          		UserBean searchuser = new UserModel().doRetrieveByKey(search_mail);
          		if(searchuser.getEmail() == null) out.print("<p>Utente non trovato</p>");
          		else
          		{
          			out.print("<fieldset class=\"fieldset-form\"><legend style=\"font-size: 20px;\">Informazioni Utente</legend><p>");
          			out.print("Nome: " + searchuser.getName() + "<br>");
          			out.print("Cognome: " + searchuser.getSurname() + "<br>");
          			out.print("Email: " + searchuser.getEmail() + "<br>");
          			out.print("Data Di Nascita: " + Utility.dateToString(searchuser.getBornDate()) + "<br>");
          			out.print("Indirizzo: " + searchuser.getAddress() +"<br>");
          			String role = "Ruolo: ";
          			if(searchuser.isAdmin()) role = role.concat("Amministratore");
          			else role = role.concat("Utente");
          			out.print("</p>");
          		}
        	%>
        	
        </div>
        
        <div id="actionadmin" class="fieldset-form hidecont">
          <br>
          <fieldset class="fieldset-form" style="padding: 2%;border: none">
          	<legend style="font-size: 20px;color: pink;">Gestione amministratori</legend>
          	<form action="AdminManager" method="post" id="adminForm" class="adminManager">
          		<input type="text" id="adminAction" name="adminAction" style="display: none;">
          		<label for="adminEmail">Inserisci l'email</label>
          		<br>
          		<input type="email" id="adminEmail" name="adminEmail" size=32 placeholder="Email" required>
          		<br><br>
          		<input type="submit" value="Rendi amministratore" onclick="setAction('adminAction','adminForm','add')">
          		<input type="submit" value="Rendi utente" onclick="setAction('adminAction','adminForm','remove')">
          	</form>
          </fieldset>
        </div>
      </div>
      
      <%@include file="footer.jsp" %>
  </body>

  </html>