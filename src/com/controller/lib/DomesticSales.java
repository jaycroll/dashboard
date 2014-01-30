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

		@Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			
			String action = request.getParameter("action");
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
			String[] classCSS = new String[3];
			classCSS[0] = "active";
			classCSS[1] =  "";
			classCSS[2] = "ADomesticSales";
			if(ch.checkMemberSession(session)){

				if(action == null){
					Map ProjectionMap = new HashMap();
					Map requestMap = new HashMap();
					
					useDispatcher = true;
					view = request.getRequestDispatcher("productsales/main.jsp");
					
					ProjectionMap.put("location", "Domestic");

					ResultSet channels = chModel.loadChannelByLocation(ProjectionMap);
					try{
						channels.last();
						int channelCount = channels.getRow();
						String[][] channelList = new String[channelCount][2];
						int iterator = 0;
						channels.beforeFirst();
						if(channels.next()){
							do{
								channelList[iterator][0] = channels.getString("channel_id");
								channelList[iterator][1] = channels.getString("channel_name");
								iterator++;
							}while(channels.next());
						}
						request.setAttribute("channelList", channelList);
					}catch(SQLException e){
						e.printStackTrace();
					}
				}
					request.setAttribute("classCSS",classCSS);
					
				}
				if(useDispatcher=true){
					response.setHeader("Cache-control","private, no-store, no-cahce,must-revalidate");
					response.setHeader("Pragma","no-cache");
					view.forward(request, response);
				}
			}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		}

	}


