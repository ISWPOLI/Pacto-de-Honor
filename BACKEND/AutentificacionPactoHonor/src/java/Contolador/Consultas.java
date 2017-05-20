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
            String consulta = "select * from registrologin where Usuario = ? and Clave= ?"; //sql Inyection
            pst = getConnection().prepareStatement(consulta);
            pst.setString(1, rusuario);
            pst.setString(2, rcontraseña);
            rs = pst.executeQuery();

            if (rs.absolute(1)) return true;
            } catch (Exception e) {
            System.out.println("Error" + e);
        } finally {
            try {
                if (getConnection() != null) getConnection().close();
                if (pst != null) pst.close();
                if (rs != null) rs.close();
            } catch (Exception e) {
                System.out.println("Error" + e);
            }
        }
        return false;
    }
    
   /**public static void main(String[]args){
        Consultas co=new Consultas();
        System.out.println(co.autentificacion("admin", "Mariana5"));
    }*/
    
    public boolean registrar(String rnombres,String rapellido,String remail,String rpais, String rciudad, String rusuario, String rcontraseña) {
        PreparedStatement pst = null;

        try {
            String Consulta = "INSERT INTO registrologin (nombre,apellido,email,pais,ciudad,usuario,clave)values(?,?,?,?,?,?,?)";
            pst = getConnection().prepareStatement(Consulta);
            pst.setString(1, rnombres);
            pst.setString(2, rapellido);
            pst.setString(3, remail);
            pst.setString(4, rpais);
            pst.setString(5, rciudad);
            pst.setString(6, rusuario);
            pst.setString(7, rcontraseña);
                        
            if (pst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("Error" + ex);
        } finally {
            try {
                if (getConnection() != null) getConnection().close();
                if (pst != null) pst.close();
            } catch (Exception e) {
                System.out.println("Error" + e);
            }
        }
        return false;
    }
    
    public static void main(String[]args){
        Consultas co=new Consultas();
        System.out.println(co.registrar("Dario", "Gutierrez", "dai@hotmail.com", "Colombia", "Bogota", "jugador1", "Camila012"));
    }
      
    }
