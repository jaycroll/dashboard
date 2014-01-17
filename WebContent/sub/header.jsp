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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"  href="<%=sitePathInit%>css/style2.css">
<link rel="stylesheet" type="text/css" href="<%=sitePathInit%>css/font.css">
<link type='text/css' href='<%=sitePathInit%>css/jquery.mobile-1.4.0.css' rel='stylesheet' media='screen' />


<!-- Contact Form CSS files -->
<!-- Load jQuery, SimpleModal and Basic JS files -->
<script type='text/javascript' src='<%=sitePathInit%>js/jquery.js'></script>
<script type='text/javascript' src='<%=sitePathInit%>js/jquery.mobile-1.4.0.js'></script>
<script type='text/javascript' src='<%=sitePathInit%>js/Chart.js'></script>

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
