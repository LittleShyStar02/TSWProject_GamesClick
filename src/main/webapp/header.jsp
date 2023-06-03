<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header>
	<nav>
		<div class="header-logo">
			<a href="index.jsp" class="header-logo-text">GamesClick</a>
		</div>
		<ul class="header-ul">
			<li>
				<a href="negozio.jsp">Negozio</a>
			</li>
			<li>
				<a href="assistenza.jsp">Assistenza</a>
			</li>
			<li>
				<a href="informazioni.jsp">Informazioni</a>
			</li>
		</ul>
		<%@ page import="it.project.bean.UserBean,it.project.model.UserModel" %>
		<%
			String email = (String) request.getSession().getAttribute("userEmail");
			if(email != null)
			{
				UserBean user = new UserModel().doRetrieveByKey(email);
				if(user.isAdmin())
				{
					out.print("<div class=\"header-icon\"><a href=\"admin.jsp\" class=\"header-image-text\"><img src=\"assets/images/staff_icon.png\" class=\"header-image\"></a></div>");
				}
			}
		%>
		<div class="header-icon">
			<a href="carrello.jsp" class="header-image-text"><img src="assets/images/icon_cart.png" class="header-image"></a>
		</div>
		<div class="account-dropdown header-icon">
			<a href="#" class="header-image-text"><img src="assets/images/icon_account.png" class="header-image"></a>
			<div class="account-dropdown-content">
				<ul>
					<%
						if(request.getSession().getAttribute("userEmail") != null)
						{
							out.print("<li><a href=\"/TSWProject_GamesClick/Account\" class=\"account-dropdown-a\">Account</a></li>");
							out.print("<li><hr></li>");
							out.print("<li><a href=\"/TSWProject_GamesClick/ALogout\" class=\"account-dropdown-a\">Logout</a></li>");
						}
						else
						{
							out.print("<li><a href=\"/TSWProject_GamesClick/Login\" class=\"account-dropdown-a\">Login</a></li>");
							out.print("<li><hr></li>");
							out.print("<li><a href=\"/TSWProject_GamesClick/Registrazione\" class=\"account-dropdown-a\">Sign Up</a></li>");
						}
					%>
				</ul>
  			</div>
		</div>
	</nav>
</header>