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

@WebServlet(description="Product Sales Projection", urlPatterns={"/DomesticProducts"})

public class DomesticSales extends HttpServlet{
		private static final long serialVersionID = 1L;
		
		public DomesticSales(){
			super();
		}

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			
			String action = request.getParameter("action");
			HttpSession session = request.getSession();
			CustomHelper ch = new CustomHelper();
			Map thisVar = new HashMap();
			ProjectionModel proj = new ProjectionModel();
			proj.projectFile = getServletContext().getRealPath("");
			
			RequestDispatcher view = null;
			Boolean useDispatcher = false;
			if(ch.checkMemberSession(session)){

				if(action==null){
					Map ProjectionMap = new HashMap();
					Map requestMap = new HashMap();
					
					ChannelModel chModel = new ChannelModel();
					SalesModel salesModel = new SalesModel();
					useDispatcher = true;
					view = request.getRequestDispatcher("productsales/main.jsp");	
					request.setAttribute("asd","asd");
					ProjectionMap.put("location","Domestic");
					ResultSet channels = chModel.loadChannelByLocation(ProjectionMap);
					try{
						if(channels.next()){
							do{
								ProjectionMap.put("channelid",channels.getString("channel_id"));
								ResultSet sales = salesModel.ldYearRevenue2(ProjectionMap);
								try{
									if(sales.next()){
										
									}
								}catch(SQLException e){
									
								}
							}while(channels.next());
						}
					}catch(SQLException e){
						e.printStackTrace();
					}
					
					
					
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
	


