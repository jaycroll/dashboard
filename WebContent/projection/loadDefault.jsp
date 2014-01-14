<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
<script>


	function createYTDGraph(area,ay,ty){
		var area = area;
		var ctx = $("#"+area).get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		var areas = new Array();
		var data = {
				labels : ["MTD","YTD","Total"],
				datasets : [
					{
						fillColor : "rgba(25,131,43,1)",
						strokeColor : "rgba(25,131,43,1)",
						data : ty
					},
					{
						fillColor : "rgba(41,171,226,1)",
						strokeColor : "rgba(41,171,226,1)",
						data : ay
					}
				]
				
			};
		var options={
				scaleOverride:true,				
				scaleSteps: 10,
				scaleStepWidth: 71*1234567,
				scaleStartValue: 100000
		};
		var myNewChart = new Chart(ctx).Bar(data,options);
	}			

				
</script>		
<div style="border: 1px solid #000000;width:700px;">
		<h2>Actual Sales and Target</h2>
		<canvas  id="ytd" width="600" height="300" ></canvas>
				<div><div style="background-color:#000fff;width:10px;height:10px"></div>Target</div>
				<div><div style="background-color:#0adcef;width:10px;height:10px"></div>Actual</div>	
		<script>
			var ActualYearly = new Array();
			var TargetYearly = new Array();
			TargetYearly[0] = <%=request.getAttribute("rsMonthTarget")%>;
			TargetYearly[1] = <%=request.getAttribute("rsYearTarget")%>;
			TargetYearly[2] = <%=request.getAttribute("rsYearTotalTarget")%>;
			
			ActualYearly[0] = <%=request.getAttribute("rsMonthRevenue")%>;
			ActualYearly[1] = <%=request.getAttribute("rsYearRevenue")%>;
			ActualYearly[2] = <%=request.getAttribute("rsYearRevenue")%>;
			createYTDGraph("ytd",ActualYearly,TargetYearly);
		</script>		
</div>			
