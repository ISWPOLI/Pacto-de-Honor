package RestFacade;

import com.sun.xml.bind.xmlschema.StrictWildcardPlug;
import entidad.Mundo;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Will
 */
@Stateless
public class MundoFacadeREST extends AbstractFacade<Mundo> {

    @PersistenceContext(unitName = "ServPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MundoFacadeREST() {
        super(Mundo.class);
    }

    @POST
    @Path("create")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String crearUsiario(Mundo entity, int idMundo, String nMundo) {
        String respuesta;
        try {
            entity.setIdMundo(idMundo);
            em.persist(entity);
            entity.setNombreMundo(nMundo);
            respuesta = "Se crea con Exito  ";
        } catch (Exception e) {
            e.printStackTrace();
            StringWriter error = new StringWriter();
            e.printStackTrace(new PrintWriter(error));
            respuesta = "no Responde a causa " + error.toString();

        }
        return respuesta;

    }

    @POST
    @Path("edit")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public String editarMundo(Mundo entity) {
        String respuesta = null;
        try {

            if (entity.getIdMundo() != 0) {
                Mundo mundo = new Mundo();

                mundo = super.find(entity.getIdMundo());
                if (mundo != null) {

                } else {

                    if (entity.getIdMundo() != 0) {
                        mundo.setIdMundo(entity.getIdMundo());
                    }
                    if (entity.getNombreMundo() != null) {
                        mundo.setNombreMundo(entity.getNombreMundo());
                    }
                    em.merge(mundo);
                    respuesta = "{'response':'OK'}";
                    
                }
            } else {
                respuesta = "{'response':'KO','cause':'no se envia id'}";
                
            }

        } catch (Exception e) {
            respuesta = "{'response':'KO','cause':'Exception'}";
            

        }
        
        return respuesta;

    }
    
     @GET
    @Path("find")
    @Produces({MediaType.APPLICATION_JSON})
     
    public String find (@QueryParam("id")Integer id){
        Mundo mundo = em.find(Mundo.class, id);
        String respuesta ;
        if (mundo != null){
            
            respuesta = "{'idMundo':'"+mundo.getIdMundo() +"', 'nombreMundo':'"+mundo.getNombreMundo()  +"'}";
        }else{
            respuesta = "{'response':'KO','cause':'City not found'}";
       }
        
        return respuesta;
    }
    
    @GET
    @Path("listMundo")
    @Produces({MediaType.APPLICATION_JSON})
    public String listarMundo(){
        
       String resultado = "[";
       Query query = em.createNamedQuery("SELECT h FROM Mundo h");
       List <Mundo> formundos = query.getResultList();
        for (int i =0; i < formundos.size();i++) {
            resultado += "{";
            if (i == formundos.size()-1 ){
                
                resultado += "'idMundo':'"+formundos.get(i).getIdMundo()+"', 'nombreMundo':'"+formundos.get(i).getNombreMundo();
            }else{
                resultado += "'idMundo':'"+formundos.get(i).getIdMundo()+"', 'nombreMundo':'"+formundos.get(i).getNombreMundo();
            }
        }
       
       return resultado;
    }
    
    
    
    
    @GET
    @Override
    @Produces({"application/json"})
    public List<Mundo> findAll() {
        return super.findAll();
    }
    
    
    
    @GET
    @Path("findRange")
    @Produces({"application/json"})
    public List<Mundo> findRange(@QueryParam("from") Integer from, @QueryParam("to") Integer to) {
             return super.findRange(new int[]{from, to});        
    }
    
    

}
