<<<<<<< HEAD

package rest;

import entities.Imagen;
import java.io.PrintWriter;
import java.io.StringWriter;
=======
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.poder.Restful.PH.service;

import com.poder.Restful.PH.Imagen;
>>>>>>> 06b43fe11dc9f6596399ecfcf3e5ea6c342dc7b3
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
<<<<<<< HEAD
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * Servicio para la entidad Imagen
 * @author jrubiaob
 */
@Stateless
@Path("imagen")
public class ImagenFacadeREST extends AbstractFacade<Imagen> {
    @PersistenceContext(unitName = "PolifightPU")
=======
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 *
 * @author ahsierra
 */
@Stateless
@Path("com.poder.restful.ph.imagen")
public class ImagenFacadeREST extends AbstractFacade<Imagen> {
    @PersistenceContext(unitName = "Restful.PHPU")
>>>>>>> 06b43fe11dc9f6596399ecfcf3e5ea6c342dc7b3
    private EntityManager em;

    public ImagenFacadeREST() {
        super(Imagen.class);
    }

<<<<<<< HEAD
    /**
     * Crea un dato
     * Se prueba con el TestCase "Crear" del proyecto Imagen-soapui-project
     * @param entity entidad Imagen
     * @return String con la respuesta OK o la excepción
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearImagen(Imagen entity) {
        String resultado;
        try{
            em.persist(entity);   
            resultado = "{'response':'OK']";
        }catch (Exception e){
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            resultado = "{'response':'KO', 'cause':'"+errors.toString()+"'}";
        }
        return resultado;
    }

   /**
     * Edita un dato de acuerdo al id enviado
     * Se prueba con el TestCase "Editar" del proyecto Imagen-soapui-project
     * @param entity entidad Imagen
     * @return mensaje satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarImagen(Imagen entity){
        try{
            if(entity.getIdImagen()!= 0 && entity.getIdImagen()!= null){
                Imagen imagen = super.find(entity.getIdImagen());
                if(imagen == null){
                   return "{'response':'KO','cause':'Image not found'}";
                }else{
                    if(entity.getFoto()!= null)  imagen.setFoto(entity.getFoto());
                    
                    em.merge(imagen);

                    return "{'response':'OK'}";
                }

            }else{
                return "{'response':'KO','cause':'Not send Id'}";
            }
            
        }catch (Exception e){
            return "{'response':'KO','cause':'Exception'}";
        }
       
    }    
        
    /**
     * Busca una imagen de acuerdo al id
     * Se prueba con el TestCase "Buscar" del proyecto Imagen-soapui-project
     * @param id del Imagen a buscar
     * @return Imagen entidad del Imagen
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        Imagen imagen = em.find(Imagen.class, id);
        if(imagen == null){
            return "{'response':'KO','cause':'Imagen not found'}";
        }else{
            return "{'idImagen':'"+imagen.getIdImagen()+"', 'foto':'"+imagen.getFoto()+"'}";
        }        
    }
    
    /**
     * Lista todos las imagenes de la base de datos
     * Se prueba con el TestCase "Listar" del proyecto Imagen-soapui-project
     * @return List con todos las Imagenes registradas
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Imagen> findAll() {
        return super.findAll();
    }
    
    /**
     * Retorna el número de datos que están en la base de datos
     * Se prueba con el TestCase "NoDatos" del proyecto Imagen-soapui-project
     * @return NoDatos
     */
=======
    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Imagen entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, Imagen entity) {
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
    public Imagen find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Imagen> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Imagen> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

>>>>>>> 06b43fe11dc9f6596399ecfcf3e5ea6c342dc7b3
    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }
<<<<<<< HEAD
    
=======
>>>>>>> 06b43fe11dc9f6596399ecfcf3e5ea6c342dc7b3

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
