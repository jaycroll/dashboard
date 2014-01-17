<%@ include file="../sub/header.jsp"%>


<!--  <div id="header" align="center"><div class="header_img"></div></div>
<div id="title" class="lucida_21_black"> DashBoard</div> -->
<div data-role="page" id="index">
	  <div data-role="header" align="center">
			<img src="<%=sitePathInit%>images/ppe-black-m.png"  />
	  </div>
	  <div class="ui-grid-solo">
	  		<div class="ui-block-a"><div id="title">Dashboard</div></div>
	  </div>
	  <ul data-role="listview" data-split-icon="gear" data-split-theme="a" data-inset="true">
		    <li><a href="#">
		        <img src="<%=sitePathInit%>images/target-m.png" style="width:52%; height:80%">
		    <h2>Target</h2>
		    </a>
		        <a href="#target" data-rel="popup" data-position-to="window" data-transition="pop" >Target Menu</a>
		    </li>
		    <li><a href="#">
		        <img src="<%=sitePathInit%>images/velocity-m.png">
		    <h2>Velocity</h2>
		   	</a>
		        <a href="#velocity" data-rel="popup" data-position-to="window" data-transition="pop" >Velocity Menu</a>
		    </li>
		    <li><a href="#">
		        <img src="<%=sitePathInit%>images/product_sales-m.png">
		    <h2>Product Sales</h2>
		    </a>
		        <a href="#product" data-rel="popup" data-position-to="window" data-transition="pop" >Product Sales Menu</a>
		    </li>
		    <li><a href="#">
		        <img src="<%=sitePathInit%>images/access-m.png">
		    <h2>Access</h2>
		    </a>
		        <a href="#access" data-rel="popup" data-position-to="window" data-transition="pop" >Access Menu</a>
		    </li>
	</ul>
	<div data-role="popup" id="target" data-theme="b" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:210px;">
            <li data-role="list-divider">Target Menu</li>
            <li><a href="#">Company Projection</a></li>
            <li><a href="#">Team Projection</a></li>
            <li><a href="#">Area Projection</a></li>
        </ul>
    </div>
    <div data-role="popup" id="velocity" data-theme="b" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:210px;">
            <li data-role="list-divider">Velocity Menu</li>
            <li><a href="#">View Partner LOP Acquisition</a></li>

        </ul>
    </div>
    <div data-role="popup" id="product" data-theme="b" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:210px;">
            <li data-role="list-divider">Product Sales Menu</li>
            <li><a href="#">Domestic Product Projection</a></li>
			<li><a href="#">International Product Projection</a></li>
        </ul>
    </div>
    <div data-role="popup" id="access" data-theme="b" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:210px;">
            <li data-role="list-divider">Access Menu</li>
            <li><a href="#">User Management</a></li>
			<li><a href="#">Role Management</a></li>
			<li><a href="#">Privilege Management</a></li>
			<li><a href="#">Target Management</a></li>
			<li><a href="#">Channel Management</a></li>
			<li><a href="#">Sales Management</a></li>
			<li><a href="#">Letter Of Purchase Management</a></li>
        </ul>
    </div>
	<% if(loggedState){}else{}%>
	<!--  variables on this page:
			div id='menu'
			div id="menu-right"
			div id="icons"
	 		div id="login-container"
	 		a href="#login-box" class="login-window"
	 		div id="login-box" class="login-popup"
	 		form method="post" class="signin" id='formLogin' action="AUser"
	 		button class="submit button jq_InitLogin" type="button" value="Login"
	 		input  name="action" value="login" type="hidden"
	 -->	
</div>

<%@ include file="../sub/footer.jsp"%>