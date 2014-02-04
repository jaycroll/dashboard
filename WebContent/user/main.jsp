<%@ include file="../sub/header.jsp"%>



<%@ page import="com.misc.lib.RolePermission" %> 


<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));


	String disabled="";
	String display_1="";
	String display_2="";
	String display_11="";
	String display_21="";
	String display_search="display:none;";
	String display_view="display:none;";
	String display_add="display:none;";
	String display_edit="display:none;";
	String display_delete="display:none;";
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
		 if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),1,7)){
			 display_search="";
		 }
		 if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),1,1)){ 
		 	display_add="";
		 }
		 if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),1,6)){
		 	display_view="";
		 }
		 

	}else{
		
		display_1="";
		display_2="display:none";
	}
	ResultSet rs = (ResultSet) request.getAttribute("usrList");
	ResultSet rsUserList = (ResultSet) request.getAttribute("usrListSpec"); 
	ResultSet rsRole = (ResultSet) request.getAttribute("urlRole"); 
%>
<div id="team">

	<div data-role="panel" id="mypanel" data-display="overlay" data-position="right">
	    <ul data-role="listview" data-theme="a" data-divider-theme="b" data-count-theme="a">
	    <li data-role="list-divider" style="font-weight:normal;font-size:20px;">Target Menu</li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">User Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Role Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Privilege Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Target Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Product Target Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Channel Management</a></li>
	    <li><a href="<%=sitePathInit%>" class="<%=disabled%>" style="font-weight:normal;">Sales Management</a></li>
	    <li><a href="<%=sitePathInit%>" style="font-weight:normal;">Home Page</a></li>
	</ul>
	</div>
	<div data-role="header" align="center" style="border:0px;margin-bottom:2%;" data-theme="b">
			<img src="<%=sitePathInit%>images/ppe-black.svg" width="80%"/>		
	</div>
	<div data-role="header" style="border:0px" data-theme="b">
	  		<div id="title2">Dashboard</div>
	  		<a href="" class="jq_btnLogout ui-btn ui-btn-a ui-corner-all ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="">Logout</span></a>
	  		<a href="#mypanel" class="ui-btn ui-btn-a ui-corner-all ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="" >Menu</span></a>
	</div>
	<div data-role="content" style="<%=display_11%>" id="search">
		<div class="ui-grid-solo"  style="">
			<a href="#" class="jq_btnAddUser ui-btn ui-btn-b ui-corner-all ui-btn-icon-left ui-icon-plus ui-nodisc-icon ui-mini" style="<%=display_add%> font-size:14px;float:left"><span class="" >Add User</span></a>	
			
		</div>
		<form id="formUserList" name="form1" method="post" action="">
		<input type='hidden' name='action' value='subLoadUser'>
		<div class="ui-grid-a" id="" style="<%=display_search%>">
			<div class="ui-block-a" id="" style="">
				<select name="userid" id="select" class='iUserSelect ui-mini'>
					<option value=""></option>
				<% while(rsUserList.next()){
				%>
         			 <option value='<%=rsUserList.getString("userid")%>'><%=rsUserList.getString("userfirstname")%> <%=rsUserList.getString("userlastname")%></option>
				<% } %>          
				</select>
			</div>
			<div class="ui-block-b" id="" style="">
				<select name="roleid" class="iUserSelect ui-mini" id="select2">
           			<option value=""></option>
           			<%
           				while(rsRole.next()){
					%>
            			<option value="<%=rsRole.getString("roleid")%>"><%=rsRole.getString("rolename")%></option>
					<% } %>      
				</select>
			</div>
		</div>
		</form>
	</div>
	<div data-role="content" style="<%=display_11%>" id="search">
		<div class="ui-grid-solo"  style="<%=display_view%>">
			<%
				if(display_view==""){
					%>
						<table  border="0" align="center" cellpadding="5" cellspacing="0" class='tblUserlist table-stroke'>      
						  <%@include file="/user/result_UserList.jsp" %>
						</table>
					<%
				}
			%>
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
<script>
$(document).ready(function($){
	
	
	$(".jq_UserTabs .ibtntabs").click(function () {
		
		if(checkLogged()){
			
							
			if(mainModule){
				$.post("<%=sitePathInit%>AUser",{action:$(this).attr("alt")},
						   function(data){
									//Submit Form	
									$(".jq_AccessManagementView").html(data);
								
				});
			}	
		}else{
				window.location='<%=sitePathInit%>';
		}	
	});


	$(".jq_DeleteAccess").click(function () {
	
		if(checkLogged()){
				
				$.post("<%=sitePathInit%>AUser",{action:'initDelete',userid:$(this).attr("alt")},
						   function(data){
									$('.basic-container').html(data);
									initModal();
				});
		}else{
			window.location='<%=sitePathInit%>';	
		}
	});	
	
	
	
	
	
	$(".jq_btnAddUser").click(function () {
		
		window.location="<%=sitePathInit%>User/AddAccess";
		
	});
	
	
	
	$('.iUserSelect').change( function(){
		loadUser();
	});
	
});
function loadUser(){
	$.post("<%=sitePathInit%>AUser",$("#formUserList").serialize(),
			   function(data){
		$(".tblUserlist").html(data);	
	});
}
</script>