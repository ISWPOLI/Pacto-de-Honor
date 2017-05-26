/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author jrubiaob
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(rest.CategoriaFacadeREST.class);
        resources.add(rest.CiudadFacadeREST.class);
        resources.add(rest.CodigosAlfanumericosFacadeREST.class);
        resources.add(rest.CrossOriginResourceSharingFilter.class);
        resources.add(rest.FraseFacadeREST.class);
        resources.add(rest.ImagenFacadeREST.class);
        resources.add(rest.JugadorFacadeREST.class);
        resources.add(rest.JugadorTieneLogrosFacadeREST.class);
        resources.add(rest.JugadorTienePersonajeFacadeREST.class);
        resources.add(rest.LogFacadeREST.class);
        resources.add(rest.LogrosFacadeREST.class);
        resources.add(rest.MundoFacadeREST.class);
        resources.add(rest.NivelFacadeREST.class);
        resources.add(rest.PaisFacadeREST.class);
        resources.add(rest.PersonajeFacadeREST.class);
        resources.add(rest.PoderFacadeREST.class);
        resources.add(rest.PruebaPsicotecnicaFacadeREST.class);
        resources.add(rest.PruebapsicotecnicaFactoresFacadeREST.class);
	   resources.add(rest.RespuestaPreguntasPsicotecnicasFacadeREST.class);
	   resources.add(rest.RespuestaPruebaJugadorFacadeREST.class);
        resources.add(rest.RolUsuarioFacadeREST.class);
        resources.add(rest.TipoPruebaFacadeREST.class);  
        resources.add(rest.UsuarioFacadeREST.class);  
    }
    
}
