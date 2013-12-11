<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.misc.lib.CustomHelper,java.sql.ResultSet" %> 

<% 

	CustomHelper chMain=new CustomHelper();

	String sitePathInit =request.getContextPath()+"/";
	HttpSession sess=request.getSession();
	
	Boolean loggedState=false;
	if((sess.getAttribute("username")==null) || (sess.getAttribute("username")=="") || (sess.getAttribute("username")=="null")){
		loggedState=false;
	}else{
		loggedState=true;
	}
	
	Boolean graphContent = (Boolean) request.getAttribute("graphContent");
%>    

<!DOCTYPE HTML>
<html>
<head>
<link rel="icon" type="image/png" href="images/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" type="text/css" href="<%=sitePathInit%>css/style.css">
<link rel="stylesheet" type="text/css" href="<%=sitePathInit%>css/font.css">
<LINK rel="stylesheet" href="<%=sitePathInit%>css/facebox.css" type="text/css">
<link type='text/css' href='<%=sitePathInit%>css/custom.css' rel='stylesheet' media='screen' />
<link type='text/css' href='<%=sitePathInit%>css/basic.css' rel='stylesheet' media='screen' />


<!-- Contact Form CSS files -->
<!-- Load jQuery, SimpleModal and Basic JS files -->
<script type='text/javascript' src='<%=sitePathInit%>js/jquery.js'></script>
<script type='text/javascript' src='<%=sitePathInit%>js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='<%=sitePathInit%>js/basic.js'></script>
<script type='text/javascript' src='<%=sitePathInit%>include/custom.jsp'></script>
<script type='text/javascript' src='<%=sitePathInit%>js/Chart.js'></script>
<% if(graphContent!=null && graphContent==true){ %>
	<link type="text/css" rel="stylesheet" href="<%=sitePathInit%>css/visualize.css"/>
	<link type="text/css" rel="stylesheet" href="<%=sitePathInit%>css/visualize-light.css"/>
	<script type="text/javascript" src="<%=sitePathInit%>js/visualize.jQuery.js"></script>
<% } %>

<title>Dashboard</title>
</head>

<body>


<div id='basic-modal-content'>
	<div class='clr'> </div>
	<div class='basic-container'>
				
	</div>
	<div class='clr'>&nbsp;</div>
</div>

<div id="page">
<div id="wrapper">
