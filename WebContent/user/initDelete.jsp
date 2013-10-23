<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %> 
<% 
	String sitePathInitSub =request.getContextPath()+"/";
%>    
<div class='divCenter txtCenter jq_DeleteUserStatus'>

		<div class='txtCenter'>Are you sure you want to delete this user?</div><br />
		<div class='txtCenter lnkGrn '><%=request.getAttribute("fullname")%> (<%=request.getAttribute("rolename")%>)</div><br />
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeleteAccess' alt='<%=request.getAttribute("userid")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div><br />
		<div class='clr'>&nbsp;</div>
</div>
