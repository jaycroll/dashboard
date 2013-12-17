<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.CustomHelper" %> 
		
<%  
		String sitePathInitMin =request.getContextPath()+"/";
		CustomHelper ch=new CustomHelper();
		int[] channels = (int[]) request.getAttribute("channels"); 
		String[][][] productArray2 = (String[][][]) request.getAttribute("productArray2");
		
%>				

<script>


	function createMonthlyGraph(area,mS,mT){
		var area = area;
		var ctx = $("#"+area).get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		var areas = new Array();
		var data = {
				labels : ["J","F","M","A","M","J","J","A","S","O","N","D"],
				datasets : [
					{
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,1)",
						data : mS
					},
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						data : mT
					}
				]
			};

		var myNewChart = new Chart(ctx).Bar(data);
	}			
	var monthlySales = new Array();
	var monthlyTarget = new Array();
</script>
<div id="test"></div>
<%
for(int i=0; i<channels.length;i++){
	%>
		<canvas id="<%=productArray2[i][0][0] %>" width="600" height="300" ></canvas>
	<%
	for(int j = 0;j<productArray2[i][1].length;j++){
		if(productArray2[i][1][j]!=null){
		%>
			<script>
				monthlySales[<%=j%>]=<%=productArray2[i][1][j]%>;
				
			</script>
		<%
		}
		else{
			%>
				<script>
				monthlySales[<%=j%>]="0";
				
			</script>
			<%
		}
	}
	

}
%>