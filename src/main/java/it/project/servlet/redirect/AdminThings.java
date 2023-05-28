package it.project.servlet.redirect;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;

/**
 * Servlet implementation class Account
 */
public class AdminThings extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminThings() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String first=null,second=null,type=null;
		
		Iterator<String> it = request.getParameterNames().asIterator();
		while(it.hasNext())
		{
			String str = it.next();
			if(str.equals("firstToShow") || str.equals("firstToShow2"))
			{
				first = request.getParameter(str);
			}
			if(str.equals("secondToShow") || str.equals("secondToShow2"))
			{
				second = request.getParameter(str);
			}
			if(str.equals("dataType") || str.equals("dataType2"))
			{
				type = request.getParameter(str);
			}
		}
		
		String forward = "/admin.jsp?";
		if(first != null) forward = forward.concat("first="+first+"&");
		if(second != null) forward = forward.concat("second="+second+"&");
		if(type != null) forward = forward.concat("type="+type+"&");
		if(forward.endsWith("?") || forward.endsWith("&")) forward = forward.substring(0,forward.length()-1);
		
		request.getServletContext().getRequestDispatcher(forward).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
