<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 

		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();
		float[] iActualSales = (float[]) request.getAttribute("iActualSales");
		float[] iActualTarget = (float[]) request.getAttribute("iActualTarget");
		String[] strMonths=ch.loadInitMonths();
		Map usrDet=new HashMap();
		usrDet = (Map)request.getAttribute("usrDet");
		
		
%>		
  <% if(!usrDet.isEmpty()){ %>
  
  <div style='margin-left:30px;'>
  			<div class='grayTitle'><%=usrDet.get("userfirstname") %> <%=usrDet.get("userlastname") %></div>
  			<div class='gry fnt13'>Born On <%=ch.aDate((String) usrDet.get("birthdate"),"1")%></div>			
  			<div class='gry fnt13' style='margin-top:10px;'><%=usrDet.get("mobile") %></div>
  			<div class='gry fnt13'>Hired last <%=ch.aDate((String) usrDet.get("hireddate"),"1")%></div>
  			<div class='gry fnt13'>Handling  <%=request.getAttribute("agent_area")%></div>
	</div>

  <% } %>	
<table class="pie line area bar jq<%=request.getAttribute("user_id")%>" style='display:none;'>
	<caption>Actual Sales and Target Per Month</caption>
	<thead>
		<tr>
			<td></td>
			
	<% for(int a=1;a<13;a++){ %>			
			<th><%=strMonths[a]%></th>
	<% } %>		
			
		</tr>
	</thead>
	<tbody>
		<tr>
		
			<th>Target</th>
			<% for(int a=1;a<13;a++){ %>
				<td><%=iActualTarget[a]%></td>
			<% } %>
		</tr>
		
		
			<tr>
			<th>Actual</th>
			<% for(int a=1;a<13;a++){ %>
				<td><%=iActualSales[a]%></td>
			<% } %>
			
		</tr>
	</tbody>
</table>

<Div style='margin-bottom:20px;'>&nbsp;</Div>
