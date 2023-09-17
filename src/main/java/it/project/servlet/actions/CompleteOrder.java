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
    	GameBean game;
    	
    	//salvare ordini
    	
    	
    	request.getSession().setAttribute("cart", new Carrello());
    	request.getSession().setAttribute("userMessafe", "Acquisto completato correttamente");
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
