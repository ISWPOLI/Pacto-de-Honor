var histo;
var button;
var music;
var musicButton;
var historieta = function(game){};
historieta.prototype = {
     preload: function(){
          game.scale.pageAlignHorizontally = true;
          game.scale.pageAlignVertically = true;

          game.load.spritesheet('historieta', '../img/Componentes/historieta/historieta.png', 800, 600);
          game.load.spritesheet('button', '../img/Componentes/historieta/botonSaltar.png', 150, 40);
         game.load.audio('sonidos','../img/Componentes/sonidos/Historieta/historieta.mp3');  
          game.load.audio('sonidoBoton', '../img/Componentes/sonidos/Botones/1.mp3');
     },
     create: function(){
         music = game.add.audio('sonidos');
         musicButton = game.add.audio('sonidoBoton');
         music.loop = true;
         music.play();
         histo = game.add.sprite(0,0, 'historieta');
         histo.animations.add('verH', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.3, false);
         histo.animations.play('verH');
         button = game.add.button (game.world.width - 100, game.world.height - 100, 'button', this.verMapa, this, 2 ,1, 0);
         button.anchor.setTo (0.5, 0.5);
        
     },
    verMapa: function(){
        this.state.start("navegacion");
        musicButton.play();
        music.pause();
    },
    update: function(){
       
    }
} 