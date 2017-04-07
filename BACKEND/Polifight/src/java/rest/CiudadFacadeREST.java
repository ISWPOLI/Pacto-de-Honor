/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import entitities.Ciudad;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * Servicio REST para la entidad Ciudad
 * @author jrubiaob
 */
@Stateless
@Path("ciudad")
public class CiudadFacadeREST extends AbstractFacade<Ciudad> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public CiudadFacadeREST() {
        super(Ciudad.class);
    }
    
    /**
     * Crea un dato Ciudad
     * Probado con el recurso "Crear"
     * @param entity 
     */
    @POST
    @Override
    @Path("create")
    @Consumes({"application/json"})
    public void create(Ciudad entity) {
        super.create(entity);
    }

    /**
     * Edita un campo de acuerdo al id enviado
     * Probado con el recurso "Editar"
     * @param entity 
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    public void edit(Ciudad entity) {
        Ciudad ciudad = super.find(entity.getIdCiudad());
        System.err.println("ID -> ");
        ciudad.setNombreCiudad(entity.getNombreCiudad());
        super.edit(ciudad);
    }
    
    /**
     * Busca un dato de acuerdo al id enviado
     * Probado con el recurso "Buscar"
     * @param id
     * @return 
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public Ciudad find(@QueryParam("id") Integer id) {
        return super.find(id);
    }

    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Probado con el recurso "Ciudad"
     * @return List<Ciudad>
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Ciudad> findAll() {
        return super.findAll();
    }

    /**
     * Retorna de acuerdo alrango envidado, donde 0 es el primer dato
     * Probado con el recurso "BuscaPorRango"
     * @param from
     * @param to
     * @return 
     */
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Ciudad> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }
    
    /**
     * Retorna el número de datos contenido en la tabla
     * Probado con el recurso "NoDatos"
     * @return 
     */
    @GET
    @Path("count")
    @Produces({"application/json"})
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
