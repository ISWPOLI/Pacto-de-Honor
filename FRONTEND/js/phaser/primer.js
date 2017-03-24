var gallo1;
var oso1
var cursores;
var counter = 0;
var text = 0;

var primer = {
	preload: function(){
		
		game.load.image('fondo', 'assets/12.png');
		game.load.image('oso1','personajes/oso5.png');
		game.load.spritesheet('gallo1','assets/gallo.png',188.5,201.5);
		game.load.image('caraoso','assets/caraoso5.png');
		game.load.image('caragallo','assets/caragallo.png');
		game.load.image('pausa','assets/pausa.png');
		game.add.image('laser','assets/1.png');
	},

	create: function(){
        game.physics.startSystem(Phaser.Physics.ARCADE);
		var x = 200;
		var fondogame = game.add.sprite(0, 0, 'fondo');
		oso1 = game.add.sprite(650,450,'oso1');
		oso1.scale.setTo(2,2);
		oso1.anchor.setTo(0.5);
		gallo1 = game.add.sprite(150,450,'gallo1');
		gallo1.scale.setTo(0.9,0.9);
		gallo1.anchor.setTo(0.5);
		gallo1.frame = 0;
		gallo1.animations.add('corre',[0,1,2,3,4,5,6,7], 10, true);
		game.physics.arcade.enable(gallo1);
        gallo1.body.collideWorldBounds = true;
		cursores = game.input.keyboard.createCursorKeys();
		var caraoso = game.add.sprite(665,30,'caraoso');
		caraoso.scale.setTo(1.3,1.3);
		var caragallo = game.add.sprite(10,30,'caragallo');
		caragallo.scale.setTo(1.3,1.3);
		var pausa = game.add.sprite(365,20,'pausa');
		pausa.scale.setTo(0.35,0.35);
		text = game.add.text(352, 90, 'time: 0 ',{fill:"white", backgroundColor: 'rgba(0,0,0,0.5)'});
   		
   		floor = new Phaser.Rectangle(144, 53, x, 20);
   		floor2 = new Phaser.Rectangle(143, 52, 202, 22);
   		floor3 = new Phaser.Rectangle(144, 53, x-10, 20);

   		floorb = new Phaser.Rectangle(460, 53, x, 20);
   		floor2b = new Phaser.Rectangle(459, 52, 202, 22);
   		floor3b = new Phaser.Rectangle(460, 53, x, 20);

   		floorc = new Phaser.Rectangle(144, 79, x, 20);
   		floor2c = new Phaser.Rectangle(143, 78, 202, 22);
   		floor3c = new Phaser.Rectangle(144, 79, x-100, 20);

   		floord = new Phaser.Rectangle(460, 79, x, 20);
   		floor2d = new Phaser.Rectangle(459, 78, 202, 22);
   		floor3d = new Phaser.Rectangle(460, 79, x, 20);
   		//game.time.events.loop(Phaser.Timer.SECOND, update, this);
   		
   		
	},

	iniciargame: function(){
			
		
	},

	render: function(){
		game.debug.geom(floor2,'#000',false);		
		game.debug.geom(floor,'#fff');
		game.debug.geom(floor3,'rgb(222,6,6)');
			
		game.debug.geom(floor2b,'#000',false);		
		game.debug.geom(floorb,'#fff');
		game.debug.geom(floor3b,'rgb(222,6,6)');

		game.debug.geom(floor2c,'#000',false);		
		game.debug.geom(floorc,'#fff');
		game.debug.geom(floor3c,'rgb(0,255,0)');

		
		game.debug.geom(floor2d,'#000',false);		
		game.debug.geom(floord,'#fff');
		game.debug.geom(floor3d,'rgb(0,255,0)');

	},

	update: function(){
//		game.physics.arcade.overlap(gallo1,oso1,colision,null,this);
		
		if (cursores.right.isDown) {
			gallo1.scale.setTo(0.9,0.9);
			gallo1.position.x += 3;
			gallo1.animations.play('corre');
		}
		else if (cursores.left.isDown) {
			gallo1.scale.setTo(-0.9,0.9);
			gallo1.position.x -= 3;
			gallo1.animations.play('corre');
		}
		else if (cursores.down.isDown) {
			gallo1.angle = -65;
		}
		else if (cursores.down.isUp) {
			gallo1.angle= 0;
			gallo1.animations.stop('corre');
		}
		else{
			gallo1.animations.stop('corre');
		}
		
			counter += 1;

   		 	text.setText('time: '+( parseInt(counter/60)) );


	},

//	colision: function(gallo1,oso1){
//		oso1.kill();
//		gallo1.kill();
//	},
}