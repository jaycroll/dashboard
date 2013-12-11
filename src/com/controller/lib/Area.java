package com.controller.lib;


import org.json.simple.JSONObject;
import com.misc.lib.CustomHelper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
 * Servlet implementation class Index
 */

@WebServlet(description = "Area servlet", urlPatterns = { "/Area" })

public class Area extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	private String strName="Testing";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Area() {
        super();
        // TODO Auto-generated constructor stub
        
    }
  
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action	= request.getParameter("action");
		HttpSession sess=request.getSession();
		CustomHelper ch=new CustomHelper();
		
		
		if(ch.checkMemberSession(sess)){
	
			ProjectionModel proj=new ProjectionModel();
			proj.projectFile=getServletContext().getRealPath("");
			
			UserModel usr=new UserModel();
			usr.projectFile=getServletContext().getRealPath("");
			
			AreaModel area = new AreaModel();
			area.projectFile = getServletContext().getRealPath("");
			RequestDispatcher view=null;
			Boolean useDispatcher=false;
			
			if(action==null){
				
				
				
				Map det=new HashMap();
				det.put("territoryid",6);
				Map territoryid = new HashMap();
				Map areaid = new HashMap();
				ResultSet agentlist=usr.loadSalesUser(det);
				ResultSet getTerritory = area.loadTerritory();
				
				String[] territories = new String[100];
				String[] areas = new String[100];//<--sucks cause i made this one static :/ i'll call you pro if you it dynamic :D
				String[] isSelected = new String[100];
				int Areaid = 0;
				int Territoryid = 0;
				try{
					if(getTerritory.next()){
						do{
							Territoryid = Integer.parseInt(getTerritory.getString("territoryid"));
							for(int i = 1; i < territories.length; i++){
								if(i == Territoryid){
									territories[i] = getTerritory.getString("territoryname");
									//System.out.println(territories[i]);
									areaid.put("territoryid",i);
									ResultSet getArea = proj.loadAreasFromTerritory(areaid);
									try{
										if(getArea.next()){
											do{
												Areaid = Integer.parseInt(getArea.getString("areaid"));
												for(int j = 1; j < areas.length; j++){
													if(j == Areaid){
														areas[j] = getArea.getString("areaid");
														//System.out.println(areas[j]);
													}
												}
											}while(getArea.next());
										}
									}catch(SQLException e){
										e.printStackTrace();
									}
								}
							}
						}while(getTerritory.next());
					}
					
				}catch(SQLException e){
					e.printStackTrace();
				}
				
				request.setAttribute("areas",areas);
				request.setAttribute("isSelected",isSelected);
				request.setAttribute("territories",territories);
				request.setAttribute("territoryList", getTerritory);
				request.setAttribute("agentlist",agentlist);
				//request.setAttribute("loadTerritory", getTerritory);
				
				
				request.setAttribute("graphContent",true);
				useDispatcher=true;
				view = request.getRequestDispatcher("area/main.jsp");
				////////////////////////////////////////////////////////

				
			}
			
			
			if(useDispatcher){	
				response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
				response.setHeader("Pragma", "no-cache");
				view.forward(request, response); 
			}
			
			
		}else{
			response.sendRedirect("/Dashboard");
		}
		 
			
		
		 
	}

	private int count(float[] iSales) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
