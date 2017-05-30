package Sevlets;

import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
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
    
      
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
    
            String email = request.getParameter("remail").trim();
            String usuario = request.getParameter("rusuario").trim();
            
            String usuarioCorreo = "polifighters@gmail.com";
            String contraseña = "equipodesarrollo";
            String asunto = "Recordar Contraseña Poli Fighters!!!";
            
            Usuario rl = (Usuario) em.createNamedQuery("Usuario.findByUsuario").setParameter("usuario", usuario).getSingleResult();

            String emailB = rl.getEmailUsuario();
            String claveB = rl.getContrasenaUsuario();

            if (!emailB.equals(email)) {
                out.println("<script type=\"text/javascript\">alert('El correo no es valido, Porfavor intentelo de nuevo')</script>");
                out.println("<meta http-equiv=\"Refresh\" content=\"0;url=Forgot.jsp\">");
            } else {
                
                String mensajet = "\n\nHola "+usuario+",\n\nTu contraseña es: " + claveB+"\n\n\nYa puedes ingresar al juego!!";
                
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
                    
                    out.println("<script type=\"text/javascript\">alert('Ya enviamos el correo, Porfavor revisalo e ingresa')</script>");
                    out.println("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"0;URL=Login.jsp\">");
                    
                } catch (MessagingException e) {
                    out.println("<div class=\"StyleImage\"><center><img src=\"Imagenes-y-Logos/mantenimiento.png\"></center><br></div><br><br><br>");
                    out.println("<br><br><center><a href=" + "Login.jsp" + ">Volver</a></center>");
                   
                }

            }

        } catch (Exception e) {
            out.println("<script type=\"text/javascript\">alert('El usuario no es valido, Porfavor intentelo de nuevo')</script>");
            out.println("<meta http-equiv=\"Refresh\" content=\"0;url=Forgot.jsp\">");
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
