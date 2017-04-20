/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rest;

import com.poder.Restful.PH.Poder;
import com.poder.Restful.PH.PoderPK;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.PathSegment;

/**
 *
 * @author ahsierra
 */
@Stateless
@Path("com.poder.restful.ph.poder")
public class PoderFacadeREST extends AbstractFacade<Poder> {
    
    @PersistenceContext(unitName = "Restful.PHPU")
    private EntityManager em;

    private PoderPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idPoder=idPoderValue;idImagen=idImagenValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        com.poder.Restful.PH.PoderPK key = new com.poder.Restful.PH.PoderPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idPoder = map.get("idPoder");
        if (idPoder != null && !idPoder.isEmpty()) {
            key.setIdPoder(new java.lang.Integer(idPoder.get(0)));
        }
        java.util.List<String> idImagen = map.get("idImagen");
        if (idImagen != null && !idImagen.isEmpty()) {
            key.setIdImagen(new java.lang.Integer(idImagen.get(0)));
        }
        return key;
    }

    public PoderFacadeREST() {
        super(Poder.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Poder entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") PathSegment id, Poder entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        com.poder.Restful.PH.PoderPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public Poder find(@PathParam("id") PathSegment id) {
        com.poder.Restful.PH.PoderPK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Poder> findAll() {
        return super.findAll();
    }
    @GET
    @Path("findAllPower")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Poder> findAllPower() {
        return super.findAll();
    } 
    @GET
    @Path("findPower")
    @Produces(MediaType.APPLICATION_JSON)
    public Poder findPower(@PathParam("findPower") int id){
        List<Poder> a = findAllPower();
        Poder b = new Poder(); 
        for (int i = 0; i < a.size(); i++) {
            if(a.get(i).getPoderPK().getIdPoder() == id){
                b = a.get(i);
            }
        }
        return b;
    }
    
    @GET
    @Path("createPower")
    @Consumes(MediaType.APPLICATION_JSON)
    public void createPower(String[] Poder) {
        PoderPK nuevoPK = new PoderPK(Integer.parseInt(Poder[0]),Integer.parseInt(Poder[1]));
        Poder nuevo = new Poder();
        nuevo.setPoderPK(nuevoPK);
        nuevo.setNombrePoder(Poder[2]);
        nuevo.setDescripcionPoder(Poder[3]);
        nuevo.setFormaPoder(Integer.parseInt(Poder[4]));
        nuevo.setPotenciaPoder(Integer.parseInt(Poder[5]));
        nuevo.setTipoPoder(Integer.parseInt(Poder[6]));
        super.create(nuevo);
    }

//    @GET
//    @Path("editPower")
//    @Consumes (MediaType.APPLICATION_JSON)
//    public void editPower(@PathParam("editPower") int idPoder, int idImagen, String NombrePoder, String DescripcionPoder, int FormaPoder, int PotenciaPoder, int TipoPoder){
//        List<Poder> a = findAllPower();
//        for (int i = 0; i < a.size(); i++) {
//            if(a.get(i).getNombrePoder().equals(NombrePoder) || a.get(i).getPoderPK().getIdPoder() == idPoder){
//                PoderPK nuevo = new PoderPK(idPoder,idImagen);
//                a.get(i).setPoderPK(nuevo);
//                a.get(i).setNombrePoder(NombrePoder);
//                a.get(i).setDescripcionPoder(DescripcionPoder);
//                a.get(i).setFormaPoder(FormaPoder);
//                a.get(i).setPotenciaPoder(PotenciaPoder);
//                a.get(i).setTipoPoder(TipoPoder);
//                super.edit(a.get(i));
//            }
//        }
//    }
    
    @GET
    @Path("findPowerByName")
    @Produces (MediaType.APPLICATION_JSON)
    public Poder findPowerByName(@PathParam("findPowerByName") String nombrePoder){
        List<Poder> a = findAllPower();
        Poder b = new Poder();
        for (int i = 0; i < a.size(); i++) {
            if(a.get(i).getNombrePoder().equals(nombrePoder)){
                b = a.get(i);
            }
        }
        return b;
    }
            
    
    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<Poder> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("countPower")
    @Produces(MediaType.APPLICATION_JSON)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
