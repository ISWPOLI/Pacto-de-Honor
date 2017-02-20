package co.edu.poli.service;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import co.edu.poli.vo.*;

@Path("/PactoHonor")
public class ServiceStatusPlayer {
	
	@POST
	@Path("/returnStatus")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public PlayerStatus returnStatus(){
		
			PlayerStatus resultado = new PlayerStatus();
			resultado.setBatallasGanadas(1);
			resultado.setBatallasPerdidas(5);
			resultado.setEstado(true);
			resultado.setInsignias(20);
			resultado.setPersonaje("Juan Rata");
			resultado.setPuntaje(5000);
			resultado.setTipoUsuario("Estudiante");
			return resultado;
		
		
	}
}
