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
import java.sql.Statement;
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
public class CapturaModuloMundo extends HttpServlet {

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
            out.println("<title>Servlet CapturaModuloMundo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CapturaModuloMundo at " + request.getContextPath() + "</h1>");

//            String IdMundo=request.getParameter("Idmundo");
//            String NomMundo=request.getParameter("Mundo");
//           System.out.println(IdMundo);
//           System.out.println(NomMundo);
//            
//            MyDb db = new MyDb();
//            Connection con= db.getCon();
//            
//            PreparedStatement stmt = con.prepareStatement("INSERT INTO mundo VALUES (?,?)");
//            stmt.setString(1, IdMundo);
//            stmt.setString(2, NomMundo);
//          //  ResultSet rs=con.executeQuery(stmt.execute(IdMundo));
//            stmt.executeUpdate();
            String IdMundo = request.getParameter("Idmundo");
            String NomMundo = request.getParameter("Mundo");
           
            System.out.println(NomMundo);

            PreparedStatement psInser;
            MyDb con = new MyDb();

            Statement Stmmt = con.getCon().createStatement();
            psInser = con.getCon().prepareStatement("INSERT INTO mundo(nombre_mundo)" + " values (?)");
            //psInser.setString(1, IdMundo);
            psInser.setString(1, NomMundo);

            psInser.executeUpdate();
            System.out.println("insert ok");

            psInser = con.getCon().prepareStatement("SELECT id_mundo, nombre_mundo FROM mundo");
            ResultSet res = psInser.executeQuery();

            while (res.next()) {
                out.println("ID: " + res.getString(1) + ", Nombre: " + res.getString(2) + "<br />");
            }

        } catch (SQLException ex) {
            System.out.println("insert bad");
            Logger.getLogger(CapturaModuloMundo.class.getName()).log(Level.SEVERE, null, ex);
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
        // processRequest(request, response);
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
