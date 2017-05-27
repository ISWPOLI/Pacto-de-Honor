
var contenido = [
		"Solo puedes usar un codgo de regalo y... ",  
"                 este ya lo has usado", 
"                     ¡Lo sentimos!"];
var line = [];

var wordIndex = 0;
var lineIndex = 0;

var wordDelay = 100;
var lineDelay = 300;


var regalado = function(game){};
regalado.prototype = {
    preload: function(){
        game.load.image('opa', 'codigosAlfa/imagesImp.png');
        game.load.spritesheet('regresar', 'codigosAlfa/regresar.png', 193, 71);
    },

    create: function(){ 
		game.add.sprite(0,0,'opa');
 var button = game.add.button(300, 400, 'regresar', null, this, 2, 1, 0);

		text = game.add.text(32, 200, '', { font: "40px Arial", fill: "#FFFF00" });

  this.nextLine();
		

	},nextLine: function(){


    if (lineIndex === contenido.length)
    {
        return;
    }
    line = contenido[lineIndex].split(' ');
    wordIndex = 0;
    game.time.events.repeat(wordDelay, line.length, this.nextWord,this);
    lineIndex++;

	}, nextWord:function(){

   text.text = text.text.concat(line[wordIndex] + " ");
   wordIndex++;

   if (wordIndex === line.length)
   {
     
       text.text = text.text.concat("\n");
       game.time.events.add(lineDelay, this.nextLine,this);

	}
}}
	