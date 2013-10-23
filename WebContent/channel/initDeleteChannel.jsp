<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %>
<% 
	String sitePathInitSub =request.getContextPath()+"/";
	
		ResultSet rs = (ResultSet) request.getAttribute("detChannel");
		if (rs.next()) {  
		
	  do{
%>  

  <div class='modalTitle' >Delete Channel</div>
<div class='divCenter txtCenter jq_DeleteChannelStatus'>

		<div class='txtCenter'>Are you sure you want to delete this channel?</div>
		<div class='txtCenter lnkGrn '>Channel Name: <%=rs.getString("channel_name")%></div>
		<div class='txtCenter lnkGrn '>Channel Group:<%=rs.getString("channel_group_name")%></div>
		<div class='txtCenter lnkGrn '>App:<%=rs.getString("app_name")%> </div>
		
		<div class='txtCenter'>
				 <span class='lnkRed jq_ConfirmDeleteChannel' alt='<%=rs.getString("channel_id")%>'>Confirm</span> &nbsp; <span  class='lnkRed jq_ModalClose'>Cancel</span>
		</div>
		<div class='clr'>&nbsp;</div>
</div>
<%		
		 } while (rs.next());
		
	    }	
%>	