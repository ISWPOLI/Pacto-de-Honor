window.onload = function() {
    game = new Phaser.Game(800, 600, Phaser.AUTO, "");
    game.state.add("regalado", regalado);
    game.state.start("regalado");
}
var linea = [];
var indice = 0;
var indiceDelineaa = 0;
var demoraEspacio = 100;
var demoralineaa = 300;
var isObteined;
var nombrePersonaje;
var contenido = ["Felicidades has desbloqueado a  "];

var regalado = function(game){};
regalado.prototype = {
    preload: function(){
                
    },
    create: function(){ 

    	if(isObteined==true){

game.start.state("navegacion.js");

}else{

	$dbh = new PDO("mysql:host=$hostname;dbname=$dbname", $usuario, $contraseña);
$sql = ("SELECT * FROM  events WHERE Id in (SELECT MAX(Id) FROM events BY Personaje)");

		    game.stage.backgroundColor = '#124184';
text = game.add.text(32, 200, '', { font: "40px Arial", fill: "#FFFF00" });

var a;
a.setText(text + Personaje);


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

	}, nextPalabra:function(){

   text.text = text.text.concat(linea[indice] + " ");
   indice++;

   if (indice === linea.length)
   {
       text.text = text.text.concat("\n");
       game.time.events.add(demoralineaa, this.nextlinea,this);

	}
}}
	