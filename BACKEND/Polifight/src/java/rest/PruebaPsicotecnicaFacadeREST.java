/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//Autor Andres Sierra
package rest;

import entities.PruebaPsicotecnica;
import entities.PruebaPsicotecnicaPK;
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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.PathSegment;

/**
 *
 * @author ahsierra
 */
@Stateless
@Path("entities.pruebapsicotecnica")
public class PruebaPsicotecnicaFacadeREST extends AbstractFacade<PruebaPsicotecnica> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    private PruebaPsicotecnicaPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idPruebaPsicotecnica=idPruebaPsicotecnicaValue;idTipoPrueba=idTipoPruebaValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        entities.PruebaPsicotecnicaPK key = new entities.PruebaPsicotecnicaPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idPruebaPsicotecnica = map.get("idPruebaPsicotecnica");
        if (idPruebaPsicotecnica != null && !idPruebaPsicotecnica.isEmpty()) {
            key.setIdPruebaPsicotecnica(new java.lang.Integer(idPruebaPsicotecnica.get(0)));
        }
        java.util.List<String> idTipoPrueba = map.get("idTipoPrueba");
        if (idTipoPrueba != null && !idTipoPrueba.isEmpty()) {
            key.setIdTipoPrueba(new java.lang.Integer(idTipoPrueba.get(0)));
        }
        return key;
    }

    public PruebaPsicotecnicaFacadeREST() {
        super(PruebaPsicotecnica.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(PruebaPsicotecnica entity) {
        super.create(entity);
    }

    @PUT
    @Path("updatePsycho")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePsycho(@PathParam("updatePsycho") PathSegment id, PruebaPsicotecnica entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        entities.PruebaPsicotecnicaPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public PruebaPsicotecnica find(@PathParam("id") PathSegment id) {
        entities.PruebaPsicotecnicaPK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<PruebaPsicotecnica> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<PruebaPsicotecnica> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("countPsycho")
    @Produces(MediaType.APPLICATION_JSON)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    @PUT
    @Path("createPsycho")
    @Consumes(MediaType.APPLICATION_JSON)
    public void createPsycho(PruebaPsicotecnica a) {
        super.create(a);
    }
    @GET
    @Path("findPsycho")
    @Produces(MediaType.APPLICATION_JSON)
    public PruebaPsicotecnica findPsycho(@PathParam("findPsycho") int id){
        List<PruebaPsicotecnica> a = findAllPsycho();
        PruebaPsicotecnica b = new PruebaPsicotecnica(); 
        for (int i = 0; i < a.size(); i++) {
            if(a.get(i).getPruebaPsicotecnicaPK().getIdPruebaPsicotecnica() == id){
                b = a.get(i);
            }
        }
        return b;
    }
    @GET
    @Path("findAllPsycho")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PruebaPsicotecnica> findAllPsycho() {
        return super.findAll();
    }

    @GET
    @Path("findPsychoByName")
    @Produces (MediaType.APPLICATION_JSON)
    public PruebaPsicotecnica findPsychoByName(@PathParam("findPsychoByName") String nombrePsy){
        List<PruebaPsicotecnica> a = findAllPsycho();
        PruebaPsicotecnica b = new PruebaPsicotecnica();
        for (int i = 0; i < a.size(); i++) {
            if(a.get(i).getNombre().equals(nombrePsy)){
                b = a.get(i);
            }
        }
        return b;
    }
}
