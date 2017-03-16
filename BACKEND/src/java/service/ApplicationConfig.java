/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author Will
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
        resources.add(service.CategoriaFacadeREST.class);
        resources.add(service.CiudadFacadeREST.class);
        resources.add(service.FraseFacadeREST.class);
        resources.add(service.ImagenFacadeREST.class);
        resources.add(service.JugadorFacadeREST.class);
        resources.add(service.LogFacadeREST.class);
        resources.add(service.MundoFacadeREST.class);
        resources.add(service.NivelFacadeREST.class);
        resources.add(service.PaisFacadeREST.class);
        resources.add(service.PersonajeFacadeREST.class);
        resources.add(service.PoderFacadeREST.class);
        resources.add(service.PreguntaPsicotecnicaFacadeREST.class);
        resources.add(service.PruebaPsicotecnicaFacadeREST.class);
        resources.add(service.RespuestaPsicotecnicaFacadeREST.class);
        resources.add(service.RolUsuarioFacadeREST.class);
        resources.add(service.TipoPreguntaPsicotecnicaFacadeREST.class);
        resources.add(service.UsuarioFacadeREST.class);
    }
    
}
