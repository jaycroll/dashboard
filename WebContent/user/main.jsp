<%@ include file="../sub/header.jsp"%>


<%@ page import="com.misc.lib.RolePermission" %> 

<% 
	HttpSession sMain=request.getSession();
	RolePermission rpMain=new RolePermission();
	rpMain.gAppProperties(request.getRealPath("/"));
%>   
<style type="text/css">
.text_12_tungsten {font-family:"Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size:12px;
	color:#333;
	text-align: center;
}
</style>

<div id="header" align="center"><img src="<%=sitePathInit%>images/ppe-blk.png"/></div>
<div id="title"><a href="<%=sitePathInit%>" class="lucida_21_black"><img src="<%=sitePathInit%>images/lock_small.png" align="absmiddle"/>Dashboard</a></div>

<% if(loggedState){%>
<div id="menu">
	<div id="menu-right" class="lucida_12_tungsten_b"> Hello, <%=sess.getAttribute("username")%> (<%=sess.getAttribute("rolename")%>). <a href="<%=sitePathInit%>User/logout"><span class="lucida_12_red_b">Logout</span></a></div>
</div>
<div id="submenu">

<div>
<ul class="tabs jq_UserTabs access">
            <li id='access1' ><a href="<%=sitePathInit%>User"  class=' ibtntabs active' title='User Management'></a></li>
            <li id='access2' ><a href="<%=sitePathInit%>Roles"  class='ibtntabs' title='Role Management'></a></li>
            <li id='access3' ><a href="<%=sitePathInit%>Privilege"  class='ibtntabs' title='Privileges Management'></a></li>
     	 	<li id='access4' ><a href="<%=sitePathInit%>Target"  class='ibtntabs' title='Target Management'></a></li>
     	 	<li id='access5' ><a href="<%=sitePathInit%>Channel"  class='ibtntabs' title='Channel Management'></a></li>
     	 	<li id='access6' ><a href="<%=sitePathInit%>Sales"  class='ibtntabs' title='Sales Management'></a></li>
     	 </ul>

</div>

</div>
</div>
<% }%>

<div id="primary">

       <div class="tabcontents">
            <div id="view1" class="tabcontent">
            
            
<div id='basic-modal' class='jq_AccessManagementView'>

<% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),1,6)){	%>   
      <%@ include file="../user/sub_UserList.jsp"%>
<% }else{ %>

		<div class='divCenter txtCenter'>
							   <div class='access_denied'>Access Denied</div>
							   <div class='clr'>&nbsp;</div>
							  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
	                           <div class='clr'>&nbsp;</div>
	                           </div>
<% } %>      
</div></div></div>

</div>
<script type='text/javascript' src='<%=sitePathInit%>include/custom.jsp'></script>
<script type='text/javascript' src='<%=sitePathInit%>include/custom_logged.jsp'></script>

<script type='text/javascript'>
$(document).ready(function($){
		
	
		$(".jq_UserTabs .ibtntabs").live('click',function () {
			
			if(checkLogged()){
				$(".jq_UserTabs").find(".ibtntabs").removeClass("active");	
				$(this).addClass("active");
				
				
				
				var mainModule=true;
				
				if($(this).attr("alt")=='loadUser'){
				
					if(checkPermission(1,6)){
						mainModule=true;
					}else{
						mainModule=false;
					}
				
				}
				
				
				if($(this).attr("alt")=='loadRole'){
					
					if(checkPermission(2,6)){
						mainModule=true;
					}else{
						mainModule=false;
					}
				
				}
				
				
			   if($(this).attr("alt")=='loadPrivilege'){
					
					if(checkPermission(3,6)){
						mainModule=true;
					}else{
						mainModule=false;
					}
				
				}
				
				
					
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
	
	
		$(".jq_DeleteAccess").live('click',function () {
		
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
		
		
		$(".jq_ConfirmDeleteAccess").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>AUser",{action:'processDelete',userid:$(this).attr("alt")},
						   function(data){
					
								$(".jq_DeleteUserStatus").html(data.status);	
								
								if(data.process){
									$(".jq_DeleteUserStatus").removeClass("red");	
									loadUser();
									setTimeout("$.modal.close()",2000);
								}else{
									$(".jq_DeleteUserStatus").addClass("red");	
								}
								
								
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
		$(".jq_btnAddAccess").live('click',function () {
			
			$.post("<%=sitePathInit%>AUser",$("#formAddAccess").serialize(),
					   function(data){
							if(!data.logged){
									window.location='<%=sitePathInit%>';
							}else{
								
							  if(!data.process){	
								$.each(data, function(index, value) {
									$("."+index).html(value).fadeIn("fast");
								});
									//$(".jq_Loading").hide();
									//$(".btnProcess").show();
							   }else{
								   window.location='<%=sitePathInit%>User';
							   }	
							
							}
							
			}, "json");
			
		});
		
		
		
		$('.iUserSelect').live('change', function(){
			loadUser();
		});
		
		
		////////////////////////////////////////////////////////
		/////////////////////////Role//////////////////////////
		
		
		$(".jq_AddRole").live('click',function () {
			
			if(checkLogged()){
					
					$.post("<%=sitePathInit%>ARole",{action:'initAdd'},
							   function(data){
										$('.basic-container').html(data);
										initModalScroll();
					});
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});
		 
		
		$(".jq_ConfirmAddRole").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>ARole",$("#formAddRole").serialize(),
						   function(data){
						
								$(".jq_AddRoleStatus").html(data.status);	
								
								if(data.process){
									$(".jq_AddRoleStatus").removeClass("red");
									$(".jq_AddRoleStatus").addClass("lnkGrn");
									loadRole();
									setTimeout("$.modal.close()",2000);
								}else{
									$(".jq_AddRoleStatus").removeClass("lnkGrn");	
									$(".jq_AddRoleStatus").addClass("red");
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
		
		$(".jq_DeleteRole").live('click',function () {
			
			if(checkLogged()){
					
					$.post("<%=sitePathInit%>ARole",{action:'initDelete',roleid:$(this).attr("alt")},
							   function(data){
										$('.basic-container').html(data);
										initModal();
					});
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});	
		
		
		$(".jq_ConfirmDeleteRole").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>ARole",{action:'processDelete',roleid:$(this).attr("alt")},
						   function(data){
					
								$(".jq_DeleteRoleStatus").html(data.status);	
								
								if(data.process){
									$(".jq_DeleteRoleStatus").removeClass("red");		
									setTimeout("$.modal.close()",2000);
									loadRole();
								}else{
									$(".jq_DeleteRoleStatus").addClass("red");	
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
		
		$(".jq_EditRole").live('click',function () {
			
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>ARole",{action:'initEdit',roleid:$(this).attr("alt")},
						   function(data){
									$('.basic-container').html(data);
									initModalScroll();
				});
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});	
		
		
		
		$(".jq_ConfirmEditRole").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>ARole",$("#formEditRole").serialize(),
						   function(data){
						
									$(".jq_EditRoleStatus").html(data.status);	
								
								if(data.process){
									$(".jq_EditRoleStatus").removeClass("red");
									$(".jq_EditRoleStatus").addClass("lnkGrn");
									loadRole();
									setTimeout("$.modal.close()",2000);
								}else{
									$(".jq_EditRoleStatus").removeClass("lnkGrn");	
									$(".jq_EditRoleStatus").addClass("red");
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
		////////////////////////////////////////////////////////
		/////////////////////////Privilege//////////////////////////
		
		$(".jq_AddPrivilege").live('click',function () {
			
			if(checkLogged()){
					
					$.post("<%=sitePathInit%>APrivilege",{action:'initAdd'},
							   function(data){
										$('.basic-container').html(data);
										initModal();
					});
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});
		
		
	
		
		$(".jq_ConfirmAddPrivilege").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>APrivilege",$("#formAddPrivilege").serialize(),
						   function(data){
						
								$(".jq_AddPrivilegeStatus").html(data.status);	
								
								if(data.process){
									$(".jq_AddPrivilegeStatus").removeClass("red");
									$(".jq_AddPrivilegeStatus").addClass("lnkGrn");
									loadPrivilege();
									setTimeout("$.modal.close()",2000);
								}else{
									$(".jq_AddPrivilegeStatus").removeClass("lnkGrn");	
									$(".jq_AddPrivilegeStatus").addClass("red");
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
	$(".jq_EditPrivilege").live('click',function () {
			
			if(checkLogged()){
				
				var mainModule=false;
				
				if(checkPermission(3,2)){
					mainModule=true;
				}else{
					mainModule=false;
				}
				
				if(mainModule){
					$.post("<%=sitePathInit%>APrivilege",{action:'initEdit',privilegeid:$(this).attr("alt")},
							   function(data){
										$('.basic-container').html(data);
										initModal();
					});
				}
				
				
				
				
				
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});	
		
	
		$(".jq_ConfirmEditPrivilege").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>APrivilege",$("#formEditPrivilege").serialize(),
						   function(data){
						
									$(".jq_EditPrivilegeStatus").html(data.status);	
								
								if(data.process){
									$(".jq_EditPrivilegeStatus").removeClass("red");
									$(".jq_EditPrivilegeStatus").addClass("lnkGrn");
									loadPrivilege();
									setTimeout("$.modal.close()",2000);
								}else{
									$(".jq_EditPrivilegeStatus").removeClass("lnkGrn");	
									$(".jq_EditPrivilegeStatus").addClass("red");
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});	
		
		
		
		$(".jq_DeletePrivilege").live('click',function () {
			
			if(checkLogged()){
					
					$.post("<%=sitePathInit%>APrivilege",{action:'initDelete',privilegeid:$(this).attr("alt")},
							   function(data){
										$('.basic-container').html(data);
										initModal();
					});
			}else{
				window.location='<%=sitePathInit%>';	
			}
		});	
		
		
		$(".jq_ConfirmDeletePrivilege").live('click',function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInit%>APrivilege",{action:'processDelete',privilegeid:$(this).attr("alt")},
						   function(data){
					
								$(".jq_DeletePrivilegeStatus").html(data.status);	
								
								if(data.process){
									$(".jq_DeletePrivilegeStatus").removeClass("red");		
									setTimeout("$.modal.close()",2000);
									loadPrivilege(); 
								}else{
									$(".jq_DeletePrivilegeStatus").addClass("red");	
								}
				},"json");
				
			}else{
				window.location='<%=sitePathInit%>';
			}
		
		});
		
		
		
		$(".jq_togglePrivilege").live('click',function () {
			$(this).parent(".rolePrivilege").find(".rolePrivilegeSettings").toggle();
		});
		
		
		$(".jqRoleSettings").live('change',function () {
			if($(this).find('option:selected').val()=='enabled'){
				$(this).parents(".jqRoleSpecSettings").find(".jqGroupSpecSetting").show();
			}else{
				$(this).parents(".jqRoleSpecSettings").find(".jqGroupSpecSetting").hide();
			}
		});
		
		
		
		
});	

function loadUser(){
		$.post("<%=sitePathInit%>AUser",$("#formUserList").serialize(),
				   function(data){
			$(".tblUserlist").html(data);	
		});
}


function loadRole(){
	$.post("<%=sitePathInit%>ARole",$("#formRoleList").serialize(),
			   function(data){
		$(".tblRolelist").html(data);	
	});
}


function loadPrivilege(){
	$.post("<%=sitePathInit%>APrivilege",$("#formPrivilegeList").serialize(),
			   function(data){
		$(".tblPrivilegelist").html(data);	
	});
}


</script>			
<%@ include file="../sub/footer.jsp"%>