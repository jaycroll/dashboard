<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();
		String[] strMonths=ch.loadShortMonths();
		Map channelVars = (Map) request.getAttribute("reqVar");
		String ytd = (String) channelVars.get("YTD");
		String mtd = (String) channelVars.get("MTD");
		String targetYtd = (String) channelVars.get("TargetYTD");
		String targetMtd = (String) channelVars.get("TargetMTD");
		float[] monthlySales = (float[]) channelVars.get("monthlySales");
		float[] monthlyTarget = (float[]) channelVars.get("monthlyTarget");

%>				
  <div class="ui-grid-b jqSection" style="margin-top:-2%">	
	<div class="ui-block-b"><a href="#year2" id="OpenYear2" class="ibtntabs ui-btn ui-btn-b ui-corner-all ui-shadow ui-mini" style="margin-top:6%">Yearly</a></div>	
	<div class="ui-block-c"><a href="#month2" id="OpenMonth2" class="ibtntabs ui-btn ui-btn-b ui-corner-all ui-shadow ui-mini" style="margin-top:6%">Monthly</a></div>	
  </div>

	<div id="year2" style="display:none">
		    <script type="text/javascript">
		  	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;	
		  	var height = (window.innerHeight > 0) ? window.innerHeight : screen.height;	
		    var svg = dimple.newSvg("#year2", width*.8,height);
		    var data = [
		                {'Projection': 'MTD', 'Amount': <%=mtd%>,'Type':'Actual'},
		                {'Projection': 'MTD', 'Amount': <%=targetMtd%>,'Type':'Target'},
		                {'Projection': 'YTD', 'Amount': <%=ytd%>,'Type':'Actual'},
		                {'Projection': 'YTD', 'Amount': <%=targetYtd%>,'Type':'Target'},
		                {'Projection': 'Total', 'Amount': <%=ytd%>,'Type':'Actual'},
		                {'Projection': 'Total', 'Amount': <%=targetYtd%>,'Type':'Target'},
		
		          
		
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
	<div id="month2" style="display:none">
			<script type="text/javascript">
		  	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;	
		  	var height = (window.innerHeight > 0) ? window.innerHeight : screen.height;	
		    var svg = dimple.newSvg("#month2", width*.8,height);
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

			$("#year2").show();
			$("#OpenYear2").click(function(){
				$("#year2").show();
				$("#month2").hide();
			});
			$("#OpenMonth2").click(function(){
				$("#month2").show();
				$("#year2").hide();
			});
	
	</script>