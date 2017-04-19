/*
 * @author William tautiva
 * 
 */
package rest;

import entities.Mundo;
import java.util.List;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Will
 */
@Path("Mundo")
public class MundoRest extends AbstractFacade<Mundo>{
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public MundoRest(Class<Mundo> entityClass) {
        super(entityClass);
    }
        
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<Mundo> findALL() {
        return super.findAll();

    }

    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    public void create(Mundo mundo) {
        super.create(mundo);

    }

    @PUT
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void edit(@PathParam("id") Integer id, Mundo mundo) {

        super.edit(mundo);
    }

    @DELETE
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void remmove(@PathParam("id") Integer id) {
        super.remove(em.find(Mundo.class, id));
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public Mundo findByid (@PathParam("id")Integer id ){        
        return em.find(Mundo.class, id);
    }

    @Override
    protected EntityManager getEntityManager() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
