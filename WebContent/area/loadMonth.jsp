<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 

		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();

		String[] strMonths=ch.loadShortMonths();
		Map areaInfo = (HashMap) request.getAttribute("areaInfo");
		String[] teamLeadinfo =(String[]) areaInfo.get("teamLeadInfo");
		String[][] teamMemberinfo = (String[][]) areaInfo.get("teamMembers");
		String areaYtd = (String) areaInfo.get("actualYtd");
		String areaMtd = (String) areaInfo.get("actualMtd");
		String targetYtd = (String) areaInfo.get("targetYtd");
		String targetMtd = (String) areaInfo.get("targetMtd");
		float[] monthlySales = (float[]) areaInfo.get("monthlySales");
		float[] monthlyTarget  = (float[]) areaInfo.get("monthlyTarget");

		
		
%>

  <div class="ui-grid-b jqSection" style="margin-top:-2%">
	<div class="ui-block-a"><a href="#team" id="OpenTeam" class="ibtntabs ui-btn ui-btn-b ui-corner-all ui-shadow ui-mini" style="margin-top:6%">Area Team</a></div>	
	<div class="ui-block-b"><a href="#year" id="OpenYear" class="ibtntabs ui-btn ui-btn-b ui-corner-all ui-shadow ui-mini" style="margin-top:6%">Yearly</a></div>	
	<div class="ui-block-c"><a href="#month" id="OpenMonth" class="ibtntabs ui-btn ui-btn-b ui-corner-all ui-shadow ui-mini" style="margin-top:6%">Monthly</a></div>	
  </div>
  	<div id="team" style="display:none">
  		Team Leader: <a href="<%=sitePathInitMin%>Profile/<%=teamLeadinfo[0]%>"><%=teamLeadinfo[1]+" "+teamLeadinfo[2] %></a> <br/>
  					<table  data-role="table" class="ui-responsive table-stroke">
					<thead>
						<tr><td>Team Members</td></tr>
					</thead>
					<tbody>
					<% for(int i = 0; i<teamMemberinfo.length;i++){ %>
					<tr>
						<td class='col1'><a href="<%=sitePathInitMin%>Profile/<%=teamMemberinfo[i][0]%>" class="jq_viewProfile"><%=teamMemberinfo[i][1]+" "+teamMemberinfo[i][2]%></a></td>
					</tr>
					<% } %>
					</tbody>
				</table>


	</div>
	<div id="year" style="display:none">
		    <script type="text/javascript">
		  	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;	
		  	var height = (window.innerHeight > 0) ? window.innerHeight : screen.height;	
		    var svg = dimple.newSvg("#year", width*.8,height);
		    var data = [
		                {'Projection': 'MTD', 'Amount': <%=areaMtd%>,'Type':'Actual'},
		                {'Projection': 'MTD', 'Amount': <%=targetMtd%>,'Type':'Target'},
		                {'Projection': 'YTD', 'Amount': <%=areaYtd%>,'Type':'Actual'},
		                {'Projection': 'YTD', 'Amount': <%=targetYtd%>,'Type':'Target'},
		                {'Projection': 'Total', 'Amount': <%=areaYtd%>,'Type':'Actual'},
		                {'Projection': 'Total', 'Amount': <%=targetYtd	%>,'Type':'Target'},
		
		          
		
		            ];
		    var myChart = new dimple.chart(svg, data);
		    myChart.setBounds(34.5, 20, width*.8, height-(height*.5));
		    var xAxis = myChart.addCategoryAxis("x", ["Projection","Type"]);
		    var yAxis = myChart.addMeasureAxis("y","Amount");
		    xAxis.addOrderRule(["MTD","YTD","Total"]);
		    
		    
		    myChart.addSeries("Type", dimple.plot.bar);
		
		    myChart.addLegend(65, 10, width*.8-(width*0.08), 20, "right");
		    myChart.draw();
		    if (yAxis.titleShape !== null && yAxis.titleShape !== undefined) {
		    	yAxis.titleShape.remove();
		    	}
		    xAxis.titleShape.remove();
		  </script>
	</div>
	<div id="month" style="display:none">
			<script type="text/javascript">
		  	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;	
		  	var height = (window.innerHeight > 0) ? window.innerHeight : screen.height;	
		    var svg = dimple.newSvg("#month", width*.8,height);
		    var TargetM = new Array();
		    var ActualM = new Array();

		    var data = [
		
						<% for(int a=1;a<13;a++){ %>		
						{'Month':'<%=strMonths[a]%>','Type':'Target','Amount':<%=monthlyTarget[a]%>},
						{'Month':'<%=strMonths[a]%>','Type':'Actual','Amount':<%=monthlySales[a]%>},				
						<% } %>	
						{'Month':'<%=strMonths[12]%>','Type':'Target','Amount':<%=monthlyTarget[12]%>},
						{'Month':'<%=strMonths[12]%>','Type':'Actual','Amount':<%=monthlySales[12]%>}			
		            ];
		    var myChart = new dimple.chart(svg, data);
		    myChart.setBounds(34.5, 20, width*.8, height-(height*.5));
		    var xAxis = myChart.addCategoryAxis("x", ["Month","Type"]);
		    var yAxis = myChart.addMeasureAxis("y","Amount");
		    xAxis.addOrderRule(["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]);
		    xAxis.addOrderRule("Type");
		    
		    myChart.addSeries("Type", dimple.plot.bar);
		
		    myChart.addLegend(65, 10, width*.8-(width*0.08), 20, "right");
		    myChart.draw();
		    if (yAxis.titleShape !== null && yAxis.titleShape !== undefined) {
		    	yAxis.titleShape.remove();
		    	}
		    xAxis.titleShape.remove();
		  </script>
	</div>
	
	<script>
		$(document).ready(function(){
			$("#team").show();
			$("#OpenTeam").click(function(){
				$("#team").show();
				$("#year").hide();
				$("#month").hide();
			});
			$("#OpenYear").click(function(){
				$("#year").show();
				$("#team").hide();
				$("#month").hide();
			});
			$("#OpenMonth").click(function(){
				$("#month").show();
				$("#year").hide();
				$("#team").hide();
			});
		});
	</script>
