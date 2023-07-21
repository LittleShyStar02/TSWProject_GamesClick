package it.project.servlet.actions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import it.project.bean.GameBean;
import it.project.model.Carrello;
import it.project.model.GameModel;

/**
 * Servlet implementation class AddCart
 */
public class AddCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCart() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("gamename");
		if(name == null) request.getServletContext().getRequestDispatcher("/index.jsp");
		
		Carrello carrello;
		if(request.getSession().getAttribute("cart") != null)
		{
			carrello = (Carrello) request.getSession().getAttribute("cart");
		}
		else
		{
			carrello = new Carrello();
		}
		
		try {
			GameBean game = new GameModel().doRetrieveByKey(name);
			carrello.addProduct(game, 0);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("cart", carrello);
		request.getServletContext().getRequestDispatcher("/negozio.jsp?start_name=NoFilter").forward(request, response);;
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
