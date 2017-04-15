package rest;

import entitities.RolUsuario;
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
 * Servicio REST para la entidad RolUsuario
 * @author jrubiaob
 */

@Stateless
@Path("rolusuario")
public class RolUsuarioFacadeREST extends AbstractFacade<RolUsuario> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public RolUsuarioFacadeREST() {
        super(RolUsuario.class);
    }

     /**
     * Crea un dato RolUsuario
     * Se prueba con el TestCase "Crear" del proyecto RolUsuario-soapui-project
     * @param entity Entidad RolUsuario
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearRol(RolUsuario entity) {
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
     * Se prueba con el TestCase "Editar" del proyecto RolUsuario-soapui-project
     * @param entity Entidad RolUsuario
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarRol(RolUsuario entity){
        try{
            if(entity.getIdRolUsuario()!= 0 && entity.getIdRolUsuario()!= null){
                RolUsuario rolUsuario = super.find(entity.getIdRolUsuario());
                if(rolUsuario == null){
                   return "{'response':'KO','cause':'Rol not found'}";
                }else{
                    if(entity.getTipoUsuario()!= null)  rolUsuario.setTipoUsuario(entity.getTipoUsuario());
                    
                    em.merge(rolUsuario);

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
     * Se prueba con el TestCase "Buscar" del proyecto RolUsuario-soapui-project
     * @param id del RolUsuario a buscar
     * @return String con la entity RolUsuario
     */
   @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        RolUsuario rolUsuario = em.find(RolUsuario.class, id);
        if(rolUsuario == null){
            return "{'response':'KO','cause':'Rol not found'}";
        }else{
            return "{'idRolUsuario':'"+rolUsuario.getIdRolUsuario()+"', 'tipoUsuario':'"+rolUsuario.getTipoUsuario()+"'}";
        }        
    }

    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "Ciudad" del proyecto RolUsuario-soapui-project
     * @return List de todos los Roles
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<RolUsuario> findAll() {
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
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<RolUsuario> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
