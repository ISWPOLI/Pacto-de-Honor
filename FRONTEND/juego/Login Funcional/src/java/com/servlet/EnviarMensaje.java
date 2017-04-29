/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import Controlador.entidades.Registrologin;
import java.util.Properties;
import javax.ejb.Stateless;
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
import javax.swing.JOptionPane;

/**
 *
 * @author JERR
 */
@Stateless
public class EnviarMensaje {

    @PersistenceContext(unitName = "PruebasPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public EnviarMensaje() {
       
    }
    
    String usuarioCorreo = "polifighters@gmail.com";
    String contraseña = "rhunjupswrijaprr";
    String destino = "";
    String asunto = "Recupera tu contraseña";

    public EnviarMensaje(String s) {
        destino = s;
    }

    /*public String getClave(String email) {
        Statement pst = null;
        ResultSet rs = null;
        String rta="";
        
        try {
            Query query =em.createQuery( "select s from Registrologin s where s.email =:x ");
            query.setParameter(email,"x" );
            
            Registrologin registro=query.getSingleResult();
            
            if (rs != null) {
                if (rs.absolute(1)) {
                    rta=rs.getString("clave");
                    return rta;
                }System.out.println("No esta Registrado");
            } else{
                System.out.println("campos vacios");
            }
        } catch (Exception e) {
             e.printStackTrace();
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(AbstractFacade.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return rta;
    }*/
    public boolean enviarCorreo(String email) {
        try {
            String clave = "";
            try {
                Registrologin rl = (Registrologin) em.createNamedQuery("Registrologin.findByEmail")
                        .setParameter("email", email)
                        .getSingleResult();

                if (rl != null) {
                    clave = rl.getClave();
                } else {
                    System.err.println("registro loginh es nulo");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Properties p = new Properties();
            p.put("mail.smtp.host", "smtp.gmail.com");
            p.setProperty("mail.smtp.starttls.enable", "true");
            p.setProperty("mail.smtp.port", "587");
            p.setProperty("mail.smtp.user", usuarioCorreo);
            p.setProperty("mail.smtp.auth", "true");

            Session s = Session.getInstance(p, null);
            BodyPart texto = new MimeBodyPart();
            texto.setText(clave);

            MimeMultipart m = new MimeMultipart();
            m.addBodyPart(texto);

            MimeMessage mensaje = new MimeMessage(s);
            mensaje.setFrom(new InternetAddress(usuarioCorreo));
            mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            mensaje.setSubject(asunto);
            mensaje.setContent(m);

            Transport t = s.getTransport("smtp");
            t.connect(usuarioCorreo, contraseña);
            t.sendMessage(mensaje, mensaje.getAllRecipients());
            t.close();
            return true;

        } catch (MessagingException e) {
            System.out.println("Error" + e);
            // throw new RuntimeException(e);
            return false;
        }

    }

}
