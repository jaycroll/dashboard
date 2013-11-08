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
import java.text.DecimalFormat;
import java.util.Calendar;
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

@WebServlet(description = "Profile servlet", urlPatterns = { "/Profile" })

public class Profile extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	private String strName="Testing";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profile() {
        super();
        // TODO Auto-generated constructor stub
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//String action	= request.getParameter("action");
		String userid = request.getParameter("userid");
		String year = request.getParameter("year");
		HttpSession sess=request.getSession();
		CustomHelper ch=new CustomHelper();
		
		
		if(ch.checkMemberSession(sess)){
	
			ProjectionModel proj=new ProjectionModel();
			proj.projectFile=getServletContext().getRealPath("");
			
			UserModel usr=new UserModel();
			usr.projectFile=getServletContext().getRealPath("");
			
			SalesModel sales=new SalesModel();
			sales.projectFile=getServletContext().getRealPath("");
			
			RequestDispatcher view=null;
			Boolean useDispatcher=false;


			
			DecimalFormat numberFormat = new DecimalFormat("#.00");
			Map salesM = new HashMap();
			Map targetM = new HashMap();
			float[] monthlySales = new float[13];
			float[] monthlyTarget = new float[13];
			
			salesM.put("userid", userid);
			targetM.put("userid", userid);
			if(year==null){
				int currentYear = Calendar.getInstance().get(Calendar.YEAR);
				salesM.put("year",currentYear);
				targetM.put("year",currentYear);
				ResultSet getSales = sales.loadAgentMonthlySales(salesM, true);
				ResultSet getTargets = proj.loadAgentMonthlyTarget(targetM, true);
				
				try{
					if(getSales.next()){
						monthlySales[0] = (float) 00.0;
						do{
							for(int i = 1; i<13; i++){
								if(i == Integer.parseInt(getSales.getString("month"))){
									
									monthlySales[i] = Float.parseFloat(getSales.getString("totalpayment"));
									
								}
							//System.out.println(getSales.getString("month"));
							//System.out.println(i);
							}
							//System.out.println(getSales.getString("month"));
						}while(getSales.next());
					}
				}catch(SQLException e){ e.printStackTrace(); }
				try{
					if(getTargets.next()){
						monthlyTarget[0] = (float) 00.0;
						do{
							for(int i = 1; i<13; i++){
								if(i == Integer.parseInt(getTargets.getString("month"))){
									System.out.println("Validated: "+getTargets.getString("month"));
									monthlyTarget[i] = Float.parseFloat(getTargets.getString("amount"));
									
								}
							//System.out.println(getTargets.getString("month"));
							//System.out.println(i);
							}
							System.out.println(getSales.getString("month"));
						}while(getTargets.next());
					}
					
				}catch(SQLException e){ e.printStackTrace(); }
				
				
			}
			
			else{
				salesM.put("year", year);
				targetM.put("year",year);
			}
			request.setAttribute("monthlySales",monthlySales);
			request.setAttribute("monthlyTargets",monthlyTarget);
			useDispatcher=true;
			view = request.getRequestDispatcher("profile/main.jsp");
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
