/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Contolador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author JERR
 */
public class conexion {
    private String USERNAME="root";//user DB
    private String PASSWORD="";//pass DB
    private String HOST="localhost";//servidor
    private String PORT="3306";//puerto msql
    private String DATABASE="pactohonorpoli";//base datos
    private String CLASSNAME="com.mysql.jdbc.Driver";//driver mysql
    private String URL="jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE;//CONEXION
    private Connection con;
    
    public conexion(){
        try {
            Class.forName(CLASSNAME);
            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Error"+e);
        }catch(SQLException e){
            System.out.println("Error"+e);
        }
        }
    
        public Connection getConnection(){
            return con;
        }
        
        public static void main(String [] args){
            conexion con=new conexion();
        }
    }
    

