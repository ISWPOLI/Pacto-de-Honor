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
public class CapturaModuloPersonaje extends HttpServlet {

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
            out.println("<title>Servlet CapturaModuloPersonaje</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CapturaModuloPersonaje at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");

            String IdCategoria = request.getParameter("idCategoria");
            String IdImagen = request.getParameter("idImagen");
            String NombrePersonaje = request.getParameter("nombrePersonaje");
            String DescripcionPersonaje = request.getParameter("descripcionPersonaje");
            String Costo = request.getParameter("costo");
            String NivelDano = request.getParameter("nivelDano");
            
            
            System.out.println(IdCategoria);
            System.out.println(IdImagen);
            System.out.println(NombrePersonaje);
            System.out.println(DescripcionPersonaje);
            System.out.println(Costo);
            System.out.println(NivelDano);
            
            PreparedStatement psInser;
            MyDb con = new MyDb();
            
            psInser = con.getCon().prepareStatement("INSERT INTO personaje(id_categoria, id_imagen, nombre_personaje, descripcion_personaje, costo, nivel_dano)" + "values (?,?,?,?,?,?)");
            
            psInser.setString(1, IdCategoria);
            psInser.setString(2, IdImagen);
            psInser.setString(3, NombrePersonaje);
            psInser.setString(4, DescripcionPersonaje);
            psInser.setString(5, Costo);
            psInser.setString(6, NivelDano);
            psInser.executeUpdate();
            
            psInser =con.getCon().prepareStatement("SELECT id_personaje, id_categoria, id_imagen, nombre_personaje, descripcion_personaje, costo, nivel_dano FROM personaje");
            ResultSet res  = psInser.executeQuery();
            
            while(res.next())
            {
                out.print("ID_personaje : "+ res.getString(1) +"  ID_categoria : "+ res.getString(2)+"  ID_imagen : "+res.getString(3)+"  Nombre_personaje : "+res.getString(4)+"  Descripción_personaje : "+res.getString(5)+"  Costo : "+res.getString(6)+"  Nivel_daño : " +res.getString(7)+ "<br />");
                out.println("<br />");
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(CapturaModuloPersonaje.class.getName()).log(Level.SEVERE, null, ex);
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
