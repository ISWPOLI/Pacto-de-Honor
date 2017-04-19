package rest;

import entities.Ciudad;
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
     * Se prueba con el TestCase "Crear" del proyecto Ciudad-soapui-project
     * @param entity Entidad Ciudad
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearImagen(Ciudad entity) {
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
     * Edita un campo de acuerdo al id enviado
     * Se prueba con el TestCase "Editar" del proyecto Ciudad-soapui-project
     * @param entity Entidad Ciudad
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarImagen(Ciudad entity){
        try{
            if(entity.getIdCiudad()!= 0 && entity.getIdCiudad()!= null){
                Ciudad ciudad = super.find(entity.getIdCiudad());
                if(ciudad == null){
                   return "{'response':'KO','cause':'City not found'}";
                }else{
                    if(entity.getNombreCiudad()!= null)  ciudad.setNombreCiudad(entity.getNombreCiudad());
                    
                    em.merge(ciudad);

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
     * Busca un dato de acuerdo al id enviado
     * Se prueba con el TestCase "Buscar" del proyecto Ciudad-soapui-project
     * @param id de la ciudad a buscar
     * @return String con la entity Ciudad
     */
   @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        Ciudad ciudad = em.find(Ciudad.class, id);
        if(ciudad == null){
            return "{'response':'KO','cause':'City not found'}";
        }else{
            return "{'idCiudad':'"+ciudad.getIdCiudad()+"', 'nombreCiudad':'"+ciudad.getNombreCiudad()+"'}";
        }        
    }

    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "Ciudad" del proyecto Ciudad-soapui-project
     * @return List de todas las Ciudades
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Ciudad> findAll() {
        return super.findAll();
    }

    /**
     * Retorna de acuerdo alrango envidado, donde 0 es el primer dato
     * Se prueba con el TestCase "BuscarPorRango" del proyecto Ciudad-soapui-project
     * @param from desde el id
     * @param to hasta el id
     * @return List con las ciudades
     */
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Ciudad> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        //if(from < super.count() && (to < from && to <= super.count())){
            return super.findRange(new int[]{from, to});        
    }
    
    /**
     * Retorna el número de datos contenido en la tabla
     * Se prueba con el TestCase "NoDatos" del proyecto Ciudad-soapui-project
     * @return String con el número de datos
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
