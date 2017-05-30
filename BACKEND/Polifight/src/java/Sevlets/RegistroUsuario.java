/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Sevlets;

import ejb.JBean.JavaBeansLogin;
//import Controlador.entidades.Registrologin;
import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.Random;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JERR
 */
public class RegistroUsuario extends HttpServlet {
    
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

        try{
            String Nombre = request.getParameter("rnombres").trim();
            String Apellido = request.getParameter("rapellido").trim();
            String Email = request.getParameter("remail").trim();
            String Pais = request.getParameter("rpais").trim();
            String Ciudad = request.getParameter("rciudad").trim();
            String Usuario = request.getParameter("ruser").trim();
            String Clave = request.getParameter("rpass").trim();
            String confirm = request.getParameter("repass").trim();
            
            if(!confirm.equals(Clave)){
                out.println("<script type=\"text/javascript\">alert('Las contraseñas son diferentes')</script><meta http-equiv=\"Refresh\" content=\"0;url=Register.jsp\">");
            }else{

                Calendar c = Calendar.getInstance();
                String dia = Integer.toString(c.get(Calendar.DATE));
                String mes = Integer.toString(c.get(Calendar.MONTH) + 1);
                String year = Integer.toString(c.get(Calendar.YEAR));
                String hour = Integer.toString(c.get(Calendar.HOUR));
                String minutes = Integer.toString(c.get(Calendar.MINUTE));
                String seconds = Integer.toString(c.get(Calendar.SECOND));

                String fecha = year + "-" + mes + "-" + dia+" "+hour+":"+minutes+":"+seconds;

                Usuario registro = new Usuario();

                registro.setIdUsuario((int)Math.random()*1000000007);
                registro.setIdPais(1);
                registro.setIdCiudad(52838);
                registro.setIdRolUsuario(1);
                registro.setNombreUsuario(Nombre);
                registro.setApellidoUsuario(Apellido);
                registro.setEmailUsuario(Email);
                registro.setContrasenaUsuario(Clave);
                registro.setFechaRegistro(fecha);
                registro.setToken(Token());
                registro.setFechaToken(fecha);
                registro.setUsuario(Usuario);

                registrologinFacade.create(registro);
                
                out.println("<script type=\"text/javascript\">alert('Registro c ompleto, ya puedes ingresar al juego')</script>");
                out.println("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"0;URL=Login.jsp\">");
            }
        }catch(javax.ejb.EJBException e){
            out.println("<div class=\"StyleImage\"><center><img src=\"Imagenes-y-Logos/mantenimiento.png\"></center><br></div><br><br><br>"+e.toString());
            out.println("<br><br><center><a href=" + "Login.jsp" + ">Volver</a></center>");
            
            
        }
        
    }
    
    private static String Token(){
        SecureRandom random = new SecureRandom();
        return new BigInteger(130,random).toString(32).toUpperCase();
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
