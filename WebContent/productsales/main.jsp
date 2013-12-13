<%@ include file="../sub/header.jsp"%>

<%@ page import="com.misc.lib.RolePermission" %> 
<%@ page import="com.model.lib.*" %>
<%@ page import="java.sql.*" %>
<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));
	String[] territories = (String[]) request.getAttribute("territories");
	String[] areas = (String[]) request.getAttribute("areas");
	String[] isSelected = (String[]) request.getAttribute("isSelected");
	String selected = request.getParameter("selected");
	

%>
<div id="header" align="center"><img src="<%=sitePathInit%>images/ppe-blk.png"/></div>
<div id="title">
	<a href="<%=sitePathInit %>" class="lucida_21_black"><img src="<%=sitePathInit%>images/productsales_small.png" align="absmiddle"/>Dashboard</a>
	
</div>