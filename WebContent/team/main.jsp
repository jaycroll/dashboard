<%@ include file="../sub/header.jsp"%>



<%@ page import="com.misc.lib.RolePermission" %> 


<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));

	int iCtr = Integer.parseInt(request.getAttribute("iCtr").toString());
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




<div class='floatleft green'>Target</div>
<div class='floatleft'>&nbsp; - &nbsp; </div>
<div class='floatleft blu'>Actual</div>
<div class='floatleft bld'>&nbsp; &nbsp;% (Achievement)</div>

<div class='clr'></div>


<div class='margintop30px'>
	<table style='width:900px;' class='gridtable' cellpadding='10' cellspacing='0'>
		<tr class='grayTitle'>
			<td  align='center' class='col2'>MTD</td>
			<td  align='center' class='col2'>YTD</td>
			<td  align='center'class='col2'>Total</td>
		</tr>

		<% for(int i=0; i<=iCtr;i++){ %>
		<tr>
			<td  align='left' class='col1'><a href="<%=sitePathInit%>Profile/<%=request.getAttribute("userid_"+i) %>" class="jq_viewProfile"><%=request.getAttribute("fullname_"+i) %></a></td>
			
			<td  align='center' class='col2'><span class='green'><%=request.getAttribute("monthly_"+i) %></span> -  <span class='blu'><%=request.getAttribute("monthlyrevenue_"+i) %></span> <%=request.getAttribute("monthlypercentage_"+i) %>%</td>

			<td  align='center' class='col2'><span class='green'><%=request.getAttribute("yearly_"+i) %></span> - <span class='blu'><%=request.getAttribute("yearlyrevenue_"+i) %></span> <%=request.getAttribute("yearlypercentage_"+i) %>%</td>
			<td  align='center' class='col2'><span class='green'><%=request.getAttribute("yearlytotal_"+i) %></span> - <span class='blu'><%=request.getAttribute("yearlyrevenue_"+i) %></span> <%=request.getAttribute("yearlytotalpercentage_"+i) %>%</td>
		</tr>
		<% } %>
		<% /*
		<tr>
			<td  align='center'>Juan De La Cruz</td>
			<td  align='center'><span class='green'>4,332,000</span> - <span class='blu'>3,600,000</span> 120%</td>
			<td  align='center'><span class='green'>4,332,000</span> - <span class='blu'>3,600,000</span> 120%</td>
			<td  align='center'><span class='green'>4,332,000</span> - <span class='blu'>3,600,000</span> 120%</td>
		</tr>
		*/ %>
		
		
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
	
	
	
	$(".jqSection .ibtntabs").click(function () {
		
		if(checkLogged()){
			$(".jqSection").find(".ibtntabs").removeClass("active");	
			$(this).addClass("active");
			
			$(".jqAction").val($(this).attr("alt"));
			loadTarget();
		}else{
				window.location='<%=sitePathInit%>';
		}	
	});
	(".jq_viewProfile").click(function () {
		
		if(checkLogged()){
				loadProfile();
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