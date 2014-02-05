<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %> 
<% 
	String sitePathInitSub =request.getContextPath()+"/";
%>    
<div class='jq_DeleteUserStatus ui-bar-a' data-role="popup" data-overlay="a" data-theme="a" id="theme" style="position:fixed;z-index:9999">
		Are you sure you want to delete this user?
		<br>
		<%=request.getAttribute("fullname")%> (<%=request.getAttribute("rolename")%>)
		<br>
		<div class="ui-block-a"><a href="" class='ui-btn ui-btn-b ui-mini jq_ConfirmDeleteAccess' alt='<%=request.getAttribute("userid")%>'>Confirm</a></div>
		<div class="ui-block-b"><a href=""  class='ui-btn ui-btn-b ui-mini jq_ModalClose'>Cancel</a></div>
		

</div>
<script>
	$(document).ready(function(){
		$(".jq_ModalClose").click(function(){
			$('.jq_DeleteUserStatus').hide();
		});	
		$(".jq_ConfirmDeleteAccess").click(function () {
			if(checkLogged()){
				
				$.post("<%=sitePathInitSub%>AUser",{action:'processDelete',userid:$(this).attr("alt")},
						   function(data){
					
								$(".jq_DeleteUserStatus").html(data.status);	
								
								if(data.process){
									$(".jq_DeleteUserStatus").removeClass("red");	
									loadUser();
									setTimeout("$('.jq_DeleteUserStatus').hide()",2000);
								}else{
									$(".jq_DeleteUserStatus").addClass("red");	
								}
								
								
				},"json");
			
				setTimeout(function(){
					 window.location.reload();
				 },1000);
				
			}else{
				window.location='<%=sitePathInitSub%>';
			}
		
		});
	});
</script>