
var password;
var text;
var text2;
var str;
var str2;
var codigo;
var desbloqueo = function(game){};
desbloqueo.prototype = {
    preload: function(){
        game.load.spritesheet('pantera1', 'codigosAlfa/pantera1.png', 212,197);
        game.load.spritesheet('gallo1', 'codigosAlfa/gallo1.png', 212,197);
        game.load.spritesheet('hormiga1', 'codigosAlfa/hormiga1.png', 212,197);
        game.load.spritesheet('jirafa1', 'codigosAlfa/jirafa1.png', 212,197);
        game.load.spritesheet('llama1', 'codigosAlfa/llama1.png', 212,197);
        game.load.spritesheet('canario1', 'codigosAlfa/canario1.png', 212,197);
        game.load.spritesheet('pajaro1', 'codigosAlfa/pajaro1.png', 212,197);
        game.load.spritesheet('leon1', 'codigosAlfa/leon1.png', 212,197);
        game.load.spritesheet('flecha', 'codigosAlfa/arrow.png', 175.5,89);
 		game.load.spritesheet('ingresar', 'codigosAlfa/ingresar.png', 193,71);          
    },
    create: function(){ 
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
			placeHolder: 'Tu codigo aqui'});

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
		    placeHolder: '¡Haz clic en algun personaje para regalar el codigo de el a un amigo!'});

	


	},
	code1:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("1"+ text + " - " + text2 + "E");
			var m = codigo.value.includes("1");
			console.log(m);
			var n = text.includes("1");
			console.log(n);
	},
	code2:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("2"+ text + " - " + text2 + "E");
	},
	code3:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("3"+ text + " - " + text2 + "E");
	},
	code4:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("4"+ text + " - " + text2 + "E");
	},
	code5:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("5"+ text + " - " + text2 + "E");
	},
	code6:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("6"+ text + " - " + text2 + "E");
	},
	code7:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("7"+ text + " - " + text2 + "E");
	},
	code8:function(){
	     	text = "";
	     	text2 = "";
			var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				text = text + possible.charAt(Math.floor(Math.random() * possible.length));
				text2 = text2 + possible.charAt(Math.floor(Math.random() * possible.length));
			}
			codigo.setText("8"+ text + " - " + text2 + "E");
	}
}
