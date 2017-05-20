package rest;

import entities.JugadorTieneLogros;
import entities.Usuario;
import java.util.LinkedList;
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
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Juan Lancheros
 */
@Stateless
@Path("logrosJugador")
public class JugadorTieneLogrosFacadeREST extends AbstractFacade<JugadorTieneLogros> {

    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public JugadorTieneLogrosFacadeREST() {
        super(JugadorTieneLogros.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(JugadorTieneLogros entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, JugadorTieneLogros entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public JugadorTieneLogros find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<JugadorTieneLogros> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<JugadorTieneLogros> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces(MediaType.TEXT_PLAIN)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public String logrosJugador(@QueryParam("token") String token) {
        String resultado = "";
        Query queryToken = em.createNamedQuery("Usuario.findToken");
        queryToken.setParameter("token", token);
        try {
            Usuario user = (Usuario) queryToken.getSingleResult();
            if (user != null) {
                Query qLogros = em.createNamedQuery("JugadorTieneLogros.findByJugador");
                qLogros.setParameter("idJugaodr", user.getIdUsuario());
                try {
                    LinkedList<JugadorTieneLogros> jtl = (LinkedList<JugadorTieneLogros>) qLogros.getResultList();
                    if (jtl != null) {
                        resultado = "{\"message\": \"OK\",\"Logros\":[ ";
                        for (JugadorTieneLogros jugadorTieneLogros : jtl) {
                            resultado +="{\"idLogro\":\""+jugadorTieneLogros.getIdLogro()+"\"},";
                        }
                        resultado+="}";
                        
                    }
                } catch (Exception l) {
                    resultado = "\"response\":\"KO\",\"Cause\":\"there is no achievments for this player\"";
                }
            } else {
                resultado = "\"response\":\"KO\",\"Cause\":\"invalid token\"";
            }
        } catch (Exception e) {
            resultado = "\"response\":\"KO\",\"Cause\":\"invalid token\"";
        }
        return resultado;

    }

}
