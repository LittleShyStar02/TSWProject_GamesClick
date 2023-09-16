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
public class UpdateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCart() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	Carrello cart = (Carrello) request.getSession().getAttribute("cart");
    	GameBean game;
    	
    	String idp;
    	
    	int count = 1;
    	
    	while((idp = request.getParameter("id"+String.valueOf(count))) != null)
    	{
    		try {
				game = new GameModel().doRetrieveByKey(idp);
				cart.updateGame(game, Integer.parseInt(request.getParameter("q"+String.valueOf(count))));
				count++;
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
