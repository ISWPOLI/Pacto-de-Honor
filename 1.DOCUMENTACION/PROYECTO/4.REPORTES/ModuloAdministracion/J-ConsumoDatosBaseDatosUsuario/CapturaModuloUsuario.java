
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Usuario
 */
public class CapturaModuloUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CapturaModuloUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CapturaModuloUsuario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            String IdPais=request.getParameter("idPais");
            String IdCiudad=request.getParameter("idCiudad");
            String IdRolUsuario=request.getParameter("idRolUsuario");
            String NombreUsuario=request.getParameter("nombreUsuario");
            String ApellidoUsuario=request.getParameter("apellidoUsuario");
            String EmailUsuario=request.getParameter("emailUsuario");
            String ContrasenaUsuario=request.getParameter("contrasenaUsuario");
            String FechaRegistro=request.getParameter("fechaRegistro");
            String Token=request.getParameter("token");
            String FechaToken=request.getParameter("fechaToken");
            
            System.out.println(IdPais);
            System.out.println(IdCiudad);
            System.out.println(IdRolUsuario);
            System.out.println(NombreUsuario);
            System.out.println(ApellidoUsuario);
            System.out.println(EmailUsuario);
            System.out.println(ContrasenaUsuario);
            System.out.println(FechaRegistro);
            System.out.println(Token);
            System.out.println(FechaToken);
            
            
            PreparedStatement psInser;
            MyDb con = new MyDb();
            psInser = con.getCon().prepareStatement("INSERT INTO usuario(id_pais, id_ciudad, id_rol_usuario, nombre_usuario,apellido_usuario, email_usuario, contrasena_usuario, fecha_registro, token, fecha_token)"+"values(?,?,?,?,?,?,?,?,?,?)");
            psInser.setString(1, IdPais);
            psInser.setString(2, IdCiudad);
            psInser.setString(3, IdRolUsuario);
            psInser.setString(4, NombreUsuario);
            psInser.setString(5, ApellidoUsuario);
            psInser.setString(6, EmailUsuario);
            psInser.setString(7, ContrasenaUsuario);
            psInser.setString(8, FechaRegistro);
            psInser.setString(9, Token);
            psInser.setString(10, FechaToken);
            psInser.executeUpdate();
            
            psInser = con.getCon().prepareStatement("SELECT id_usuario, id_pais, id_ciudad, id_rol_usuario, nombre_usuario, apellido_usuario, email_usuario, contrasena_usuario, fecha_registro, token, fecha_token FROM usuario");
            ResultSet res = psInser.executeQuery();
            
            while(res.next())
            {
                out.print(" Id_usuario: "+" Id pais: "+" Id ciudad: "+"Id rol usuario: "+" Nombre usuario: "+" Apellido usuario: "+" Email usuario: "+" Contraseña usuario: "+" Fecha Registro: "+" Token: "+" Fecha token: " + "<br />");
                out.print("<br />");
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(CapturaModuloUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
