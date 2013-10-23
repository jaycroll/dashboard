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

public class TargetModel{
	
	//For Database Connection
	 private String connectionURL = "";
	 private String dbUser="";
	 private String dbPassword="";
	 public String projectFile="";
	 public int  targetid=0;
	 
		
	 public void fetchProperties() throws IOException{
		 
		 String relativeWebPath = "/WEB-INF/app.properties";
		 Properties p = new Properties();
		 p.load(new FileInputStream(projectFile+relativeWebPath));
		 
		 this.connectionURL=p.getProperty("connectionURL");
		 this.dbUser=p.getProperty("dbUser");
		 this.dbPassword=p.getProperty("dbPassword");
	 }
	 
	 
	 public Boolean InsertTarget(Map det){
			
			String query="";
			Boolean process=false;
		try{
			 this.fetchProperties();
			 Connection connection=null;
			 Class.forName("com.mysql.jdbc.Driver");
			 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
			 CustomHelper ch=new CustomHelper();
			 
			  Statement st = connection.createStatement();
			   query="INSERT INTO targets("+
							"target_date,"+
							"target_amount," +
							"target_group_id," +
							"department_id," +
							"user_id," +
							"target_datecreated"+
							")" +
							"VALUES(" +
							"'"+det.get("target_date")+"',"+
							"'"+det.get("target_amount")+"'," +
							"'"+det.get("target_group_id")+"'," +
							"'"+det.get("department_id")+"'," +
							"'"+det.get("user_id")+"'," +
							"'"+ch.loadDateNow()+"'" +
							")";
				
			  st.executeUpdate(query,Statement.RETURN_GENERATED_KEYS);
			  int iTargetid=0;
			  ResultSet rs = st.getGeneratedKeys();
		        if (rs.next()){
		        	iTargetid=rs.getInt(1);
		        }
		        this.targetid=iTargetid;
		        rs.close();
		        
				process=true;  
			  
		 } catch (SQLException e) {
			  System.err.println("SQLException: "
		    	        +e.getMessage());
		      System.err.println("SQL Query: "+query);
		 } catch (Exception e){
		 			System.out.println("Error in fetching"+e);
		 }	
		return process;
	}
	 
	 
	 public ResultSet loadDepartment(){
			
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
						" department order by department_id asc";
					
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
	 
	 
	  public ResultSet loadTargetGroup(){
			
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
						" target_group";
					
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
		  
	  public ResultSet loadDepartmentUser(Map det){
			
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  		  query="SELECT `user`.userid, "
							  + "       `user`.userfirstname, "
							  + "       `user`.userlastname, "
							  + "       roles.rolename, "
							  + "       department.department_name, "
							  + "       roles.department_id "
							  + "FROM   department "
							  + "       INNER JOIN roles "
							  + "               ON roles.department_id = department.department_id "
							  + "       INNER JOIN `user` "
							  + "               ON `user`.roleid = roles.roleid "
							  + " WHERE 1=1 ";
							
						  if(det.get("department_id") != null && det.get("deparment_id") != ""){
							  query+=" and roles.department_id = '"+det.get("department_id")+"' ";;
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
	 
	  
	  
	  public ResultSet loadTarget(Map det){
			
			String query="";
			ResultSet rs=null;
			
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 
				  Statement st = connection.createStatement();
				  query= "SELECT targets.target_id, "
						  + "       DATE_FORMAT(targets.target_date, '%m/%d/%Y') as target_date, "
						  + "       targets.target_amount, "
						  + "       targets.target_group_id, "
						  + "       targets.user_id, "
						  + "       targets.department_id, "
						  + "       targets.target_datecreated, "
						  + "       target_group.target_group_name, "
						  + "       `user`.userid, "
						  + "       `user`.userfirstname, "
						  + "       `user`.userlastname, "
						  + "       department.department_name "
						  + "FROM   targets "
						  + "       LEFT JOIN `user` "
						  + "              ON targets.user_id = `user`.userid "
						  + "       INNER JOIN department "
						  + "               ON targets.department_id = department.department_id "
						  + "       INNER JOIN target_group "
						  + "               ON targets.target_group_id = target_group.target_group_id "
						  + " where 1=1 ";
				  
				  
				  if(det.get("target_id") != null && det.get("target_id,") != ""){
					  query+=" and targets.target_id='"+det.get("target_id")+"'";
				  }
				  
				  if(det.get("target_date") != null && det.get("target_date,") != ""){
					  query+=" and targets.target_date='"+det.get("target_date")+"'";
				  }
				  

				  if(det.get("target_amount") != null && det.get("target_amount") != ""){
					  query+=" and targets.target_amount LIKE '%"+det.get("target_amount")+"%'";
				  }
				  
				  if(det.get("department_id") != null && det.get("department_id") != ""){
					  query+=" and targets.department_id='"+det.get("department_id")+"'";
				  }
				  
				  if(det.get("target_group_id") != null && det.get("target_group_id") != ""){
					  query+=" and targets.target_group_id='"+det.get("target_group_id")+"'";
				  }
				  
				  if(det.get("user") != null && det.get("user") != ""){
					  query+=" and (user.userfirstname LIKE '%"+det.get("user")+"%' || user.userlastname LIKE '%"+det.get("user")+"%')";
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
	  
	  
	  

		
		public Boolean UpdateTarget(Map det){
				
				
				String query="";
				Boolean process=false;
			try{
				 this.fetchProperties();
				 Connection connection=null;
				 Class.forName("com.mysql.jdbc.Driver");
				 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
				 CustomHelper ch=new CustomHelper();
				 
				  Statement st = connection.createStatement();
				  
				   query="UPDATE targets set " +
					   	 " target_date='" +det.get("target_date")+"',"+
					   	 " target_amount='" +det.get("target_amount")+"',"+
					   	 " target_group_id='" +det.get("target_group_id")+"',"+
					   	 " department_id='" +det.get("department_id")+"',"+
					   	 " user_id='" +det.get("user_id")+"'"+
					   	 " where target_id='" +det.get("target_id")+"'";
					   
				  st.executeUpdate(query);
				  
				  process=true;  
				  
			 } catch (SQLException e) {
				  System.err.println("SQLException: "
			    	        +e.getMessage());
			      System.err.println("SQL Query: "+query);
			 } catch (Exception e){
			 			System.out.println("Error in fetching"+e);
			 }	
			return process;
		}


		
		public Boolean DeleteTarget(String target_id){
			
			String query="";
			Boolean process=false;
		try{
			 this.fetchProperties();
			 Connection connection=null;
			 Class.forName("com.mysql.jdbc.Driver");
			 connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
			 CustomHelper ch=new CustomHelper();
			 
			  Statement st = connection.createStatement();
			  query="DELETE FROM targets WHERE target_id='"+target_id+"'";
			  st.executeUpdate(query);
			  process=true;
			  
			  
		 } catch (SQLException e) {
			  System.err.println("SQLException: "
		    	        +e.getMessage());
		      System.err.println("SQL Query: "+query);
		 } catch (Exception e){
		 			System.out.println("Error in fetching"+e);
		 }	
		return process;
		}
		  
}
