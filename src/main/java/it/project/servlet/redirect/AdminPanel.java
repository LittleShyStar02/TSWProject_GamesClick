package it.project.servlet.redirect;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;

import it.project.bean.CategoryBean;
import it.project.bean.ConsoleBean;
import it.project.model.CategoryModel;
import it.project.model.ConsoleModel;

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
						if(saveCategory(request,"modify")) message ="Categoria modificata con successo";
						break;
					case "delete_category":
						if(saveCategory(request,"delete")) message ="Categoria eliminata con successo";
						break;
					case "create_console":
						if(saveConsole(request,"create")) message = "Console creata con successo";
						break;
					case "modify_console":
						if(saveConsole(request,"modify")) message ="Console modificata con successo";
						break;
					case "delete_console":
						if(saveConsole(request,"delete")) message ="Console eliminata con successo";
						break;
				}
			}
		}
		catch(SQLException e)
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

}
