var gallo1;//guarda el sprite del gallo
var oso1//guarda el sprite del oso
var cursores;//crea cursores
var text;
var counter = 0;
var ti = 0;
var x = 200; // heroe
var y = 200; // villano
var atqueH1=6;//ataque heroe
var ataqueV1=6;//ataque villano
var atqueH2=10;//ataque heroe especial 
var ataqueV2=10;//ataque villano especia
var ataqueV3=15;//ataque villano plagio

var danoH=[6,2]; //daño del heroe
var danoV=[6,10,15]; //daño del villano

//arreglo para saber que accion esta ejecutando el villano
//[ataqueNomal,ataquePersonalidad,ataquePlagio,Defensa]
var movV=[false,false,false,false];
//arreglo para saber que accion esta ejecutando el Heroe
//[ataqueNomal,ataquePersonalidad,ataquePlagio,Defensa]
var movH=[false,false,false,false];

var ataquePlagio;
var ataquePersonalidadV;
var ataquePersonalidadB;
var primer = {

	preload : function() {

		
		game.load.image('fondo', '../img/escenarios/escenariosSecundarios/nivel1.png');
		game.load.spritesheet('oso1', '../img/sprites/personajesMalos/oso.png',200,200);
		game.load.spritesheet('gallo1', '../img/sprites/personajesBuenos/gallo.png', 200, 200);
		game.load.image('caraoso', '../img/componentes/batalla/caraoso.png');
		game.load.image('caragallo', '../img/componentes/batalla/caragallo.png');
		game.load.image('pausa', '../img/componentes/batalla/pausa.png');
		game.load.image('menup', '../img/componentes/batalla/menup.png');
		game.load.spritesheet('ataquePlagio', '../img/sprites/poderes/poderesPlagioMalos/error404.png',500,500);
		game.load.image('ataquePersonalidadV', '../img/sprites/poderes/PoderesPersonalidadMalos/camiloPERSONALIDAD.png');
		game.load.image('ataquePersonalidadB', '../img/sprites/poderes/PoderesPersonalidadBuenos/AndresGallo.png');
		

	},

	create : function() {
		game.physics.startSystem(Phaser.Physics.ARCADE);

		


		var fondogame = game.add.sprite(0, 0, 'fondo');
		oso1 = game.add.sprite(650, 450, 'oso1');
		//oso1.scale.setTo(-1, 1);
		oso1.anchor.setTo(0.5);
		gallo1 = game.add.sprite(150, 450, 'gallo1');
		gallo1.scale.setTo(0.9, 0.9);
		gallo1.anchor.setTo(0.5);
		gallo1.frame = 1;

		gallo1.animations.add('quieto', [1], 10, true);
    	gallo1.animations.add('correr', [6, 7, 8, 9, 11, 12, 13, 14], 10, true);
    	gallo1.animations.add('punos', [16, 17, 18, 19], 7, true);
    	gallo1.animations.add('defensa', [21], 10, true);
    	gallo1.animations.add('especial', [23, 24], 10, true);
    	gallo1.animations.play('quieto');
		game.physics.arcade.enable(gallo1);
		gallo1.body.collideWorldBounds = true; 

		oso1.animations.add('quieto', [1], 10, true);
    	oso1.animations.add('correr', [6, 7, 8, 9, 11, 12, 13, 14], 10, true);
    	oso1.animations.add('punos', [16, 17, 18, 19], 7, true);
   	 	oso1.animations.add('defensa', [21], 10, true);
    	oso1.animations.add('especial', [23, 24], 10, true);
    	oso1.animations.play('quieto');   
    	

		 game.physics.arcade.enable(oso1);
		 oso1.body.collideWorldBounds = true;
		
		cursores = game.input.keyboard.createCursorKeys();
		esp = game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR);
		game.add.text(145,20,'Andres Gallo',{fill:'white'});
		 game.add.text(460,20,'Felipe Oso',{fill:'white'});



		var caraoso = game.add.sprite(665, 30, 'caraoso');
		caraoso.scale.setTo(0.6);
		var caragallo = game.add.sprite(10, 30, 'caragallo');
		caragallo.scale.setTo(0.6);
		var pausa = game.add.button(365, 20, 'pausa', this.pausar,this);
		pausa.inputEnabled=true;
		//funcion para pausar
		pausa.events.onInputUp.add(function () {
			game.paused=true;

				 //choiseLabel = game.add.text(300, 300, 'continuar', { font: '30px Arial', fill: '#fff' });
				 	lal=game.add.image(270,170,'menup');
				    lal.scale.setTo(1.5);
		});

		game.input.onDown.add(unpause, self);
		//funcion para reaunudar
		 function unpause(event){
		 	if(game.paused){

                fondogame.destroy();

                // Unpause the game
                game.paused = false;
                counter=0;
                game.state.start('primer');
		 	}
		 };
		
		pausa.scale.setTo(0.4, 0.4);
		text = game.add.text(365, 110, 'time: 99', {
			fill : "white",
			backgroundColor : 'rgba(0,0,0,0.5)'
		});
		// game.time.event.loop(Phaser.Timer.SECOND, updateCounter, this);
		floor = new Phaser.Rectangle(144, 53, 200, 20);//primer barra blanca
		floor2 = new Phaser.Rectangle(143, 52, 200, 22);//primer borde negro
		floor3 = new Phaser.Rectangle(144, 53, 200, 20);//primer barra roja

		floorc = new Phaser.Rectangle(144, 79, 200, 20);
		floor2c = new Phaser.Rectangle(143, 78, 200, 22);
		floor3c = new Phaser.Rectangle(144, 79, 200, 20);


		floorb = new Phaser.Rectangle(460, 53, 200, 20);
		floor2b = new Phaser.Rectangle(459, 52, 200, 22);
		floor3b = new Phaser.Rectangle(460, 53, 200, 20);//segunda barra roja

		

		floord = new Phaser.Rectangle(460, 79, 200, 20);
		floor2d = new Phaser.Rectangle(459, 78, 200, 22);
		floor3d = new Phaser.Rectangle(460, 79, 200, 20);
		//var animacion = game.add.tween(oso1).to({
		//	x : 400
		//}, 1000, Phaser.Easing.Linear.None, true, 0, 70, true);

	},

	

	render : function() {
		game.debug.geom(floor2, '#000', false);
		game.debug.geom(floor, '#fff');
		game.debug.geom(floor3, 'rgb(222,6,6)');

		game.debug.geom(floor2b, '#000', false);
		game.debug.geom(floorb, '#fff');
		game.debug.geom(floor3b, 'rgb(222,6,6)');

		game.debug.geom(floor2c, '#000', false);
		game.debug.geom(floorc, '#fff');
		game.debug.geom(floor3c, 'rgb(0,255,0)');

		game.debug.geom(floor2d, '#000', false);
		game.debug.geom(floord, '#fff');
		game.debug.geom(floor3d, 'rgb(0,255,0)');

	},
	//se crea esta funcion para disminuir la barra de energia
	actualizarBarra: function(barra,daño){
		if(barra.width-daño>0)
			barra.width=barra.width-daño;
		else{
			barra.width=0;
			game.state.start("fin"); 
		}
	},
	activarEspecial: function(){
		ataquePlagio = game.add.sprite(0,gallo1.body.y-200, 'ataquePlagio');
 			game.physics.arcade.enable(ataquePlagio);
			ataquePlagio.collideWorldBounds = true; 
        	ataquePlagio.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 15, false,true);
        	ataquePlagio.animations.play('especiall');
        	ataquePlagio.destroy();
	},
	destruirSprite:function(sprite){
		sprite.destroy();
	},
 	 colision : function(){
 	 	gallo1.position.x -=100;
 	 	oso1.position.x+=200;
 	 },
 	
	colision : function(){
 	 	gallo1.position.x -=100;
 	 	gallo1.animations.play('correr');
 	 	oso1.position.x+=200;
 	 	//oso1.animations.play('correr',20,false,true);
 	 	if(movV[0]==true&&!movH[3]){
 	 		primer.actualizarBarra(floor3,danoV[0]);
 	 		movH[3]=false;
 	 		movV[0]=false;
 	 	}
 	 	if(movH[0]){
 	 		primer.actualizarBarra(floor3b,danoH[0]);
 	 		movH[0]=false;
 	 	}if(movV[2]==true){
 	 		if(!movH[3]){
 	 			primer.actualizarBarra(floor3,danoV[2]);
 	 			movH[3]=false;
 	 		}
 	 		//destruirSprite(ataquePlagio);

 	 	}

 	 },
	update : function() {

		if (cursores.right.isDown) {
			gallo1.body.x+=2;
        	gallo1.animations.play('correr');
		} else if (cursores.left.isDown) {
			gallo1.body.x-=2;
        	gallo1.animations.play('correr');
		} else if (cursores.down.isDown) {
			gallo1.animations.play('defensa');
			movH[3]=true;

		} else if (cursores.up.isDown) {
			gallo1.animations.play('especial');
			movH[1]=true;

		} else if (esp.isDown){
			gallo1.animations.play('punos');
			gallo1.body.x+=2;
			movH[0]=true;
		}else{			
			gallo1.animations.play('quieto')
			movH[0]=false;
		}


		 if(floor3b.width>100){
		 	if(oso1.position.x-(gallo1.x+200)>60){
 	 		oso1.body.x -= 3;	
 	 		oso1.animations.play('correr');
 	 		}else{
 	 		 	oso1.animations.play('punos');
 				oso1.body.x-=2;
 				movV[0]=true
 	 		}
 		}else{
 			if(oso1.position.x<200){
 				oso1.body.x += 3;	
 	 			oso1.animations.play('correr');
 	 		}else{
 	 			if(movV[2]==false){
 	 				oso1.animations.play('especial');
        			ataquePlagio = game.add.sprite(0,gallo1.body.y-200, 'ataquePlagio');
 					game.physics.arcade.enable(ataquePlagio);
					ataquePlagio.collideWorldBounds = true; 
        			ataquePlagio.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 15, false,true);
        			ataquePlagio.animations.play('especiall');
        		}else{
        			oso1.animations.play('punos');
 					oso1.body.x-=2;
 					movV[0]=true
 				}
        		
 	 		}

 			
 	 	}

		counter++;
		ti = parseInt(counter / 60);
		if (ti == 70) {
			game.add.text(200,200,'JUEGO TERMINADO', {font:'45px'});
		}
		if (ti <= 70) {
			text.setText('time: ' + ti);
		} else {
			game.state.start('fin');
		}

		game.physics.arcade.overlap(gallo1,ataquePlagio,this.colision);
		 game.physics.arcade.collide(gallo1, oso1, this.colision, null, this);
		 game.physics.arcade.collide(gallo1, oso1);

	}

	
}
