
var password;
var text;
var text2;
var str;
var str2;
 var codigo;
var desbloqueo = function(game){};
desbloqueo.prototype = {
     preload: function(){
        game.load.spritesheet('pantera1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/pantera1.png', 212,197);
         game.load.spritesheet('gallo1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/gallo1.png', 212,197);
          game.load.spritesheet('hormiga1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/hormiga1.png', 212,197);
          // game.load.image('leon', 'images/leon.png');
            game.load.spritesheet('jirafa1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/jirafa1.png', 212,197);
             game.load.spritesheet('llama1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/llama1.png', 212,197);
              game.load.spritesheet('canario1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/canario1.png', 212,197);
               game.load.spritesheet('pajaro1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/pajaro1.png', 212,197);
                game.load.spritesheet('leon1', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/leon1.png', 212,197);
           game.load.spritesheet('flecha', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/arrow.png', 175.5,89);
 game.load.spritesheet('ingresar', 'FRONTEND/juego/img/Componentes/desbloquearPersonaje/ingresar.png', 193,71);

                     
     },
     create: function(){ 
     //game.add.plugin(PhaserInput.Plugin); 
    game.stage.backgroundColor = '#1873CE';
game.add.plugin(PhaserInput.Plugin);

 var input = game.add.inputField(100, 493,{
    font: '18px Arial',
    fill: '#212121',
    fontWeight: 'bold',
    width: 360,
    padding: 8,
    borderWidth: 1,
    borderColor: '#000',
    borderRadius: 6,
    placeHolder: 'Tu codigo aqui'
 
});//
btFlechar = game.add.button (10, 10, 'flecha', null, 0, 0, 0, 1);
 btFlechar.scale.setTo(0.5, 0.5);

 btPantera = game.add.button (100, 100, 'pantera1', this.code1, 0, 0, 0, 1);
 btPantera.scale.setTo(0.5, 0.5);

btLLama = game.add.button(430,260,'llama1',this.code2,0,0,0,1);
btLLama.scale.setTo(0.5,0.5);

btPajaro= game.add.button(260,260,'pajaro1',this.code3,0,0,0,1);
btPajaro.scale.setTo(0.5,0.5);

btLeon = game.add.button(100,260,'leon1',this.code4,0,0,0,1);
btLeon.scale.setTo(0.5,0.5);

 btJirafa= game.add.button(600,260,'jirafa1',this.code5,0,0,0,1);
btJirafa.scale.setTo(0.5,0.5);

 btGallo = game.add.button(600,100,'gallo1',this.code6,0,0,0,1);
btGallo.scale.setTo(0.5,0.5);

 btHotmiga= game.add.button(430,100,'hormiga1',this.code7,0,0,0,1);
btHotmiga.scale.setTo(0.5,0.5);

 btCanario= game.add.button(260,100,'canario1',this.code8,0,0,0,1);
btCanario.scale.setTo(0.5,0.5);


btIngresar  = game.add.button(570,480,'ingresar',null,this,2,1,0);
btIngresar.scale.setTo(0.9,0.9);
//********************************Generador str*************************************
var randomString = function(length){
text = "";
var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
for(var i = 0; i < length; i++){
	text += possible.charAt(Math.floor(Math.random() * possible.length));

}
return text;

   }
//**********************************Generador str2*************************************
var randomString2 = function(length){
text2 = "";
var possible2 = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
for(var i = 0; i < length; i++){
	text2 += possible2.charAt(Math.floor(Math.random() * possible2.length));

}
return text2;

   }
//**********************************************************************************
      str = randomString(4);
      str2 = randomString2(4);
codigo = game.add.inputField(100,400, {
                font: '18px Arial',
                fill: '#212121',
                fillAlpha: 1,
                fontWeight: 'bold',
                width: 600,
                 padding: 8,
              borderRadius: 6,
           zoom: true,
         textAlign: 'center',
                borderColor: '#FFFFFF',
              max:11,
              min:11,
                placeHolder: '¡Haz clic en algun personaje para regalar el codigo de el a un amigo!',
       
                
            }); 	

     },
     code1:function(){
codigo.setText("1"+ str + " - " +str2 + "E");
    },
     code2:function(){
codigo.setText("2"+ str + " - " +str2 + "E");
    },
     code3:function(){
codigo.setText("3"+ str + " - " +str2 + "E");
    },
     code4:function(){
codigo.setText("4"+ str + " - " +str2 + "E");
    },
     code5:function(){
codigo.setText("5"+ str + " - " +str2 + "E");
    },
     code6:function(){
codigo.setText("6"+ str + " - " +str2 + "E");
    },
     code7:function(){
codigo.setText("7"+ str + " - " +str2 + "E");
    },
     code8:function(){
codigo.setText("8"+ str + " - " +str2 + "E");
    }


   

}
