package rest;

import entities.Ciudad;
import entities.Pais;
import entities.RolUsuario;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
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
     * Se prueba con el TestCase "Listar" del proyecto Usuario-soapui-project
     * @return String con todos los Usuarios
     */    
    @GET
    @Path("listUsers")
    @Produces({"application/json"})
    public String listarUsuario(){
        String resultado = "[";
        Query query = em.createQuery("SELECT u FROM Usuario u");
        List<Usuario> datos = query.getResultList();
        for (int i = 0; i < datos.size(); i++) {
            resultado += "{";
            if(i == datos.size()-1){
                resultado += "'idUsuario':'"+datos.get(i).getIdUsuario()+"', 'pais':'"+em.find(Pais.class, datos.get(i).getIdPais()).getNombrePais()+
                        "', 'ciudad':'"+em.find(Ciudad.class, datos.get(i).getIdCiudad()).getNombreCiudad()+"', 'rol':'"+em.find(RolUsuario.class, datos.get(i).getIdRolUsuario()).getTipoUsuario()+
                        "', 'nombreUsuario':'"+ datos.get(i).getNombreUsuario()+"', 'apellidoUsuario':'"+datos.get(i).getApellidoUsuario()+"', 'emailUsuario':'"+
                        datos.get(i).getEmailUsuario()+"', " + "'fechaRegistro':'"+datos.get(i).getFechaRegistro()+"'}";
            }else{
                resultado += "'idUsuario':'"+datos.get(i).getIdUsuario()+"', 'pais':'"+em.find(Pais.class, datos.get(i).getIdPais()).getNombrePais()+
                        "', 'ciudad':'"+em.find(Ciudad.class, datos.get(i).getIdCiudad()).getNombreCiudad()+"', 'rol':'"+em.find(RolUsuario.class, datos.get(i).getIdRolUsuario()).getTipoUsuario()+
                        "', 'nombreUsuario':'"+ datos.get(i).getNombreUsuario()+"', 'apellidoUsuario':'"+datos.get(i).getApellidoUsuario()+"', 'emailUsuario':'"+
                        datos.get(i).getEmailUsuario()+"', " + "'fechaRegistro':'"+datos.get(i).getFechaRegistro()+"'},";
            }
        }
        return resultado += "]";
    }
            
    @GET
    @Override
    @Produces({"application/json"})
    public List<Usuario> findAll() {
        Usuario usuario = new Usuario();
        List<Usuario> list = new ArrayList<>();
        list.add(usuario);
        return list;
    }
    
    /**
     * Método que valida si un usuario se encuentra registrado 
     * @param usuario nombre del usuario
     * @param contrasena contraseña del usuario
     * @return String con la respuesta satisfactoria o inválida
     */
    @POST
    @Path("login")
    @Produces({"application/json"})
    @Consumes({"application/json"})
    public String login(@QueryParam("user") String usuario, @QueryParam("pass") String contrasena){
        String resultado = "";
        System.out.println(usuario);
        System.out.println(contrasena);
        if(usuario != null&& contrasena != null){
            Query query = em.createNamedQuery("Usuario.login");
            query.setParameter("user", usuario);
            query.setParameter("password", contrasena);
            try{
                Usuario user = (Usuario) query.getSingleResult();
                if(user != null){                    
                    user.setToken(generateToken());
                    user.setFechaToken(FechaActual.timestamp());
                    em.merge(user);
                    resultado = "{'response':'OK', 'token':'"+user.getToken()+"'}";
                }else{
                    resultado = "{'response':'OK','cause':'User not found'}";
                }
            }catch (Exception e){
                resultado = "{'response':'OK','cause':'Unregistered user'}";
            }
            
        }else if(usuario == null){
            resultado = "{'response':'KO', 'cause':'Field user is empty'}";
        }else if(contrasena == null){
            resultado = "{'response':'KO', 'cause':'Field pass is empty'}";
        }
        if(usuario == null && contrasena == null){
            resultado = "{'response':'KO', 'cause':'Field pass and user is empty'}";
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
    
    /**
     * Método que genera el token para el consumo de los servicios.
     * @return 
     */
    private String generateToken(){
        return UUID.randomUUID().toString().toUpperCase().replaceAll("-", "").concat(FechaActual.timeToken());
    }
}
