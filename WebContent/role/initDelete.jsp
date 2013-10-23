<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %> 
<% 
	String sitePathInitSub =request.getContextPath()+"/";
%>    
<div class='divCenter txtCenter jq_DeleteRoleStatus'>

		<div class='txtCenter'>Are you sure you want to delete this role?</div>
		<div class='txtCenter lnkGrn '><%=request.getAttribute("rolename")%></div>
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeleteRole' alt='<%=request.getAttribute("roleid")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div>
		<div class='clr'>&nbsp;</div>
</div>
