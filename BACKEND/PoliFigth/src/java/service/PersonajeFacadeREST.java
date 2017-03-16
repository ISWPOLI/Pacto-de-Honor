/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import entidades.Personaje;
import entidades.PersonajePK;
import java.util.List;
import javax.ejb.Stateless;
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
import javax.ws.rs.core.PathSegment;

/**
 *
 * @author Will
 */
@Stateless
@Path("entidades.personaje")
public class PersonajeFacadeREST extends AbstractFacade<Personaje> {
    @PersistenceContext(unitName = "PoliFigthPU")
    private EntityManager em;

    private PersonajePK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idPersonaje=idPersonajeValue;idCategoria=idCategoriaValue;idImagen=idImagenValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        entidades.PersonajePK key = new entidades.PersonajePK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idPersonaje = map.get("idPersonaje");
        if (idPersonaje != null && !idPersonaje.isEmpty()) {
            key.setIdPersonaje(new java.lang.Integer(idPersonaje.get(0)));
        }
        java.util.List<String> idCategoria = map.get("idCategoria");
        if (idCategoria != null && !idCategoria.isEmpty()) {
            key.setIdCategoria(new java.lang.Integer(idCategoria.get(0)));
        }
        java.util.List<String> idImagen = map.get("idImagen");
        if (idImagen != null && !idImagen.isEmpty()) {
            key.setIdImagen(new java.lang.Integer(idImagen.get(0)));
        }
        return key;
    }

    public PersonajeFacadeREST() {
        super(Personaje.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Personaje entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") PathSegment id, Personaje entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        entidades.PersonajePK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public Personaje find(@PathParam("id") PathSegment id) {
        entidades.PersonajePK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Personaje> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Personaje> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
