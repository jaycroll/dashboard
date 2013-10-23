<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
<% 
	String sitePathInit =request.getContextPath()+"/";
%>    
	
<div class='divCenter txtCenter'>
  <form id="formAddChannel" name="form1" method="post" action="">
  
  <div class='modalTitle' >Add Channel</div>
  <div class='jq_AddChannelStatus txtCenter' >&nbsp;</div>

	 <table class='txtCenter' width="280" cellspacing="0" cellpadding="5" border="0" align="center">
      <tbody>
      

     <tr>
        <td width="250" class="text12_tungsten" align='left'>Channel ID:</td>
        <td width="200" align="left" class="text10_red">
        	<input type="text" size="20" id="textfield" name="channel_id">
        </td>
      </tr>
      
      <tr>
        <td width="250" class="text12_tungsten" align='left'>Channel Name:</td>
        <td width="200" align="left" class="text10_red">
        	<input type="text" size="20" id="textfield" name="channel_name">
        </td>
      </tr>
      
      
       <tr>
        <td width="250" class="text12_tungsten" align='left'>Channel Group</td>
        <td width="200" align="left" class="text10_red">
        		<select name='channel_group_id' class='text_12_tungsten''>
				        <%		
				    				ResultSet rstGrp = (ResultSet) request.getAttribute("listChannelGroup");							
									if (rstGrp.next()) {  
									 do{
						%>			<option value='<%=rstGrp.getString("channel_group_id")%>'><%=rstGrp.getString("channel_group_name")%></option>
				    	<% 			} while (rstGrp.next());
										}
						%>	
        		</select>
        </td>
      </tr>
      
        <tr>
        <td width="250" class="text12_tungsten" align='left'>Automated</td>
        <td width="200" align="left" class="text10_red">
        		<select name='channel_automated' class='text_12_tungsten''>
				        <option>Yes</option>
				        <option>No</option>	
        		</select>
        </td>
      </tr>
      
       <tr>
        <td width="250" class="text12_tungsten" align='left'>App</td>
        <td width="200" align="left" class="text10_red">
        		<select name='app_id' class='text_12_tungsten jq_DeparmentSelect'>
        				<option value="0"></option>
				        <%		
				    				ResultSet listApp = (ResultSet) request.getAttribute("listApp");							
									if (listApp.next()) {  
									 do{
						%>			<option value='<%=listApp.getString("app_id")%>'><%=listApp.getString("app_name")%></option>
				    	<% 			} while (listApp.next());
										}
						%>	
        		</select>
        </td>
      </tr>
        
       <tr>
        <td align="center" class="text12_tungsten" colspan="3"><img  class='jq_ConfirmAddChannel' width="65" height="30" src="<%=sitePathInit%>images/add_button.png"></td>
      </tr>
      
      
    </tbody></table>
    
	<input type='hidden' name='action' value='processAddChannel' >
	</form>
</div>
         