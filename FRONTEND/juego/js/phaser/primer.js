var personajeJugador;//guarda el sprite del personaje elegido
var personajeComputadora//guarda el sprite del personaje asignado a un escenario
var cursores;//crea cursores
var counter = 0;
var ti = 0;
var x = 200; // heroe
var y = 200; // villano
var danoH=[6,10]; //daño del heroe
var danoV=[6,10,15]; //daño del villano

//arreglo para saber que accion esta ejecutando el Heroe
//[Defensa,ataqueNormal,ataquePersonalidad]
var movH=[false,false,false];

//arreglo para saber que accion esta ejecutando el villano
//[Defensa,ataqueNomal,ataquePersonalidad,ataquePlagio]
var movV=[false,false,false,false];

var ataquePlagio;
var ataquePersonalidadV;
var idPJ="idPDos";
var idPC="idPUno";
//es  200 es temporal y varia dependiendo de la pantalla 
var costoAtaqueJ=personajesBuenos[idPJ].energia*200;
var costoAtaqueC=personajesMalos[idPJ].energia[0]*200;
var costoPlagioC=personajesMalos[idPJ].energia[1]*200;
var ataquePersonalidadJ;
var ataquePersonalidadC;
var secuencia=false;
var movimientoComputadora="adelante";
var primeImpacto=false;
var indice;
var primer = {
	preload : function() {		
		funcionesBatalla.cargar(idPJ,idPC);
	},

	create : function() {		
		game.physics.startSystem(Phaser.Physics.ARCADE);
		ataquePersonalidadC = game.add.weapon(10, 'ataquePersonalidadV');
		var fondogame = game.add.sprite(0, 0, 'fondo');
		ataqueJ=game.add.group();
		personajeComputadora = game.add.sprite(650, 450, 'personajeComputadora');
		personajeComputadora.anchor.setTo(0.5);
		personajeJugador = game.add.sprite(150, 450, 'personajeJugador');
		personajeJugador.anchor.setTo(0.5);
		funcionesBatalla.iniciarSprite(personajeJugador);
		funcionesBatalla.iniciarSprite(personajeComputadora);
		cursores = game.input.keyboard.createCursorKeys();
		esp = game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR);
		game.add.text(145,20,personajesBuenos[idPJ].nombre,{fill:'white'});
		game.add.text(460,20,personajesMalos[idPC].nombre,{fill:'white'});

		var avatarPersonajeComputadora = game.add.sprite(665, 30, 'avatarPersonajeComputadora');
		avatarPersonajeComputadora.scale.setTo(0.6);
		var avatarPersonajeJugador = game.add.sprite(10, 30, 'avatarPersonajeJugador');
		avatarPersonajeJugador.scale.setTo(0.6);
		var pausa = game.add.button(365, 20, 'pausa', this.pausar,this);
		pausa.inputEnabled=true;
		//funcion para pausar
		pausa.events.onInputUp.add(function () {
			funcionesBatalla.pausar()
        });
		game.input.onDown.add(unpause, self);
		//funcion para reaunudar
        function unpause(event){
        	funcionesBatalla.unpause(event);
        }  
		pausa.scale.setTo(0.4, 0.4);
		text = game.add.text(365, 110, 'time: 99', {
			fill : "white",
			backgroundColor : 'rgba(0,0,0,0.5)'
		});
		vidaBlancoJugador = new Phaser.Rectangle(144, 53, 200, 20);//primer barra blanca de vida
		vidaNegroJugador = new Phaser.Rectangle(143, 52, 202, 22);//primer borde negro de vida 
		vidaRojoJugador = new Phaser.Rectangle(144, 53, 200, 20);//primer barra roja  de vida

		energiaBlancaJugador = new Phaser.Rectangle(144, 79, 200, 20);//primer barra blanca de energia
		energiaNegroJugador = new Phaser.Rectangle(143, 78, 202, 22);//primer borde negro de energia
		energiaVerdeJugador = new Phaser.Rectangle(144, 79, 200, 20);//primer barra verde de energia

		vidaBlancoComputadora = new Phaser.Rectangle(460, 53, 200, 20);//segunda barra blanca de vida
		vidaNegroComputadora = new Phaser.Rectangle(459, 52, 200, 22);//segunda borde negro de vida 
		vidaRojoComputadora = new Phaser.Rectangle(460, 53, 200, 20);//segunda barra roja		

		energiaBlancaComputadora = new Phaser.Rectangle(460, 79, 200, 20);
		energiaNegroComputadora = new Phaser.Rectangle(459, 78, 200, 22);
		energiaVerdeComputadora = new Phaser.Rectangle(460, 79, 200, 20);
		

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
	
	activarPlagio: function(){
			
        	ataquePlagio.destroy();
	},
	update : function() {
		indice=funcionesBatalla.numeroAleatorio(1,4)
		
		funcionesBatalla.cargarEnergia(energiaVerdeJugador);
		funcionesBatalla.cargarEnergia(energiaVerdeComputadora);
		funcionesBatalla.movimientoJugador(energiaVerdeJugador);
		
		funcionesBatalla.guiaComputadora(movimientoComputadora);
		if(!secuencia)
			funcionesBatalla.llamarSecuencia(indice);	
		counter++;
		ti = parseInt(counter / 60);
		if (ti == 70) {
			funcionesBatalla.finJuego();
		}
		if (ti <= 70) {
			text.setText('time: ' + ti);
		} 
		game.physics.arcade.overlap(personajeJugador,ataquePlagio,funcionesBatalla.impactoPlagioC,false,this);
		game.physics.arcade.overlap(personajeJugador,ataquePersonalidadC.bullets,funcionesBatalla.impactoAtaqueComputadora,false,this);
		game.physics.arcade.overlap(personajeComputadora,ataquePersonalidadJ,funcionesBatalla.impactoAtaqueJugador,false,this);
        game.physics.arcade.collide(personajeJugador, personajeComputadora, funcionesBatalla.colision, null, this);
       }
		
}