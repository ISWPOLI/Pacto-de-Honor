/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviciosRest;

import Controlador.entidades.Registrologin;
import javax.ws.rs.Consumes;
import static javax.ws.rs.HttpMethod.POST;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;



/**
 *
 * @author JERR
 */

@Path("/Registrar")

public class ServicioRegistro {

    @POST
    @Path("/Registrar")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addUsuario(Registrologin registro) {
        System.out.println(registro.getNombre() + registro.getClave());
    }
}



