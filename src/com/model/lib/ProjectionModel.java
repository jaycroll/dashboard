package com.model.lib;

import com.misc.lib.CustomHelper;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;

import java.security.*;
import java.math.*;

import javax.servlet.http.HttpSession;

public class ProjectionModel{
	
	//For Database Connection
	 private String connectionURL = "";
	 private String dbUser="";
	 private String dbPassword="";
	 public String projectFile="";
	 
		
	 public void fetchProperties() throws IOException{
		 
		 String relativeWebPath = "/WEB-INF/app.properties";
		 Properties p = new Properties();
		 p.load(new FileInputStream(projectFile+relativeWebPath));
		 
		 this.connectionURL=p.getProperty("connectionURL");
		 this.dbUser=p.getProperty("dbUser");
		 this.dbPassword=p.getProperty("dbPassword");
	 }
	 
	 
	 public ResultSet loadProjectionA(Map det){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				  query = ""
						  + "SELECT ( (SELECT Ifnull(Sum(revenue_report.amount), 0) AS thisyear "
						  + "          FROM   revenue_report "
						  + "          WHERE  Date_format(revenue_report.revenue_date, '%Y-%m') = '"+det.get("fromMonth")+"' "
						  + "                 AND Date_format(revenue_report.revenue_date, '%Y-%m-%d') < "
						  + "                     '"+det.get("toMonth")+"' "
						  + "                 AND revenue_type = 'Sales') - (SELECT "
						  + "                Ifnull( "
						  + "                                               Sum(revenue_report.amount), 0) AS "
						  + "                thisyear "
						  + "                                                FROM   revenue_report "
						  + "                                                WHERE "
						  + "                Date_format( "
						  + "                revenue_report.revenue_date, '%Y-%m') = '"+det.get("fromMonth")+"' "
						  + "                AND Date_format( "
						  + "                    revenue_report.revenue_date, '%Y-%m-%d') < "
						  + "                    '"+det.get("toMonth")+"' "
						  + "                AND revenue_type = 'Refund') ) AS ActualMonthSales, "
						  + "       ( (SELECT Ifnull(Sum(revenue_report.amount), 0) AS thisyear "
						  + "          FROM   revenue_report "
						  + "          WHERE  Date_format(revenue_report.revenue_date, '%Y') = '"+det.get("fromYear")+"' "
						  + "                 AND Date_format(revenue_report.revenue_date, '%Y-%m-%d') < "
						  + "                     '"+det.get("toYear")+"' "
						  + "                 AND revenue_type = 'Sales') - (SELECT "
						  + "         Ifnull( "
						  + "                                               Sum(revenue_report.amount), 0) AS "
						  + "         thisyear "
						  + "                                                FROM   revenue_report "
						  + "                                                WHERE "
						  + "         Date_format( "
						  + "         revenue_report.revenue_date, '%Y') = '"+det.get("fromYear")+"' "
						  + "         AND Date_format( "
						  + "             revenue_report.revenue_date, '%Y-%m-%d') < "
						  + "             '"+det.get("toYear")+"' "
						  + "         AND revenue_type = 'Refund') )        AS ActualYearSales "
						  + "FROM   revenue_report "
						  + "LIMIT  1 ";

				  rs = st.executeQuery(query);
				  
				  
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 
	 public ResultSet loadProjectionMonthly(Map det){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				  /* query= ""
						  + "SELECT Sum(revenue_report.amount)                     AS subTotal, "
						  + "       Date_format(revenue_report.revenue_date, '%m') AS monthNum "
						  + "FROM   revenue_report "
						  + "WHERE  revenue_type = '"+det.get("revenue_type")+"' "
						  + "       AND Date_format(revenue_report.revenue_date, '%Y') = '"+det.get("year")+"' "
						  + "GROUP  BY Date_format(revenue_report.revenue_date, '%m-%y') ";
						 */
				  
		
			 query="SELECT Ifnull(Sum(CASE "
				  + "                    WHEN revenue_type = 'Sales' THEN amount "
				  + "                    ELSE 0 "
				  + "                  end) - Sum(CASE "
				  + "                               WHEN revenue_type = 'Refund' THEN amount "
				  + "                               ELSE 0 "
				  + "                             end), 0)                 AS subTotal, "
				  + "       Date_format(revenue_report.revenue_date, '%m') AS monthNum "
				  + "FROM   revenue_report "
				  + "WHERE  revenue_type = 'Sales' "
				  + "       AND Date_format(revenue_report.revenue_date, '%Y') = '"+det.get("year")+"' "
				  + "GROUP  BY Date_format(revenue_report.revenue_date, '%m-%y') ";
				   
				  rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 public ResultSet ldMonthRevenue(Map det,Boolean specDate){
		
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				   			query = ""
								  + "SELECT Ifnull(Sum(CASE "
								  + "                    WHEN revenue_type = 'Sales' THEN amount "
								  + "                    ELSE 0 "
								  + "                  end) - Sum(CASE "
								  + "                               WHEN revenue_type = 'Refund' THEN amount ELSE 0 "
								  + "                             end), 0) AS actual_revenue "
								  + "FROM   revenue_report "
								  + "WHERE  Date_format(revenue_date, '%Y-%m') = ";
				   			
				   				if(specDate){
				   					query += "       '"+det.get("month")+"'";
				   				}else{
				   					query += "       Date_format(NOW() - INTERVAL 1 day, '%Y-%m' ";
				   					query += "       ) ";
				   				}  
				   				
				   
				  rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 public ResultSet ldMonthTarget(Map det,Boolean specDate){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				   			query = ""
		   							+ "SELECT Ifnull(Sum(target_amount),0) as target_amount "
		   							+ "FROM   targets "
		   							+ "WHERE  target_group_id = 2 and department_id='1'"
		   							+ "       AND Date_format(target_date, '%Y-%m') = "; 
		   							
									if(specDate){
											query += "      '"+det.get("month")+"' ";
									}else{
											query += "       Date_format(NOW() - INTERVAL 1 day, '%Y-%m' ";
											query += "       ) ";	
									}
				
						
				 rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 public ResultSet loadAgentMonthlyTarget(Map det,Boolean byYear){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				   			query = "  SELECT target_amount, YEAR(target_date) as year, DATE_FORMAT(target_date,'%m') as month "
				   					+" FROM targets "
				   					+" WHERE user_id='"+det.get("userid")+"' "
				   					+" AND target_group_id=2 "
				   					+" AND department_id=2 "
				   				    +" AND YEAR(target_date)='"+det.get("year")+"' "
				   					+" GROUP BY YEAR(target_date), MONTH(target_date)";
				
				 
				 rs = st.executeQuery(query);
				 System.out.println(det.get("userid"));
				 System.out.println(det.get("year"));
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 
	 public ResultSet ldYearRevenue(Map det){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				   			query = ""
		   							+ "SELECT Ifnull(Sum(CASE "
		   							+ "                    WHEN revenue_type = 'Sales' THEN amount "
		   							+ "                    ELSE 0 "
		   							+ "                  end),0) -  Ifnull(Sum(CASE "
		   							+ "                               WHEN revenue_type = 'Refund' THEN amount - 0 "
		   							+ "                             end), 0) AS actual_revenue "
		   							+ "FROM   revenue_report "
		   							+ "WHERE  Date_format(revenue_date, '%Y') = Date_format(NOW() - INTERVAL 1 day, "
		   							+ "                                         '%Y') ";
				   
				  rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 public ResultSet ldYearTarget(Map det){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				  query = ""
						  + "SELECT Ifnull(Sum(target_amount),0) as target_amount "
						  + "FROM   targets "
						  + "WHERE  target_group_id = 2  and department_id='1'"
						  + "       AND Date_format(target_date, '%Y-%m') <= Date_format(NOW() - "
						  + "                                                INTERVAL 1 day, '%Y-%m' "
						  + "                                                ) ";		   
				  rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 public ResultSet ldYearTotalTarget(Map det){
			
		 	/////Notes here
		 
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  
				  query =    "SELECT  Ifnull(Sum(target_amount),0) as target_amount "
							 + "FROM   targets "
							 + "WHERE  target_group_id = 2 and department_id='1'"
							 + "       AND Date_format(target_date, '%Y') = Date_format(Now() - INTERVAL 1 day, "
							 + "                                            '%Y') ";	   
				  rs = st.executeQuery(query);
		
			} catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	  
	 
	 
	 /*
	 
	 public ResultSet loadTerritory(){
			
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  query="SELECT"+
						" *"+
						" FROM"+
						" territories order by territoryid asc";
					
				  rs = st.executeQuery(query);
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			return rs;
		}
	 
	 
	 
	 public Map fetchArea(int iAreaId){
			
			//privileges
			Map territoryDetails=new HashMap();
			String query="";
			 try{
					 
				 ResultSet rs=null;
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  query="Select * from areas where areaid='"+iAreaId+"'";
				
				  rs = st.executeQuery(query);
				  
				  if (rs.next()) {  
					 do{
						 territoryDetails.put("areaid",rs.getString("areaid"));
						 territoryDetails.put("areaname",rs.getString("areaname"));
						 territoryDetails.put("territoryid",rs.getString("territoryid"));
						 territoryDetails.put("status",rs.getString("status"));
					 }while(rs.next());
					  
				  }else{
					   //Details Here
				  }
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	  
			
			return territoryDetails;
	} 
	
			*/
	 
}
