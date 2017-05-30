package Sevlets;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import Controlador.entidades.Registrologin;
import entities.Usuario;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author JERR
 */
public class InicioSesionServlet extends HttpServlet {

    @PersistenceContext(unitName = "PolifightPU")
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
        
        String Usuario = request.getParameter("rusuario");
        String Clave = request.getParameter("rcontrasena");
        System.out.println(Usuario + Clave);

        try{
            Usuario entidadUsuario = (Usuario) em.createNamedQuery("Usuario.findByUsuario").setParameter("usuario", Usuario).getSingleResult();
            String UsuarioB = entidadUsuario.getUsuario();
            String claveB = entidadUsuario.getContrasenaUsuario();
            System.out.println(UsuarioB + claveB);

            if (Clave.equals(claveB) && Usuario.equals(UsuarioB)) {
                System.out.println("Datos ingresados");
                //ACA VA EL JUEGO
                response.sendRedirect("Historieta.jsp");
                /** Token alfanumerico
                x 
                 
                 */
            } else {
                //System.out.println("entro al error");
                out.println("<script type=\"text/javascript\">alert('Contraseña incorrecta, porfavor intentelo de nuevo')</script>");
                out.println("<meta http-equiv=\"Refresh\" content=\"0;url=Login.jsp\">");
            }
        } catch (javax.persistence.NoResultException e) {
            System.out.println("Error" + e);
            out.println("<script type=\"text/javascript\">alert('El usuario no existe, porfavor intentelo de nuevo')</script>");
            out.println("<meta http-equiv=\"Refresh\" content=\"0;url=Login.jsp\">");
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
