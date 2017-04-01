/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.poli.service;

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
        resources.add(co.edu.poli.service.CategoriaFacadeREST.class);
        resources.add(co.edu.poli.service.CiudadFacadeREST.class);
        resources.add(co.edu.poli.service.FraseFacadeREST.class);
        resources.add(co.edu.poli.service.ImagenFacadeREST.class);
        resources.add(co.edu.poli.service.JugadorFacadeREST.class);
        resources.add(co.edu.poli.service.LogFacadeREST.class);
        resources.add(co.edu.poli.service.MundoFacadeREST.class);
        resources.add(co.edu.poli.service.NivelFacadeREST.class);
        resources.add(co.edu.poli.service.PaisFacadeREST.class);
        resources.add(co.edu.poli.service.PersonajeFacadeREST.class);
        resources.add(co.edu.poli.service.PoderFacadeREST.class);
        resources.add(co.edu.poli.service.PreguntaPsicotecnicaFacadeREST.class);
        resources.add(co.edu.poli.service.PruebaPsicotecnicaFacadeREST.class);
        resources.add(co.edu.poli.service.RespuestaPsicotecnicaFacadeREST.class);
        resources.add(co.edu.poli.service.RolUsuarioFacadeREST.class);
        resources.add(co.edu.poli.service.TipoPreguntaPsicotecnicaFacadeREST.class);
        resources.add(co.edu.poli.service.UsuarioFacadeREST.class);
    }
    
}
