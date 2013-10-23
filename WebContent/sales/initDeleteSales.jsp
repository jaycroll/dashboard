<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %>
<% 
	String sitePathInitSub =request.getContextPath()+"/";
	
		ResultSet rs = (ResultSet) request.getAttribute("detSales");
		if (rs.next()) {  
		
	  do{
%>  

  <div class='modalTitle' >Delete Revenue</div>
<div class='divCenter txtCenter jq_DeleteRevenueStatus'>

		<div class='txtCenter'>Are you sure you want to delete this revenue?</div>
		<div class='txtCenter lnkGrn '>Channel: <%=rs.getString("channel_name")%></div>
		<div class='txtCenter lnkGrn '>Revenue Date:<%=rs.getString("revenue_date")%></div>
		<div class='txtCenter lnkGrn '>Amount:<%=rs.getString("amount")%> </div>
		<div class='txtCenter lnkGrn '>Revenue Type:<%=rs.getString("revenue_type")%> </div>
		
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeleteSales' alt='<%=request.getAttribute("salesinfo")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div>
		<div class='clr'>&nbsp;</div>
</div>
<%		
		 } while (rs.next());
		
	    }	
%>	