/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import entities.Jugador;
import entities.PruebaPsicotecnicaFactores;
import entities.RespuestaPreguntasPsicotecnicas;
import entities.RespuestaPruebaJugador;
import entities.Usuario;
import java.util.Arrays;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import mundo.FactorPsicotecnico;

/**
 *
 * @author nimartinezma
 */
@Stateless
@Path("respuestapruebajugador")
public class RespuestaPruebaJugadorFacadeREST extends AbstractFacade<RespuestaPruebaJugador> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public RespuestaPruebaJugadorFacadeREST() {
        super(RespuestaPruebaJugador.class);
    }
    
    /**
     * Busca un jugaddor de acuerdo al id
     * Se prueba con el TestCase "Buscar" del proyecto Personaje-soapui-project
     * @param id del Jugador a buscar
     * @param token String con el token que se otorgo en el login
     * @return Un vector que indica la cantidas de puntos obtenidos en cada factor 
     */
    @GET
    @Path("pointsFactors")
    @Produces({"application/json"})
    public String contarRespuestas(@QueryParam("id") Integer id, @QueryParam("token") String token) {
       String resultado = "{";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               Jugador jugador = em.find(Jugador.class, id);
               if(jugador == null){
                   resultado = "{'response':'KO','cause':'Invalid id'}";
               }else{
                   Query queryFactor = em.createNamedQuery("PruebaPsicotecnicaFactores.findAll");
                   List<PruebaPsicotecnicaFactores> listF = queryFactor.getResultList();
                   FactorPsicotecnico factores[]=new FactorPsicotecnico[listF.size()+1];
                   for (int i = 0; i < listF.size(); i++) {
                       factores[listF.get(i).getIdFactor()]=new FactorPsicotecnico(listF.get(i).getNombreFactor(),listF.get(i).getIdFactor(),listF.get(i).getPuntosTotales());
                   }
                    Query queryJugador = em.createNamedQuery("RespuestaPruebaJugador.findByIdJugador");
                    queryJugador.setParameter("idJugador", jugador.getIdJugador());
                    List<RespuestaPruebaJugador> listR = queryJugador.getResultList();
                    for (int i = 0; i < listF.size(); i++) {
                        
                       RespuestaPruebaJugador temporal=listR.get(i);
                       System.out.print(temporal.getIdRespuesta());
                       Query queryPregunta= em.createNamedQuery("RespuestaPreguntasPsicotecnicas.findAll");
                       //queryPregunta.setParameter("idRespuestaPsicotecnica", temporal.getIdRespuesta());      
                        //List<RespuestaPreguntasPsicotecnicas> listP=queryPregunta.getResultList();
                      //RespuestaPreguntasPsicotecnicas pregunta = (RespuestaPreguntasPsicotecnicas) queryPregunta.getParameters();
                       //factores[pregunta.getIdFactor()].getCount();
                   }
              
                    for (int i = 1; i < factores.length; i++) {
                        resultado += "{";
                    if(i == factores.length-1){
                        resultado += "\"idJugador\":\""+jugador.getIdJugador()+"\", \"idFactor\":\""+factores[i].getId()+
                                "\",\"nombreFactor\":\""+factores[i].getName()+"\", \"puntosFactor\":\""+factores[i].getCount()+"\"}";
                    }else{
                        resultado += "\"idJugador\":\""+jugador.getIdJugador()+"\", \"idFactor\":\""+factores[i].getId()+
                                "\",\"nombreFactor\":\""+factores[i].getName()+"\", \"puntosFactor\":\""+factores[i].getCount()+"\"},\n";
                    }  
                }
                resultado += "}";
               }  
           }else{ 
              resultado = "{'response':'KO', 'cause':'Invalid token'}";
           }
        }catch (Exception e){
             e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
             
         }
         return resultado;
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(RespuestaPruebaJugador entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, RespuestaPruebaJugador entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public RespuestaPruebaJugador find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<RespuestaPruebaJugador> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<RespuestaPruebaJugador> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
    
}