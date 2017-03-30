/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.poli.service;

import co.edu.poli.entidades.Jugador;
import co.edu.poli.entidades.JugadorPK;
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
@Path("/jugador")
public class JugadorFacadeREST extends AbstractFacade<Jugador> {
    @PersistenceContext(unitName = "PoliFigthPU")
    private EntityManager em;

    private JugadorPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idJugador=idJugadorValue;idNivel=idNivelValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        co.edu.poli.entidades.JugadorPK key = new co.edu.poli.entidades.JugadorPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idJugador = map.get("idJugador");
        if (idJugador != null && !idJugador.isEmpty()) {
            key.setIdJugador(new java.lang.Integer(idJugador.get(0)));
        }
        java.util.List<String> idNivel = map.get("idNivel");
        if (idNivel != null && !idNivel.isEmpty()) {
            key.setIdNivel(new java.lang.Integer(idNivel.get(0)));
        }
        return key;
    }

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
    public void edit(@PathParam("id") PathSegment id, Jugador entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        co.edu.poli.entidades.JugadorPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public Jugador find(@PathParam("id") PathSegment id) {
        co.edu.poli.entidades.JugadorPK key = getPrimaryKey(id);
        return super.find(key);
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
