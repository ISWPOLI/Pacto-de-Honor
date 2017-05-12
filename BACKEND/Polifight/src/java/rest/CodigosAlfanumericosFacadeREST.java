/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import entities.CodigosAlfanumericos;
import entities.Usuario;
import java.util.HashSet;
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
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Usuario
 */
@Stateless
@Path("entities.codigosalfanumericos")
public class CodigosAlfanumericosFacadeREST extends AbstractFacade<CodigosAlfanumericos> {

    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    public CodigosAlfanumericosFacadeREST() {
        super(CodigosAlfanumericos.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(CodigosAlfanumericos entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, CodigosAlfanumericos entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public CodigosAlfanumericos find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<CodigosAlfanumericos> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<CodigosAlfanumericos> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST(@QueryParam("token") String token) {
        String resultado = "";
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            System.err.println(token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if (user != null) {
                resultado = String.valueOf(super.count());
            } else {
                resultado = "{'response':'KO', 'cause':'Invalid token'}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultado = "{'response':'KO', 'cause':'Invalid token'}";
        }
        return resultado;
    }

    @GET
    @Path("validate")
    @Produces("text/plain")
    public String validateCode(@QueryParam("token") String token, @QueryParam("codigo") String Codigo) {

        String resultado = "";
        try {
            em.clear();
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            System.err.println(token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if (user != null) {
                em.clear();
                Query codes = em.createNamedQuery("CodigosAlfanumericos.findByCodigo");
                codes.setParameter("codigo", Codigo);
                resultado += Codigo;
                try {
                    CodigosAlfanumericos ca = (CodigosAlfanumericos) codes.getSingleResult();
                    resultado += ca.toString();
                    if (ca != null) {
                        resultado += ca.getUsado();
                        if (ca.getUsado()) {
                            resultado += "{'response':'KO', 'cause':'Codigo ya utilizado'}";
                        } else {
                            resultado += "{'response':'OK'}";
                        }

                    } else {
                        resultado = "{'response':'KO', 'cause':'invalid Code'}";
                    }
                } catch (Exception e) {
                    resultado = "{'response':'KO', 'cause':'Invalid Code '}";
                }
            } else {
                resultado = "{'response':'KO', 'cause':'Invalid token'}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultado += "{'response':'KO', 'cause':'Invalid token}";
        }
        return resultado;
    }

    @GET
    @Path("update")
    @Produces("text/plain")
    public String updateCode(@QueryParam("token") String token, @QueryParam("codigo") String Codigo) {

        String resultado = "";
        try {
            Query queryToken = em.createNamedQuery("Usuario.findToken");
            queryToken.setParameter("token", token);
            System.err.println(token);
            Usuario user = (Usuario) queryToken.getSingleResult();
            if (user != null) {
                Query codes = em.createNamedQuery("CodigosAlfanumericos.findByCodigo");
                codes.setParameter("codigo", Codigo);

                try {
                    CodigosAlfanumericos ca = (CodigosAlfanumericos) codes.getSingleResult();

                    if (ca != null) {

                        if (!ca.getUsado()) {
                            ca.setUsado(Boolean.TRUE);
                            em.merge(ca);

                            resultado = "{'response':'OK','message':'codigo utilizado con exito'}";
                        } else {
                            resultado = "{'response':'KO','message':'codigo ya utilizado'}";

                        }

                    } else {
                        resultado = "{'response':'KO', 'cause':'invalid Code'}";
                    }
                } catch (Exception e) {
                    resultado = "{'response':'KO', 'cause':'Invalid Code '}" + e.getMessage();
                }
            } else {
                resultado = "{'response':'KO', 'cause':'Invalid token'}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultado += "{'response':'KO', 'cause':'Invalid token}";
        }
        return resultado;
    }
}
