<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 

		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();
		String[] areas = (String[]) request.getAttribute("areas");
		String[] areaid = (String[]) request.getAttribute("areaId");
		String[][][][] testArray = (String[][][][]) request.getAttribute("testArray");
		String[] strMonths=ch.loadInitMonths();
		Map usrDet=new HashMap();
		Map detMap = (HashMap) request.getAttribute("map");
		usrDet = (Map)request.getAttribute("usrDet");
		
		
%>
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
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,1)",
						data : ay
					},
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						data : ty
					}
				]
			};
		var lmt = Math.max.apply(Math, ty); 
		var lms = Math.max.apply(Math,ay);
		var largest = 0;
		if(lmt<lms){
			 largest = lms;
		}
		else{
			largest = lmt;
		}
		var options={
				scaleOverride:true,				
				scaleSteps: 10,
				scaleStepWidth: Math.ceil(lmt/10),
				scaleStartValue: 0
		};
		var myNewChart = new Chart(ctx).Bar(data);
	}			


	function createMonthlyGraph(area,am,tm){

		var ctx = $("#"+area+"2").get(0).getContext("2d");

		var myNewChart = new Chart(ctx);
		var areas = new Array();
		<%
			for(int a = 1; a<strMonths.length;a++){
		%>
			areas.push("<%=strMonths[a]%>");
		<%
			}
		%>
		var data = {
				labels : areas,
				datasets : [
					{
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,1)",
						data : am
					},
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						data : tm
					}
				]
			};
		var lmt = Math.max.apply(Math, tm); 
		var lms = Math.max.apply(Math,am);
		var largest = 0;
		if(lmt<lms){
			 largest = lms;
		}
		else{
			largest = lmt;
		}
		var options={
				scaleOverride:true,				
				scaleSteps: 10,
				scaleStepWidth: Math.ceil(lmt/10),
				scaleStartValue: 0
		};
		var myNewChart = new Chart(ctx).Bar(data);
	}			
						
</script>		
<%
	for(int j = 1;j<testArray.length;j++){
		if(testArray[j][0][0][0]!=null){
%>
		<div id="dsp"></div>
		<br>
		<br>
		
		<div style="border: 1px solid #000000;width:700px;">
		
		<canvas id="<%=testArray[j][1][0][0]%>" width="600" height="300" ></canvas>
				<div><div style="background-color:#000fff;width:10px;height:10px"></div>Target</div>
				<div><div style="background-color:#0adcef;width:10px;height:10px"></div>Actual</div>			
		</div>
		<br>
		<div><%=testArray[j][0][0][0] %></div>
		<br>
		<div id="teamlead">Team Leader: </div>
		<div id="users">Sales Team:<br></div>	
		<br>
		<br>
		<canvas id="<%=testArray[j][1][0][0]%>2" width="600" height="200" style="border: 1px solid #000000"></canvas>
		<script>
		var ActualYearly = new Array();
		var TargetYearly = new Array();
		var ActualMonthly = new Array();
		var TargetMonthly = new Array();
		<%
			int ctr = 1;
			if(testArray[j][2][1][1]!=null){
				%>
					$("#teamlead").append("<a href='<%=sitePathInitMin%>Profile/<%=testArray[j][2][1][0]%>'><%=testArray[j][2][1][1]%></a>");
				<%
			}
			for(int i = 2;i<testArray[j][2].length;i++){
				if(testArray[j][2][i][1]!=null){
					%>
						$("#users").append("<%=ctr%>. <a href='<%=sitePathInitMin%>Profile/<%=testArray[j][2][i][0]%>'><%=testArray[j][2][i][1]%></a><br>");
					<%
					ctr++;
				}
			}

			for(int i = 0;i<testArray[j][3][0].length;i++){
				if(testArray[j][3][0][i]!=null){
					%>		
							ActualYearly.push("<%=testArray[j][3][0][i]%>");
					<%
				}
			}
			for(int i = 0;i<testArray[j][4][0].length;i++){
				if(testArray[j][4][0][i]!=null){
					%>
							TargetYearly.push("<%=testArray[j][4][0][i]%>");						
					<%
				}
			}
			for(int i=1;i<testArray[j][5].length;i++){
				if(testArray[j][5][i][0]!=null){
					%>
						TargetMonthly[<%=i%>-1]=<%=testArray[j][5][i][0]%>;
						
					<%
				}
			}
			for(int i=1;i<testArray[j][6].length;i++){
				if(testArray[j][6][i][0]!=null){
					%>
						ActualMonthly[<%=i%>-1]=<%=testArray[j][6][i][0]%>;
					<%
				}
			}
		%>
		ActualYearly[2] = ActualYearly[1];
		TargetYearly[2] = TargetYearly[1];
		createYTDGraph(<%=testArray[j][1][0][0] %>,ActualYearly,TargetYearly);
		createMonthlyGraph(<%=testArray[j][1][0][0]%>,ActualMonthly,TargetMonthly);
		</script>
<% 		
		}

	}
%>
<div id='test'>

</div>


		
<Div style='margin-bottom:20px;'>&nbsp;</Div>
