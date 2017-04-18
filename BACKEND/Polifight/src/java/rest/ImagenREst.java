/*
 * @author William tautiva
 */
package rest.services;

import Entidades.Imagen;
import Entidades.sessiones.ImagenFacade;
import java.util.List;
import javafx.scene.media.Media;
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
@Path("Imagen")
public class ImagenREst {

    @EJB
    private ImagenFacade ejbImagenFacade;

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<Imagen> findALL() {
        return ejbImagenFacade.findAll();

    }

    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    public void create(Imagen imagen) {
        ejbImagenFacade.create(imagen);

    }

    @PUT
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void edit(@PathParam("id") Integer id, Imagen imagen) {

        ejbImagenFacade.edit(imagen);
    }

    @DELETE
    @Consumes({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public void remmove(@PathParam("id") Integer id) {
        ejbImagenFacade.remove(ejbImagenFacade.find(id));
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    @Path("{id}")
    public Imagen findByid (@PathParam("id")Integer id ){
        
        return ejbImagenFacade.find(id);
    }
    
    

}
