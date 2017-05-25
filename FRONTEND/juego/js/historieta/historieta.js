variablesHistorieta={
    histo:null,
    button:null
}
var historieta = function(game){};
historieta.prototype = {
     preload: function(){
         game.load.spritesheet('historieta', '../img/componentes/historieta/historieta.png', 800, 600);
         game.load.spritesheet('button', '../img/componentes/botones/botonSaltar.png', 150, 40);
     },
    
     create: function(){

        variablesBoot.musicaMapa.play();
        variablesHistorieta.histo = game.add.sprite(0,0, 'historieta');
        variablesHistorieta.histo.animations.add('verH', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.3, false);
        variablesHistorieta.histo.animations.play('verH');
        variablesHistorieta.button = game.add.button (game.world.width - 100, game.world.height - 100, 'button', this.verMapa, this, 2 ,1, 0);
        variablesHistorieta.button.anchor.setTo (0.5, 0.5);
     },
    
    verMapa: function(){
        this.state.start("navegacion");
        variablesBoot.sonidoBoton.play();
    }
} 