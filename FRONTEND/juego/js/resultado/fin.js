
var fin = {
    preload: function(){
		this.preloadBar=this.add.sprite(this.game.world.centerX,this.game.world.centerY,'barraCarga');
		
        game.load.image('poli', '../img/componentes/finBatalla/poli.jpg');
        game.load.image('monedas','../img/componentes/finBatalla/moneda.png');  
        game.load.image('experiencia','../img/componentes/finBatalla/experiencia.png');
        game.load.spritesheet('botonFinBatalla','../img/componentes/finBatalla/botonVolver.png',598,140);
        
        
    },
    create: function(){
		var resultado;
		var color;
        var exp;
        var coins;
        
        /*console.log("Nombre: "+personajesBuenos[variablesCampoBatalla.idPJ].nombre);
        console.log("Daño normal: "+personajesBuenos[variablesCampoBatalla.idPJ].dano[0]);
        console.log("Daño especial: "+personajesBuenos[variablesCampoBatalla.idPJ].dano[1]);
        console.log("Vida: "+personajesBuenos[variablesCampoBatalla.idPJ].vida);
        console.log("Defensa: "+personajesBuenos[variablesCampoBatalla.idPJ].defensa);
        console.log("Energia: "+personajesBuenos[variablesCampoBatalla.idPJ].energia);
        console.log("Nivel: "+personajesBuenos[variablesCampoBatalla.idPJ].nivel);
        console.log("Experiencia: "+personajesBuenos[variablesCampoBatalla.idPJ].exp);*/
       
		if(variablesCampoBatalla.ganador){
			resultado = "GANASTE";
			color = {fill:'#01DF01',font: '40px Arial'};
            coins = 200;
            datosperfil["datos"].monedas += 200;
            exp = 100;
            datosperfil["datos"].experiencia += 100;
            personajesBuenos[variablesCampoBatalla.idPJ].exp += 100;
		}else{
			resultado = "PERDISTE";
			color = {fill:'#DF0101',font: '40px Arial'};
            coins = 0;
            exp = 10;
            datosperfil["datos"].experiencia += 10;
            personajesBuenos[variablesCampoBatalla.idPJ].exp += 10;
		}
        boot.verificarNivelJugador();
        boot.verificarNivelPersonajes();
        
        /*console.log("Nombre: "+personajesBuenos[variablesCampoBatalla.idPJ].nombre);
        console.log("Daño normal: "+personajesBuenos[variablesCampoBatalla.idPJ].dano[0]);
        console.log("Daño especial: "+personajesBuenos[variablesCampoBatalla.idPJ].dano[1]);
        console.log("Vida: "+personajesBuenos[variablesCampoBatalla.idPJ].vida);
        console.log("Defensa: "+personajesBuenos[variablesCampoBatalla.idPJ].defensa);
        console.log("Energia: "+personajesBuenos[variablesCampoBatalla.idPJ].energia);
        console.log("Nivel: "+personajesBuenos[variablesCampoBatalla.idPJ].nivel);
        console.log("Experiencia: "+personajesBuenos[variablesCampoBatalla.idPJ].exp);*/
        
		if(variablesBoot.dispositivoMovil){
			game.add.sprite(0, 0, 'poli');
        	personaje = game.add.sprite(game.world.width/2,game.world.height/1.3, 'personajeJugador');
        	personaje.scale.setTo(1.1);
        	personaje.anchor.setTo(1.1);
        	personaje.frame = 24;
        
        	var name = datosperfil["datos"].nickname;
        	win= game.add.text(game.world.width/3,game.world.height/4,resultado,color);
        	win.anchor.x=0.5;
        	win.anchor.y = 0.5;
        
        	game.add.text(game.world.width/5,game.world.height/1.25,name,color);

        	//se agrega el icono de las monedas ganadas por el jugador
        	monedas = game.add.sprite(game.world.width/1.7,game.world.height/2.5,'monedas');
        	monedas.scale.setTo(0.6);
        	monedas.anchor.setTo(0.4);
        
        	//se agrega el boton de experiencia
        	experiencia = game.add.sprite(game.world.width/1.7,game.world.height/1.5,'experiencia');
        	experiencia.scale.setTo(0.6);
        	experiencia.anchor.setTo(0.4);
        
        	//textos de la monedas y experiencia obtenida
        	game.add.text(game.world.width/1.4,game.world.height/2.78,'+ 250 ',{fill:'#FF8000',font: '40px Arial'});
        
        	game.add.text(game.world.width/1.4,game.world.height/1.58,'+ 350',{fill:'#2E64FE',font: '40px Arial'});
        
        	//se le agrega el boton que lo devuelve a la pantalla principal
        	volver = game.add.button(game.world.width/1.53,game.world.height/1.2,'botonFinBatalla',this.volver,1,1,0,2);
        	volver.scale.setTo(0.4);
        	volver.anchor.setTo(0.3);
				
		}else{
			game.add.sprite(0, 0, 'poli');
        	personaje = game.add.sprite(game.world.width/2,game.world.height/1.3, 'personajeJugador');
        	personaje.scale.setTo(1.1);
        	personaje.anchor.setTo(1.1);
        	personaje.frame = 24;
        
        	var name = datosperfil["datos"].nickname;
        	win= game.add.text(game.world.width/3,game.world.height/4,resultado,color);
        	win.anchor.x=0.5;
        	win.anchor.y = 0.5;
        
        	game.add.text(game.world.width/5,game.world.height/1.25,name,color);

        	//se agrega el icono de las monedas ganadas por el jugador
        	monedas = game.add.sprite(game.world.width/1.7,game.world.height/2.5,'monedas');
        	monedas.scale.setTo(0.6);
        	monedas.anchor.setTo(0.4);
        
        	//se agrega el boton de experiencia
        	experiencia = game.add.sprite(game.world.width/1.7,game.world.height/1.5,'experiencia');
        	experiencia.scale.setTo(0.6);
        	experiencia.anchor.setTo(0.4);
        
        	//textos de la monedas y experiencia obtenida
        	game.add.text(game.world.width/1.4,game.world.height/2.78,'+ '+coins,{fill:'#FF8000',font: '40px Arial'});
        
        	game.add.text(game.world.width/1.4,game.world.height/1.58,'+ '+exp,{fill:'#2E64FE',font: '40px Arial'});
        
        	//se le agrega el boton que lo devuelve a la pantalla principal
        	volver = game.add.button(game.world.width/1.53,game.world.height/1.2,'botonFinBatalla',this.volver,1,1,0,2);
        	volver.scale.setTo(0.4);
        	volver.anchor.setTo(0.3);
		}
    },
    volver: function(){
        game.state.start('navegacion');
        variablesBoot.sonidoBoton.play();
    }
}