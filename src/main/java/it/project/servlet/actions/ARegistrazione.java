package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import it.project.bean.UserBean;
import it.project.exception.PasswordException;
import it.project.model.UserModel;

/**
 * Servlet implementation class ARegistrazione
 */
public class ARegistrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ARegistrazione() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserModel model = new UserModel();
		UserBean bean = new UserBean();
		bean.setAdmin(false);
		
		String page = null;
		String message = null;
		String password2 = null;
		
		try 
		{
			bean.setName(request.getParameter("nome"));
			bean.setSurname(request.getParameter("cognome"));
			bean.setEmail(request.getParameter("email"));
			bean.setPassword(request.getParameter("password"));
			password2 = request.getParameter("password2");
			if(!bean.getPassword().equals(password2)) throw new PasswordException();
			bean.setBornDate(new SimpleDateFormat("dd-MM-yyyy").parse(request.getParameter("data")));
			bean.setAddress(request.getParameter("indirizzo"));
			if(model.doSave(bean))
			{
				page = "/Login";
				message = "Registrazione avventa con successo! Benvenuto/a su GamesClick! Ora effettua il login!";
			}
			else
			{
				page = "/Registrazione";
				message = "Errore durante la registrazione, contatta un amministratore";
			}
		}
		catch (SQLException | ParseException | PasswordException e)
		{
			page = "/Login";
			message = e.getMessage();
		}
		finally
		{
			if(page.equals("/Home")) request.getSession().setAttribute("userEmail", bean.getEmail());
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
