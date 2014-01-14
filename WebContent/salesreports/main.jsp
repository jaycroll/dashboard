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

<div id="submenu">
<div id="submenu-left">
<form id='formTarget'>
Month <select name="month" id="month">
      <option value="1">January</option>
	<option value="2">February</option>
<option value="3">March</option>
<option value="4">April</option>
<option value="5">May</option>
<option value="6">June</option>
<option value="7">July</option>
<option value="8">August</option>
<option value="9">September</option>
<option value="10">October</option>
<option value="11">November</option>
<option value="12">December</option>
      </select>
Year <select name="year" id="year">
<option value="2013">2013</option>
<option value="2014">2014</option>
<option value="2015">2015</option>
<option value="2016">2016</option>
<option value="2017">2017</option>
<option value="2018">2018</option>
<option value="2019">2019</option>
<option value="2020">2020</option>
</select>

<input type='hidden' name='action' class='jqAction' value='export'> 
<input type="button" value="Submit" class="button"  onclick="getReport();"/>
</form>
</div>
<div id="submenu-right2"> 

	<ul class="tab jqSection">
		<li><a href="javascript:void(0);" class="ibtntabs active" alt='graphs'>Graphs</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='targetvsactual'>Target vs Actual</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='actualmonthlysales'>Actual Monthly</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='monthtodate'>Month To Date</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='top20accounts'>Top 20</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='mtdgraph'>MTD Graph</a></li>
		<li><a href="javascript:void(0);" class="ibtntabs" alt='data'>Data</a></li>
	</ul>
</div>

</div>

<div id="content2">

<% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),7,6)){	%>  
<iframe name="ifrm" id="ifrm" src="" frameborder="0" width="100%" height="700">
Your browser doesn't support iframes.</iframe>

<% }else{ %>
		
		<div style='clear:both'>&nbsp;</div>
		<div  class='divCenter txtCenter'>
			  <div class='access_denied'>Access Denied</div>
			  <div class='clr'>&nbsp;</div>
			  <div class='clr'><a  style='color:#3E7836;' href="<%=sitePathInit%>">Back to Main</a></div>
              <div class='clr'>&nbsp;</div>
	    </div>
<% } %>
		
</div>

      <BR><img  src=""  align="left" id="siimage" width="100%" height="100%" /><BR>



<script type='text/javascript'>

var d = new Date();
d.setDate(d.getDate() - 1);
var currentmonth = d.getMonth()+1;
var currentyear = d.getFullYear();
var currentdiv = "graphs";
defaultheight=700;

$(document).ready(function($){

        <% if(rpMain.verifyModule(Integer.parseInt(sMain.getAttribute("roleid").toString()),7,6)){      %>
                        loadTarget("graphs");
        <% } %>

        $(".jqSection .ibtntabs").click(function () {

                if(checkLogged()){

                        $(".jqSection").find(".ibtntabs").removeClass("active");
                        $(this).addClass("active");

                        $(".jqAction").val($(this).attr("alt"));

                        loadTarget($(this).attr("alt"));

                }else{
                                window.location='<%=sitePathInit%>';
                }
        });



});


function loadTarget(dfile)
{
        currentdiv = dfile;


        if (currentmonth < 10)
                dmonth = "0" + currentmonth;
        else
                dmonth = currentmonth;


        dfilemmyyyy= "graphs" + "-" + dmonth + currentyear + ".pdf";
        if (dfile != 'graphs')
        {
                dfilemmyyyy = dfile + "-"+ dmonth + currentyear + ".html";
        }


        var url = "<%=sitePathInit%>export/" + dfilemmyyyy ;
        var $iframe = $('#ifrm');
        if ( $iframe.length ) {
                 $iframe.attr('src',url);
		if (dfile == 'mtdgraph')
			$iframe.attr('height',100);
		else if (dfile == 'targetvsactual')
			$iframe.attr('height',500);
		else if (dfile == 'actualmonthlysales')
			$iframe.attr('height',560);
		else
			$iframe.attr('height',defaultheight);

        }
        if (dfile != 'mtdgraph')
        {
                $("#siimage").hide();
        }
        else
        {
                url = "<%=sitePathInit%>export/" + dfile + "-"+ dmonth + currentyear + ".gif" ;
                var $iframeimg = $('#siimage');
                if ( $iframeimg.length ) {
                         $('#siimage').attr('src',url);
			  $("#siimage").show();


                }
        }

}

function getReport(){

        currentmonth = $("#month").val();
        currentyear = $("#year").val();

        loadTarget(currentdiv);
}

</script>



<% }%>