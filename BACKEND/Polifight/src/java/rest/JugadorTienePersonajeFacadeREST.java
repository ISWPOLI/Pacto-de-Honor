/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import entities.JugadorTienePersonaje;
import entities.Personaje;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 *
 * @author 1013608348
 */
@Stateless
@Path("jugadortienepersonaje")
public class JugadorTienePersonajeFacadeREST extends AbstractFacade<JugadorTienePersonaje> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;
    
    /**
     * Retorna los id de los datos en la tabla JugadorTienePersonaje
     * * Se prueba con el TestCase getId" del proyecto JugadorTienePersonaje-soapui-project
     * @Param token
     * @return List con los datos
     */
    
    @GET
    @Path("getId")
    @Produces({"application/json"})
    public String returnId(@QueryParam("token") String token){
        String result = "{\"datos\":[";        
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query query = em.createNamedQuery("JugadorTienePersonaje.findAll");
                List<JugadorTienePersonaje> datos = query.getResultList();            
                for (int i = 0; i < datos.size(); i++) {
                    result += "{";
                    if(i == datos.size()-1){
                        result += "\"idJugadortienepersonaje\":"+datos.get(i).getIdJugadortienepersonaje();
                    }else{
                        result += "\"idJugadortienepersonaje\":"+datos.get(i).getIdJugadortienepersonaje();
                    }
                }
                result += "]}";
            }else{
                result = "{'response':'KO', 'cause':'Invalid token'}";
            }        
        }catch (Exception e){
            e.printStackTrace();
            result = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return result;
    }
    
    /**
     * Crea un dato donde se asigna un personaje a un jugador
     * Se prueba con el TestCase "Create" del proyecto JugadorTienePersonaje-soapui-project
     * @param token String correspondiente al token que se otorgo en el login
     * @param entity entidad JugadorTienePersonaje
     * @return String con la respuesta OK o KO
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearJugadorTienePersonaje(JugadorTienePersonaje entity, @QueryParam("token") String token) {
        String result;
        try{
            Query query = em.createNamedQuery("Usuario.findToken");
            query.setParameter("token", token);
            Usuario user = (Usuario) query.getSingleResult();
            if(user != null){
                em.persist(entity);
                result = "{'response':'OK'}";
            }else{
                result = "{'response':'KO', 'cause':'Token invalid'}";
            }
        }catch (Exception e){
            e.printStackTrace();
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            result = "{'response':'KO'}";
        }
        return result;
    }
    
    
    /**
     * Busca que personajes tiene el jugador de acuerdo al idJugadortienepersonaje
     * Se prueba con el TestCase "Find" del proyecto JugadorTienePersonaje-soapui-project
     * @param id del Jugador a buscar
     * @param token String con el token que se otorgo en el login
     * @return idPersonaje
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id, @QueryParam("token") String token) {
        String result = "";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               JugadorTienePersonaje jugadortienepersonaje = em.find(JugadorTienePersonaje.class, id);
               if(jugadortienepersonaje == null){
                   result = "{'response':'KO','cause':'Id not found'}";
               }else{
                   result =  "{'idJugadortienepersonaje':'"+jugadortienepersonaje.getIdJugadortienepersonaje()+"', 'idJugador':'"+jugadortienepersonaje.getJugador().getIdJugador()+"', 'idPersonaje':'"+jugadortienepersonaje.getPersonaje().getIdPersonaje()+"'}";
               }  
           }else{
              result = "{'response':'KO', 'cause':'Invalid token'}";
           }
        }catch (Exception e){
             e.printStackTrace();
             result = "{'response':'KO', 'cause':'Invalid token'}";
         }
         return result;
    }
    
    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<JugadorTienePersonaje> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<JugadorTienePersonaje> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }
    
    /**
     * Retorna el número de datos que están en la base de datos
     * Se prueba con el TestCase "Count" del proyecto JugadorTienePersonaje-soapui-project
     * @param token String con el token otorgado en el login
     * @return número de datos
     */
    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST(@QueryParam("token") String token) {
        String result = "";
        try{
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
             System.err.println(token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                result = String.valueOf(super.count());
            }else{
                result = "{'response':'KO', 'cause':'Invalid token'}";
            }
         }catch(Exception e){
             e.printStackTrace();
             result = "{'response':'KO', 'cause':'Invalid token'}";
         }
        return result;
    }
    
    public JugadorTienePersonajeFacadeREST() {
        super(JugadorTienePersonaje.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}