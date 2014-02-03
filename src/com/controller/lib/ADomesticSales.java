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

@WebServlet(description="Product Sales Projection", urlPatterns={"/ADomesticSales"})

public class ADomesticSales extends HttpServlet{
		private static final long serialVersionID = 1L;
		
		public ADomesticSales(){
			super();
		}
		@Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			
		
		}
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			
			String action = request.getParameter("action");
			String channel_id = request.getParameter("channel_id");
			HttpSession session = request.getSession();
			CustomHelper ch = new CustomHelper();
			Map thisVar = new HashMap();
			ProjectionModel proj = new ProjectionModel();
			proj.projectFile = getServletContext().getRealPath("");
			ChannelModel chModel = new ChannelModel();
			chModel.projectFile = getServletContext().getRealPath("");
			SalesModel salesModel = new SalesModel();
			salesModel.projectFile = getServletContext().getRealPath("");
			RequestDispatcher view = null;
			Boolean useDispatcher = false;
			String YTD = "";
			String MTD = "";
			String TargetYTD = "";
			String TargetMTD = "";
			int iterator = 1;
			float[] monthlySales = new float[13];
			float[] monthlyTarget = new float[13];
			Map reqVar = new HashMap();
			//System.out.println(channel_id);
			//System.out.println("it gets here");
			// Note: notice the parameters for getString on ResultSets getChannelTargetYTD, getChannelTargetMTD, and
			// getChannelMonthlyTarget are all "actual_revenue"?
			//I kind of forgot to rename those. Please rename that parameter in the SalesModel.java to target_amount
			if(ch.checkMemberSession(session)){
		
				if(action.equals("loadSales")){
					
					thisVar.put("channelid", channel_id);
					ResultSet getChannelYTD = salesModel.ldYearRevenue2(thisVar);
					try{
						getChannelYTD.beforeFirst();
						if(getChannelYTD.next()){
							do{YTD = getChannelYTD.getString("actual_revenue");}while(getChannelYTD.next());
							
						}
						reqVar.put("YTD",YTD);
					}catch(SQLException e){
						e.printStackTrace();
					}
					ResultSet getChannelMTD = salesModel.ldMonthRevenue2(thisVar,false);
					try{
						getChannelMTD.beforeFirst();
						if(getChannelMTD.next()){
							do{MTD=getChannelMTD.getString("actual_revenue");}while(getChannelMTD.next());
						}
						reqVar.put("MTD",MTD);
					}catch(SQLException e){
						e.printStackTrace();
					}
					ResultSet getChannelTargetYTD = salesModel.ldProductYearlyTarget(thisVar,false);
					try{
						getChannelTargetYTD.beforeFirst();
						if(getChannelTargetYTD.next()){
							do{TargetYTD = getChannelTargetYTD.getString("actual_revenue");}while(getChannelTargetYTD.next());
						}
						reqVar.put("TargetYTD",TargetYTD);
					}catch(SQLException e){
						e.printStackTrace();
					}
					
					ResultSet getChannelTargetMTD = salesModel.ldProductMonthTarget(thisVar,false);
					try{
						getChannelTargetMTD.beforeFirst();
						if(getChannelTargetMTD.next()){
							do{TargetMTD = getChannelTargetMTD.getString("actual_revenue");}while(getChannelTargetMTD.next());					
						}
						reqVar.put("TargetMTD",TargetMTD);
					}catch(SQLException e){
						e.printStackTrace();
					}
					ResultSet getChannelMonthlySales = salesModel.ldProductMonthlyRevenue(thisVar, false);
					try{
						getChannelMonthlySales.beforeFirst();
						if(getChannelMonthlySales.next()){
							do{
								monthlySales[Integer.parseInt(getChannelMonthlySales.getString("month"))] = Float.parseFloat(getChannelMonthlySales.getString("actual_revenue"));
							}while(getChannelMonthlySales.next());
						}
						reqVar.put("monthlySales",monthlySales);
					}catch(SQLException e){
						e.printStackTrace();
					}
					ResultSet getChannelMonthlyTarget = salesModel.ldProductMonthlyTarget(thisVar,false);
					try{
						getChannelMonthlyTarget.beforeFirst();
						if(getChannelMonthlyTarget.next()){
							do{
								monthlyTarget[Integer.parseInt(getChannelMonthlyTarget.getString("month"))]=Float.parseFloat(getChannelMonthlyTarget.getString("actual_revenue"));
								}while(getChannelMonthlyTarget.next());
							
						}
						reqVar.put("monthlyTarget",monthlyTarget);
					}catch(SQLException e){
						e.printStackTrace();
					}
					request.setAttribute("reqVar",reqVar);
					useDispatcher = true;
					view = request.getRequestDispatcher("domestic/loadMonth.jsp");
				}
				if(useDispatcher=true){
					response.setHeader("Cache-control","private, no-store, no-cahce,must-revalidate");
					response.setHeader("Pragma","no-cache");
					view.forward(request, response);
				}
			}
		}
		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
	
	}
	


