<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
				
<table  class="pie line area bar" style='display:none;' >
	<caption>Actual Sales and Target</caption>
	<thead>
		<tr>
			<td></td>
			<th>MTD</th>
			<th>YTD</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>Target</th>
			<td><%=request.getAttribute("rsMonthTarget")%></td>
			<td><%=request.getAttribute("rsYearTarget")%></td>
			<td><%=request.getAttribute("rsYearTotalTarget")%></td>
			
		</tr>
		<tr>
			<th>Actual</th>
			<td><%=request.getAttribute("rsMonthRevenue")%></td>
			<td><%=request.getAttribute("rsYearRevenue")%></td>
			<td><%=request.getAttribute("rsYearRevenue")%></td>
			<td>0</td>
		
		
		</tr>
	
	</tbody>
</table>
