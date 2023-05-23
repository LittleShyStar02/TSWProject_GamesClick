package it.project.servlet.actions;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import it.project.storage.ConnectionPool;

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
		Connection conn = null;
		PreparedStatement ps = null;
		
		String page = null;
		String message = null;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try 
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente WHERE Email = ? AND Password = ?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet set = ps.executeQuery();
			if(set.getRow()==1)
			{
				page = "/Home";
				message = "Autenticato correttamente";
			}
			else
			{
				page = "/Login";
				message = "Non è stato trovato nessun account con queste credenziali";
			}
			
			if(ps != null) ps.close();
			ConnectionPool.releaseConnection(conn);
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
