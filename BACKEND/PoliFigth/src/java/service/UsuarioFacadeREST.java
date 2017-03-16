/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import entidades.Usuario;
import entidades.UsuarioPK;
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
import javax.ws.rs.core.PathSegment;

/**
 *
 * @author Will
 */
@Stateless
@Path("entidades.usuario")
public class UsuarioFacadeREST extends AbstractFacade<Usuario> {
    @PersistenceContext(unitName = "PoliFigthPU")
    private EntityManager em;

    private UsuarioPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;idJugador=idJugadorValue;idPais=idPaisValue;idCiudad=idCiudadValue;idRolUsuario=idRolUsuarioValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        entidades.UsuarioPK key = new entidades.UsuarioPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> idJugador = map.get("idJugador");
        if (idJugador != null && !idJugador.isEmpty()) {
            key.setIdJugador(new java.lang.Integer(idJugador.get(0)));
        }
        java.util.List<String> idPais = map.get("idPais");
        if (idPais != null && !idPais.isEmpty()) {
            key.setIdPais(new java.lang.Integer(idPais.get(0)));
        }
        java.util.List<String> idCiudad = map.get("idCiudad");
        if (idCiudad != null && !idCiudad.isEmpty()) {
            key.setIdCiudad(new java.lang.Integer(idCiudad.get(0)));
        }
        java.util.List<String> idRolUsuario = map.get("idRolUsuario");
        if (idRolUsuario != null && !idRolUsuario.isEmpty()) {
            key.setIdRolUsuario(new java.lang.Integer(idRolUsuario.get(0)));
        }
        return key;
    }

    public UsuarioFacadeREST() {
        super(Usuario.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(Usuario entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") PathSegment id, Usuario entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        entidades.UsuarioPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public Usuario find(@PathParam("id") PathSegment id) {
        entidades.UsuarioPK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<Usuario> findAll() {
        return super.findAll();
    }

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

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
