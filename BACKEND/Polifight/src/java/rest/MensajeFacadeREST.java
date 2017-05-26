package rest;

import entities.Mensaje;
import entities.Personaje;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * Servicio para la entidad "Mensaje"
 * @author jrubiaob
 */
@Stateless
@Path("entities.mensaje")
public class MensajeFacadeREST extends AbstractFacade<Mensaje> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public MensajeFacadeREST() {
        super(Mensaje.class);
    }

    /**
     * Crea un dato
     * Se prueba con el TestCase "Crear" del proyecto Mensaje-soapui-project
     * @param token String correspondiente al token que se otorgo en el login
     * @param entity entidad Mesaje
     * @return String con la respuesta OK o la excepción
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearMensaje(@QueryParam("token") String token, Mensaje entity) {
        String resultado;
        try{
            Query query = em.createNamedQuery("Usuario.findToken");
            query.setParameter("token", token);
            Usuario user = (Usuario) query.getSingleResult();
            if(user != null){
                em.persist(entity);   
                resultado = "{'response':'OK'}";
            }else{
                resultado = "{'response':'KO', 'cause':'Token invalid'}";
            }            
        }catch (Exception e){
            e.printStackTrace();
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            resultado = "{'response':'KO', 'cause':'"+errors.toString()+"'}";
        }
        return resultado;
    }

    /**
     * Edita un dato de acuerdo al id enviado
     * Se prueba con el TestCase "Editar" del proyecto Mensaje-soapui-project
     * @param token String con el token otorgado en el login
     * @param entity entidad Mensaje
     * @return String satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarPersonaje(@QueryParam("token") String token, Mensaje entity){
         String resultado = "";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){        
                if(entity.getIdMensaje() != 0 && entity.getIdMensaje() != null){
                    Mensaje mensaje = super.find(entity.getIdMensaje());
                    if(mensaje == null){
                       resultado = "{'response':'KO','cause':'Personaje not found'}";
                    }else{
                        if(entity.getIdJugadorFrom() != 0)  mensaje.setIdJugadorTo(entity.getIdJugadorFrom());
                        if(entity.getIdJugadorTo()!= 0) mensaje.setIdJugadorTo(entity.getIdJugadorTo());
                        if(entity.getMensaje()!= null) mensaje.setMensaje(entity.getMensaje());

                        em.merge(mensaje);

                        resultado = "{'response':'OK'}";
                    }

                }else{
                    resultado =  "{'response':'KO','cause':'Not send Id'}";
                }
           }else{
                resultado = "{\"response\":\"KO\",\"cause\":\"Invalid token\"}";

           }
        }catch (Exception e){
            e.printStackTrace();
                           resultado = "{\"response\":\"KO\",\"cause\":\"Invalid token\"}";

        }            
       return resultado;       
    }    


    /**
     * Busca un mensaje de acuerdo al id
     * Se prueba con el TestCase "Buscar" del proyecto Mensaje-soapui-project
     * @param id del Mensaje a buscar
     * @param token String con el token que se otorgo en el login
     * @return String entidad del Mensaje
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id, @QueryParam("token") String token) {
        String resultado = "";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               Mensaje mensaje = em.find(Mensaje.class, id);
               if(mensaje == null){
                   resultado = "{\"response\":\"KO\",\"cause\":\"Personaje not found\"}";
               }else{
                   resultado =  "{\"idMensaje\":\""+mensaje.getIdMensaje()+"\", \"idJugadorFrom\":\""+mensaje.getIdJugadorFrom()+"\","
                           + "\"idJugadorTo\":\""+mensaje.getIdJugadorTo()+"\"}";
               }  
           }else{
               resultado = "{\"response\":\"KO\",\"cause\":\"Invalid token\"}";
           }
        }catch (Exception e){
             e.printStackTrace();
             resultado = "{'response':'KO', 'cause':'Invalid token'}";
         }
         return resultado;
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Mensaje> findAll() {
        return super.findAll();
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
