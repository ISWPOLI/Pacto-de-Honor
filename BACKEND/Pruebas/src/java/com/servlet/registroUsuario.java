/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import Controlador.ejb.JBean.JavaBeansLogin;
import Controlador.entidades.Registrologin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JERR
 */
public class registroUsuario extends HttpServlet {
    
@EJB
private JavaBeansLogin registrologinFacade;    

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String Nombre = request.getParameter("rnombres");
        String Apellido = request.getParameter("rapellido");
        String Email = request.getParameter("remail");
        String Pais = request.getParameter("rpais");
        String Ciudad = request.getParameter("rciudad");
        String Usuario = request.getParameter("ruser");
        String Clave = request.getParameter("rpass");

        Calendar c = Calendar.getInstance();
        String dia = Integer.toString(c.get(Calendar.DATE));
        String mes = Integer.toString(c.get(Calendar.MONTH) + 1);
        String year = Integer.toString(c.get(Calendar.YEAR));

        String fecha = year + "-" + mes + "-" + dia;

        Registrologin registro = new Registrologin();

        registro.setNombre(Nombre);
        registro.setApellido(Apellido);
        registro.setEmail(Email);
        registro.setPais(Pais);
        registro.setCiudad(Ciudad);
        registro.setUsuario(Usuario);
        registro.setClave(Clave);
        registro.setFecha(fecha);

        registrologinFacade.create(registro);

        out.println("Successful registration, please Log in.");
        out.println("<a href=" + "Login.jsp" + ">Login</a>");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para capturar los datos del registro y hacer la persstencia";
    }// </editor-fold>

}
