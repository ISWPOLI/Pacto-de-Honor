
var gallo1;
var oso1
var cursores;
var text;
var counter = 0;
var ti = 0;
var x = 180; // heroe
var y = 200; // villano
var oso1;
var gallo1;
var primer = {

	preload : function() {

		
		game.load.image('fondo', '../img/escenarios/escenariosSecundarios/nivel1.png');
		game.load.spritesheet('oso1', '../img/sprites/personajesMalos/oso.png',200,200);
		game.load.spritesheet('gallo1', '../img/sprites/personajesBuenos/gallo.png', 200, 200);
		game.load.image('caraoso', '../img/componentes/batalla/caraoso5.png');
		game.load.image('caragallo', '../img/componentes/batalla/caragallo.png');
		game.load.image('pausa', '../img/componentes/batalla/pausa.png');
		game.load.image('menup', '../img/componentes/batalla/menup.png');
		

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
		floor = new Phaser.Rectangle(144, 53, 201, 20);//primer borde negro
		floor2 = new Phaser.Rectangle(143, 52, 202, 22);//primer barra blanca
		floor3 = new Phaser.Rectangle(144, 53, 201, 20);//primer barra

		floord = new Phaser.Rectangle(460, 79, 201, 20);
		floor2d = new Phaser.Rectangle(459, 78, 202, 22);
		floor3d = new Phaser.Rectangle(460, 79, x, 20);


		floorb = new Phaser.Rectangle(460, 53, 201, 20);
		floor2b = new Phaser.Rectangle(459, 52, 202, 22);
		floor3b = new Phaser.Rectangle(460, 53, x, 20);

		floorc = new Phaser.Rectangle(144, 79, 201, 20);
		floor2c = new Phaser.Rectangle(143, 78, 202, 22);
		floor3c = new Phaser.Rectangle(144, 79, y, 20);
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
 	 colision : function(){
 	 	gallo1.position.x -=100;
 	 	oso1.position.x+=200;
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
		} else if (cursores.up.isDown) {
			gallo1.animations.play('especial');

		} else if (esp.isDown){
			gallo1.animations.play('punos');
			gallo1.body.x+=2;
		}else{			
			gallo1.animations.play('quieto')
		}


		 if(oso1.position.x>gallo1.position.x+200){
 	 		oso1.body.x -= 3;	
 	 		oso1.animations.play('correr');
 		}else{
 			//oso1.animations.play('quieto')
 			oso1.animations.play('punos');

 	 	}

		counter++;
		ti = parseInt(counter / 60);
		if (ti == 2) {
			game.add.text(200,200,'JUEGO TERMINADO', {font:'45px'});
		}
		if (ti <= 3) {
			text.setText('time: ' + ti);
		} else {
			game.state.start('fin');
		}

		 game.physics.arcade.collide(gallo1, oso1, this.colision, null, this);
		 game.physics.arcade.collide(gallo1, oso1);

	}

	
}
