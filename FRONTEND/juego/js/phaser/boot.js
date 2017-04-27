var dispositivoMovil;
var boot ={
	preload: function () {
		game.load.image('barraCarga','../img/componentes/carga/barraCarga.png');		
	},
    
	create: function () {
		this.game.stage.backgroundColor = '#B22222';
		game.physics.startSystem(Phaser.Physics.ARCADE);
		
    	if(isMobile. any()!=null){
            game.scale.forceOrientation(true, false, 'orientation');
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
            dispositivoMovil=true;
   		}else{
   			game.scale.pageAlignHorizontally = true;
        	game.scale.pageAlignVertically = true;
   			dispositivoMovil=false;
   			this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
   		}
   		this.scale.refresh();
    	game.state.start("seleccionavatar");
	}
}