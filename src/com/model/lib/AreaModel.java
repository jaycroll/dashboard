package com.model.lib;

import com.misc.lib.CustomHelper;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;

import com.mysql.jdbc.Driver;
import java.security.*;
import java.math.*;

import javax.servlet.http.HttpSession;

public class AreaModel{
        
        //For Database Connection
         private String connectionURL = "";
         private String dbUser="";
         private String dbPassword="";
         public String projectFile="";
         public String salesDB="";
         public String dashboardDB="";
         public Connection connection=null;
                
         public void fetchProperties() throws IOException, SQLException, ClassNotFoundException{
                 
                 String relativeWebPath = "/WEB-INF/app.properties";
                 Properties p = new Properties();
                 p.load(new FileInputStream(projectFile+relativeWebPath));
                 
                 this.connectionURL=p.getProperty("connectionURL");
                 this.dbUser=p.getProperty("dbUser");
                 this.dbPassword=p.getProperty("dbPassword");
                 this.salesDB=p.getProperty("salesDB");
                 this.dashboardDB=p.getProperty("dashboardDB");
                 Class.forName("com.mysql.jdbc.Driver");
                 this.connection = DriverManager.getConnection(this.connectionURL,this.dbUser,this.dbPassword);
         }
         public ResultSet loadTerritory(){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                       Statement st = this.connection.createStatement();
                       query= "SELECT "+this.salesDB+".territories.territoryname, "+this.salesDB+".territories.territoryid "
                    		 +"FROM "+this.salesDB+".territories "
                    		 +"WHERE "+this.salesDB+".territories.territoryid !='' ";
                     // System.out.println(query);
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
         public ResultSet loadAreasFromTerritory(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT "+this.salesDB+".areas.areaname, "+this.salesDB+".areas.areaid "
                    		 +"FROM "+this.salesDB+".areas, "+this.salesDB+".territories "
                    		 +"WHERE "+this.salesDB+".territories.territoryid ="+det.get("territoryid")+" "
                    		 +"AND "+this.salesDB+".areas.territoryid = "+this.salesDB+".territories.territoryid ";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadAgentsFromAreas(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT "+this.salesDB+".agents.agentid, user.userid, "+this.salesDB+".areas.areaid "
                    		 +"FROM "+this.salesDB+".agents, "+this.salesDB+".agent_areas, "+this.salesDB+".areas, user "
                    		 +"WHERE "+this.salesDB+".areas.areaid ="+det.get("areaid")+" "
                    		 +"AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		 +"AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		 +"AND user.userid = "+this.salesDB+".agents.agentuserid "
                    		 +"AND user.roleid =5";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadTeamLeaderFromAreas(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT "+this.salesDB+".agents.agentid, user.userid, "+this.salesDB+".areas.areaid "
                    		 +"FROM "+this.salesDB+".agents, "+this.salesDB+".agent_areas, "+this.salesDB+".areas, user "
                    		 +"WHERE "+this.salesDB+".areas.areaid ="+det.get("areaid")+" "
                    		 +"AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		 +"AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		 +"AND user.userid = "+this.salesDB+".agents.agentuserid "
                    		 +"AND user.roleid =4";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadFLAreaId(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT (SELECT "+this.salesDB+".areas.areaid "
                    		 +"FROM "+this.salesDB+".areas, "+this.salesDB+".territories "
                    		 +"WHERE "+this.salesDB+".territories.territoryid ="+det.get("territoryid")+" "
                    		 +"AND "+this.salesDB+".areas.territoryid = "+this.salesDB+".territories.territoryid "
                    		 +"ORDER BY areaid ASC LIMIT 1) as first,"
                    		 +"(SELECT "+this.salesDB+".areas.areaid "
                             +"FROM "+this.salesDB+".areas, "+this.salesDB+".territories "
                             +"WHERE "+this.salesDB+".territories.territoryid ="+det.get("territoryid")+" "
                             +"AND "+this.salesDB+".areas.territoryid = "+this.salesDB+".territories.territoryid "
                             +"ORDER BY areaid DESC LIMIT 1) as last";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadAreaSalesMTD(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT Ifnull(SUM("+this.salesDB+".sales_order.totalamountpaid),0) as totalsales "
                    		  +" FROM "+this.salesDB+".sales_order, salesteam.agents, "+this.salesDB+".agent_areas, "+this.salesDB+".areas "
                    		  +" WHERE "+this.salesDB+".areas.areaid = '"+det.get("areaid")+"' "
                    		  +" AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		  +" AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		  +" AND "+this.salesDB+".sales_order.agentid = "+this.salesDB+".agents.agentid "
                    		  +" AND YEAR("+this.salesDB+".sales_order.salesinvoicecreateddate) = YEAR(NOW()) "
                    		  +" AND MONTH("+this.salesDB+".sales_order.salesinvoicecreateddate) = MONTH(NOW())"
                    		  +" AND DAY("+this.salesDB+".sales_order.salesinvoicecreateddate) < DAY(NOW())";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadAreaSalesYTD(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT Ifnull(SUM("+this.salesDB+".sales_order.totalamountpaid),0) as totalsales "
                    		  +" FROM "+this.salesDB+".sales_order, "+this.salesDB+".territories,salesteam.agents, "+this.salesDB+".agent_areas, "+this.salesDB+".areas "
                    		  +" WHERE "+this.salesDB+".areas.areaid= '"+det.get("areaid")+"' "
                    		  +" AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		  +" AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		  +" AND "+this.salesDB+".sales_order.agentid = "+this.salesDB+".agents.agentid "
                    		  +" AND YEAR("+this.salesDB+".sales_order.salesinvoicecreateddate) = YEAR(NOW()) "
                    		  +" AND DATE_FORMAT("+this.salesDB+".sales_order.salesinvoicecreateddate,'%m-%d') < DATE_FORMAT(NOW(),'%m-%d')";                     
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadAreaTargetMTD(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT Ifnull(SUM(target_amount),0) as target_amount, MONTH(target_date) as month "
                    		  +"FROM targets, user, "+this.salesDB+".areas, "+this.salesDB+".agent_areas, "+this.salesDB+".territories, "+this.salesDB+".agents "
                    		  +"WHERE "+this.salesDB+".areas.areaid ='"+det.get("areaid")+"' "
                    		  +"AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		  +"AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		  +"AND user.userid = "+this.salesDB+".agents.agentuserid "
                    		  +"AND targets.user_id = user.userid "
                    		  +"AND targets.department_id = 2 "
                    		  +"AND YEAR(target_date) = YEAR(NOW()) "
                    		  +"AND MONTH(target_date) = MONTH(NOW()) " ;
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }
         public ResultSet loadAreaTargetYTD(Map det){
             
             String query="";
             ResultSet rs=null;
             
             try{
                      this.fetchProperties();
                      Statement st = this.connection.createStatement();
                       query= "SELECT Ifnull(SUM(target_amount),0) as target_amount, MONTH(target_date) as month "
                    		  +"FROM targets, user, "+this.salesDB+".areas, "+this.salesDB+".agent_areas, "+this.salesDB+".territories, "+this.salesDB+".agents "
                    		  +"WHERE "+this.salesDB+".areas.areaid ='"+det.get("areaid")+"' "
                    		  +"AND "+this.salesDB+".agent_areas.areaid = "+this.salesDB+".areas.areaid "
                    		  +"AND "+this.salesDB+".agents.agentid = "+this.salesDB+".agent_areas.agentid "
                    		  +"AND user.userid = "+this.salesDB+".agents.agentuserid "
                    		  +"AND targets.user_id = user.userid "
                    		  +"AND targets.department_id = 2 "
                    		  +"AND YEAR(target_date) = YEAR(NOW()) ";
                      
                       rs = st.executeQuery(query);
                      //st.close();
              } catch (SQLException e) {
                       System.err.println("SQLException: "
                                 +e.getMessage());
                   System.err.println("SQL Query: "+query);
              } catch (Exception e){
                                      System.out.println("Error in fetching"+e);
              }        
            
             return rs;
             
         }

        
}
