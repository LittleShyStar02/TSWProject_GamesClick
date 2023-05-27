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

  <body>
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
		<br><br>
        <fieldset class="fieldset-form" style="right: 3%;width: 90%;border: none;padding: 2%">
          <legend style="font-size: 20px;color: pink;">Cosa vuoi aggiornare?</legend>
          <form action="" method="post">
            <ul class="admin-ul">
              <li><input type="button" value="Categorie Giochi" class="admin-binput" onclick="toggle('actioncat',null)"></li>
              <li><input type="button" value="Console" class="admin-binput" onclick="toggle('actioncon',null)"></li>
              <li><input type="button" value="Giochi" class="admin-binput" onclick="toggle('actiongame',null)"></li>
              <li><input type="button" value="Amministratori" class="admin-binput" onclick="toggle('actionadmin',null)"></li>
            </ul>
          </form>
        </fieldset>
        <br><br>

        <div id="actioncat" class="hidecont">
          <br>
          <fieldset class="fieldset-form" style="padding: 2%;border: none">
          	<legend style="font-size: 20px;color: pink;">Gestione amministratori</legend>
          	<form action="AdminManager" method="post" id="adminForm" class="adminManager">
          		<input type="text" id="categoryName" name="categoryName" onkeypress="categoryAutoComplete()">
          		<div class="showList">
          		</div>
          	</form>
          </fieldset>
        </div>
        
        <div id="actioncon" class="hidecont">
          Azione Console
        </div>
        
        <div id="actiongame" class="hidecont">
          Azione Gioco
        </div>
        
        <div id="actionadmin" class="fieldset-form hidecont">
          <br>
          <fieldset class="fieldset-form" style="padding: 2%;border: none">
          	<legend style="font-size: 20px;color: pink;">Gestione amministratori</legend>
          	<form action="AdminManager" method="post" id="adminForm" class="adminManager">
          		<input type="text" id="adminAction" name="adminAction" style="display: none;">
          		<label for="adminEmail">Inserisci l'email dell'amministratore</label>
          		<br>
          		<input type="email" id="adminEmail" name="adminEmail" size=32 placeholder="Email" required>
          		<br><br>
          		<input type="button" value="Rendi amministratore" onclick="setAction('adminAction','adminForm','add')">
          		<input type="button" value="Rendi utente" onclick="setAction('adminAction','adminForm','remove')">
          	</form>
          </fieldset>
        </div>
      </div>
      
      <%@include file="footer.jsp" %>
  </body>

  </html>