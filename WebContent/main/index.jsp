<%@ include file="../sub/header.jsp"%>


<div id="header" align="center"><img src="<%=sitePathInit%>images/ppe-blk.png"/></div>
<div id="title" class="lucida_21_black"> DashBoard</div>

<% if(loggedState){%>

	<div id="menu">
				<div id="menu-right" class="lucida_12_tungsten_b"> Hello, <%=sess.getAttribute("username")%> (<%=sess.getAttribute("rolename")%>). <a href="<%=sitePathInit%>User/logout"><span class="lucida_12_red_b">Logout</span></a></div>
 	</div>
 	
<div id="icons" style="margin:0px auto;">
<a href="Projection"><img src="<%=sitePathInit%>images/icon1.png" border="0" style="float:left; margin:0 10px;" /></a>
<a href="#"><img src="<%=sitePathInit%>images/grayscale_velocity.png" border="0" style="float:left; margin:0 10px;" /></a>
<a href="<%=sitePathInit%>DomesticProducts"><img src="<%=sitePathInit%>images/icon3.png" border="0" style="float:left; margin:0 30px;" /></a>
<a href="<%=sitePathInit%>User"><img src="images/access.png" width="90" height="110" border="0"  style="float:left; margin:0 10px;" /></a>
</div>


<% }else{ %>



<div id="menu">

 </div>

<div id="icons" style="margin:0px auto;">
<a href="<%=sitePathInit%>"><img src="<%=sitePathInit%>images/icon1.png" border="0" style="float:left; margin:0 10px;" /></a>
<a href="<%=sitePathInit%>"><img src="<%=sitePathInit%>images/icon2.png" border="0" style="float:left; margin:0 10px;" /></a>
<a href="<%=sitePathInit%>"><img src="<%=sitePathInit%>images/icon3.png" border="0" style="float:left; margin:0 30px;" /></a>
<a href="<%=sitePathInit%>"><img src="images/access.png" width="90" height="110" border="0"  style="float:left; margin:0 10px;" /></a>
</div>
<br/><br/><br/>

<div id="title"><a href="#login-box" class="login-window" style="color:#62bbf5; font-family: 'Lucida Grande', Tahoma, Verdana, Arial, sans-serif; font-size:12px; font-weight:bold; text-decoration:none;">Login</a></div>


<div id="login-box" class="login-popup">
        <a href="#" class="close"><img src="<%=sitePathInit%>images/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>
          <form method="post" class="signin" id='formLogin' action="AUser">
          				<div class='sLoginStatus red fnt11' align='center'> </div>
                <fieldset class="textbox">
            	<label class="username">
                <span>Username</span>
                <input id="username" name="username" value="" type="text" autocomplete="on">
                </label>
                <label class="password">
                <span>Password</span>
                <input id="password" name="password" value="" type="password">
                </label>
                <button class="submit button jq_InitLogin" type="button" value="Login">Login</button>
                <p>
                <a class="forgot" href="#">Forgot your password?</a>
                </p>        
                </fieldset>
                
                <input  name="action" value="login" type="hidden">
                
          </form>
</div>


<script type='text/javascript' src='<%=sitePathInit%>include/custom_notlogged.jsp'></script>
<% } %>

<%@ include file="../sub/footer.jsp"%>