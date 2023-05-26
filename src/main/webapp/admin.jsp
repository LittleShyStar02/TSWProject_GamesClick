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
          display: inline;
        }
	</style>
    <script>
    	function toggle(firstToShow, secondToShow)
    	{
    		document.getElementById('actioncat').classList.remove('showcont');
        document.getElementById('actioncat').classList.add('hidecont');

        document.getElementById('actioncon').classList.remove('showcont');
        document.getElementById('actioncon').classList.add('hidecont');

        document.getElementById('actiongame').classList.remove('showcont');
        document.getElementById('actiongame').classList.add('hidecont');

        document.getElementById('actionadmin').classList.remove('showcont');
        document.getElementById('actionadmin').classList.add('hidecont');

        document.getElementById(firstToShow).classList.add('showcont');
        if(secondToShow != null)
        {
          document.getElementById(secondToShow).classList.add('showcont');
        }
    	}
    </script>
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

      <div class="first-container">

        <fieldset class="fieldset-form">
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


        <div id="actioncat" class="hidecont">
          Azione Categoria
        </div>
        
        <div id="actioncon" class="hidecont">
          Azione Console
        </div>
        
        <div id="actiongame" class="hidecont">
          Azione Gioco
        </div>
        
        <div id="actionadmin" class="hidecont">
          Azione Amministratore
        </div>

      </div>
      
      <%@include file="footer.jsp" %>
  </body>

  </html>