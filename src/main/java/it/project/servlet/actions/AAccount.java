package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import it.project.model.MethodModel;
import it.project.bean.MethodBean;

/**
 * Servlet implementation class AAccount
 */
public class AAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AAccount() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String message = null;
		
		String name, info, email;
		
		name = request.getParameter("payname");
		info = request.getParameter("payinfo");
		email = request.getParameter("paymail");
		
		MethodBean bean = new MethodBean();
		MethodModel model = new MethodModel();
		bean.setName(name);
		bean.setInfo(info);
		bean.setEmail(email);
		
		
		try
		{
			if(model.doRetrieveByKey(name, info, email).getName() == null)
			{
				model.doSave(bean);
				message = "Metodo di pagamento creato con successo";
			}
			else
			{
				message = "Metodo di pagamento già esistente";
			}
		}
		catch(SQLException e)
		{
			message = e.getMessage();
		}
		
		request.getSession().setAttribute("userMessage", message);
		request.getServletContext().getRequestDispatcher("/account.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request,response);
	}

}
