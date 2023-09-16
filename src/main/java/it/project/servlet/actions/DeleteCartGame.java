package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import it.project.bean.GameBean;
import it.project.model.Carrello;
import it.project.model.GameModel;

/**
 * Servlet implementation class DeleteCartGame
 */
public class DeleteCartGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCartGame() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	String gamename = request.getParameter("gamename");
    	
    	Carrello cart = (Carrello) request.getSession().getAttribute("cart");
    	
    	if(cart != null)
    	{
    		GameBean game;
    		try {
    			game = new GameModel().doRetrieveByKey(gamename);
    			if(game == null)
    	    	{
    				request.getSession().setAttribute("userMessage", "Errore durante l'eliminazione del tuo carrello");
    	    	}
    			else
    			{
    				cart.removeProduct(game);
    				request.getSession().setAttribute("userMessage", "Gioco rimosso correttamente" + cart.toString());
    			}
    			
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
    	}
    	request.getSession().setAttribute("cart", cart);
		request.getServletContext().getRequestDispatcher("/carrello.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
