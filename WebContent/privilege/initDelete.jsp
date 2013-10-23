<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,com.misc.lib.CustomHelper" %> 
<% 
	String sitePathInitSub =request.getContextPath()+"/";
	CustomHelper ch=new CustomHelper();
%>    
<div class='divCenter txtCenter jq_DeletePrivilegeStatus'>

		<div class='txtCenter'>Are you sure you want to delete this privilege?</div>
		<div class='txtCenter lnkGrn '><%=ch.UpperCaseWords((String)request.getAttribute("privilege"))%></div>
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeletePrivilege' alt='<%=request.getAttribute("privilegeid")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div>
		<div class='clr'>&nbsp;</div>
</div>
