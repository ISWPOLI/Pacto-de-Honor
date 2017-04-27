/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import Entidades.Imagen;
import com.sun.xml.bind.xmlschema.StrictWildcardPlug;
import Entidades.Mundo;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 * Servivio para la entidad Mundo 
 * @author Will
 * 
 */
@Stateless
@Path("mundo")
public class MundoFacadeREST extends AbstractFacade<Mundo> {
    @PersistenceContext(unitName = "PoliFightPU")
    private EntityManager em;

     @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MundoFacadeREST() {
        super(Mundo.class);
    }
    
    /**
    *  Crea un dato mundo 
    * @param entity Entidad Mundo
    * @return String con informacion de satisfactorio o error en creacion
    */
    
    @POST
    @Path("create")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String crearUsiario(Mundo entity) {
        String respuesta;
        try {
            em.persist(entity);
            respuesta = "{'response':'Ok'}";
        } catch (Exception e) {
            e.printStackTrace();
            StringWriter error = new StringWriter();
            e.printStackTrace(new PrintWriter(error));
            respuesta =  "{'response':'KO', 'cause':'"+error.toString()+"'}";

        }
        return respuesta;

    }
    
    
    /**
    *  Editar un dato mundo
    * @param entity Entidad Mundo
    * @return String con informacion de satisfactorio o error en creacion
    */
    
    @POST
    @Path("edit")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String editarMundo(Mundo entity) {
        String respuesta = null;
        try {

            if (entity.getIdMundo() != 0) {
                Mundo mundo = new Mundo();

                mundo = super.find(entity.getIdMundo());
                if (mundo != null) {

                } else {

                    if (entity.getIdMundo() != 0) {
                        mundo.setIdMundo(entity.getIdMundo());
                    }
                    if (entity.getNombreMundo() != null) {
                        mundo.setNombreMundo(entity.getNombreMundo());
                    }
                    em.merge(mundo);
                    respuesta = "{'response':'OK'}";
                    
                }
            } else {
                respuesta = "{'response':'KO','cause':'no se envia id'}";
                
            }

        } catch (Exception e) {
            respuesta = "{'response':'KO','cause':'Exception'}";
            

        }
        
        return respuesta;

    }
    
    /**
    *  Busca  un dato por un parametro 
    * @param Integer id parametro de busqueda 
    * @return String si es satisfactorio genera la informacion si no error 
    */
    
    @GET
    @Path("find")
    @Produces({MediaType.APPLICATION_JSON})
     
    public String find (@QueryParam("id")Integer id){
        Mundo mundo = em.find(Mundo.class, id);
        Imagen imagen =em.find(Imagen.class, id);
        
        String respuesta ;
        if (mundo != null){
            
            respuesta = "{'idMundo':'"+mundo.getIdMundo() +"', 'nombreMundo':'"+mundo.getNombreMundo()+"', 'foto':'"+imagen.getFoto() +"'}";
        }else{
            respuesta = "{'response':'KO','cause':'City not found'}";
       }
        
        return respuesta;
    }
    
    /**
    *  Lista todos los datos Mundo 
    * @return String si es satisfactorio genera la informacion si no error 
    */
    
    @GET
    @Path("listMundo")
    @Produces({MediaType.APPLICATION_JSON})
    public String listarMundo(){
        
       String resultado = "[";
       //Query query = em.createNamedQuery("SELECT h FROM Mundo h");
       //
       String query1 = "SELECT p FROM Mundo p"; 
       String query2 = "SELECT s FROM Imagen s";
        TypedQuery<Mundo> consultaMundo=em.createQuery(query1,Mundo.class);
        List <Mundo> formundos = consultaMundo.getResultList();
        
        TypedQuery<Imagen> consultaImagen=em.createQuery(query2,Imagen.class);
         List <Imagen> forimagen = consultaImagen.getResultList();
        
        
        try {
                       
                   
            for (int i =0; i < formundos.size();i++) {
            resultado += "{";
            if (i == formundos.size()-1 ){
                
                resultado += "'idMundo':'"+formundos.get(i).getIdMundo()+"', 'nombreMundo':'"+formundos.get(i).getNombreMundo()+"', 'foto':'"+ forimagen.get(i).getFoto() ;
            }else{
                resultado += "'idMundo':'"+formundos.get(i).getIdMundo()+"', 'nombreMundo':'"+formundos.get(i).getNombreMundo()+"', 'foto':'"+ forimagen.get(i).getFoto();
            }
        }
            
        } catch (Exception e) {
            
            e.printStackTrace();
       e.printStackTrace();
            StringWriter error = new StringWriter();
            e.printStackTrace(new PrintWriter(error));
            resultado =  "{'response':'KO', 'cause':'"+error.toString()+"'}";
        }
        
       
       return resultado;
    }
    
    
    
    
    @GET
    @Override
    @Produces({"application/json"})
    public List<Mundo> findAll() {
        return super.findAll();
    }
    
    
    
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Mundo> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
             return super.findRange(new int[]{from, to});        
    }
    
    

}
