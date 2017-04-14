/*Este archivo se crea para declarar los personajes como se va a hecer en la base de datos
*Con esto nos aseguramos que vaya a funcionar cuando de consuman los servicios 
*/
var personajesBuenos={
	"idPUno":{"nombre":"Andres Gallo","rutaSprite":"../img/sprites/personajesBuenos/gallo.png",
			  "rutaAvatar":"../img/componentes/batalla/caragallo.png",
			  "rutaAtaque":"../img/sprites/poderes/PoderesPersonalidadBuenos/AndresGallo.png",
			  "rutaImpactoPersonalidad":"../img/sprites/poderes/PoderesImpactos/impactoGallo.png",
			  "daño":[6,2],"energia":1,"defensa":10,"vida":200},

	"idPDos":{"nombre":"Daniel Leon","rutaSprite":"../img/sprites/personajesBuenos/leon.png",
			  "rutaAvatar":"../img/componentes/batalla/caragallo.png",
			  "rutaAtaque":"../img/sprites/poderes/PoderesPersonalidadBuenos/DanielLeon.png",
			  "rutaImpactoPersonalidad":"../img/sprites/poderes/PoderesImpactos/impactoLeon.png",
			  "daño":[6,2],"energia":1,"defensa":10,"vida":200}		  

}

var personajesMalos={
	"idPUno":{"nombre":"Felipe Oso","rutaSprite":"../img/sprites/personajesMalos/oso.png",
			  "rutaAvatar":"../img/componentes/batalla/caraoso.png",
			  //se toma otro sprtite porque el del oso no esta 
			  "rutaAtaque":"../img/sprites/poderes/PoderesPersonalidadMalos/camiloPERSONALIDAD.png",
			  "rutaAtaquePlagio":"../img/sprites/poderes/poderesPlagioMalos/error404.png",
			  "rutaImpactoPersonalidad":"../img/sprites/poderes/PoderesImpactos/impactoOso1.png",
			  "rutaImpactoPlagio":"../img/sprites/poderes/PoderesImpactos/impactoOso2.png",
			  "daño":[6,2],"energia":[0.5,1],"defensa":10,"vida":200}

}