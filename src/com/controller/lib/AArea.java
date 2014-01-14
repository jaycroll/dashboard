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
		
		

		if(action.equals("loadAreas")){
		   
		   	Map det=new HashMap();
			 useDispatcher=true;
			 det.put("revenue_type", "Sales");
			 det.put("year",ch.formatDate("yyyy"));
			 ResultSet detSales=proj.loadProjectionMonthly(det);
			 
			 //System.out.println(territoryid);
			 String[] territories = new String[100];
			 String[] areas = new String[100];
			 String[] areaId = new String[100];
			 String[][][][] testArray = new String[100][10][100][2];
			 String[][] testArray2 = new String[10][10];
			 
			
			 try{
					det.put("territoryid",territoryid);
					ResultSet getAreas = proj.loadAreasFromTerritory(det);
					int i = 0;
					int j = 2;
					int m = 0;
					if(getAreas.next()){
						 do{
							 
							 	i++;
							  if(!getAreas.getString("areaname").equals(null)){
								  testArray[i][0][0][0] = getAreas.getString("areaname");
								  testArray[i][1][0][0] = getAreas.getString("areaid");
								  det.put("areaid",getAreas.getString("areaid"));
								  ResultSet getTeamleader = proj.loadTeamLeaderFromAreas(det);
								  ResultSet getAgents = proj.loadAgentsFromAreas(det);
								  ResultSet getTargetMTD = proj.loadAreaTargetMTD(det);
								  ResultSet getSalesMTD = proj.loadAreaSalesMTD(det);
								  ResultSet getTargetYTD = proj.loadAreaTargetYTD(det);
								  ResultSet getSalesYTD = proj.loadAreaSalesYTD(det);
								  ResultSet getAMT = proj.loadAgentsMonthlyTarget(det, false);
								  ResultSet getAMS = proj.loadAreaMonthlySales(det, false);
								  System.out.println("Area: "+testArray[i][0][0][0]);
								  if(getTeamleader.next()){  
									 testArray[i][2][1][1] = getTeamleader.getString("userfirstname")+" "+getTeamleader.getString("userlastname");	
									 testArray[i][2][1][0] = getTeamleader.getString("userid");	
									 System.out.println("		Team Leader:"+testArray[i][2][1][1]);
									 
								  }
								  
								  System.out.println("			Agents:");
								  if(getAgents.next()){
									  do{
										  if(!getAgents.getString("userid").equals(null)){
											  testArray[i][2][j][0] = getAgents.getString("userid");
											  testArray[i][2][j][1] = getAgents.getString("userfirstname")+" "+getAgents.getString("userlastname");
											  System.out.println("				"+testArray[i][2][j][1]);
											  j++;
										  }
										 
									  }while(getAgents.next());
									  
								  }
								  
								  
								  if(getTargetMTD.next()){
									  testArray[i][4][0][0] = getTargetMTD.getString("target_amount");
									  System.out.println("		Target MTD:"+testArray[i][4][0][0]);
								  }
								  if(getSalesMTD.next()){
									  testArray[i][3][0][0] = getSalesMTD.getString("totalsales");
									  System.out.println("		 Sales MTD:"+testArray[i][3][0][0]);
								  }
								  if(getTargetYTD.next()){
									  testArray[i][4][0][1] = getTargetYTD.getString("target_amount");
									  System.out.println("		Target YTD:"+testArray[i][4][0][1]);
								  }
								  if(getSalesYTD.next()){
									  testArray[i][3][0][1] = getSalesYTD.getString("totalsales");
									  System.out.println("		Sales YTD:"+testArray[i][3][0][1]);
								  }
								  System.out.println("			Target Sales:");
								  if(getAMT.next()){
									  do{
										  if(!getAMT.getString("month").equals(null)){
											  int month = Integer.parseInt(getAMT.getString("month"));
											  testArray[i][5][month][0] = getAMT.getString("target_amount");
											  System.out.println("Month:"+month+ "Sales:"+testArray[i][5][month][0]);
										  }
									  }while(getAMT.next());
								  }
								  System.out.println("			Actual Sales:");
								  if(getAMS.next()){
									  do{
										  if(!getAMS.getString("month").equals(null)){
											  int month = Integer.parseInt(getAMS.getString("month"));
											  testArray[i][6][month][0] = getAMS.getString("totalpayment");
											  System.out.println("Month:"+month+ "Sales:"+testArray[i][6][month][0]);
										  }
									  }while(getAMS.next());
								  }

							  }
						  } while (getAreas.next());
					}
					
				}catch(SQLException e){
					e.printStackTrace();
				}
					
		
			request.setAttribute("areas",areas);
			request.setAttribute("areaId", areaId);
			request.setAttribute("testArray",testArray);
	
			
			view = request.getRequestDispatcher("area/loadMonth.jsp");
			response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			view.forward(request, response);

		   
	   }
		
		 
	}//end of function
	
	
	
	
	

}//end of class
