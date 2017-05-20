package rest;

import entities.Categoriaimagen;
import entities.Imagen;
import entities.Jugador;
import entities.JugadorTienePersonaje;
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
        }catch (IllegalArgumentException e){
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'IllegalArgumentException. Verifique los campos, si el inconveniente persiste consulte con el administrador'}";
        }catch (Exception e){
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return resultado += "}";
    }

    /**
     * Método de compra que permite saber cuántos personajes buenos tiene un jugador
     * @param idJugador id del jugador que se desea consultar
     * @param token String correspondiente al token otorgado en el momento de hacer el login
     * @return 
     */
    @GET
    @Path("compra")
    @Produces({"application/json"})
    public String compra(@QueryParam("idJugador") Integer idJugador, @QueryParam("token") String token){
        int cont = 0;
        String resultado = "";
        try{
            //Verifica el token
           Query queryToken = em.createNamedQuery("Usuario.findToken");
           queryToken.setParameter("token", token);
           Usuario user = (Usuario) queryToken.getSingleResult();
           if(user != null){
               //Trae la lista de la tabla Jugador tiene Personaje
               Query queryJugadorTiene = em.createNamedQuery("JugadorTienePersonaje.findPlayerJugador");
               queryJugadorTiene.setParameter("idJugador", idJugador);
               List<JugadorTienePersonaje> j = queryJugadorTiene.getResultList();
               //Valida si tiene más de un personaje asociado
               if(!j.isEmpty()){
                    //Si solo tiene uno asociado en la tabla Jugador tiene Personaje
                    if(j.size() == 1){
                       //Busca el personaje y valida si es bueno
                       Personaje personaje = em.find(Personaje.class, j.get(0).getJugador().getIdJugador());
                       if(personaje.getIdCategoria() == 1){
                           resultado = "{\"idPersonaje\":\""+personaje.getIdPersonaje()+"\",\"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\"}";
                       }else{
                           resultado = "{\"response\":\"No tiene personajes buenos asignados\"}";
                       }                                   
                    }else{
                       resultado = "{\"datos\":[";  
                       for (int i = 0; i < j.size(); i++) {
                           Personaje personaje = em.find(Personaje.class, j.get(i).getPersonaje().getIdPersonaje());
                           if(personaje.getIdCategoria() == 1){
                               //Si es el último no pone una coma, de lo contrario la ingresa
                               if(i == j.size()-1){
                                resultado += "{\"idPersonaje\":"+personaje.getIdPersonaje()+", \"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\"}";
                                cont ++;
                               }else{
                                 resultado += "{\"idPersonaje\":"+personaje.getIdPersonaje()+", \"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\"},";
                                 cont ++;
                               }
                           }
                           if(cont == 0){
                               resultado = "{\"response\":\"No tiene personajes buenos asignados\"}";
                           }

                       }
                       resultado += "]}";
                   }   
               }else{
                   resultado = "{\"response\":\"No tiene personajes buenos asignados\"}";
               }
               
           }else{
               resultado = "{'response':'KO', 'cause':'Invalid token'}";               
           }           
        }catch(Exception e){
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
            e.printStackTrace();
        }
        return resultado;
    }
	
	
	/**
     * Busca los personajes que un jugador ha desbloqueado
     * Se prueba con el TestCase "unlockedCharacter" del proyecto JugadorTienePersonaje-soapui-project
     * @param token String con el token que se otorgo en el login
     * @param idJugador
     * @return list nombre, avatar, estado y descripcion del personaje
	 * @author EdnaEspejo
     */
    @GET
    @Path("unlockedCharacter")
    @Produces({"application/json"})
    public String unlockedCharacter(@QueryParam("idJugador") Integer idJugador, @QueryParam("token") String token){
        String result = "";
        try{
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query queryJugadorTienePersonaje = em.createNamedQuery("JugadorTienePersonaje.findByIdJugador");
                queryJugadorTienePersonaje.setParameter("idJugador", idJugador);
                List<JugadorTienePersonaje> jugadortienepersonaje = queryJugadorTienePersonaje.getResultList();
                if(!jugadortienepersonaje.isEmpty()){
                    if(jugadortienepersonaje.size() == 1){
                        Personaje personaje = em.find(Personaje.class, jugadortienepersonaje.get(0).getIdJugador());
                        int estado;
                        //categoria 1 para personajes buenos
                        if(personaje.getIdCategoria() == 1){
                            estado = 1; //desbloqueado
                            result = "{\"idP\":\""+personaje.getIdPersonaje()+"\",\"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\",\"estado\":\""+estado+"\",\"avatar\":\""+personaje.getIdImagen()+"\",\"descripcion\":\""+personaje.getDescripcionPersonaje()+"\"}";
                        }else{
                            estado = 0; //bloqueado
                            result = "{\"idP\":\""+personaje.getIdPersonaje()+"\",\"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\",\"estado\":\""+estado+"\",\"avatar\":\""+personaje.getIdImagen()+"\",\"descripcion\":\""+personaje.getDescripcionPersonaje()+"\"}";
                        }
                    }else{
                        result = "{\"response\":\"No unlocked character\"}";
                    }
                }else{
                    result = "{\"response\":\"No unlocked character\"}";
                }
            }else{
                result = "{\"response\":\"Invalid token\"}";
            }
        }catch(Exception e){
            result = "{\"response\":\"Invalid token\"}";
            e.printStackTrace();
        }
        return result;
    }
    
    /**
     * Busca los jefes que un jugador ha derrotado
     * Se prueba con el TestCase "defeatedBoss" del proyecto JugadorTienePersonaje-soapui-project
     * @param token String con el token que se otorgo en el login
     * @param idJugador
     * @return list nombre, avatar, estado y descripcion del jefe
	 * @author EdnaEspejo
     */
    @GET
    @Path("defeatedBoss")
    @Produces({"application/json"})
    public String defeatedBoss(@QueryParam("idJugador") Integer idJugador, @QueryParam("token") String token){
        String result = "";
        try{
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if(user != null){
                Query queryJugadorTienePersonaje = em.createNamedQuery("JugadorTienePersonaje.findByIdJugador");
                queryJugadorTienePersonaje.setParameter("idJugador", idJugador);
                List<JugadorTienePersonaje> jugadortienepersonaje = queryJugadorTienePersonaje.getResultList();
                if(!jugadortienepersonaje.isEmpty()){
                    if(jugadortienepersonaje.size() == 1){
                        Personaje personaje = em.find(Personaje.class, jugadortienepersonaje.get(0).getIdJugador());
                        int estado;
                        //categoria 1 para personajes buenos
                        if(personaje.getIdCategoria() == 1){
                            estado = 1; //desbloqueado
                            result = "{\"idP\":\""+personaje.getIdPersonaje()+"\",\"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\",\"estado\":\""+estado+"\",\"avatar\":\""+personaje.getIdImagen()+"\",\"descripcion\":\""+personaje.getDescripcionPersonaje()+"\"}";
                        }else{
                            estado = 0; //bloqueado
                            result = "{\"idP\":\""+personaje.getIdPersonaje()+"\",\"nombrePersonaje\":\""+personaje.getNombrePersonaje()+"\",\"estado\":\""+estado+"\",\"avatar\":\""+personaje.getIdImagen()+"\",\"descripcion\":\""+personaje.getDescripcionPersonaje()+"\"}";
                        }
                    }else{
                        result = "{\"response\":\"No unlocked character\"}";
                    }
                }else{
                    result = "{\"response\":\"No unlocked character\"}";
                }
            }else{
                result = "{\"response\":\"Invalid token\"}";
            }
        }catch(Exception e){
            result = "{\"response\":\"Invalid token\"}";
            e.printStackTrace();
        }
        return result;
    }
	
    
    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Jugador> findAll() {
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