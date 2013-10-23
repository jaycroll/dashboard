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
import java.util.LinkedHashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Index
 */

@WebServlet(description = "Init servlet", urlPatterns = { "/Index" })

public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String strName="Testing";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
        
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		CustomHelper ch=new CustomHelper();
		HttpSession sess=request.getSession();
		RequestDispatcher view=null;
		
			
		if(ch.checkMemberSession(sess)){
			request.setAttribute("logged",false);
		}else{
			request.setAttribute("showMenu",false);
		}
		
		 view = request.getRequestDispatcher("main/index.jsp");
		 response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
		 view.forward(request, response); 
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
