/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import Entidades.Frase;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import rest.AbstractFacade;

/**
 *
 * @author Will
 */


@Stateless
@Path("Frases")
public class FraseFacadeREST extends AbstractFacade<Frase> {

    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    

    public FraseFacadeREST() {
        super(Frase.class);
    }
    
    
     /**
     * Crea un dato Frase
     *
     * @param entity Entidad Frase
     * @return String con informacion de satisfactorio o error en creación
     */

    @POST
    @Path("create")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String crearFrase(Frase entity) {

        String respuesta;
        try {
            em.persist(entity);
            respuesta = "{'response':'Ok'}";
        } catch (Exception e) {
            StringWriter error = new StringWriter();
            e.printStackTrace(new PrintWriter(error));
            respuesta = "{'response':'KO', 'cause':'" + error.toString() + "'}";
        }
        return respuesta;

    }
    
    /**
     * Editar un dato Frase
     *
     * @param entity Entidad Frase
     * @return String con informacion de satisfactorio o error en creacion
     */
    
    @POST
    @Path("edit")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String editarFrase(Frase entity) {
        String respuesta = null;

        try {
            if (entity.getIdFrase() != 0 && entity.getDescripcion() != null) {

                Frase frase = new Frase();
                frase = super.find(entity.getIdFrase());
                if (frase == null) {
                    return "{'response':'KO','cause':'the sentences  not found'}";
                } else {
                    if (entity.getIdFrase() != 0) {
                        frase.setIdFrase(entity.getIdFrase());
                    }
                    if (entity.getDescripcion() != null) {
                        frase.setDescripcion(entity.getDescripcion());
                    }
                    em.merge(frase);
                    respuesta = "{'response':'OK'}";
                }
            } else {
                respuesta = "{'response':'KO','cause':'the sentences not found '}";
            }
        } catch (Exception e) {

            respuesta = "{'response':'KO','cause':'Exception'}";
        }
        return respuesta;
    }
    /**
     * Busca un dato por un parametro
     *
     * @param Integer id parametro de busqueda
     * @return String si es satisfactorio genera la informacion si no error
     */
    
    

    @GET
    @Path("find")
    @Produces({MediaType.APPLICATION_JSON})
    public String find(@QueryParam("id") Integer id) {
        Frase frase = em.find(Frase.class, id);
        

        String respuesta;
        if (frase != null) {

            respuesta = "{'idMundo':'" + frase.getIdFrase() + "', 'nombreMundo':'" + frase.getDescripcion() + "'}";
        } else {
            respuesta = "{'response':'KO','cause':'World is  not found'}";
        }
        return respuesta;
    }
    
    /**
     * Lista todos los datos Frase
     *
     * @return String si es satisfactorio genera la informacion si no error
     */
    
    
    
    @GET
    @Path("listFrases")
    @Produces({MediaType.APPLICATION_JSON})
    public String ListarFrases (){
        
        
        String resultado ="[";
        String query1= "SELECT p FROM Frase p";
        
        try {
            
            TypedQuery<Frase> consultaFrase = em.createQuery(query1, Frase.class);
            List<Frase> forfrase = consultaFrase.getResultList();
            
            for (int i = 0 ; i <forfrase.size();i++){
                
                resultado +="{";
                if(i == forfrase.size()-1){
                     resultado += "'idFrase':'" + forfrase.get(i).getIdFrase() + "', 'descripcion':'" + forfrase.get(i).getDescripcion();
                }else{
                    resultado += "'idFrase':'" + forfrase.get(i).getIdFrase() + "', 'descripcion':'" + forfrase.get(i).getDescripcion();
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            StringWriter error = new StringWriter();
            e.printStackTrace(new PrintWriter(error));
            resultado = "{'response':'KO', 'cause':'" + error.toString() + "'}";
        }
        return resultado;
        
    }
    
     @GET
    @Override
    @Produces({"application/json"})
    public List<Frase> findAll() {
        Frase frase = new Frase();
        List<Frase> fra = new ArrayList<>();
        frase.setIdFrase(0);
        frase.setDescripcion("0");
        fra.add(frase);
        return fra;
    }
    
    
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Frase> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }
}