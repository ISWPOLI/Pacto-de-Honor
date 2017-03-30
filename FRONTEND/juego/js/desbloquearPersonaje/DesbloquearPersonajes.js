var btLLama, btPajaro, btLeon, btGallo, btJirafa, btHotmiga, btCanario, btHiena, btIngresar;
window.onload = function(){
    game = new Phaser.Game(800,600, Phaser.AUTO,"");
    game.state.add("theGame1", theGame1);
    game.state.start("theGame1");
}
var Personajes = function(game){};
Personajes.prototype = {

    preload: function(){
        game.load.image('llama', 'personajesB/1.png');
         game.load.image('llama', 'personajesB/1.png');
          game.load.image('llama', 'personajesB/1.png');
           game.load.image('llama', 'personajesB/1.png');
            game.load.image('llama', 'personajesB/1.png');
             game.load.image('llama', 'personajesB/1.png');
              game.load.image('llama', 'personajesB/1.png');
               game.load.image('llama', 'personajesB/1.png');
                gme.load.spritesheet('ingresar', 'personajesB/buttonIngresar.png', 193,71);
    },create:function(){


game.stage.backgroundColor = '#124184'
btLLama = game.add.button(430,260,'llama',null,0,0,0,1);
btLLama.scale.setTo(0.5,0.5);

btPajaro= game.add.button(260,260,'llama',null,0,0,0,1);
btPajaro.scale.setTo(0.5,0.5);

btLeon = game.add.button(100,260,'llama',null,0,0,0,1);
btLeon.scale.setTo(0.5,0.5);

 btJirafa= game.add.button(600,260,'llama',null,0,0,0,1);
btJirafa.scale.setTo(0.5,0.5);

 btGallo = game.add.button(600,100,'llama',null,0,0,0,1);
btGallo.scale.setTo(0.5,0.5);

 btHotmiga= game.add.button(430,100,'llama',null,0,0,0,1);
btHotmiga.scale.setTo(0.5,0.5);

 btCanario= game.add.button(260,100,'llama',null,0,0,0,1);
btCanario.scale.setTo(0.5,0.5);

 btHiena= game.add.button(100,100,'llama',null,0,0,0,1);
btHiena.scale.setTo(0.5,0.5);

btIngresar  = game.add.button(570,450,'llama',null,0,0,0,1);
btIngresar.scale.setTo(0.5,0.5);


    }
}