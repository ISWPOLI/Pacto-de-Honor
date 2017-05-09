package rest;

import entities.Categoriaimagen;
import entities.Imagen;
import entities.Jugador;
import entities.Mundo;
import entities.Nivel;
import entities.Personaje;
import entities.PersonajeTieneImagen;
import entities.Usuario;
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
 * Servicio REST para la entidad Jugador
 * @author jrubiaob
 */
@Stateless
@Path("jugador")
public class JugadorFacadeREST extends AbstractFacade<Jugador> {
    
    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public JugadorFacadeREST() {
        super(Jugador.class);
    }
    
  
    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Jugador entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, Jugador entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    /**
     * Método que retorna la estructura solicitada en el issue #455
     * @param idJugador id del jugador que se desea buscar
     * @param idPersonaje id del Personaje que se desea traer el avatar
     * @param token token otorgado al momento del login
     * @return String con los atributos de Jugador
     */
    @GET
    @Path("find")
    @Produces({"application/json"})
    public String buscarJugador(@QueryParam("idJugador") Integer idJugador, @QueryParam("idPersonaje") Integer idPersonaje, @QueryParam("token") String token) {
         String resultado = "{";
         int idCategoriaAvatar;
         String avatar = "Avatar";
        try{
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               Jugador jugador = em.find(Jugador.class, idJugador);              
               if(jugador == null){
                   resultado = "{'response':'KO','cause':'Jugador not found'}";
               }else{
                    Nivel nivel = em.find(Nivel.class, jugador.getNivel().getIdNivel());
                    Mundo mundo = em.find(Mundo.class, nivel.getMundo().getIdMundo());
                    Query queryCategoriaImagen = em.createNamedQuery("Categoriaimagen.findByDescCategoriaImagen")
                            .setParameter("descCategoriaImagen", avatar);
                    
                    List<Categoriaimagen> listCategoriaImagen = queryCategoriaImagen.getResultList();
                    
                    if(listCategoriaImagen.size() >= 2){
                        resultado = "{'response':'KO', 'cause':'Existe más de una categoría llamada Avatar'";
                    }else{
                        idCategoriaAvatar = listCategoriaImagen.get(0).getIdcategoriaImagen();
                        Query queryPersonajeImagen = em.createNamedQuery("PersonajeTieneImagen.findImagenForPersonaje")
                                .setParameter("idCategoriaImagen", listCategoriaImagen.get(0))
                                .setParameter("idPersonaje", em.find(Personaje.class, idPersonaje));
                        
                        List<PersonajeTieneImagen> listPersonajeImagen = queryPersonajeImagen.getResultList();
                        
                        if(listPersonajeImagen.size() >= 2){
                            resultado = "{'response':'KO', 'cause':'Existe más de un avatar asignado al Personaje";
                        }else{
                            Imagen imagenAvatar = em.find(Imagen.class, listPersonajeImagen.get(0).getIdImagen().getIdImagen());                            
                            resultado +=  "'idJugador':'"+jugador.getIdJugador()+"', 'nickname':'"+jugador.getNickname()+"', "
                           + "'avatar':'"+imagenAvatar.getFoto()+"', 'mundo':'"+mundo.getNombreMundo()+"', 'nivel':'"+jugador.getNivel().getNombreNivel()+"',"
                           + "'monedas':'"+jugador.getMonedaJugador()+"', 'experiencia':'"+jugador.getExperienciaJugador()+"'";
                        }
                        
                    }                   
               }
           }else{
             resultado = "{'response':'KO', 'cause':'Invalid token'}";
           }
        }catch (Exception e){
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return resultado += "}";
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Jugador> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Jugador> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
