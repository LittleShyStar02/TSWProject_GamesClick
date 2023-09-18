package it.project.servlet.actions;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Set;

import it.project.model.Carrello;
import it.project.model.AcquistoModel;
import it.project.model.GameModel;
import it.project.model.MethodModel;
import it.project.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCartGame
 */
public class CompleteOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompleteOrder() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	Carrello cart = (Carrello) request.getSession().getAttribute("cart");
    	String method_name = null;
    	for(String key : request.getParameterMap().keySet())
    	{
    		if(key.startsWith("method")) method_name = request.getParameter(key);
    	}
    	String email_user = (String) request.getSession().getAttribute("userEmail");
    	
    	try {
			int IDUser = new UserModel().doRetrieveKey(email_user);
			int IDMethod = new MethodModel().doRetrieveKey(method_name,email_user,email_user);
	   
			AcquistoModel amodel = new AcquistoModel();
	    	GameModel model = new GameModel();;
	    	int IDGame;
	    	
	    	Set<String> keys = cart.getProducts().keySet();
	    	
	    	for(String key : keys)
	    	{
	    		
	    		IDGame = model.doRetrieveKey(key);
	    		amodel.doSave(IDUser, IDGame, IDMethod, cart.getProducts().get(key), new Date());
	    	}
	    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	request.getSession().setAttribute("cart", new Carrello());
    	request.getSession().setAttribute("userMessage", "Acquisto completato correttamente");
    	request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
