<%@ include file="../sub/header.jsp"%>

<%@ page import="com.misc.lib.RolePermission" %> 
<%@ page import="com.model.lib.*" %>
<%@ page import="java.sql.*" %>
<%
	HttpSession sMain = request.getSession();
	RolePermission rpMain = new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));
	String[][] channelList = (String[][]) request.getAttribute("channelList");
	String[] loc_def = (String[]) request.getAttribute("classCSS");
	String disabled="";
	String display_1="";
	String display_2="";
	String display_11="";
	String display_21="";
	if(loggedState){
		
		 if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),8,6)){
			 disabled="";
		     display_11="";
			 display_21="display:none";
			 disabled="";
			
		 }
		 else{
			 disabled="ui-disabled";
			 display_11="display:none";
			 display_21="";
		 }
	}else{
		
		display_1="";
		display_2="display:none";
	}
%>

<div id ="productSales">

	<div data-role="panel" id="mypanel" data-display="overlay" data-position="right">
	    <ul data-role="listview" data-theme="a" data-divider-theme="b" data-count-theme="a">
	    <li data-role="list-divider" style="font-weight:normal;font-size:20px;">Product Sales Menu</li>
	    <li><a href="<%=sitePathInit%>DomesticProducts" class="<%=disabled%>" style="font-weight:normal;">Domestic Sales Projection</a></li>
	    <li><a href="<%=sitePathInit%>InternationalProducts" class="<%=disabled%>" style="font-weight:normal;">International Sales Projection</a></li>
	    <li><a href="<%=sitePathInit%>" style="font-weight:normal;">Home Page</a></li>
	</ul>
	</div>
	<div data-role="header" align="center" style="border:0px;margin-bottom:2%;" data-theme="b">
			<img src="<%=sitePathInit%>images/ppe-black.svg"  width="80%"/>		
	</div>
	<div data-role="header" style="border:0px" data-theme="b">
	  		<div id="title2">Dashboard</div>
	  		<a href="" class="jq_btnLogout ui-btn ui-btn-a ui-corner-all  ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="">Logout</span></a>
	  		<a href="#mypanel" class="ui-btn ui-btn-a ui-corner-all  ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="" >Menu</span></a>
	</div>
	<div data-role="content" style="<%=display_11%>">
		<div class="ui-grid-solo">	
				Select Product:
			    <form>
				<fieldset data-role="controlgroup" data-type="horizontal">
			    	<label for="select2">Product:</label>
			    	<select name="territory" name="select2" id="product2" data-inline="true" data-mini="true">
			    		<option value="" >--Product--</option>
							<%
								for(int i = 0; i<channelList.length;i++){
									%>
										<option value="<%=channelList[i][0]%>"><%=channelList[i][1] %>-<%=channelList[i][0]%></option>
									<%
								}
							%>
				    </select>
				</fieldset>
				</form>
		</div>
		<div class="ui-grid-solo" id="content6">	
		</div>
	</div>
	<div data-role="content" style="<%=display_21%>">
		<div class="ui-grid-solo content" style="text-align:center">
				  <div class=''>Access Denied</div>
				  <br>
				  <div class=''><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
		</div>
	</div>
</div>
<script type='text/javascript' src='<%=sitePathInit%>include/login.jsp'></script>
<script type='text/javascript' src='<%=sitePathInit%>include/custom.jsp'></script>
</div>
<script>
$(document).ready(function(){
		
	
});
$("#product2").change(function(){
	var str = "";
    $( "#product2 option:selected" ).each(function() {
      str += $( this ).val();
      $("#content6").empty();
   	loadProductProjection2(str);
    	});
	
});

function loadProductProjection2(channel_id){
	var channel_id = channel_id;
	$.post("<%=sitePathInit%>AInternationalSales",{action:'loadSales',channel_id:channel_id},
			   function(data){
	
		$("#content6").append(data);
	});
}
</script>