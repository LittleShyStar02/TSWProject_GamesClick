<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <!DOCTYPE html>

  <html lang="it">

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
    <script src="assets/js/ajax/jquery-3.7.0.min.js"></script>
    <script src="assets/js/ajax/autocomplete.js"></script>
  </head>

  <%@page import="it.project.model.EsecuzioneGiocoModel,it.project.model.CategoriaGiocoModel" %>
  <%
  	String datasearch = request.getParameter("datasearch");
  	String onload = "visualize({first},{second},{type});setDataSearch('" + datasearch + "');";
  	if(request.getParameter("first") != null) 
  	{
  		onload = onload.replace("{first}","'"+request.getParameter("first")+"'");
  	}
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
          <form action="AdminPanel" method="post" id="firstForm" class="adminManager">
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
          	<form action="AdminPanel" method="post" id="secondForm" class="adminManager" autocomplete="off" onsubmit="setParameter('secondForm','searchthing',getFromType(),getInputDataType());">
          		<input type="text" id="firstToShow2" name="firstToShow" style="display: none;">
          		<input type="text" id="secondToShow2" name="secondToShow" style="display: none;">
          		<input type="text" id="dataType2" name="dataType" style="display: none;">
          		<input type="text" id="input_datatype" name="input_datatype" style="display: none;">
          		<input type="text" id="action_form" name="action_form" style="display: none;">
          		<label for="search_datatype" id="label_datatype"></label>
          		<br>
          		<input type="text" id="search_datatype" name="search_datatype" class="inb20" required>
          		<input type="submit" value="Trova" class="admin-binput">
          		<div id="autocomplete-div" class="autocomplete-div">
          			
          		</div>
          		<div id="catinfo" class="hidecont">
          			<%@page import="it.project.bean.CategoryBean,it.project.model.CategoryModel" %>
        			<%
        				
          				if(datasearch == null) out.print("<p>Errore durante la comunicazione con il server</p>");
          				else
          				{
          					CategoryBean catbean = new CategoryModel().doRetrieveByKey(datasearch);
          					if(catbean.getName() == null) 
          					{
          						out.print("<p>Categoria inesistente. Creala</p>");
          						out.print("<br>");
          						out.print("<textarea id=\"catdesc\" name=\"catdesc\" class=\"textarea-lock\" placeholder=\"Descrizione... (max 2000 caratteri)\"></textarea>");
          						out.print("<p id=\"errordesc\"></p>");
          						out.print("<br>");
          						out.print("<input type=\"button\" value=\"Crea\" class=\"admin-binput binputw\" onclick=\"createCategory()\">");
          					}
          					else
          					{
          						out.print("<br>");
          						out.print("<textarea type=\"text\" id=\"catdesc\" name=\"catdesc\" class=\"textarea-lock readonly\" readonly>" + catbean.getDescription() + "</textarea>");
          						out.print("<p id=\"errordesc\"></p>");
          						out.print("<br>");
          						out.print("<input type=\"button\" value=\"Clicca per modificare\" class=\"admin-binput binputw\" onclick=\"unlockCategory()\">");
          						out.print("<input type=\"button\" value=\"Salva\" class=\"admin-binput binputw\" onclick=\"modifyCategory()\">");
          						out.print("<input type=\"button\" value=\"Elimina\" class=\"admin-binput binputw\" onclick=\"deleteCategory()\">");
          					}
          				}
        			%>
        		</div>
        
        			<div id="coninfo" class="hidecont">
          			<%@page import="it.project.bean.ConsoleBean,it.project.model.ConsoleModel" %>
        			<%
        				
          				if(datasearch == null) out.print("<p>Errore durante la comunicazione con il server</p>");
          				else
          				{
          					ConsoleBean conbean = new ConsoleModel().doRetrieveByKey(datasearch);
          					if(conbean.getName() == null) 
          					{
          						out.print("<p>Console inesistente. Creala</p>");
          						out.print("<textarea type=\"text\" id=\"condesc\" name=\"condesc\" class=\"textarea-lock\" placeholder=\"Descrizione... (max 2000 caratteri)\"></textarea>");
          						out.print("<p id=\"errordesc2\"></p>");
          						out.print("<br>");
          						out.print("<input type=\"button\" value=\"Crea\" class=\"admin-binput binputw\" onclick=\"createConsole()\">");
          					}
          					else
          					{
          						out.print("<br>");
          						out.print("<textarea type=\"text\" id=\"condesc\" name=\"condesc\" class=\"textarea-lock readonly\" readonly >" + conbean.getDescription() + "</textarea>");
          						out.print("<p id=\"errordesc2\"></p>");
          						out.print("<br>");
          						out.print("<input type=\"button\" value=\"Clicca per modificare\" class=\"admin-binput binputw\" onclick=\"unlockConsole()\">");
          						out.print("<input type=\"button\" value=\"Salva\" class=\"admin-binput binputw\" onclick=\"modifyConsole()\">");
          						out.print("<input type=\"button\" value=\"Elimina\" class=\"admin-binput binputw\" onclick=\"deleteConsole()\">");
          					}
          				}
        			%>
        		</div>
        
       	 		<div id="gameinfo" class="hidecont">
        			<%@page import="it.project.bean.GameBean,it.project.model.GameModel,java.util.Collection,java.util.Iterator" %>
        			<%
        				if(datasearch == null) out.print("<p>Errore durante la comunicazione con il server</p>");
        				else
        				{
        					GameBean gamebean = new GameModel().doRetrieveByKey(datasearch);
        					if(gamebean.getName() == null)
        					{
        						out.print("<p>Gioco inesistente. Crealo</p>");
        						out.print("<textarea type=\"text\" id=\"gamedesc\" name=\"gamedesc\" class=\"textarea-lock\" placeholder=\"Descrizione... (max 2000)\"></textarea>");
        						out.print("<p id=\"errordesc3\"></p>");
        						out.print("<br><br>");
        						out.print("Data rilascio: <input type=\"date\" id=\"gamedate\" name=\"gamedate\" required>");
        						out.print("<p id=\"errordate\"></p>");
        						out.print("<br><br>");
        						out.print("<input type=\"number\" id=\"gameprice\" name=\"gameprice\" placeholder=\"Prezzo...\" required>");
        						out.print("<br><br>");
        						out.print("<input type=\"number\" id=\"minage\" name=\"minage\" placeholder=\"Età Minima...\" required>");
        						out.print("<br><br>");
        						out.print("<input type=\"text\" id=\"gameurl\" name=\"gameurl\" placeholder=\"Game Image Url...\" required>");
        						out.print("<br><br>");
        						out.print("<input type=\"email\" id=\"gameadmin\" name=\"gameadmin\" placeholder=\"Email...\" required>");
        						out.print("<br><br>");
        						out.print("<input <type=\"text\" id=\"gameconsole\" name=\"gameconsole\" style=\"display: none\">");
        						out.print("<h3>Console</h3><br>");
        						
        						Collection<ConsoleBean> conlist = new ConsoleModel().doRetrieveAll("ASC");
        						if(!conlist.isEmpty())
        						{
        							Iterator<ConsoleBean> iconsole = conlist.iterator();
        							int cid = 1;
        							while(iconsole.hasNext())
        							{
        								ConsoleBean console = iconsole.next();
        								out.print("<input type=\"checkbox\" id=\"con" + cid + "\" value=\"" + console.getName() + "\">");
        								out.print("<label for=\"con" + cid + "\">" + console.getName() + "</label><br><br>");
        								cid++;
        							}
        						}
        						
        						out.print("<input <type=\"text\" id=\"gamecategory\" name=\"gamecategory\" style=\"display: none\">");
        						out.print("<h3>Categorie</h3><br>");
        						Collection<CategoryBean> catlist = new CategoryModel().doRetrieveAll("ASC");
        						if(!catlist.isEmpty())
        						{
        							Iterator<CategoryBean> icat = catlist.iterator();
        							int cid = 1;
        							while(icat.hasNext())
        							{
        								CategoryBean catbean = icat.next();
        								out.print("<input type=\"checkbox\" id=\"cat" + cid + "\" value=\"" + catbean.getName() + "\">");
        								out.print("<label for=\"cat" + cid + "\">" + catbean.getName() + "</label><br><br>");
        								cid++;
        							}
        						}
        						
        						
        						out.print("<br>");
        						out.print("<input type=\"button\" value=\"Crea\" class=\"admin-binput binputw\" onclick=\"createGame()\">");
        					}
        					else
        					{
        						out.print("<textarea type=\"text\" id=\"gamedesc\" name=\"gamedesc\" class=\"textarea-lock readonly\" placeholder=\"Descrizione...\">" + gamebean.getDescription() + "</textarea>");
        						out.print("<p id=\"errordesc3\"></p>");
        						out.print("<br><br>");
        						out.print("Data rilascio: <input type=\"date\" id=\"gamedate\" name=\"gamedate\" class=\"readonly\" value=\"" + Utility.dateToMysql(gamebean.getReleaseDate()) + "\" required readonly>");
        						out.print("<p id=\"errordate\"></p>");
        						out.print("<br><br>");
        						out.print("<input type=\"number\" id=\"gameprice\" name=\"gameprice\" placeholder=\"Prezzo...\" class=\"readonly\" value=\"" + gamebean.getPrice() + "\" required readonly>");
        						out.print("<br><br>");
        						out.print("<input type=\"number\" id=\"minage\" name=\"minage\" placeholder=\"Età Minima...\" class=\"readonly\" value=\"" + gamebean.getMinAge() + "\" required readonly>");
        						out.print("<br><br>");
        						out.print("<input type=\"text\" id=\"gameurl\" name=\"gameurl\" placeholder=\"Game Image Url...\" class=\"readonly\" value=\"" + gamebean.getPreview() + "\" required readonly>");
        						out.print("<br><br>");
        						out.print("<input type=\"email\" id=\"gameadmin\" name=\"gameadmin\" placeholder=\"Email...\" class=\"readonly\" value=\"" + new UserModel().adminMailByKey(gamebean.getAdminKey()) + "\" required readonly>");
        						out.print("<br><br>");
        						
        						out.print("<input <type=\"text\" id=\"gameconsole\" name=\"gameconsole\" style=\"display: none\">");
        						out.print("<h3>Console</h3><br>");
        						
        						Collection<ConsoleBean> conlist = new ConsoleModel().doRetrieveAll("ASC");
        						if(!conlist.isEmpty())
        						{
        							Iterator<ConsoleBean> iconsole = conlist.iterator();
        							int cid = 1;
        							while(iconsole.hasNext())
        							{
        								ConsoleBean console = iconsole.next();
        								if(EsecuzioneGiocoModel.exists(console.getName(), gamebean.getName()))
        								{
        									out.print("<input type=\"checkbox\" id=\"con" + cid + "\" value=\"" + console.getName() + "\" checked disabled>");
            								out.print("<label for=\"con" + cid + "\">" + console.getName() + "</label><br><br>");
        								}
        								else
        								{
        									out.print("<input type=\"checkbox\" id=\"con" + cid + "\" value=\"" + console.getName() + "\" disabled>");
            								out.print("<label for=\"con" + cid + "\">" + console.getName() + "</label><br><br>");
        								}
        								cid++;
        							}
        						}
        						
        						out.print("<input <type=\"text\" id=\"gamecategory\" name=\"gamecategory\" style=\"display: none\">");
        						out.print("<h3>Categorie</h3><br>");
        						Collection<CategoryBean> catlist = new CategoryModel().doRetrieveAll("ASC");
        						if(!catlist.isEmpty())
        						{
        							Iterator<CategoryBean> icat = catlist.iterator();
        							int cid = 1;
        							while(icat.hasNext())
        							{
        								CategoryBean catbean = icat.next();
        								if(CategoriaGiocoModel.exists(catbean.getName(), gamebean.getName()))
        								{
        									out.print("<input type=\"checkbox\" id=\"cat" + cid + "\" value=\"" + catbean.getName() + "\" checked disabled>");
            								out.print("<label for=\"cat" + cid + "\">" + catbean.getName() + "</label><br><br>");
        								}
        								else
        								{
        									out.print("<input type=\"checkbox\" id=\"cat" + cid + "\" value=\"" + catbean.getName() + "\" disabled>");
            								out.print("<label for=\"cat" + cid + "\">" + catbean.getName() + "</label><br><br>");
        								}
        								cid++;
        							}
        						}
        						
        						out.print("<br>");
        						out.print("<input type=\"button\" value=\"Clicca per modificare\" class=\"admin-binput binputw\" onclick=\"unlockGame()\">");
          						out.print("<input type=\"button\" value=\"Salva\" class=\"admin-binput binputw\" onclick=\"modifyGame()\">");
          						out.print("<input type=\"button\" value=\"Elimina\" class=\"admin-binput binputw\" onclick=\"deleteGame()\">");
        					}
        				}
        			%>
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
          			out.print("<fieldset class=\"fieldset-form\" style=\"border: none;\"><legend style=\"font-size: 20px;\">Informazioni Utente</legend><p>");
          			out.print("Nome: " + searchuser.getName() + "<br>");
          			out.print("Cognome: " + searchuser.getSurname() + "<br>");
          			out.print("Email: " + searchuser.getEmail() + "<br>");
          			out.print("Data Di Nascita: " + Utility.dateToString(searchuser.getBornDate()) + "<br>");
          			out.print("Indirizzo: " + searchuser.getAddress() +"<br>");
          			String role = "Ruolo: ";
          			if(searchuser.isAdmin()) role = role.concat("Amministratore");
          			else role = role.concat("Utente");
          			out.print(role);
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
          		<input type="submit" class="admin-binput" value="Rendi amministratore" onclick="setAction('adminAction','adminForm','add')">
          		<input type="submit" class="admin-binput" value="Rendi utente" onclick="setAction('adminAction','adminForm','remove')">
          	</form>
          </fieldset>
        </div>
      </div>
      
      <%@include file="footer.jsp" %>
  </body>

  </html>