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
		String territoryid = request.getParameter("territoryid");
		ProjectionModel proj=new ProjectionModel();
		AreaModel area = new AreaModel();
		CustomHelper ch=new CustomHelper();
		proj.projectFile=getServletContext().getRealPath("");
		HttpSession sess=request.getSession();
		
		
		if(action.equals("loadAreas")){
		   
		   	Map det=new HashMap();
			useDispatcher=true;
			det.put("territoryid",territoryid);
			ResultSet areas = area.loadAreasFromTerritory(det);
			request.setAttribute("areaList",areas);
		   
			useDispatcher=true;
			view = request.getRequestDispatcher("area/main.jsp");
			////////////////////////////////////////////////////////

			
		}
		
		
		if(useDispatcher){	
			response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			view.forward(request, response); 
		}
		
		
		 
	}//end of function
	
	
	
	

}//end of class
