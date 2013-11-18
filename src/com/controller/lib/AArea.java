package com.controller.lib;

import com.misc.lib.CustomHelper;

import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.simple.JSONValue;

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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		RequestDispatcher view=null;
		Boolean useDispatcher=false;
		
		Map iVariable=new HashMap();
		
		String action	= request.getParameter("action");
		ProjectionModel proj=new ProjectionModel();
		CustomHelper ch=new CustomHelper();
		proj.projectFile=getServletContext().getRealPath("");
		HttpSession sess=request.getSession();
		
		
		if(action.equals("loadDefault")){
		
			 Map det=new HashMap();
			 request.setAttribute("banner","dashboard");
			 useDispatcher=true;
			 
			/* 
			//Monthly
			det.put("fromMonth",ch.formatDate("yyyy-MM"));
			det.put("toMonth",ch.formatDate("yyyy-MM-dd"));
			
			//Yearly
			det.put("fromYear",ch.formatDate("yyyy"));
			det.put("toYear",ch.formatDate("yyyy-MM-dd"));
			
			ResultSet rDetails=proj.loadProjectionA(det);
			request.setAttribute("rDetails",rDetails);
			*/
			 
			 
			//Monthly Revenue 
			try {
				det.put("month",ch.formatDate("yyyy-MM"));
				ResultSet rsMonthRevenue=proj.ldMonthRevenue(det,false);
				
				if (rsMonthRevenue.next()) {  
					  do{
						  	request.setAttribute("rsMonthRevenue",rsMonthRevenue.getString("actual_revenue"));
					  } while (rsMonthRevenue.next());
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			//Monthly Target 
			try {
				det.put("month",ch.formatDate("yyyy-MM"));
				ResultSet rsMonthTarget=proj.ldMonthTarget(det,false);
				
				if (rsMonthTarget.next()) {  
					  do{
						  	request.setAttribute("rsMonthTarget",rsMonthTarget.getString("target_amount"));
					  } while (rsMonthTarget.next());
				  }
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			//Yearly  Revenue
			try {
					det.put("year",ch.formatDate("yyyy"));
					ResultSet rsYearRevenue=proj.ldYearRevenue(det);
					if (rsYearRevenue.next()) {  
						  do{
							  	request.setAttribute("rsYearRevenue",rsYearRevenue.getString("actual_revenue"));
			    		  } while (rsYearRevenue.next());
					  }
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			//Yearly Target
			try {
				det.put("year",ch.formatDate("yyyy"));
				ResultSet rsYearTarget=proj.ldYearTarget(det);
				if (rsYearTarget.next()) {  
					  do{
						  	request.setAttribute("rsYearTarget",rsYearTarget.getString("target_amount"));
					  } while (rsYearTarget.next());
				  }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			//Total Target
			try {
				det.put("year",ch.formatDate("yyyy"));
				ResultSet rsYearTotalTarget=proj.ldYearTotalTarget(det);
				if (rsYearTotalTarget.next()) {  
					  do{
						  	request.setAttribute("rsYearTotalTarget",rsYearTotalTarget.getString("target_amount"));
					  } while (rsYearTotalTarget.next());
				  }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		//	request.setAttribute("exportfile", "/ExportSales?action=export&month=" + ch.formatDate("MM") + "&year" + ch.formatDate("yyyy"));
			
			
			view = request.getRequestDispatcher("projection/loadDefault.jsp");
			
		 	response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			view.forward(request, response);
			
	   }if(action.equals("loadMonth")){
		   
		   	Map det=new HashMap();
			 useDispatcher=true;
			 det.put("revenue_type", "Sales");
			 det.put("year",ch.formatDate("yyyy"));
			 ResultSet detSales=proj.loadProjectionMonthly(det);
			 
			 /*
			 	float[] iActualSales=new float[13];
			 
			 	float[] iSales=new float[13];
			 	try {
					if (detSales.next()) {  
						
						iSales[0]=(float) 00.0;
					do{
						
						for(int i=1;i<13;i++){
							if(detSales.getString("monthNum").equals(String.format("%02d", i))){
								iActualSales[i]=Float.parseFloat(detSales.getString("subTotal"));
								System.out.println("Sales"+iActualSales[i]);
							}
							
						}//end of loop
					
					} while (detSales.next());
					
					}
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			 	
			 */
			 
			 float[] iActualSales=new float[13];
			 float[] iActualTarget=new float[13];
			 
		for(int i=1;i<13;i++){
			 
			
			
			
			try {
					det.put("month",ch.formatDate("yyyy-")+String.format("%02d", i));
					ResultSet rsMonthRevenue=proj.ldMonthRevenue(det,true);
					
					if (rsMonthRevenue.next()) {  
						  do{
							  iActualSales[i]=Float.parseFloat(rsMonthRevenue.getString("actual_revenue"));
							  	//request.setAttribute("rsMonthRevenue",rsMonthRevenue.getString("actual_revenue"));
						  } while (rsMonthRevenue.next());
						  }
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			 	
			
			
			try {
				det.put("month",ch.formatDate("yyyy-")+String.format("%02d", i));
				ResultSet rsMonthTarget=proj.ldMonthTarget(det,true);
				
				if (rsMonthTarget.next()) {  
					  do{
						  iActualTarget[i]=Float.parseFloat(rsMonthTarget.getString("target_amount"));
						  	//request.setAttribute("rsMonthTarget",rsMonthTarget.getString("target_amount"));
					  } while (rsMonthTarget.next());
				  }
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			  
			  
			  
		}//end of loop	 	
			 	
			 	/*
			 	 det.put("revenue_type", "Refund");
				 det.put("year",ch.formatDate("yyyy"));
				 ResultSet detRefund=proj.loadProjectionMonthly(det);
				 
				 float[] iRefund=new float[13];
				 	try {
						if (detRefund.next()) {  
					
							iRefund[0]=(float) 00.0;
						do{
							
							for(int i=1;i<13;i++){
								if(detRefund.getString("monthNum").equals(String.format("%02d", i))){
									iRefund[i]=Float.parseFloat(detRefund.getString("subTotal"));
								}
								
							}//end of loop
						
						} while (detRefund.next());
						
						}
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 
				
				iActualSales[0]=(float) 00.0;
				
				for(int b=1;b<13;b++){
					iActualSales[b]=iSales[b]-iRefund[b];
				}//end of float
				*/
			request.setAttribute("iActualSales",iActualSales);
			request.setAttribute("iActualTarget",iActualTarget);
			view = request.getRequestDispatcher("projection/loadMonth.jsp");
			
			response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			view.forward(request, response);
		   
	   }
		
		 
	}//end of function
	
	
	
	

}//end of class