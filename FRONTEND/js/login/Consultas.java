/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Contolador;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author JERR
 */
public class Consultas extends conexion{
    
    public boolean autentificacion(String rusuario, String rcontraseña) {
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select * from registrologin where Email =? and Clave=?";
            pst = getConnection().prepareStatement(consulta);
            pst.setString(1, rusuario);
            pst.setString(2, rcontraseña);
            rs = pst.executeQuery();

            if (rs.absolute(1)) {
                return true;
            }

        } catch (Exception e) {
            System.out.println("Error" + e);
        } finally {
            try {
                if (getConnection() != null) {
                    getConnection().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.out.println("Error" + e);
            }
        }
        return false;
    }
    
   /** public static void main(String[]args){
        Consultas co=new Consultas();
        System.out.println(co.autentificacion("jerrincon@gmail.com", "Mariana2"));
    }*/
    
    public boolean registrar(String rnombres, String rusuario, String rcontraseña) {
        PreparedStatement pst = null;

        try {
            String Consulta = "INSERT INTO registrologin (Nombre,Email,Clave)values(?,?,?)";
            pst = getConnection().prepareStatement(Consulta);
            pst.setString(1, rnombres);
            pst.setString(2, rusuario);
            pst.setString(3, rcontraseña);

            if (pst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("Error" + ex);
        } finally {
            try {
                if (getConnection() != null) {
                    getConnection().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.out.println("Error" + e);
            }
        }
        return false;
    }
    
   /**public static void main(String[]args){
        Consultas co=new Consultas();
        System.out.println(co.registrar("Ernesto", "jerrincon@hotmail.com", "Mariana"));
    }*/
      
    }
