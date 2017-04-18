package rest;

import entitities.Ciudad;
import entitities.Pais;
import entitities.RolUsuario;
import entitities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import java.util.UUID;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import mundo.FechaActual;

/**
 * Servicio REST para la entidad Usuario
 * @author jrubiaob
 */

@Stateless
@Path("usuario")
public class UsuarioFacadeREST extends AbstractFacade<Usuario> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public UsuarioFacadeREST() {
        super(Usuario.class);
    }

    /**
     * Crea un dato Usuario
     * Se prueba con el TestCase "Crear" del proyecto Usuario-soapui-project
     * @param entity Entidad Usuario
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearUsuario(Usuario entity) {
        String resultado;
        try{
            entity.setFechaRegistro(FechaActual.timestamp());            
            em.persist(entity);   
            resultado = "{'response':'OK'}";
        }catch (Exception e){
            e.printStackTrace();
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            resultado = "{'response':'KO', 'cause':'"+errors.toString()+"'}";
        }
        return resultado;
    }

    /**
     * Edita un campo de acuerdo al id enviado
     * Se prueba con el TestCase "Editar" del proyecto Usuario-soapui-project
     * @param entity Entidad Usuario
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarUsuario(Usuario entity){
        try{
            if(entity.getIdUsuario() != 0){
                Usuario usuario = super.find(entity.getIdUsuario());
                if(usuario == null){
                   return "{'response':'KO','cause':'User not found'}";
                }else{
                    if(entity.getIdPais() != 0)  usuario.setIdPais(entity.getIdPais());
                    if(entity.getIdCiudad() != 0) usuario.setIdCiudad(entity.getIdCiudad());
                    if(entity.getIdRolUsuario() != 0) usuario.setIdRolUsuario(entity.getIdRolUsuario());
                    if(entity.getNombreUsuario() != null) usuario.setNombreUsuario(entity.getNombreUsuario());
                    if(entity.getApellidoUsuario() != null) usuario.setApellidoUsuario(entity.getApellidoUsuario());
                    if(entity.getEmailUsuario() != null) usuario.setEmailUsuario(entity.getEmailUsuario());
                    
                    
                    em.merge(usuario);

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
     * Se prueba con el TestCase "Buscar" del proyecto Usuario-soapui-project
     * @param id del Usuario a buscar
     * @return String con la entity Usuario
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        Usuario usuario = em.find(Usuario.class, id);       
        if(usuario == null){
            return "{'response':'KO','cause':'User not found'}";
        }else{
            RolUsuario rol = em.find(RolUsuario.class, usuario.getIdRolUsuario());
            Pais pais = em.find(Pais.class, usuario.getIdPais());
            Ciudad ciudad = em.find(Ciudad.class, usuario.getIdCiudad());
            return "{'idUsuario':'"+usuario.getIdUsuario()+"', 'nombrePais':'"+pais.getNombrePais()+"', 'nombreCiudad':'"+ciudad.getNombreCiudad()+"',"
                    + "'rolUsuario':'"+rol.getTipoUsuario()+"', 'apellido':'"+usuario.getApellidoUsuario()+"', 'email':'"+usuario.getEmailUsuario()+"',"
                    + " 'fechaRegistro':'"+usuario.getFechaRegistro()+"'}";
        }        
    }

    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "Usuario" del proyecto Usuario-soapui-project
     * @return List de todos los Usuarios
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Usuario> findAll() {
        return super.findAll();
    }
    
    @POST
    @Produces({"application/json"})
    @Consumes({"application/json"})
    public String login(@QueryParam("user") String usuario, @QueryParam("pass") String contrasena){
        String resultado;
        Query query = em.createQuery("SELECT u FROM Usuario u WHERE u.nombreUsuario=:x AND u.contrasenaUsuario=:password");
        query.setParameter("user", usuario);
        query.setParameter("password", contrasena);
        Usuario user = (Usuario) query.getSingleResult();
        if(user != null){
            resultado = "{'response':'OK'}";
            user.setToken(generateToken());
            user.setFechaToken(FechaActual.timestamp());
        }else{
            resultado = "{'response':'OK','cause':'User not found'}";
        }
        return resultado;
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
    public List<Usuario> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }
    
    /**
     * Crear un método para cambiar la contraseña de un usuario.
     * Debe recibir el id del usuario, la contraseña anterior, la nueva y un token 
     * de autorización
     */

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    private String generateToken(){
        return UUID.randomUUID().toString().toUpperCase().replaceAll("-", "").concat(FechaActual.timeToken());
    }
    
}
