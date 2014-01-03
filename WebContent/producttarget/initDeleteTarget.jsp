<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %>
<% 
	String sitePathInitSub =request.getContextPath()+"/";
	
		ResultSet rs = (ResultSet) request.getAttribute("detProductTarget");
		if (rs.next()) {  
		
	  do{
%>  
  <div class='modalTitle' >Delete Target</div>
<div class='divCenter txtCenter jq_DeleteTargetStatus'>

		<div class='txtCenter'>Are you sure you want to delete this target?</div>
		<div class='txtCenter lnkGrn '>Target Date: <%=rs.getString("target_date")%></div>
		<div class='txtCenter lnkGrn '>Target Amount:<%=rs.getString("target_amount")%></div>
<%-- 		 --%>
		
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeleteTarget' alt='<%=rs.getString("target_id")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div>
		<div class='clr'>&nbsp;</div>
</div>
<%		
		 } while (rs.next());
		
	    }	
%>	