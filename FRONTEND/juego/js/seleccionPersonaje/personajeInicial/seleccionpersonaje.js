var columns = 3;
var rows = 3;
var characterWidth = 80;
var characterHeight = 80;
var spacing = 70;
var characters = ['pantera','gallo','cierva','girafa','leon','canario','ruisenor','raton','hormiga'];
var l;
var musicButton;
var startButton;

var seleccionpersonaje = function(game){};
seleccionpersonaje.prototype = {
     preload: function(){
          game.scale.pageAlignHorizontally = true;
          game.scale.pageAlignVertically = true;

          game.load.spritesheet('pantera', '../img/personajes/avatares/caraPantera.png', 125, 125, 3);
          game.load.spritesheet('gallo', '../imgpersonajes/avatares/caraGallo.png', 125, 125, 3);
          game.load.spritesheet('cierva', '../img/personajes/avatares/caraCierva.png', 125, 125, 3);
          game.load.spritesheet('girafa', '../img/personajes/avatares/caraJirafa.png', 125, 125, 3);
          game.load.spritesheet('leon', '../img/personajes/avatares/caraLeon.png', 125, 125, 3);
          game.load.spritesheet('canario', '../img/personajes/avatares/caraCanario.png', 125, 125, 3);
          game.load.spritesheet('ruisenor', '../img/personajes/avatares/caraRuiseñor.png', 125, 125, 3);
          game.load.spritesheet('raton', '../img/personajes/avatares/caraRatón.png', 125, 125, 3);
          game.load.spritesheet('hormiga', '../img/personajes/avatares/caraHormiga.png', 125, 125, 3);
          game.load.spritesheet('button', '../img/Componentes/seleccion de personaje/SpriteButton.png', 150, 40);
         
         game.load.audio('sonidoBoton', '../img/Componentes/sonidos/Botones/1.mp3');
     },
     create: function(){  
         musicButton = game.add.audio('sonidoBoton');
          game.stage.backgroundColor = "#2451A6"; 
          this.pageText = game.add.text(game.width / 2, 45, "Selección de Personaje", {font: "32px Roboto", fill: "#ffffff"})
          this.pageText.anchor.set(0.5);
          
          var rowLength = characterWidth * columns + spacing * (columns - 1);
          var leftMargin = (game.width - rowLength) / 2;
          var colHeight = characterHeight * columns + spacing * (columns - 1);
          var topMargin = (game.width - colHeight);
          l = 0;

          for(var i = 0; i < columns; i++){
               for(var j = 0; j < rows; j++){
                    for(l; l < characters.length; l++){
                        //thumb.scale.setTo(1.5);
                        var button = game.add.button(leftMargin + j * (characterWidth + spacing), topMargin - 350 + i * (characterHeight + spacing), characters[l], sonido, this, 2, 1, 0);
                        l = l + 1;
                        break;    
                        function sonido (){
                            musicButton.play();
                        }
                    }
               }
          }
          startButton = game.add.button(game.world.width / 2, 550, 'button', this.verbatalla, this, 2, 1, 0); // over, out, down, up
          startButton.anchor.set(0.5);
     },
    
    verbatalla: function () {
        cookies.setCookie("name", "idPUno");
        this.state.start ("batalla");
        musicButton.play();
    }
    
    
}