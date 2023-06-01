package it.project.servlet.redirect;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Iterator;
import java.sql.Date;

import it.project.bean.CategoryBean;
import it.project.bean.ConsoleBean;
import it.project.bean.GameBean;
import it.project.exception.AdminNotExists;
import it.project.model.CategoriaGiocoModel;
import it.project.model.CategoryModel;
import it.project.model.ConsoleModel;
import it.project.model.EsecuzioneGiocoModel;
import it.project.model.GameModel;
import it.project.model.UserModel;

/**
 * Servlet implementation class Account
 */
public class AdminPanel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPanel() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String first=null,second=null,type=null,datasearch=null,action=null;
		String message = null;
		
		try
		{
			action = request.getParameter("action_form");
			if(action != null)
			{
				switch(action)
				{
					case "create_category":
						if(saveCategory(request,"create")) message = "Categoria creata con successo";
						break;
					case "modify_category":
						if(saveCategory(request,"modify")) message = "Categoria modificata con successo";
						break;
					case "delete_category":
						if(saveCategory(request,"delete")) message = "Categoria eliminata con successo";
						break;
					case "create_console":
						if(saveConsole(request,"create")) message = "Console creata con successo";
						break;
					case "modify_console":
						if(saveConsole(request,"modify")) message = "Console modificata con successo";
						break;
					case "delete_console":
						if(saveConsole(request,"delete")) message = "Console eliminata con successo";
						break;
					case "create_game":
						if(saveGame(request,"create")) message = "Gioco creato con successo";
						break;
					case "modify_game":
						if(saveGame(request,"modify")) message = "Gioco modificato con successo";
						break;
					case "delete_game":
						if(saveGame(request,"delete")) message = "Gioco eliminato con successo";
						break;
				}
			}
		}
		catch(SQLException | ParseException | AdminNotExists e)
		{
			message = e.getMessage();
		}
		
		Iterator<String> it = request.getParameterNames().asIterator();
		while(it.hasNext())
		{
			String str = it.next();
			if(str.equals("firstToShow") || str.equals("firstToShow2"))
			{
				first = request.getParameter(str);
			}
			if(str.equals("secondToShow") || str.equals("secondToShow2"))
			{
				second = request.getParameter(str);
			}
			if(str.equals("dataType") || str.equals("dataType2"))
			{
				type = request.getParameter(str);
			}
			if(str.equals("search_datatype"))
			{
				datasearch = request.getParameter("search_datatype");
			}
		}
		
		String forward = "/admin.jsp?";
		if(first != null) forward = forward.concat("first="+first+"&");
		if(second != null) forward = forward.concat("second="+second+"&");
		if(type != null) forward = forward.concat("type="+type+"&");
		if(datasearch != null) forward = forward.concat("datasearch="+datasearch+"&");
		if(forward.endsWith("?") || forward.endsWith("&")) forward = forward.substring(0,forward.length()-1);
		
		if(message != null) request.getSession().setAttribute("userMessage", message);
		
		request.getServletContext().getRequestDispatcher(forward).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public boolean saveCategory(HttpServletRequest request,String atype) throws SQLException
	{
		String name = request.getParameter("search_datatype");
		String desc = request.getParameter("catdesc");
		CategoryBean bean = new CategoryBean();
		bean.setName(name);
		bean.setDescription(desc);
		
		CategoryModel model = new CategoryModel();
		
		switch(atype)
		{
			case "create":
				return model.doSave(bean);
			case "modify":
				return model.doUpdate(bean);
			case "delete":
				return model.doDelete(bean);
		}
		
		return false;
	}
	
	public boolean saveConsole(HttpServletRequest request,String atype) throws SQLException
	{
		String name = request.getParameter("search_datatype");
		String desc = request.getParameter("condesc");
		ConsoleBean bean = new ConsoleBean();
		bean.setName(name);
		bean.setDescription(desc);
		
		ConsoleModel model = new ConsoleModel();
		
		switch(atype)
		{
			case "create":
				return model.doSave(bean);
			case "modify":
				return model.doUpdate(bean);
			case "delete":
				return model.doDelete(bean);
		}
		
		return false;
	}
	
	public boolean saveGame(HttpServletRequest request,String atype) throws SQLException, ParseException, AdminNotExists
	{
		String name = request.getParameter("search_datatype");
		String desc = request.getParameter("gamedesc");
		Date date = Date.valueOf(request.getParameter("gamedate"));
		double price = Double.parseDouble(request.getParameter("gameprice"));
		int age = Integer.parseInt(request.getParameter("minage"));
		String url = request.getParameter("gameurl");
		String email = request.getParameter("gameadmin");
		
		boolean check = false;
		
		GameBean bean = new GameBean();
		bean.setName(name);
		bean.setDescription(desc);
		bean.setPrice(price);
		bean.setMinAge(age);
		bean.setReleaseDate(date);
		bean.setPreview(url);
		
		int key = new UserModel().doRetrieveAdminKey(email);
		bean.setAdminKey(key);
		
		GameModel model = new GameModel();
		
		switch(atype)
		{
			case "create":
				
				if(key == -1)
				{
					throw new AdminNotExists("L'email inserita non appartiene ad un amministratore");
				}
				if(model.doSave(bean))
				{
					check = true;
					if(request.getParameter("gameconsole") != null)
					{
						saveGameConsole(request,name);
					}
					if(request.getParameter("gamecategory") != null)
					{
						saveGameCategory(request,name);
					}
				}
				return check;
			case "modify":
				if(key == -1)
				{
					throw new AdminNotExists("L'email inserita non appartiene ad un amministratore");
				}
				if(model.doUpdate(bean))
				{
					check = true;
					EsecuzioneGiocoModel.doDeleteByGame(bean);
					if(request.getParameter("gameconsole") != null)
					{
						saveGameConsole(request,name);
					}
					CategoriaGiocoModel.doDeleteByGame(bean);
					if(request.getParameter("gamecategory") != null)
					{
						saveGameCategory(request,name);
					}
				}
				return check;
			case "delete":
				return model.doDelete(bean);
		}
		
		return false;
	}
	
	public void saveGameConsole(HttpServletRequest request,String name) throws SQLException
	{
		String str = request.getParameter("gameconsole");
		if(str.contains(";"))
		{
			String[] strs = str.split(";");
			for(String tmp : strs) EsecuzioneGiocoModel.doSave(tmp, name);
		}
		else EsecuzioneGiocoModel.doSave(str, name);
	}
	
	public void saveGameCategory(HttpServletRequest request,String name) throws SQLException
	{
		String str = request.getParameter("gamecategory");
		if(str.contains(";"))
		{
			String[] strs = str.split(";");
			for(String tmp : strs) CategoriaGiocoModel.doSave(tmp, name);
		}
		else CategoriaGiocoModel.doSave(str, name);
	}

}
