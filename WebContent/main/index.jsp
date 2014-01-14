<%@ include file="../sub/header.jsp"%>


<div id="header" align="center"><div class="header_img"></div></div>
<div id="title" class="lucida_21_black"> DashBoard</div>

<% if(loggedState){%>

	<div id="menu">
				<div id="menu-right" class="lucida_12_tungsten_b"> Hello, <%=sess.getAttribute("username")%> (<%=sess.getAttribute("rolename")%>). <a href="<%=sitePathInit%>User/logout"><span class="lucida_12_red_b">Logout</span></a></div>
 	</div>
 	
<div id="icons" style="margin:0px auto;">
<a href="Projection" class="icon1"></a>
<a href="#" class="icon2"></a>
<a href="<%=sitePathInit%>DomesticProducts" class="icon3"></a>
<a href="<%=sitePathInit%>User" class="icon4"></a>
</div>


<% }else{ %>



<div id="menu">

 </div>

<div id="icons" style="margin:0px auto;">
<a href="<%=sitePathInit%>" class="icon1"></a>
<a href="<%=sitePathInit%>" class="icon2"></a>
<a href="<%=sitePathInit%>" class="icon3"></a>
<a href="<%=sitePathInit%>" class="icon4"></a>
</div>


<div id="login-container"><a href="#login-box" class="login-window">Login</a></div>


<div id="login-box" class="login-popup">
        <a href="#" class="close" title="Close Window" alt="Close"></a>
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