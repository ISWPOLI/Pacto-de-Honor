package rest;

import entitities.Personaje;
import entitities.PersonajePK;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import javax.ws.rs.core.PathSegment;

/**
 * Servicio para la entidad Personaje
 * @author jrubiaob
 */
@Stateless
@Path("personaje")
public class PersonajeFacadeREST extends AbstractFacade<Personaje> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    private PersonajePK getPrimaryKey(PathSegment pathSegment) {
        entitities.PersonajePK key = new entitities.PersonajePK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idPersonaje = map.get("idPersonaje");
        if (idPersonaje != null && !idPersonaje.isEmpty()) {
            key.setIdPersonaje(new java.lang.Integer(idPersonaje.get(0)));
        }
        java.util.List<String> idCategoria = map.get("idCategoria");
        if (idCategoria != null && !idCategoria.isEmpty()) {
            key.setIdCategoria(new java.lang.Integer(idCategoria.get(0)));
        }
        java.util.List<String> idImagen = map.get("idImagen");
        if (idImagen != null && !idImagen.isEmpty()) {
            key.setIdImagen(new java.lang.Integer(idImagen.get(0)));
        }
        return key;
    }

    public PersonajeFacadeREST() {
        super(Personaje.class);
    }
    
     /**
     * Crea un dato
     * Se prueba con el recurso ""
     * @param entity entidad Personaje
     */
    @POST    
    @Override 
    @Path("create")
    @Consumes({"application/json"})
    public void create(Personaje entity) {
        //Categoria es una entidad, problema al traer la entidad
        super.create(entity);
    }
    
    
    /**
     * Edita un dato de acuerdo al id enviado
     * Se prueba con el TestCase ""
     * @param entity entidad Personaje
     */
    @POST
    @Override
    @Path("edit")
    @Consumes({"application/json"})    
    public void edit(Personaje entity) {
        super.edit(entity);
    }
    
    /**
     * Busca un personaje de acuerdo al id
     * Se prueba con TestCase ""
     * @param id del Personaje a buscar
     * @return Personaje entidad del Personaje
     */
   /* @GET
    @Path("find")
    @Produces({"application/json"})
    public Personaje find(@QueryParam("id") PathSegment id) {
        entitities.PersonajePK key = getPrimaryKey(id);
        return super.find(key);
    }*/
    
    /**
     * Lista todos los personajes de la base de datos
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
     * Prueba con el TestCase ""
     * @param from desde qué id
     * @param to hasta qué id
     * @return List con los personajes de acuerdo al rango
     */
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Personaje> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    /**
     * Retorna el número de datos que están en la base de datos
     * Se prueba con el TestCase ""
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
     * Se prueba con el TestCase ""
     * @return 
     */
    /*@GET
    @Path("getData")
    @Produces({"application/json"})
    public String getData(@QueryParam("id") PathSegment id){
        String resultado = "";
        System.out.println("ID -> "+id);
       // PersonajePK key = getPrimaryKey(id);
        //System.out.println("Key -> " + key);
       // Personaje personaje = super.find(key);
        //resultado = personaje.getNombrePersonaje()+personaje.getNivelDano()+personaje.getImagen();
        return resultado;
    }*/
            

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
