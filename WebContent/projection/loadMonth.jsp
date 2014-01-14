<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();
		float[] iActualSales = (float[]) request.getAttribute("iActualSales");
		float[] iActualTarget = (float[]) request.getAttribute("iActualTarget");
		String[] strMonths=ch.loadInitMonths();
		
%>	
<script>

function createMTDGraph(area,am,tm){
	var area = area;
	var ctx = $("#"+area).get(0).getContext("2d");
	var myNewChart = new Chart(ctx);
	var areas = new Array();
	var months = new Array();
	<% for(int a=1;a<13;a++){ %>			
		months[<%=a%>-1]="<%=strMonths[a]%>";
	<% } %>	
	var data = {
			labels : months,
			datasets : [

				{
					fillColor : "rgba(41,171,226,1)",
					strokeColor : "rgba(41,171,226,1)",
					data : am
				},
				{
					fillColor : "rgba(25,131,43,1)",
					strokeColor : "rgba(25,131,43,1)",
					data : tm
				}
			]
			
		};
	var options={
			scaleOverride:true,				
			scaleSteps: 10,
			scaleStepWidth: 71*123,
			scaleStartValue: 100000
	};
	var thisNewChart = new Chart(ctx).Bar(data,options);
}			
</script>
<div style="border: 1px solid #000000;width:700px;">
		<h2>Actual Sales and Target</h2>
		<canvas  id="mtd" width="600" height="300" ></canvas>
				<div><div style="background-color:#000fff;width:10px;height:10px"></div>Target</div>
				<div><div style="background-color:#0adcef;width:10px;height:10px"></div>Actual</div>	
		<script>
			var ActualM = new Array();
			var TargetM = new Array();
			<% for(int a=1;a<13;a++){ %>
				TargetM[<%=a%>-1]='<%=iActualTarget[a]%>';
				ActualM[<%=a%>-1]='<%=iActualSales[a]%>';
			<% } %>
			createMTDGraph("mtd",ActualM,TargetM);
		</script>		
</div>				

