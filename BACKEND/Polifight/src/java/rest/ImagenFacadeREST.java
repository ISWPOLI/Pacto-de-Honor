
package rest;

import entities.Imagen;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
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
    private EntityManager em;

    public ImagenFacadeREST() {
        super(Imagen.class);
    }

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
