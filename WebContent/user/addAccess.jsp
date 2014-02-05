<%@ include file="../sub/header.jsp"%>



<%@ page import="com.misc.lib.RolePermission" %> 
<%@ page import="java.util.Calendar" %> 

<% 
	HttpSession sMain=request.getSession();
	RolePermission rp=new RolePermission();
	rp.gAppProperties(request.getRealPath("/"));
	String[] listMonth=(String[]) request.getAttribute("listMonth");
	Calendar now = Calendar.getInstance();
	int currentYear = now.get(Calendar.YEAR);
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
		display_1="";
		display_2="display:none";
		

	}else{
		
		display_1="display:none";
		display_2="";
	}
	
%>
<div id="addUser">

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
	<div data-role="header" style="border:0px margin-bottom:-10%;" data-theme="b">
	  		<div id="title2">Dashboard</div>
	  		<a href="" class="jq_btnLogout ui-btn ui-btn-a ui-corner-all ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="">Logout</span></a>
	  		<a href="#mypanel" class="ui-btn ui-btn-a ui-corner-all ui-btn-block " style="<%=display_1%>; font-size:14px"><span class="" >Menu</span></a>
	</div>
	<div data-role="content" style="<%=display_1%>" >
		<div class="ui-grid-solo ui-field-contain">

			<div data-theme="b" style="text-align:center;font-size:120%">Add User</div>

			<form id="formAddAccess" name="form1" method="post" action="">
				
		             
		               <input name="userfirstname" type="text" placeholder="First Name" data-theme="c"/>
		               <span class='iError_userfirstname lucida_10_red'></span>		            		             
		             
		               <input name="userlastname" type="text" placeholder="Last Name" data-theme="c"/>
		              <span class='iError_userlastname lucida_10_red'></span>
		             
		             <input type="text" name="username" placeholder="Username" data-theme="c"/>
		             	<span class='iError_username lucida_10_red'></span>
		             
		             <input type="password" name="password" placeholder="Password" data-theme="c"/>
		             	<span class='iError_password lucida_10_red'></span>
		             
		             <input type="password" name="password2" placeholder="Confirm Password" data-theme="c"/>
		             	 <span class='iError_password2 lucida_10_red'></span>
		            <div class="ui-field-contain">
		            <label for="bMonth">Birthday:</label>
			             <fieldset  data-role="controlgroup" data-type="horizontal">
			             	
			             	<select name="bMonth"  id="select2" class="ui-mini" data-theme="a">
			             		<option value="01"  >January</option>
			             	<% for(int i=2;i<listMonth.length;i++){ %>
			             			<option value="<%=String.format("%02d",i)%>"  ><%=listMonth[i]%></option>
			             	<% } %>	
			             	</select>
			             	
			             	<select name="bDate" id="select2" class="ui-mini" data-theme="a">
			             			<option value="1">1</option>
			             	<% for(int i=2;i<32;i++){ %>
			             			<option value="<%=String.format("%02d",i)%>" ><%=i%></option>
			             	<% } %>		
			             	</select>
			             	
			             	<select name="bYear" id="select2" class="ui-mini" data-theme="a">
			             			<option value="1984">1984</option>
			             	<% for(int i=1985;i<currentYear-18;i++){ %>
			             			<option value="<%=i%>" ><%=i%></option>
			             	<% } %>		
			             	</select>
			             
			             	 <span class='iError_birthdate lucida_10_red'></span>
			             </fieldset>
			       </div>
		           <div class="ui-field-contain">
		             <label for="status">Status:</label>
		             <select name="status" id="select" class="ui-mini" data-theme="a">
		               <option value='active'>Active</option>
		               <option value='inactive'>Inactive</option>
		               <option value='awol'>AWOL</option>
		               <option value='resigned'>Resigned</option>
		               <option value='terminated'>Terminated</option>
		             </select>
		           </div>
		             <input name="email_address" type="text" placeholder="E-mail" data-theme="c"/>
		             	 <span class='iError_email_address lucida_10_red' ></span>
		            
		             <input type="tel" name="mobile" placeholder="Mobile #" data-theme="c"/>
		             	 <span class='iError_mobile lucida_10_red' ></span>	 
		       		<div class="ui-field-contain">
		       		<label for="roleid">Role:</label>
		             <select name="roleid"  id="select2" class="ui-mini" data-theme="a">
		              	<%  
							ResultSet rs = (ResultSet) request.getAttribute("usrRole"); 
							while(rs.next()){
						%>
						   <option value='<%=rs.getString("roleid") %>'><%=rs.getString("rolename") %></option>    	
		              	<% } %>
		             	</select>
		             </div>
		            <div class="ui-field-contain">
		       		<label for="hMonth">Hire Date:</label>
		             <fieldset data-role="controlgroup" data-type="horizontal" class="ui-mini">
		             	<select name="hMonth"  id="select2" data-theme="a">
		             			<option value="01">January</option>
		             	<% for(int i=2;i<listMonth.length;i++){ %>
		             			<option value="<%=String.format("%02d",i)%>" ><%=listMonth[i]%></option>
		             	<% } %>	
		             	</select>
		             	
		             	<select name="hDate"  id="select2" data-theme="a" class="ui-mini">
		             			<option value="1">1</option>
		             	<% for(int i=2;i<32;i++){ %>
		             			<option value="<%=String.format("%02d",i)%>" ><%=i%></option>
		             	<% } %>		
		             	</select>
		             	
		             	<select name="hYear"  id="select2" data-theme="a" class="ui-mini">
		             			<option value="2005">2005</option>
		             	<% for(int i=2006;i<currentYear+1;i++){ %>
		             			<option value="<%=i%>" ><%=i%></option>
		             	<% } %>		
		             	</select>
		             
		             	 <span class='iError_hireddate lucida_10_red'></span>
		             
		            </fieldset>
		          </div>
		          <% if(rp.verifyModule(Integer.parseInt(sess.getAttribute("roleid").toString()),1,1)){%>
		          	<span class='jq_btnAddAccess ui-btn ui-btn-b ui-corner-all ui-mini'   border="0" >Add</span>
		          <%} %>
		           

		       <input type='hidden' name='action' value='processAddAccess'>
		       </form>
		</div>
	</div>
	<div data-role="content" style="<%=display_2%>">
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
	
	checkPermission(1,1);
	
	$(".jq_btnAddAccess").click(function () {
		
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
	
	
	
				
		
		
});		
</script>