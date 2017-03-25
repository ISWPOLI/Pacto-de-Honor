/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.service;

import com.entidades.Mundo;
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
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Will
 */
@Stateless
@Path("com.entidades.mundo")
public class MundoFacadeREST extends AbstractFacade<Mundo> {
    @PersistenceContext(unitName = "PoliFigthPU")
    private EntityManager em;

    public MundoFacadeREST() {
        super(Mundo.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Mundo entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, Mundo entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public Mundo find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Mundo> findAll() {
        return super.findAll();
    }
    
    
     @GET 
    @Path("buscarall")
    @Produces(MediaType.APPLICATION_JSON)
   public java.util.List<Mundo> getAllhumano(){
        List<Mundo> humano = findAll();
        
        if(humano== null || humano.size()== 0){
            throw new WebApplicationException(404);
        }
       
        return humano;
    }
    

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Mundo> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
