
var boot ={
	preload: function () {
		game.load.image('barraCarga','../img/componentes/carga/barraCarga.png');
	},
	create: function () {
		this.game.stage.backgroundColor = '#B22222';
		
    	this.game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
    	this.scale.refresh();
    	
    	console.log(game.device.iOS);
    	game.state.start('seleccionavatar');

	}

}