package rest;

import entities.Jugador;
import entities.Mundo;
import entities.Nivel;
import entities.Usuario;
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

/**
 * Servicio REST para la entidad Jugador
 * @author jrubiaob
 */
@Stateless
@Path("jugador")
public class JugadorFacadeREST extends AbstractFacade<Jugador> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public JugadorFacadeREST() {
        super(Jugador.class);
    }
    
  
    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Jugador entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, Jugador entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    /**
     * Método que retorna la estructura solicitada en el issue #455
     * @param id
     * @return 
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String buscarJugador(@QueryParam("id") Integer id, @QueryParam("token") String token) {
         String resultado = "{";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               Jugador jugador = em.find(Jugador.class, id);
               Nivel nivel = em.find(Nivel.class, jugador.getIdNivel());
               Mundo mundo = em.find(Mundo.class, nivel.getMundo());
               if(jugador == null){
                   resultado = "{'response':'KO','cause':'Jugador not found'}";
               }else{
                   resultado +=  "'idJugador':'"+jugador.getIdJugador()+"', 'nickname':'"+jugador.getNickname()+"', "
                           + "'avatar':'', 'mundo':'"+mundo.getNombreMundo()+"', 'nivel':'"+jugador.getIdNivel().getNombreNivel()+"',"
                           + "'monedas':'"+jugador.getMonedaJugador()+"', 'experiencia':'"+jugador.getExperienciaJugador()+"'";
               }
           }else{
             resultado = "{'response':'KO', 'cause':'Invalid token'}";
           }
        }catch (Exception e){
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return resultado += "}";
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Jugador> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Jugador> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
