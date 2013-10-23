<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="../sub/header.jsp"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.RolePermission" %>  

<%  

		HttpSession sSub=request.getSession();
		RolePermission rp=new RolePermission();
		rp.gAppProperties(request.getRealPath("/"));


		String sitePathInitMin =request.getContextPath()+"/";
		ResultSet rsRole = (ResultSet) request.getAttribute("roleList"); 
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
            <li id='access1' ><a href="<%=sitePathInit%>User"  class=' ibtntabs' title='User Management'></a></li>
            <li id='access2' ><a href="<%=sitePathInit%>Roles"  class='ibtntabs active' title='Role Management'></a></li>
            <li id='access3' ><a href="<%=sitePathInit%>Privilege"  class='ibtntabs' title='Privileges Management'></a></li>
     	 	<li id='access4' ><a href="<%=sitePathInit%>Target"  class='ibtntabs' title='Target Management'></a></li>
     	 	<li id='access5' ><a href="<%=sitePathInit%>Channel"  class='ibtntabs' title='Channel Management'></a></li>
     	 	<li id='access6' ><a href="<%=sitePathInit%>Sales"  class='ibtntabs' title='Sales Management'></a></li>
     	 </ul>

</div>

</div>
</div>


<div id="primary">

       <div class="tabcontents">
            <div id="view1" class="tabcontent">
            
            
<div id='basic-modal' class='jq_AccessManagementView'>
<% if(rp.verifyModule(Integer.parseInt(sSub.getAttribute("roleid").toString()),1,6)){	%>
<form id="formRoleList" name="form1" method="post" action="">
    <table width="650" border="0" align="center" cellpadding="5" cellspacing="0">
    
      <tr>
        <td class="text12_tungsten"> 
        
        <% if(rp.verifyModule(Integer.parseInt(sSub.getAttribute("roleid").toString()),2,1)){	%>
         <div id='basic-modal'> 
         	<a href="javascript:void(0);" class='jq_AddRole'  style='text-decoration:none;' ><img src="<%=sitePathInitMin%>images/add.png" width="28" height="26" border="0" align="absmiddle" /></a><span class='lucida_12_tungsten_b'>Role</span>
         </div> 
        <% } %> 
         </td>
        <td align="center" class="text10_red">&nbsp;</td>
        <td align="center" class="text10_red">&nbsp;</td>
      </tr>
      
   
<%  
if(rp.verifyModule(Integer.parseInt(sSub.getAttribute("roleid").toString()),2,6)){	%>       
<%
		while(rsRole.next()){
%>  

      <tr>
        <td width="250" class='text12_tungsten'><%=rsRole.getString("rolename")%></td>
        <td width="200" align="center" class="text10_red">
        <% if(rp.verifyModule(Integer.parseInt(sSub.getAttribute("roleid").toString()),2,2)){ %>
        			<a href="javascript:void(0);" class='jq_EditRole'  style='text-decoration:none;' alt='<%=rsRole.getString("roleid")%>'><span class='lucida_10_red'><img  class='hnd'  src="<%=sitePathInitMin%>images/pencil-edit.png"></span></a>
        <% } %>
        </td>
        <td width="200" class="lucida_10_red" align="center">
        <% if(rp.verifyModule(Integer.parseInt(sSub.getAttribute("roleid").toString()),2,5)){ %>
        <a href='javascript:void(0);' style='font-decoration:none;' class="lucida_10_red jq_DeleteRole" alt='<%=rsRole.getString("roleid")%>'><span class='lucida_10_red'>x</span></a>
        <% } %>
        </td>
      </tr>
	<% } %>   
	 </table>
 
     <input type='hidden' name='action' value='subLoadRole'>
</form>
<% } 
else{ %>

		<div class='divCenter txtCenter'>
							   <div class='access_denied'>Access Denied</div>
							   <div class='clr'>&nbsp;</div>
							  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
	                           <div class='clr'>&nbsp;</div>
	                          </div>
	          
<% } %>           
   
<% 
	}
else{ %>

<div class='divCenter txtCenter'>
					   <div class='access_denied'>Access Denied</div>
					   <div class='clr'>&nbsp;</div>
					  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
                       <div class='clr'>&nbsp;</div>
                       </div>
<% }    
	
  }
	
else{ %>

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
								
								setTimeout("$.modal.close()",2000);
								setTimeout(function () { location.reload(1); }, 2000);
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
								setTimeout(function () { location.reload(1); }, 2000);
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
								
								setTimeout("$.modal.close()",2000);
								setTimeout(function () { location.reload(1); }, 2000);
							}else{
								$(".jq_EditRoleStatus").removeClass("lnkGrn");	
								$(".jq_EditRoleStatus").addClass("red");
							}
			},"json");
			
		}else{
			window.location='<%=sitePathInit%>';
		}
	
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