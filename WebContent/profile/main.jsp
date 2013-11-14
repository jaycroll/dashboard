<%@ include file="../sub/header.jsp"%>



<%@ page import="com.misc.lib.RolePermission" %> 
<%@ page import="java.text.DecimalFormat" %>

<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));
	CustomHelper ch = new CustomHelper();
	float[] iActualSales = (float[]) request.getAttribute("monthlySales");
	float[] iActualTarget = (float[]) request.getAttribute("monthlyTargets");
	String[] strMonths=ch.loadInitMonths();
	DecimalFormat numberFormat = new DecimalFormat("#.00");
%>

<div id="header" align="center"><img src="<%=sitePathInit%>images/ppe-blk.png"/></div>
<div id="title">

<a href="<%=sitePathInit%>" class="lucida_21_black"><img src="<%=sitePathInit%>images/target-small.png" align="absmiddle"/>Dashboard</a>

</div>

<% if(loggedState){%>
<div id="menu">
<div id="menu-right" class="lucida_12_tungsten_b"> Hello, <%=sess.getAttribute("username")%> (<%=sess.getAttribute("rolename")%>). <a href="<%=sitePathInit%>User/logout"><span class="lucida_12_red_b">Logout</span></a></div>
<div id="menu-left">
	<ul class="sub">
	<li id="menu1"><a href="<%=sitePathInit%>Projection" title="menu1"><span class="displace"></span></a></li>
	<li id="menu2"><a href="<%=sitePathInit%>Team" title="menu2"  class="active"><span class="displace"></span></a></li>
    <li id="menu3"><a href="<%=sitePathInit%>Area"  title="menu3"><span class="displace"></span></a></li>
    </ul>
</div>
</div>


<form id='formTarget'>

<% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),8,6)){	%>  

<div id="content" style='float:left'>
	<div>
	<!-- Profile status here -->
	</div>
	<div>
	<!-- Form and Table here  -->
		<table>
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
						<td><%=iActualTarget[a] %></td>
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
	</div>
</div>


<% }else{ %>
		
		<div style='clear:both'>&nbsp;</div>
		<div  class='divCenter txtCenter'>
			  <div class='access_denied'>Access Denied</div>
			  <div class='clr'>&nbsp;</div>
			  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
              <div class='clr'>&nbsp;</div>
	    </div>
<% } %>

<input type='hidden' name='action' class='jqAction' value='loadDefault'> 
</form>

<script type='text/javascript'>

$(document).ready(function($){
	
	
	
	$(".jqSection .ibtntabs").live('click',function () {
		
		if(checkLogged()){
			$(".jqSection").find(".ibtntabs").removeClass("active");	
			$(this).addClass("active");
			
			$(".jqAction").val($(this).attr("alt"));
			loadTarget();
		}else{
				window.location='<%=sitePathInit%>';
		}	
	});
	
	
	
});



function loadTarget(){
	$.post("<%=sitePathInit%>AProjection",$("#formTarget").serialize(),
			   function(data){
		$("#content").html(data);	
		$('table.bar').visualize({type: 'bar', barDirection: 'vertical'});
	});
}

</script>

<% }%>