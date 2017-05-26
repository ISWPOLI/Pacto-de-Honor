variablesCampoBatalla = {
    idNivel:"1-5", //Guarda el id del nivel a crear
	personajeJugador: null,//guarda el sprite del personaje elegido
    personajeComputadora:null,//guarda el sprite del personaje asignado a un escenario
    cursores:null,//crea cursores
    counter:0,//lleva el tiempo de la partida
   	ti:0,//muestra el avance del tiempo en segundos
   	danoH:null,//daño del heroe
    danoV:null,//daño del villano
    musicButton:null,
	movH:null, //arreglo para saber que accion esta ejecutando el Heroe//[Defensa,ataqueNormal,ataquePersonalidad,DefensaPlagio]
	movV:null,//arreglo para saber que accion esta ejecutando el villano//[Defensa,ataqueNomal,ataquePersonalidad,ataquePlagio]
    ataquePlagio:null, //guarda el sprite del ataque plagio del villano
	ataquePersonalidadC:null,//guarda el sprite del ataque de personalidad del villano
	idPJ:"idPUno",//guarda el id del personaje del jugador
	idPC:"idPUno",//guarda el id del personaje del mapa
	costoAtaqueJ:0,//el consumo de energia que causa el ataque
	costoAtaqueC:0,//el consumo de energia que causa el ataque
	costoPlagioC:0,//el consumo de energia que causa el ataque
	ataquePersonalidadC:null,
	secuencia:false,//pregunta si el villano esta realizando un movimiento
	movimientoComputadora:"adelante",//lleva el movimiento que realiza el villano
	primeImpacto:false,//se usa para que el ataque plagio solo reste vida una vez
	indice:0,//decide que secuencia de ataque realiza el villano
    fondogame:null,//gurada la imagen del fond
    ataquePersonalidadJ:null,//guarda ataque del jugador
    escudo1:null, //guarda la ruta del escudo uno
    escudo2:null,//guarda la ruta del escudo dos
    golpeAlAire:null,//sonido del juego
	golpe_al_cuerpo:null,//sonido del juego
	cambioOrientacion:false,//pregunta si hubo cambio de posciciones
	saltoJ:0,//tiempo de salto
	ganador:true,//true si el jugador gana
	animP:null,//guarda la animaicon de punos del personaje del jugador
	animE:null,//guarda la animaicon de escudo
	unClick:false,//guia para el boton de ataque en version movil 
	botonAtaque:null,//guarda el boton de ataque en la version movil
	botonEscudo:null,//guarda el bton del segundo escudo en la version movil 
	unClickEscudo:false//guia para el boton de ataque en version movil 
	
};

var boxGame = 1;
var caja;
var openBox;
var timeShowBox = Math.round(Math.random(118)*100);
var sendGift = true;
var rect;
var rect1;
var batalla = {
	preload : function() {
		
		this.preloadBar=this.add.sprite(this.game.world.centerX,this.game.world.centerY,'barraCarga');
		this.load.setPreloadSprite(this.preloadBar);
		//boxGame =game.rnd.integerInRange(1, 8);		
		//timeShowBox = game.rnd.integerInRange(5,60);
		funcionesBatalla.cargar(variablesCampoBatalla.idPJ, variablesCampoBatalla.idPC, boxGame, variablesCampoBatalla.idNivel);
	},

	create : function() {	
		variablesCampoBatalla.saltoJ=0; 
		variablesCampoBatalla.cambioOrientacion = false;
		variablesCampoBatalla.counter = 7200;
         if(variablesCampoBatalla.idNivel=='1-1'){
            variablesCampoBatalla.counter=8500;
         }
		variablesCampoBatalla.ti = 0;
		variablesCampoBatalla.danoH=personajesBuenos[variablesCampoBatalla.idPJ].dano;
		variablesCampoBatalla.danoV=personajesMalos[variablesCampoBatalla.idPC].dano;
		variablesCampoBatalla.movH=[false,false,false,false];
		variablesCampoBatalla.movV=[false,false,false,false,false];
		variablesCampoBatalla.costoAtaqueJ=personajesBuenos[variablesCampoBatalla.idPJ].energia*200;
		variablesCampoBatalla.costoAtaqueC=personajesMalos[variablesCampoBatalla.idPJ].energia[0]*200;
		variablesCampoBatalla.costoPlagioC=personajesMalos[variablesCampoBatalla.idPJ].energia[1]*200;
		variablesCampoBatalla.secuencia=false;
 		variablesCampoBatalla.movimientoComputadora="adelante";
		variablesCampoBatalla.primeImpacto=false;
		sendGift = true;
        
        variablesCampoBatalla.ataquePersonalidadC = game.add.weapon(10, 'ataquePersonalidadV');
	 	variablesCampoBatalla.fondogame = game.add.sprite(0, 0, 'fondo');
		variablesCampoBatalla.personajeComputadora = game.add.sprite(650, 300, 'personajeComputadora');
		variablesCampoBatalla.personajeComputadora.anchor.setTo(0.5);
		variablesCampoBatalla.personajeJugador = game.add.sprite(150, 300, 'personajeJugador');
		variablesCampoBatalla.personajeJugador.anchor.setTo(0.5);

		funcionesBatalla.iniciarSprite(variablesCampoBatalla.personajeJugador);
		funcionesBatalla.iniciarSprite(variablesCampoBatalla.personajeComputadora);
		
		
		

		caja = game.add.button(game.rnd.integerInRange(30, (game.width)-30), game.rnd.integerInRange(60, (game.height)-60), "caja",this.catchedBox,this);
        caja.visible = false;
        openBox = game.add.image(game.width/2, game.height/2, 'cajaOpen');
        openBox.anchor.setTo(0.5);
        openBox.visible =false;
        caja.inputEnabled=true;
       	caja.events.onInputUp.add(function () {
			funcionesBatalla.catchedBox()
        });
        //se crea un rectangulo invisibe para simular el piso 
       	rect = game.add.sprite(0, 0, null);
       	game.physics.arcade.enable(rect);
       	rect.body.setSize(800, 45, 0, 400); 
       	rect.body.collideWorldBounds = true; 

       	rect1 = game.add.sprite(0, 0, null);
       	game.physics.arcade.enable(rect1);
       	rect1.body.setSize(800, 45, 0, 400); 
       	rect1.body.collideWorldBounds = true; 


       	

		if(variablesBoot.dispositivoMovil){
			 //Add the VirtualGamepad plugin to the game
        	gamepad = game.plugins.add(Phaser.Plugin.VirtualGamepad);
        	// Add a joystick to the game (only one is allowed right now)
        	joystick = gamepad.addJoystick(100, 500, 1, 'gamepad');       
        	// Add a button to the game (only one is allowed right now)
        	variablesCampoBatalla.botonAtaque = gamepad.addButton(730, 500, 0.8, 'gamepad');
			variablesCampoBatalla.botonEscudo = game.add.button(690, 250, 'botonEscudo',null,null,null,null,1,0);
			variablesCampoBatalla.botonEscudo.scale.setTo(0.8);
			variablesCampoBatalla.botonEscudo.onInputDown.add(function(){
				variablesCampoBatalla.unClickEscudo=true;
			});
			variablesCampoBatalla.botonEscudo.onInputUp.add(function(){
				variablesCampoBatalla.unClickEscudo=false;
			});
			// cursores = game.input.keyboard.createCursorKeys();
			// esp = game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR);
			
			//avatarPersonajeJugador.anchor.setTo(0.9);
			//avatarPersonajeComputadora.anchor.setTo(0.4);
			
			var avatarPersonajeComputadora = game.add.sprite(690, 30, 'avatarPersonajeComputadora');
			var avatarPersonajeJugador = game.add.sprite(20, 30, 'avatarPersonajeJugador');
			
			avatarPersonajeComputadora.scale.setTo(0.45);	
			avatarPersonajeJugador.scale.setTo(0.45);
			
			var botonPoder = game.add.button(690, 350, 'botonPoder', funcionesBatalla.clickBotonPoder, 1, 1, 0, 2);
			botonPoder.scale.setTo(1.2);
			
			var pausa = game.add.button(360, 20, 'pausa', this.pausar,this);
			
			game.add.text(125,20,personajesBuenos[variablesCampoBatalla.idPJ].nombre,{fill:'white'});
            game.add.text(480,20,personajesMalos[variablesCampoBatalla.idPC].nombre,{fill:'white'});
                 
			vidaBlancoJugador = new Phaser.Rectangle(124, 53, personajesBuenos[variablesCampoBatalla.idPJ].vida, 20);//primer barra blanca de vida
			vidaNegroJugador = new Phaser.Rectangle(123, 52, personajesBuenos[variablesCampoBatalla.idPJ].vida+2, 22);//primer borde negro de vida 
			vidaRojoJugador = new Phaser.Rectangle(124, 53, personajesBuenos[variablesCampoBatalla.idPJ].vida, 20);//primer barra roja  de vida

			energiaBlancaJugador = new Phaser.Rectangle(124, 79, 200, 20);//primer barra blanca de energia
			energiaNegroJugador = new Phaser.Rectangle(123, 78, 202, 22);//primer borde negro de energia
			energiaVerdeJugador = new Phaser.Rectangle(124, 79, 200, 20);//primer barra verde de energia

			vidaBlancoComputadora = new Phaser.Rectangle(480, 53, 200, 20);//segunda barra blanca de vida
			vidaNegroComputadora = new Phaser.Rectangle(479, 52, 200, 22);//segunda borde negro de vida 
			vidaRojoComputadora = new Phaser.Rectangle(480, 53, 200, 20);//segunda barra roja		

			energiaBlancaComputadora = new Phaser.Rectangle(480, 79, 200, 20);
			energiaNegroComputadora = new Phaser.Rectangle(479, 78, 200, 22);
			energiaVerdeComputadora = new Phaser.Rectangle(480, 79, 200, 20);
			
			
			pausa.scale.setTo(0.4, 0.4);
			text = game.add.text(360, 110, 'time: 00', {fill : "white", backgroundColor : 'rgba(0,0,0,0.5)'});
            }
        else{

			cursores = game.input.keyboard.createCursorKeys();
			
			teclaEscudo = game.input.keyboard.addKey(Phaser.Keyboard.M);
			
			var avatarPersonajeComputadora = game.add.sprite(665, 30, 'avatarPersonajeComputadora');
			var avatarPersonajeJugador = game.add.sprite(10, 30, 'avatarPersonajeJugador');
			
			avatarPersonajeComputadora.scale.setTo(0.6);	
			avatarPersonajeJugador.scale.setTo(0.6);
			
			var botonPoder = game.add.button(145, 105, 'botonPoder', funcionesBatalla.clickBotonPoder, 1, 1, 0, 2);
			
			var pausa = game.add.button(365, 20, 'pausa', this.pausar,this);
			
			var txtNombrePJ = game.add.text(145,20,personajesBuenos[variablesCampoBatalla.idPJ].nombre,{fill:'white'});
			var txtNombrePC = game.add.text(460,20,personajesMalos[variablesCampoBatalla.idPC].nombre,{fill:'white'});
            var txtMundoNivel = game.add.text(15, 12, variablesCampoBatalla.idNivel, {font: "14px Roboto", fill:'white'});
            txtNombrePJ.stroke = "black";
            txtNombrePJ.strokeThickness = 4;
            txtNombrePC.stroke = "black";
            txtNombrePC.strokeThickness = 4;			
            txtMundoNivel.stroke = "black";
            txtMundoNivel.strokeThickness = 3;
        
			vidaBlancoJugador = new Phaser.Rectangle(144, 53, personajesBuenos[variablesCampoBatalla.idPJ].vida, 20);//primer barra blanca de vida
			vidaNegroJugador = new Phaser.Rectangle(143, 52, personajesBuenos[variablesCampoBatalla.idPJ].vida+2, 22);//primer borde negro de vida 
			vidaRojoJugador = new Phaser.Rectangle(144, 53, personajesBuenos[variablesCampoBatalla.idPJ].vida, 20);//primer barra roja  de vida

			energiaBlancaJugador = new Phaser.Rectangle(144, 79, 200, 20);//primer barra blanca de energia
			energiaNegroJugador = new Phaser.Rectangle(143, 78, 202, 22);//primer borde negro de energia
			energiaVerdeJugador = new Phaser.Rectangle(144, 79, 200, 20);//primer barra verde de energia

			vidaBlancoComputadora = new Phaser.Rectangle(460, 53, personajesMalos[variablesCampoBatalla.idPC].vida, 20);//segunda barra blanca de vida
			vidaNegroComputadora = new Phaser.Rectangle(459, 52, personajesMalos[variablesCampoBatalla.idPC].vida+2, 22);//segunda borde negro de vida 
			vidaRojoComputadora = new Phaser.Rectangle(460, 53, personajesMalos[variablesCampoBatalla.idPC].vida, 20);//segunda barra roja		

			energiaBlancaComputadora = new Phaser.Rectangle(460, 79, 200, 20);
			energiaNegroComputadora = new Phaser.Rectangle(459, 78, 200, 22);
			energiaVerdeComputadora = new Phaser.Rectangle(460, 79, 200, 20);
			
			pausa.scale.setTo(0.4, 0.4);
			text = game.add.text(365, 110, 'time: 00', {
			fill : "white",
			backgroundColor : 'rgba(0,0,0,0.5)'
		});			
		}
        
		pausa.inputEnabled=true;
		//funcion para pausar
		pausa.events.onInputUp.add(function () {
            variablesBoot.sonidoBoton.play();
			funcionesBatalla.pausar();
        });
        game.input.onDown.add(unpause, self);
		//funcion para reaunudar
        function unpause(event){
            variablesBoot.sonidoBoton.play();
        	funcionesBatalla.unpause(event);
        }
        boot.verificarMusica("batalla");


        
    },
       		
    
	render : function() {
		game.debug.geom(vidaNegroJugador, '#000', false);
		game.debug.geom(vidaBlancoJugador, '#fff');
		game.debug.geom(vidaRojoJugador, 'rgb(222,6,6)');

		game.debug.geom(energiaNegroJugador, '#000', false);
		game.debug.geom(energiaBlancaJugador, '#fff');
		game.debug.geom(energiaVerdeJugador, 'rgb(0,255,0)');
		

		game.debug.geom(vidaNegroComputadora, '#000', false);
		game.debug.geom(vidaBlancoComputadora, '#fff');
		game.debug.geom(vidaRojoComputadora, 'rgb(222,6,6)');

		game.debug.geom(energiaNegroComputadora, '#000', false);
		game.debug.geom(energiaBlancaComputadora, '#fff');
		game.debug.geom(energiaVerdeComputadora, 'rgb(0,255,0)');
	},
	//se crea esta funcion para disminuir la barra de energia
    
	update : function() {
        if(variablesCampoBatalla.counter<7200){
            indice=funcionesBatalla.numeroAleatorio(1,4);
        }
        
		funcionesBatalla.cargarEnergia(energiaVerdeJugador);
        funcionesBatalla.cargarEnergia(energiaVerdeComputadora);        
				
		if(variablesBoot.dispositivoMovil)
			funcionesBatalla.joystick(joystick,variablesCampoBatalla.botonAtaque,variablesCampoBatalla.botonEscudo);
		else
			funcionesBatalla.movimientoJugador();
        
          if(variablesCampoBatalla.counter<7200){ funcionesBatalla.guiaComputadora(variablesCampoBatalla.movimientoComputadora);
       } 
		if(!variablesCampoBatalla.secuencia)
			 if(variablesCampoBatalla.counter<7200){
            funcionesBatalla.llamarSecuencia(indice);
             }

		variablesCampoBatalla.counter--;
		variablesCampoBatalla.ti = parseInt(variablesCampoBatalla.counter / 60);
		if (variablesCampoBatalla.ti < 0) {
			funcionesBatalla.finJuego();
		}
		if (variablesCampoBatalla.ti >= 0) {
			text.setText('time: ' + variablesCampoBatalla.ti);
		}
        if(variablesCampoBatalla.idNivel=='1-1'){
    
        if(variablesCampoBatalla.counter==8460){
           if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorialM();} else {funcionesBatalla.tutorial();}
           } if(variablesCampoBatalla.counter==8300){
             texto1.destroy();
            derecha.destroy();
            izquierda.destroy();
        } if(variablesCampoBatalla.counter==8260){
             if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorial2M();} else {funcionesBatalla.tutorial2();}
           }if(variablesCampoBatalla.counter==8100){
             texto2.destroy();
            arriba.destroy();
        } if(variablesCampoBatalla.counter==8060){
             if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorial3M();} else {funcionesBatalla.tutorial3();}
           }if(variablesCampoBatalla.counter==7900){
             texto3.destroy();
            abajo.destroy();
        } if(variablesCampoBatalla.counter==7860 ){
            if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorial4M();} else {funcionesBatalla.tutorial4();}
           }if(variablesCampoBatalla.counter==7700){
             texto4.destroy();
            m.destroy();
        } if(variablesCampoBatalla.counter==7660 ){
            if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorial5M();} else {funcionesBatalla.tutorial5();}
           } if(variablesCampoBatalla.counter==7500){
             texto5.destroy();
            espacio.destroy();
        }if(variablesCampoBatalla.counter==7460){
            if(variablesBoot.dispositivoMovil) {funcionesBatalla.tutorial6M();} else {funcionesBatalla.tutorial6();}
           }if(variablesCampoBatalla.counter==7250){
             texto6.destroy();
               n.destroy();
               energia.destroy();
               vida.destroy();
        }
        }
		if(variablesCampoBatalla.ti == timeShowBox){
			funcionesBatalla.showBox();	
		}

		if(variablesCampoBatalla.ti == timeShowBox + 3){
			funcionesBatalla.hideBox();
		}
		if (caja.visible) {
			caja.angle += 1
			caja.x-=2;
			caja.y-=3;
		}
		if(variablesCampoBatalla.ti == timeShowBox + 5){
			funcionesBatalla.hideOpenBox();

		}
		if (boxGame == 7 && !openBox.visible) {
			variablesCampoBatalla.danoH=personajesBuenos[variablesCampoBatalla.idPJ].dano;
			variablesCampoBatalla.personajeJugador.scale.setTo(1,1);
		}
	
		if (openBox.visible) {
				if (boxGame == 1 && !sendGift) {
					gameTime = gameTime + funcionesBatalla.giftbox();
				};
				if (boxGame == 2 && !sendGift) {
					energiaVerdeJugador.width = funcionesBatalla.giftlife(energiaVerdeJugador);
				};
				if (boxGame == 3 && !sendGift) {
					vidaRojoJugador.width = funcionesBatalla.giftlife(vidaRojoJugador);
				}
				if (boxGame == 4 && !sendGift) {
					vidaRojoJugador.width = funcionesBatalla.steallife(vidaRojoJugador);
				}
				if (boxGame == 5 && !sendGift ) {
					var cblood = funcionesBatalla.changelife(vidaRojoJugador,vidaRojoComputadora);
					vidaRojoJugador.width = cblood[1];
					vidaRojoComputadora.width =cblood[0];
				}
				if (boxGame == 6) {
					energiaVerdeJugador.width = 0;
				}
				if (boxGame == 7) {
					variablesCampoBatalla.danoH = funcionesBatalla.getstrong(variablesCampoBatalla.danoH);
					variablesCampoBatalla.personajeJugador.scale.setTo(1.5,1.5);
				}
				if (boxGame == 8) {
					var cbloodd = funcionesBatalla.fatality(vidaRojoJugador,vidaRojoComputadora);
					vidaRojoJugador.width = cbloodd[1];
					vidaRojoComputadora.width =cbloodd[0];
				}
				sendGift = true;
		};		
			
			if(Math.abs(Math.abs(variablesCampoBatalla.personajeJugador.body.x)-Math.abs(variablesCampoBatalla.personajeComputadora.body.x))<98){
				if(variablesCampoBatalla.cambioOrientacion){
					variablesCampoBatalla.personajeJugador.scale.setTo(1,1);
					variablesCampoBatalla.personajeComputadora.scale.setTo(1,1);
					variablesCampoBatalla.personajeComputadora.body.x+=200;
					variablesCampoBatalla.personajeJugador.body.x-=100;
					variablesCampoBatalla.cambioOrientacion=false;
				}else{
					variablesCampoBatalla.personajeJugador.scale.setTo(-1,1);
					variablesCampoBatalla.personajeComputadora.scale.setTo(-1,1);
					variablesCampoBatalla.personajeComputadora.body.x-=100;
					variablesCampoBatalla.personajeJugador.body.x+=100;
					variablesCampoBatalla.cambioOrientacion=true;
				}
			}
			
			
			

		
		
		game.physics.arcade.collide(rect1, variablesCampoBatalla.personajeJugador);
		game.physics.arcade.collide(rect, variablesCampoBatalla.personajeComputadora);
		game.physics.arcade.overlap(variablesCampoBatalla.personajeJugador,variablesCampoBatalla.ataquePlagio,funcionesBatalla.impactoPlagioC,false,this);
		game.physics.arcade.overlap(variablesCampoBatalla.personajeJugador,variablesCampoBatalla.ataquePersonalidadC.bullets,funcionesBatalla.impactoAtaqueComputadora,false,this);
		game.physics.arcade.overlap(variablesCampoBatalla.personajeComputadora,variablesCampoBatalla.ataquePersonalidadJ,funcionesBatalla.impactoAtaqueJugador,false,this);
        game.physics.arcade.collide(variablesCampoBatalla.personajeJugador,variablesCampoBatalla.personajeComputadora, funcionesBatalla.colision, null, this);
       }		
}