/*
 * @author William tautiva
 * 
 */
package rest.services;

import Entidades.Imagen;
import Entidades.Mundo;
import Entidades.sessiones.MundoFacade;
import java.util.List;
import javax.ejb.EJB;
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
public class MundoRest {
    
    @EJB
    private MundoFacade ejbMundoFacade;
    
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<Mundo> findALL() {
        return ejbMundoFacade.findAll();

    }

    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    public void create(Mundo mundo) {
        ejbMundoFacade.create(mundo);

    }

    @PUT
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void edit(@PathParam("id") Integer id, Mundo mundo) {

        ejbMundoFacade.edit(mundo);
    }

    @DELETE
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void remmove(@PathParam("id") Integer id) {
        ejbMundoFacade.remove(ejbMundoFacade.find(id));
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public Mundo findByid (@PathParam("id")Integer id ){
        
        return ejbMundoFacade.find(id);
    }
    
    
}
