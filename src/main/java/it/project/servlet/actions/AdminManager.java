package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import it.project.bean.UserBean;
import it.project.exception.AdminExists;
import it.project.exception.AdminNotExists;
import it.project.model.UserModel;

/**
 * Servlet implementation class AdminManager
 */
public class AdminManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminManager() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("adminEmail");
		if(email == null)
		{
			request.getSession().setAttribute("userMessage","Email nulla");
			request.getServletContext().getRequestDispatcher("/admin.jsp").forward(request, response);
		}
		String action = request.getParameter("adminAction");
		String message = null;
		try {
			UserModel model = new UserModel();
			UserBean user = model.doRetrieveByKey(email);
			if(user.getEmail() != null)
			{
				
				if(action.equals("add"))
				{
					model.doSaveAdmin(user);
					message = "Utente con mail " + email + " reso ammistratore con successo";
				}
				else if(action.equals("remove"))
				{
					model.doDeleteAdmin(user);
					message = "Admin con mail " + email + " reso utente con successo";
				}
			}
			else
			{
				message = "Utente non registrato";
			}
			
		} 
		catch (SQLException | AdminExists | AdminNotExists e) {
			message = e.getMessage();
		}
		finally
		{
			request.getSession().setAttribute("userMessage",message);
			request.getServletContext().getRequestDispatcher("/admin.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
