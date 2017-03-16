/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import entidades.PreguntaPsicotecnica;
import entidades.PreguntaPsicotecnicaPK;
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
@Path("entidades.preguntapsicotecnica")
public class PreguntaPsicotecnicaFacadeREST extends AbstractFacade<PreguntaPsicotecnica> {
    @PersistenceContext(unitName = "PoliFigthPU")
    private EntityManager em;

    private PreguntaPsicotecnicaPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idPreguntaPsicotecnica=idPreguntaPsicotecnicaValue;idRespuestaPsicotecnica=idRespuestaPsicotecnicaValue;idTipoPreguntaPsicotecnica=idTipoPreguntaPsicotecnicaValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        entidades.PreguntaPsicotecnicaPK key = new entidades.PreguntaPsicotecnicaPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idPreguntaPsicotecnica = map.get("idPreguntaPsicotecnica");
        if (idPreguntaPsicotecnica != null && !idPreguntaPsicotecnica.isEmpty()) {
            key.setIdPreguntaPsicotecnica(new java.lang.Integer(idPreguntaPsicotecnica.get(0)));
        }
        java.util.List<String> idRespuestaPsicotecnica = map.get("idRespuestaPsicotecnica");
        if (idRespuestaPsicotecnica != null && !idRespuestaPsicotecnica.isEmpty()) {
            key.setIdRespuestaPsicotecnica(new java.lang.Integer(idRespuestaPsicotecnica.get(0)));
        }
        java.util.List<String> idTipoPreguntaPsicotecnica = map.get("idTipoPreguntaPsicotecnica");
        if (idTipoPreguntaPsicotecnica != null && !idTipoPreguntaPsicotecnica.isEmpty()) {
            key.setIdTipoPreguntaPsicotecnica(new java.lang.Integer(idTipoPreguntaPsicotecnica.get(0)));
        }
        return key;
    }

    public PreguntaPsicotecnicaFacadeREST() {
        super(PreguntaPsicotecnica.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(PreguntaPsicotecnica entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") PathSegment id, PreguntaPsicotecnica entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        entidades.PreguntaPsicotecnicaPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public PreguntaPsicotecnica find(@PathParam("id") PathSegment id) {
        entidades.PreguntaPsicotecnicaPK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<PreguntaPsicotecnica> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<PreguntaPsicotecnica> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
