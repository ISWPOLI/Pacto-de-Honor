package rest;

import entities.Pais;
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
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * Servicio REST para la entidad Pais
 * @author jrubiaob
 */
@Stateless
@Path("pais")
public class PaisFacadeREST extends AbstractFacade<Pais> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public PaisFacadeREST() {
        super(Pais.class);
    }

    /**
     * Crea un dato Pais
     * Se prueba con el TestCase "Crear" del proyecto Pais-soapui-project
     * @param entity Entidad Pais
     * @return String con el mensaje satisfactorio o insatisfactorio
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearPais(Pais entity) {
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
     * Se prueba con el TestCase "Editar" del proyecto Pais-soapui-project
     * @param entity Entidad Pais
     * @return JSON con el mensaje satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarPais(Pais entity){
        try{         
            if(entity.getIdPais()!= 0 && entity.getIdPais()!= null){
                Pais pais = super.find(entity.getIdPais());
                if(pais == null){
                   return "{'response':'KO','cause':'Country not found'}";
                }else{
                    if(entity.getNombrePais()!= null)  pais.setNombrePais(entity.getNombrePais());
                    
                    em.merge(pais);

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
     * Se prueba con el TestCase "Buscar" del proyecto Pais-soapui-project
     * @param id de la Pais a buscar
     * @return String con la entity Pais
     */
   @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        Pais pais = em.find(Pais.class, id);
        if(pais == null){
            return "{'response':'KO','cause':'Country not found'}";
        }else{
            return "{'idPais':'"+pais.getIdPais()+"', 'nombrePais':'"+pais.getNombrePais()+"'}";
        }        
    }

    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "Pais" del proyecto Pais-soapui-project
     * @return List de todos las Paises
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Pais> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Pais> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }

    /**
     * Retorna el número de datos contenido en la tabla
     * Se prueba con el TestCase "NoDatos" del proyecto Pais-soapui-project
     * @return String con el número de datos
     */
    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
