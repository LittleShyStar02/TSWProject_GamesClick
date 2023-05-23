<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	if(request.getSession().getAttribute("userMessage") != null)
 	{
 		out.print("<div class=\"error-box\"><p id=\"userMessage\">" + request.getSession().getAttribute("userMessage") + "</p></div>");
 		request.getSession().removeAttribute("userMessage");
 	}
%>