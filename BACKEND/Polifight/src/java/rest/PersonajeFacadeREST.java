package rest;

import entities.Personaje;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * Servicio para la entidad Personaje
 * @author jrubiaob
 */

@Stateless
@Path("personaje")
public class PersonajeFacadeREST extends AbstractFacade<Personaje> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public PersonajeFacadeREST() {
        super(Personaje.class);
    }
    
    /**
     * Retorna los id de los datos en la tabla Personaje
     * * Se prueba con el TestCase "ListarId" del proyecto Personaje-soapui-project
     * @return List con los datos
     */
    @GET
    @Path("getId")
    @Produces({"application/json"})
    public String returnId(@QueryParam("token") String token){
        String resultado = "[";        
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query query = em.createQuery("SELECT p FROM Personaje p");
                List<Personaje> datos = query.getResultList();            
                for (int i = 0; i < datos.size(); i++) {
                    resultado += "{";
                    if(i == datos.size()-1){
                        resultado += "'idPersonje':'"+datos.get(i).getIdPersonaje()+"', nombrePersonaje':'"+datos.get(i).getNombrePersonaje()+"'}";
                    }else{
                        resultado += "'idPersonje':'"+datos.get(i).getIdPersonaje()+"', nombrePersonaje':'"+datos.get(i).getNombrePersonaje()+"'},";
                    }
                }
                resultado += "]";
            }else{
                resultado = "{'response':'KO', 'cause':'Invalid token'}";
            }        
        }catch (Exception e){
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        System.err.println(resultado);
        return resultado;
    }
    
     /**
     * Crea un dato
     * Se prueba con el TestCase "Crear" del proyecto Personaje-soapui-project
     * @param token String correspondiente al token que se otorgo en el login
     * @param entity entidad Personaje
     * @return String con la respuesta OK o la excepción
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String crearPersonaje(@QueryParam("token") String token, Personaje entity) {
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
     * Se prueba con el TestCase "Editar" del proyecto Personaje-soapui-project
     * @param entity entidad Personaje
     * @return mensaje satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editarPersonaje(Personaje entity){
        try{
            if(entity.getIdPersonaje() != 0 && entity.getIdPersonaje() != null){
                Personaje personaje = super.find(entity.getIdPersonaje());
                if(personaje == null){
                   return "{'response':'KO','cause':'Personaje not found'}";
                }else{
                    if(entity.getCosto() != 0)  personaje.setCosto(entity.getCosto());
                    if(entity.getDescripcionPersonaje() != null) personaje.setDescripcionPersonaje(entity.getDescripcionPersonaje());
                    if(entity.getIdCategoria() != 0) personaje.setIdCategoria(entity.getIdCategoria());
                    if(entity.getIdImagen() != 0) personaje.setIdImagen(entity.getIdImagen());
                    if(entity.getNivelDano() != 0) personaje.setNivelDano(entity.getNivelDano());
                    if(entity.getNombrePersonaje() != null) personaje.setNombrePersonaje(entity.getNombrePersonaje());

                    em.merge(personaje);

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
     * Busca un personaje de acuerdo al id
     * Se prueba con el TestCase "Buscar" del proyecto Personaje-soapui-project
     * @param id del Personaje a buscar
     * @return Personaje entidad del Personaje
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id) {
        Personaje personaje = em.find(Personaje.class, id);
        if(personaje == null){
            return "{'response':'KO','cause':'Personaje not found'}";
        }else{
            return "{'idPersonaje':'"+personaje.getIdPersonaje()+"', 'idCategoria':'"+personaje.getIdCategoria()+"',"
                    + "'idImagen':'"+personaje.getIdImagen()+"','nombrePersonaje':'"+personaje.getNombrePersonaje()+"',"
                    + "'descripcionPersonaje':'"+personaje.getDescripcionPersonaje()+"','costo':'"+personaje.getCosto()+"',"
                    + "'nivelDano':'"+personaje.getNivelDano()+"'}";
        }        
    }
    
    /**
     * Lista todos los personajes de la base de datos
     * Se prueba con el TestCase "Listar" del proyecto Personaje-soapui-project
     * @return List con todos los Personajes registrados
     */
    @GET
    @Override
    @Produces({"application/json"})
    public List<Personaje> findAll() {
        return super.findAll();
    }
    
    /**
     * Retorna los datos de acuerdo a un rango
     * Se prueba con el TestCase "BuscarPorRango" del proyecto Personaje-soapui-project
     * @param from desde qué id
     * @param to hasta qué id
     * @return List con los personajes de acuerdo al rango
     */
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Personaje> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        //SELECT * FROM Personaje WHERE id_personaje BETWEEN 5 AND 7 ORDER BY id_personaje
        Query query = em.createQuery("SELECT p FROM Personaje p WHERE p.idPersonaje BETWEEN :from AND :to"); 
        query.setParameter("from", from);
        query.setParameter("to", to);        
        return query.getResultList();
    }

    /**
     * Retorna el número de datos que están en la base de datos
     * Se prueba con el TestCase "NoDatos" del proyecto Personaje-soapui-project
     * @return NoDatos
     */
    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }
    
    /**
     * Retorna los datos nombre, imagen y nivel de dano
     * Se prueba con el TestCase "Crear" del proyecto Personaje-soapui-project
     * @param id del Personaje
     * @return JSON(String) con la respuesta del servicio
     */
    @GET
    @Path("getData")
    @Produces({"application/json"})
    public String getData(@QueryParam("id") Integer id){
        String resultado = "";
        Personaje personaje =  super.find(id);
        if(personaje != null){
            resultado = "{'idPersonaje':'"+personaje.getIdPersonaje()+"', 'nombrePersonaje':'"+personaje.getNombrePersonaje()+"', "
                    + "'imagen':'"+personaje.getIdImagen()+"', 'nivelDano':'"+personaje.getNivelDano()+"'}";   
        }else{
            resultado = "{'response':'KO', 'cause':'Personaje not found'}";
        }         
              
                     
        return resultado;
    }
           
    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
