<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.sql.ResultSet,com.misc.lib.RolePermission" %> 

<%  
		String sitePathInitMin =request.getContextPath()+"/";

		HttpSession sSub=request.getSession();
		RolePermission rp=new RolePermission();
		rp.gAppProperties(request.getRealPath("/"));
	
		
		ResultSet rs2 = (ResultSet) request.getAttribute("usrList");
		while(rs2.next()){
%>

<tr>
        <td class="text12_tungsten" width="200"><%=rs2.getString("userfirstname")+" "+rs2.getString("userlastname")%></td>
        <td class="text12_tungsten" width="200"><%=rs2.getString("rolename")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align="center" class="lucida_10_red" width="100" style="text-align:center; height: 30px">
        	<span class="ui-btn ui-btn-b ui-icon-edit ui-nodisc-icon ui-btn-icon-notext ui-corner-all ui-mini" title='<%=rs2.getString("userid")%>'>Edit</span>
        </td>
        <td align="center" class="lucida_10_red" width="100" style="text-align:center; height: 30px">
        	<span class="jq_DeleteAccess ui-btn ui-btn-b ui-nodisc-icon ui-icon-delete ui-btn-icon-notext ui-corner-all ui-mini" title='<%=rs2.getString("userid")%>'>Delete</span>
        </td>
        </tr>
<%		
	}
%>	    