package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import it.project.bean.UserBean;
import it.project.model.UserModel;

/**
 * Servlet implementation class ALogin
 */
public class ALogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ALogin() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String page = null;
		String message = null;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try 
		{
			
			if(request.getSession().getAttribute("userEmail") == null)
			{
				UserBean user = new UserModel().doRetrieveByKey(email);
				if(user.getEmail() != null)
				{
					if(user.getPassword().equals(password))
					{
						page = "/Home";
						message = "Autenticato correttamente";
					}
					else
					{
						page = "/Login";
						message = "Password errata";
					}
				}
				else
				{
					page = "/Login";
					message = "Non è stato trovato nessun account con queste credenziali";
				}
			}
			else
			{
				page = "/Login";
				message = "Sei già autenticato";
			}
		}
		catch (SQLException e) 
		{
			page = "/Login";
			message = e.getMessage();
		}
		finally
		{
			if(page.equals("/Home")) request.getSession().setAttribute("userEmail", email);
			request.getSession().setAttribute("userMessage", message);
			request.getServletContext().getRequestDispatcher(page).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
