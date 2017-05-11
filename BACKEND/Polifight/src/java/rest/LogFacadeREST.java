/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import entities.Log;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 *
 * @author 1013608348
 */
@Stateless
@Path("log")
public class LogFacadeREST extends AbstractFacade<Log> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;
    
    
    @GET
    @Path("getId")
    @Produces({"application/json"})
    public String returnId(@QueryParam("token") String token){
        String resultado = "{\"datos\":[";        
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query query = em.createNamedQuery("Log.findAll");
                List<Log> datos = query.getResultList();            
                for (int i = 0; i < datos.size(); i++) {
                    resultado += "{";
                    if(i == datos.size()-1){
                        resultado += "\"idPersonaje\":"+datos.get(i).getIdPersonaje();
                    }else{
                        resultado += "\"idPersonaje\":"+datos.get(i).getIdPersonaje();
                    }
                }
                resultado += "]}";
            }else{
                resultado = "{'response':'Error', 'cause':'Invalid token'}";
            }        
        }catch (Exception e){
            e.printStackTrace();
            resultado = "{'response':'Error', 'cause':'Invalid token'}";
        }
        return resultado;
    }
    
    /**
     * Crea un dato Log
     * Se prueba con el TestCase "Crear" del proyecto Log-soapui-project
     * @param entity Entidad Log
     * @return JSON con la respuesta satisfactoria o insatisfactoria
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String createNivel(Log entity) {
        String result;
        try{
            em.persist(entity);
            result = "{'response':'Log create']";
        }catch (Exception e){
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            result = "{'response':'Error', 'cause':'"+errors.toString()+"'}";
        }
        return result;
    }
    
    /**
     * Busca un dato de acuerdo al id que recibe
     * Se prueba con el TestCase "Buscar" del proyecto Log-soapui-project
     * @param id del Log a buscar
     * @return String con la entity Log
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id){
        Log log = em.find(Log.class, id);
        if (log == null){
            return "{'response':'Error','cause':'Log not found'}";
        }else{
            return "{'idLog':'"+log.getIdLog()+"', 'idJugador':'"+log.getIdJugador()+"' 'tiempoLog':'"+log.getTiempoLog()+"'}"+"' 'fechaInicio':'"+log.getFechaInicio()+"'}"+"' 'fechaFinal':'"+log.getFechaFinal()+"'}"+"' 'idNivel':'"+log.getIdNivel()+"'}"+"' 'idMundo':'"+log.getIdMundo()+"'}"+"' 'idPersonaje':'"+log.getIdPersonaje();
        }        
    }
    
    /**
     * Busca un dato de acuerdo al id_jugador que recibe
     * Se prueba con el TestCase "BuscarJugador" del proyecto Log-soapui-project
     * @param idJugador del Log a buscar
     * @return String con la entity Log
     */
    @GET
    @Path("findJugador")
    @Produces({"application/json"})
    public String findJugador(@QueryParam("idJugador") Integer idJ){
        Log log = em.find(Log.class, idJ);
        if (log == null){
            return "{'response':'Error','cause':'Player not found'}";
        }else{
            return "{'idLog':'"+log.getIdLog()+"', 'idJugador':'"+log.getIdJugador()+"' 'tiempoLog':'"+log.getTiempoLog()+"'}"+"' 'fechaInicio':'"+log.getFechaInicio()+"'}"+"' 'fechaFinal':'"+log.getFechaFinal()+"'}"+"' 'idNivel':'"+log.getIdNivel()+"'}"+"' 'idMundo':'"+log.getIdMundo()+"'}"+"' 'idPersonaje':'"+log.getIdPersonaje();
        }        
    }
    
    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "ListarTodo" del proyecto Log-soapui-project
     * @return String con todos los Nivel
     */ 
    
    @GET
    @Path("listLogs")
    @Produces({"application/json"})
    public String listLog(){
        String resultado = "[";
        Query query = em.createQuery("SELECT l FROM Log l");
        List<Log> datos = query.getResultList();
        for (int i = 0; i < datos.size(); i++) {
            resultado += "{";
            if(i == datos.size()-1){
                resultado += "'idLog':'"+datos.get(i).getIdNivel()+"', 'idJugador':'"+datos.get(i).getIdJugador()+"', 'tiempoLog':'"+datos.get(i).getTiempoLog()+"', 'fechaInicio':'"+datos.get(i).getFechaInicio()+"', 'fechaFinal':'"+datos.get(i).getFechaFinal()+"', 'idNivel':'"+datos.get(i).getIdNivel()+"', 'idMundo':'"+datos.get(i).getIdMundo()+"', 'idPersonaje':'"+datos.get(i).getIdPersonaje();
            }else{
                resultado += "'idLog':'"+datos.get(i).getIdNivel()+"', 'idJugador':'"+datos.get(i).getIdJugador()+"', 'tiempoLog':'"+datos.get(i).getTiempoLog()+"', 'fechaInicio':'"+datos.get(i).getFechaInicio()+"', 'fechaFinal':'"+datos.get(i).getFechaFinal()+"', 'idNivel':'"+datos.get(i).getIdNivel()+"', 'idMundo':'"+datos.get(i).getIdMundo()+"', 'idPersonaje':'"+datos.get(i).getIdPersonaje();
            }
        }
        return resultado += "]";
    }
    
    @GET
    @Override
    @Produces({"application/json"})
    public List<Log> findAll() {
        Log log = new Log();
        List<Log> list = new ArrayList<>();
        list.add(log);
        return list;
    }
    
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Log> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }
    
    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public LogFacadeREST() {
        super(Log.class);
    }
    
}
