package rest;

import entities.Imagen;
import entities.MundoTieneImagen;
import entities.Nivel;
import entities.Personaje;
import entities.Usuario;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
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
import javax.persistence.Query;

/**
 * Servicio REST para la entidad Nivel
 * @author 1013608348 - Edna Espejo
 */
@Stateless
@Path("nivel")
public class NivelFacadeREST extends AbstractFacade<Nivel> {
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;
    
    /**
     * Crea un dato Nivel
     * Se prueba con el TestCase "Crear" del proyecto Nivel-soapui-project
     * @param entity Entidad Nivel
     * @return JSON con la respuesta satisfactoria o insatisfactoria
     */
    @POST
    @Path("create")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String createNivel(Nivel entity) {
        String result;
        try{
            em.persist(entity);
            result = "{'response':'Level create']";
        }catch (Exception e){
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));            
            result = "{'response':'Error', 'cause':'"+errors.toString()+"'}";
        }
        return result;
    }

    /**
     * Edita un campo de acuerdo al id que recibe
     * Se prueba con el TestCase "Editar" del proyecto Nivel-soapui-project
     * @param entity Entidad Nivel
     * @return JSON con la respuesta satisfactorio o insatisfactorio
     */
    @POST
    @Path("edit")
    @Consumes({"application/json"})
    @Produces({"application/json"})
    public String editNivel(Nivel entity) {
        try{
            if(entity.getIdNivel() != 0){
                Nivel nivel = super.find(entity.getIdNivel());
                if(nivel == null){
                    return "{'response':'Error','cause':'Level not found'}";
                }else{
                    if(entity.getIdNivel() != 0) nivel.setIdNivel(entity.getIdNivel());
                    if(entity.getIdMundo() != null) nivel.setIdMundo(entity.getIdMundo());
                    if(entity.getNombreNivel()!= null) nivel.setNombreNivel(entity.getNombreNivel());
                    
                    em.merge(nivel);
                    
                    return "{'response':'Level modificated'}";
                }
            }else{
                return "{'response':'Error','cause':'Not send Id'}";
            }
        }catch (Exception e){
            return "{'response':'Error','cause':'Exception'}";
        }
    }
    
    /**
     * Busca un dato de acuerdo al id que recibe
     * Se prueba con el TestCase "Buscar" del proyecto Nivel-soapui-project
     * @param id del Nivel a buscar
     * @return String con la entity Nivel
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String find(@QueryParam("id") Integer id){
        Nivel nivel = em.find(Nivel.class, id);
        if (nivel == null){
            return "{'response':'Error','cause':'Level not found'}";
        }else{
            return "{'idNivel':'"+nivel.getIdNivel()+"', 'idMundo':'"+nivel.getIdMundo()+"' 'nombreNivel':'"+nivel.getNombreNivel()+"'}";
        }        
    }
    
    /**
     * Al consumir, arroja un json con todos los datos de la tabla
     * Se prueba con el TestCase "ListarTodo" del proyecto Nivel-soapui-project
     * @return String con todos los Nivel
     */ 
    
    @GET
    @Path("listLevels")
    @Produces({"application/json"})
    public String listNivel(){
        String resultado = "[";
        Query query = em.createQuery("SELECT n FROM Nivel n");
        List<Nivel> datos = query.getResultList();
        for (int i = 0; i < datos.size(); i++) {
            resultado += "{";
            if(i == datos.size()-1){
                resultado += "'idNivel':'"+datos.get(i).getIdNivel()+"', 'idMundo':'"+datos.get(i).getIdMundo()+"', 'nombreNivel':'"+datos.get(i).getNombreNivel();
            }else{
                resultado += "'idNivel':'"+datos.get(i).getIdNivel()+"', 'idMundo':'"+datos.get(i).getIdMundo()+"', 'nombreNivel':'"+datos.get(i).getNombreNivel();
            }
        }
        return resultado += "]";
    }
    
    
    @GET
    @Override
    @Produces({"application/json"})
    public List<Nivel> findAll() {
        Nivel nivel = new Nivel();
        List<Nivel> list = new ArrayList<>();
        list.add(nivel);
        return list;
    }

    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Nivel> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }
    
    @GET
    @Path("nivelPersonaje")
    @Produces({"application/json"})
    public String nivelPersonaje(@QueryParam("token") String token){
        
        String resultado = "{\"datos\":[";      
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query query = em.createNamedQuery("Nivel.findAll");
                List<Nivel> listNivel = query.getResultList();
                for (int i = 0; i < listNivel.size(); i++) {
                    resultado += "{";
                    MundoTieneImagen mundoTieneImagen = em.find(MundoTieneImagen.class, listNivel.get(i).getIdMundo().getIdMundo());
                    System.err.println("MundoTieneImagen ---> "+mundoTieneImagen.getIdImagen().getIdImagen());
                    Imagen imagen = em.find(Imagen.class, mundoTieneImagen.getIdImagen().getIdImagen());
                    Personaje personaje = em.find(Personaje.class, listNivel.get(i).getIdPersonaje().getIdPersonaje());
                     if(i == listNivel.size()-1){
                        resultado += "\"Nivel\":\""+listNivel.get(i).getNombreNivel()+"\",\"idPersonaje\":"+personaje.getIdPersonaje()+", \"imagenFondo\":\""+imagen.getFoto()+"\"}";
                    }else{
                        resultado += "\"Nivel\":\""+listNivel.get(i).getNombreNivel()+"\",\"idPersonaje\":"+personaje.getIdPersonaje()+", \"imagenFondo\":\""+imagen.getFoto()+"\"},";
                    }
                }
                resultado += "]}";
            }
        }catch (Exception e){
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return resultado;
    }
    @Override
    protected EntityManager getEntityManager() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

   

    public NivelFacadeREST() {
        super(Nivel.class);
    }
    
}
