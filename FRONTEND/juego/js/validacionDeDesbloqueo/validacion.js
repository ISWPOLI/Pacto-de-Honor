
var linea = [];
var indice = 0;
var indiceDelineaa = 0;
var demoraEspacio = 100;
var demoralineaa = 300;

var idpj = "idP";
var idpj2 = "idP2";
var idpj3 = "idP3";
var idpj4 = "idP4";
var idpj5 = "idP5";
var idpj6 = "idP6";
var idpj7 = "idP7";
var idpj8 = "idP8";
var idpj9 = "idP9";

var perDesbloqueado = personajesDesbloq[idpj].estado;
var perDesbloqueado2 = personajesDesbloq[idpj2].estado;
var perDesbloqueado3 = personajesDesbloq[idpj3].estado;
var perDesbloqueado4 = personajesDesbloq[idpj4].estado;
var perDesbloqueado5 = personajesDesbloq[idpj5].estado;
var perDesbloqueado6 = personajesDesbloq[idpj6].estado;
var perDesbloqueado7 = personajesDesbloq[idpj7].estado;
var perDesbloqueado8 = personajesDesbloq[idpj8].estado;
var perDesbloqueado9 = personajesDesbloq[idpj9].estado;


var nombrePersonaje;
var contenido = ["Felicidades has desbloqueado a  "];

var validacion  = function(game){};
validacion.prototype = {
    preload: function(){
                
    },
    create: function(){ 

    	if(perDesbloqueado=="1"){

game.start.state("navegacion.js");

}else{

		    game.stage.backgroundColor = '#124184';
text = game.add.text(32, 200, personajesDesbloq[idpj].nombre, { font: "40px Arial", fill: "#FFFF00" });

/*var a;
a.setText(text + personajesDesbloq[idpj].nombre);

*/
 this.nextlinea();}
	},nextlinea: function(){

    if (indiceDelineaa === contenido.length)
    {
        return;
    }
    linea = contenido[indiceDelineaa].split(' ');
    indice = 0;
    game.time.events.repeat(demoraEspacio, linea.length, this.nextPalabra,this);
    indiceDelineaa++;

	}



  , nextPalabra:function(){

   text.text = text.text.concat(linea[indice] + " ");
   indice++;

   if (indice === linea.length)
   {
       text.text = text.text.concat("\n");
       game.time.events.add(demoralineaa, this.nextlinea,this);

  }
}}
	