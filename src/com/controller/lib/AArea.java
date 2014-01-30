package com.controller.lib;

import com.misc.lib.CustomHelper;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;




import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.lib.*;

/**
 * Servlet implementation class AUser
 */
@WebServlet("/AArea")
public class AArea extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AArea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		RequestDispatcher view=null;
		Boolean useDispatcher=false;
		
		Map iVariable=new HashMap();
		
		String action	= request.getParameter("action");
		ProjectionModel proj=new ProjectionModel();
		CustomHelper ch=new CustomHelper();
		AreaModel area = new AreaModel();
		proj.projectFile=getServletContext().getRealPath("");
		HttpSession sess=request.getSession();
		String territoryid = request.getParameter("territoryid");
		String areaid = request.getParameter("areaid");
		
		//System.out.println(action);

		

		if(action.equals("loadProjection")){
	
		   	Map det=new HashMap();
			 useDispatcher=true;
			 det.put("revenue_type", "Sales");
			 det.put("year",ch.formatDate("yyyy"));
			 det.put("areaid", areaid);
			 //ResultSet detSales=proj.loadProjectionMonthly(det);
			 ResultSet teamLead = proj.loadTeamLeaderFromAreas(det);
			 ResultSet team = proj.loadAgentsFromAreas(det);
			 ResultSet targetYtd = proj.loadAreaTargetYTD(det);
			 ResultSet targetMtd = proj.loadAreaTargetMTD(det);
			 ResultSet actualYtd = proj.loadAreaSalesYTD(det);
			 ResultSet actualMtd = proj.loadAreaSalesMTD(det);
			 ResultSet actualMonthly = proj.loadAreaMonthlySales(det, false);
			 ResultSet targetMonthly = proj.loadAgentsMonthlyTarget(det, false);
			 Map areaInfo = new HashMap();
			 //System.out.println(territoryid);
			 	try{
				 	String[] teamLeadinfo = new String[3];

					if(teamLead.next()){
						do{
							teamLeadinfo[0] = teamLead.getString("userid");
							teamLeadinfo[1] = teamLead.getString("userfirstname");
							teamLeadinfo[2] = teamLead.getString("userlastname");
							//System.out.println(teamLeadinfo[1]);
						}while(teamLead.next());
					}
					areaInfo.put("teamLeadInfo", teamLeadinfo);
				}catch(SQLException e){
					e.printStackTrace();
				}
			 	try{
			 		team.last();
			 		int rowCount = team.getRow();
			 		String[][] teamMemberinfo = new String[rowCount][3];
			 		team.beforeFirst();
			 		int iterator = 0;
			 		if(team.next()){
			 			do{
			 				teamMemberinfo[iterator][0] = team.getString("userid");
			 				teamMemberinfo[iterator][1] = team.getString("userfirstname");
			 				teamMemberinfo[iterator][2] = team.getString("userlastname");
			 				
			 				
			 				iterator++;
			 			}
			 			while(team.next());
			 			
			 		}
			 		areaInfo.put("teamMembers", teamMemberinfo);
			 		
			 	}catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	try{
			 		targetYtd.beforeFirst();
			 		String targetYtdContainer ="";
			 		if(targetYtd.next()){
			 			targetYtdContainer = targetYtd.getString("target_amount");
			 		}
			 		areaInfo.put("targetYtd",targetYtdContainer);
			 	}
			 	catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	try{
			 		targetMtd.beforeFirst();
			 		String targetMtdContainer = "";
			 		if(targetMtd.next()){
			 			targetMtdContainer = targetMtd.getString("target_amount");
			 		}
			 		areaInfo.put("targetMtd",targetMtdContainer);
			 	}catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	try{
			 		actualYtd.beforeFirst();
			 		String actualYtdContainer="";
			 		if(actualYtd.next()){
			 			actualYtdContainer = actualYtd.getString("totalsales");
			 		}
			 		areaInfo.put("actualYtd",actualYtdContainer);
			 	}catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	try{
			 		actualMtd.beforeFirst();
			 		String actualMtdContainer = "";
			 		if(actualMtd.next()){
			 			actualMtdContainer = actualMtd.getString("totalsales");
			 		}
			 		areaInfo.put("actualMtd", actualMtdContainer);
			 	}catch(SQLException e){
			 		
			 	}
			 	try{
			 		actualMonthly.last();
			 		int iterator_2 = actualMonthly.getRow();
			 		actualMonthly.beforeFirst();
			 		float[] monthlySales = new float[13];
			 		

			 		if(actualMonthly.next()){
			 			do{

			 				monthlySales[Integer.parseInt(actualMonthly.getString("month"))] = Float.parseFloat(actualMonthly.getString("totalpayment")); 
			 				System.out.println(Integer.parseInt(actualMonthly.getString("month"))+"-Actual ");
			 			}while(actualMonthly.next());
			 		}
			 		areaInfo.put("monthlySales", monthlySales);
			 	}catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	try{
			 		targetMonthly.last();
			 		targetMonthly.beforeFirst();
			 		float[] monthlyTarget = new float[13];
			 		if(targetMonthly.next()){
			 			do{
			 					//if(targetMonthly.getString("target_amount")!=null || targetMonthly.getString("target_amount")!=""){
			 					monthlyTarget[Integer.parseInt(targetMonthly.getString("month"))] = Float.parseFloat(targetMonthly.getString("target_amount"));
			 					System.out.println(Integer.parseInt(targetMonthly.getString("month"))+"-Target");
			 			}while(targetMonthly.next());
			 		}
			 		areaInfo.put("monthlyTarget",monthlyTarget);
			 	}catch(SQLException e){
			 		e.printStackTrace();
			 	}
			 	
					
		
			request.setAttribute("areaInfo",areaInfo);
			
			view = request.getRequestDispatcher("area/loadMonth.jsp");
			response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			view.forward(request, response);

		   
	   }
		
		 
	}//end of function
	
	
	
	
	

}//end of class
