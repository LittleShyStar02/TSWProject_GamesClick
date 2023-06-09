package it.project.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import com.google.gson.Gson;

import it.project.bean.CategoryBean;
import it.project.bean.ConsoleBean;
import it.project.bean.GameBean;
import it.project.bean.UserBean;
import it.project.model.CategoryModel;
import it.project.model.ConsoleModel;
import it.project.model.GameModel;
import it.project.model.UserModel;

/**
 * Servlet implementation class AjaxCategory
 */
public class AjaxAutoComplete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxAutoComplete() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	String type = request.getParameter("type");
    	String start = request.getParameter("start");
    	
    	try {
    		
    		if(type.equals("category"))
    		{
    			Collection<CategoryBean> coll = new CategoryModel().doRetrieveAll("ASC");
    			Collection<CategoryBean> coll2;
    			
    			if(start != null && !start.equals(""))
    			{
    				coll2 = coll.stream().filter(cat -> cat.getName().toLowerCase().startsWith(start.toLowerCase())).toList();
    				response.getWriter().write(new Gson().toJson(coll2));
    			}
    			else
    			{
    				response.getWriter().write(new Gson().toJson(coll));
    			}
    		}
    		
    		if(type.equals("console"))
    		{
    			Collection<ConsoleBean> coll = new ConsoleModel().doRetrieveAll("ASC");
    			Collection<ConsoleBean> coll2;
    			
    			if(start != null && !start.equals(""))
    			{
    				coll2 = coll.stream().filter(cat -> cat.getName().toLowerCase().startsWith(start.toLowerCase())).toList();
    				response.getWriter().write(new Gson().toJson(coll2));
    			}
    			else
    			{
    				response.getWriter().write(new Gson().toJson(coll));
    			}
    		}
    		
    		if(type.equals("game"))
    		{
    			Collection<GameBean> coll = new GameModel().doRetrieveAll("ASC");
    			Collection<GameBean> coll2;
    			
    			if(start != null && !start.equals(""))
    			{
    				coll2 = coll.stream().filter(cat -> cat.getName().toLowerCase().startsWith(start.toLowerCase())).toList();
    				response.getWriter().write(new Gson().toJson(coll2));
    			}
    			else
    			{
    				response.getWriter().write(new Gson().toJson(coll));
    			}
    		}
    		
			if(type.equals("user"))
			{
				Collection<UserBean> coll = new UserModel().doRetrieveAll("ASC");
				Collection<UserBean> coll2;
				
				if(start != null && !start.equals(""))
				{
					coll2 = coll.stream().filter(cat -> cat.getName().toLowerCase().startsWith(start.toLowerCase()) 
							|| cat.getSurname().toLowerCase().startsWith(start.toLowerCase()) 
							|| cat.getEmail().toLowerCase().startsWith(start.toLowerCase())).toList();
					response.getWriter().write(new Gson().toJson(coll2));
				}
				else
				{
					response.getWriter().write(new Gson().toJson(coll));
				}
			}
			
		} catch (SQLException e) {
			request.getSession().setAttribute("userMessage", e.getMessage());
		}
    	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
