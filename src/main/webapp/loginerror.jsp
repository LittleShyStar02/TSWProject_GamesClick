<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.SQLException,it.project.bean.UserBean,it.project.model.UserModel" %>
<%

	String mail = (String) request.getSession().getAttribute("userEmail");
	if(mail == null)
	{
		request.getSession().setAttribute("userMessage", "Per accedere a questa pagina devi prima autenticarti");
		request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
	}
%>