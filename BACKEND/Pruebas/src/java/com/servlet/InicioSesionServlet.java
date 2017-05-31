/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Controlador.entidades.Registrologin;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author JERR
 */
public class InicioSesionServlet extends HttpServlet {

    @PersistenceContext(unitName = "PruebasPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }
    
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
        //processRequest(request, response);

     
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
        
           response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String Usuario = request.getParameter("rusuario");
            String Clave = request.getParameter("rcontrasena");
            System.out.println(Usuario + Clave);

            Registrologin entidadUsuario = (Registrologin) em.createNamedQuery("Registrologin.findByUsuario").setParameter("usuario", Usuario).getSingleResult();
            String UsuarioB = entidadUsuario.getUsuario();
            String claveB = entidadUsuario.getClave();
            System.out.println(UsuarioB + claveB);

            if (Clave.equals(claveB) && Usuario.equals(UsuarioB)) {
                System.out.println("Datos ingresados");
                response.sendRedirect("Historieta.jsp");
                /** Token alfanumerico
                 
                 
                 */
            } else {
                System.out.println("entro al error");
                out.println("User does not exist, Incorrect User or password, try again, please Register or log in.");
                out.println("<a href=" + "Login.jsp" + ">Log in</a>");
            }
        } catch (IOException e) {
            System.out.println("Error" + e);
            out.println("User does not exist, Incorrect password or User, try again, please Register or log in.");
            out.println("<a href=" + "Login.jsp" + ">Log in</a>");
        }
        
  }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para capturar los datos del Inicio y hacer la autentificación";
    }// </editor-fold>

}
