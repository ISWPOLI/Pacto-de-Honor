/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import Controlador.entidades.Registrologin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.ejb.EJB;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JERR
 */
public class RecuperarClave extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
      
    @PersistenceContext(unitName = "PruebasPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
    
        try {
    
        String email = request.getParameter("remail");

        String usuarioCorreo = "polifighters@gmail.com";
        String contraseña = "rhunjupswrijaprr";
        String asunto = "Recover your password";
        
        
            Registrologin rl = (Registrologin) em.createNamedQuery("Registrologin.findByEmail").setParameter("email", email).getSingleResult();

            String emailB = rl.getEmail();
            String claveB = rl.getClave();

            if (!emailB.equals(email)) {
                System.err.println("Nulo");
                
            } else {
                
                String mensajet = "Remember your password is: " + claveB+" Now you can login";
                try {
                    Properties p = new Properties();
                    p.put("mail.smtp.host", "smtp.gmail.com");
                    p.setProperty("mail.smtp.starttls.enable", "true");
                    p.setProperty("mail.smtp.port", "587");
                    p.setProperty("mail.smtp.user", usuarioCorreo);
                    p.setProperty("mail.smtp.auth", "true");

                    Session s = Session.getInstance(p, null);
                    BodyPart texto = new MimeBodyPart();
                    texto.setText(mensajet);

                    MimeMultipart m = new MimeMultipart();
                    m.addBodyPart(texto);

                    MimeMessage mensaje = new MimeMessage(s);
                    mensaje.setFrom(new InternetAddress(usuarioCorreo));
                    mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                    mensaje.setSubject(asunto);
                    mensaje.setContent(m);

                    Transport t = s.getTransport("smtp");
                    t.connect(usuarioCorreo, contraseña);
                    t.sendMessage(mensaje, mensaje.getAllRecipients());
                    t.close();
                  
                    out.println("We send the password to your registered mail, Please check and log in.");
                    out.println("<a href=" + "Login.jsp" + ">Log in</a>");
                    
                } catch (MessagingException e) {
                    System.out.println("Error" + e);
                    // throw new RuntimeException(e);
                    
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("User does not exist,or the data is not valid please Register.");
            out.println("<a href=" + "Registro.jsp" + ">Register</a>");
        }

        //response.sendRedirect("login.jsp");
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
