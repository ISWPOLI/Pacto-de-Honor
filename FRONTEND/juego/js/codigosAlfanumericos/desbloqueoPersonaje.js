variableDesbloqueoPersonaje ={
	input:null,
	codigo:null,
	mapnumeros1:0,
	mapletras1:0,
	string:"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
	CadenaAnalizar:0,
	possible:"ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890",
	text:null,
	text2:null

};

var desbloqueoPersonaje = function(game){};
desbloqueoPersonaje.prototype = {
    preload: function(){
        game.load.spritesheet('ingresar', '../img/componentes/botones/ingresar.png', 193,71);
    },
    
    create: function(){ 
		game.stage.backgroundColor = "#2451A6";
		game.add.plugin(PhaserInput.Plugin);
	    variableDesbloqueoPersonaje.input = game.add.inputField(100, 493,{
			font: '18px Arial',
			fill: '#212121',
			fontWeight: 'bold',
			width: 360,
			padding: 8,
			borderWidth: 1,
			borderColor: '#000',
			borderRadius: 6,
			placeHolder: 'Tu codigo aqui'});
        
        btFlechar = game.add.button (5, 5, 'botonVolver', this.verPerfilJugador, 0, 0, 0, 1);
		
		btPantera = game.add.button (240, 60, 'botonPantera', this.code1, 0, 0, 0, 1);
		btPantera.scale.setTo(0.8,0.8);
		//btPantera.scale.setTo(0.5, 0.5);

		btLLama = game.add.button(380,280,'botonCierva',this.code2,0,0,0,1);
		btLLama.scale.setTo(0.8,0.8);
		//btLLama.scale.setTo(0.5,0.5);

		btPajaro= game.add.button(380,170,'botonRuisenor',this.code3,0,0,0,1);
		btPajaro.scale.setTo(0.8,0.8);
		//btPajaro.scale.setTo(0.5,0.5);

		btLeon = game.add.button(240,280,'botonLeon',this.code4,0,0,0,1);
		btLeon.scale.setTo(0.8,0.8);
		//btLeon.scale.setTo(0.5,0.5);

		btJirafa= game.add.button(520,280,'botonJirafa',this.code5,0,0,0,1);
		btJirafa.scale.setTo(0.8,0.8);
		//btJirafa.scale.setTo(0.5,0.5);

		btGallo = game.add.button(520,170,'botonGallo',this.code6,0,0,0,1);
		btGallo.scale.setTo(0.8,0.8);
		//btGallo.scale.setTo(0.5,0.5);

		btHotmiga= game.add.button(520,60,'botonHormiga',this.code7,0,0,0,1);
		
		btHotmiga.scale.setTo(0.8,0.8);

		btCanario= game.add.button(380,60,'botonCanario',this.code8,0,0,0,1);
		btCanario.scale.setTo(0.8,0.8);
		//btCanario.scale.setTo(0.5,0.5);
		btRata= game.add.button(240,170,'botonRaton',this.code9,0,0,0,1);
		btRata.scale.setTo(0.8,0.8);

		btIngresar  = game.add.button(570,480,'ingresar',validarString,this,2,1,0);
		btIngresar.scale.setTo(0.9,0.9);
		variableDesbloqueoPersonaje.codigo = game.add.inputField(100,400, {
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

function validarString () {
	variableDesbloqueoPersonaje.CadenaAnalizar = variableDesbloqueoPersonaje.input.value;
    if(variableDesbloqueoPersonaje.CadenaAnalizar.length!=11){
        return alert("Tu codigo de regalo tiene mas o menos de 11 digitos por favor verificalo");
    }
    variableDesbloqueoPersonaje.mapnumeros1 = new Array();
    for(var i = 1; i <= 9 ; i++){
        variableDesbloqueoPersonaje.mapnumeros1[i]=true;
    }
    //variableDesbloqueoPersonaje.string ="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    variableDesbloqueoPersonaje.mapletras1 = new Array();
    for(var i = 0 ; i <= variableDesbloqueoPersonaje.string.length; i++){
        variableDesbloqueoPersonaje.mapletras1[variableDesbloqueoPersonaje.string.substr(i,1)]=true;
    }
    
    for(var i = 0; i < variableDesbloqueoPersonaje.CadenaAnalizar.length ; i++){
        if(i==0 && variableDesbloqueoPersonaje.mapnumeros1[variableDesbloqueoPersonaje.CadenaAnalizar.substr(i,1)]==undefined){
            return alert("Tu codigo esta mal escrito o no existe");;

        }else if(((i>=1 && i<=4)||(i>=6 && i<=9)) && variableDesbloqueoPersonaje.mapletras1[variableDesbloqueoPersonaje.CadenaAnalizar.substr(i,1)]==undefined){
            return alert("Tu codigo esta mal escrito o no existe");;

        }else if(i==5 && variableDesbloqueoPersonaje.CadenaAnalizar.substr(i,1)!="-"){
            return alert("Tu codigo esta mal escrito o no existe");;

        }else if(i==10 && (variableDesbloqueoPersonaje.CadenaAnalizar.substr(i,1)=="P")){
            return alert("Has desbloqueado a tu personaje con exito, este codigo ha sido regalado por un profesor");
				$ajax({
        		type:"POST",
        		dataType: 'json',
        		data:JsonAlfa,
        		url:'poliFight/webresources/codigos/alfaNumericos/unlockCharacter',//Falta la direccion del servidor en la url.
        		succes:function(data){

        			return alert("Has desbloqueado a tu personaje con exito, este codigo ha sido regalado por un profesor");

        		}


        	});
        }else if(i==10 && (variableDesbloqueoPersonaje.CadenaAnalizar.substr(i,1)=="E")){//al entrar en este bloque de codigo se enviara el
        																					//al servidor.
            
                    	return alert("Has desbloqueado a tu personaje con exito, este codigo ha sido regalado por un amigo");

        	$ajax({
        		type:"POST",
        		dataType: 'json',
        		data:JsonAlfa,
        		url:'poliFight/webresources/codigos/alfaNumericos/unlockCharacter',//Falta la direccion del servidor en la url.
        		succes:function(data){

        			return alert("Has desbloqueado a tu personaje con exito, este codigo ha sido regalado por un estudiante");

        		}


        	});
        	return alert("Has desbloqueado a tu personaje con exito, este codigo ha sido regalado por un amigo");
        }
    }
    return alert("Tu codigo esta mal escrito o no existe");
}  
		//var letra = input.value;
	//alfaNumeric(letra);

	/*},
	alfaNumeric1:function(){
		var letra = input.value;
		var expresion = /^1[A-Z][-][A-Z]+E$/;
		if(letra.match(expresion)){
	alert("esta");
		}else{
	alert("no esta");
		}
*/

	},
	verPerfilJugador:function(){
        game.state.start("perfilJugador");
        variablesBoot.sonidoBoton.play();
    },
    
	code1:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("1"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
		
	},
	code2:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("2"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code3:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("3"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code4:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 =variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("4"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code5:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("5"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code6:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("6"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code7:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("7"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
	},
	code8:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("8"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");

	},code9:function(){
	     	variableDesbloqueoPersonaje.text = "";
	     	variableDesbloqueoPersonaje.text2 = "";
			//var possible = "ABCDEFGHIJKLMNIOPQRSTUVWXYZ1234567890";
			for(var i = 0; i < 4; i++){
				variableDesbloqueoPersonaje.text = variableDesbloqueoPersonaje.text + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
				variableDesbloqueoPersonaje.text2 = variableDesbloqueoPersonaje.text2 + variableDesbloqueoPersonaje.possible.charAt(Math.floor(Math.random() * variableDesbloqueoPersonaje.possible.length));
			}
			variableDesbloqueoPersonaje.codigo.setText("9"+ variableDesbloqueoPersonaje.text + "-" + variableDesbloqueoPersonaje.text2 + "E");
}}