<%@ include file="../sub/header.jsp"%>
<%@ page import="com.misc.lib.RolePermission" %> 


<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));
	
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
	<li id="menu1"><a href="<%=sitePathInit%>Projection" title="menu1" class="active"><span class="displace"></span></a></li>
	<li id="menu2"><a href="<%=sitePathInit%>Team" title="menu2"><span class="displace"></span></a></li>
    <li id="menu3"><a href="<%=sitePathInit%>Area"  title="menu3"><span class="displace"></span></a></li>
    </ul>
</div>
</div>



<div id="submenu-right">
	<ul class="tab jqSection">
		<li><a href="javascript:void(0);" class="ibtntabs active" alt='loadDefault'>Snapshot</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='loadMonth'>Monthly</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs">Query</a></li>
		
	</ul>
</div>


<br><br>


<form id='formTarget'>
<div id="content" class="hoverhand">

<% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),7,6)){	%>  

<% }else{ %>
		
		<div style='clear:both'>&nbsp;</div>
		<div  class='divCenter txtCenter'>
			  <div class='access_denied'>Access Denied</div>
			  <div class='clr'>&nbsp;</div>
			  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
              <div class='clr'>&nbsp;</div>
	    </div>
<% } %>
<%--include file="../target/loadDefault.jsp" --%>
		
</div>
<input type='hidden' name='action' class='jqAction' value='loadDefault'> 
</form>

<script type='text/javascript'>

$(document).ready(function($){
	
	<% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),7,6)){	%> 	
			loadTarget();
	<% } %>		

	
	
	$(".jqSection .ibtntabs").click(function () {
		
		if(checkLogged()){
				
			$(".jqSection").find(".ibtntabs").removeClass("active");	
			$(this).addClass("active");
			
			$(".jqAction").val($(this).attr("alt"));
			
			if(checkPermission(7,6)){
				mainModule=true;
			}else{
				mainModule=false;
			}
			
	  		if(mainModule){		
				loadTarget();
	  		}
	  		
	  	}else{
				window.location='<%=sitePathInit%>';
		}	
	});
	
	
/*
	
	$(".jq_AreaTabs .ibtntabs").click(function () {
		
		if(checkLogged()){
			
			$(".jq_AreaTabs").find(".ibtntabs").removeClass("selected");	
			$(this).addClass("selected");
			
				$.post("<%=sitePathInit%>APurchase",{action:$(this).attr("alt")},
						   function(data){
									//Submit Form	
									$(".jq_AreaManagementView").html(data);
				});
		}else{
				window.location='<%=sitePathInit%>';
		}	
	});
	
	*/
	
});



function loadTarget(){
	$.post("<%=sitePathInit%>AProjection",$("#formTarget").serialize(),
			   function(data){
		$("#content").empty();
		$("#content").html(data);	
		$('table.bar').visualize({type: 'bar', barDirection: 'vertical'});
		$('#content').click(function() {
				var d = new Date();
				d.setDate(d.getDate() - 1);
				var dmonth = d.getMonth();
				if (dmonth < 10)
					dmonth = "0" + dmonth;
					
				var href = "<%=sitePathInit%>SalesReports";
					window.location = href;

				$('#content').hover(function() {
					$(this).css('cursor', 'hand');
				},function() {
					$(this).css('cursor','auto');
				});
		});
	});
}

</script>

<% }%>
