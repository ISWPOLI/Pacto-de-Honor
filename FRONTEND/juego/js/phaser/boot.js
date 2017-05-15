/*
*Este es un estado de precarga
*en el se cargan los ajustes de pantalla dependiendo del diposistivo, las imagenes de varios modulos
*se carga la barra una imagen para que sirva de barra de carga
*/
variablesBoot={
    dispositivoMovil:null,
    musicaMapa:null,
    musicaMenus:null,
    musicaBatalla:null, 
    sonidoBoton:null,
    musicaOnOff :null
}

var boot ={
	preload: function () {
        //Sonido al oprimir botones y musica
        game.load.audio('sonidoBoton', '../img/Componentes/sonidos/sonidoBoton.mp3');
        game.load.audio('musicaMenus','../img/Componentes/sonidos/musicaMenus.mp3');
        game.load.audio('musicaMapa','../img/Componentes/sonidos/musicaMapa.mp3');
        game.load.audio('musicaBatalla','../img/Componentes/sonidos/musicaBatalla.mp3');
        //Barra de carga, boton de volver de todos los estados y boton seleccionar de Seleccion de avatar y personaje
		game.load.image('barraCarga','../img/componentes/carga/barraCarga.png');
        game.load.spritesheet('botonVolver', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);
        game.load.spritesheet('botonSeleccionar', '../img/Componentes/botones/botonSeleccionar.png', 150, 40);
        //Imágenes de los ScrollingMaps de Selección avatar, rankings y Compra personajes
        game.load.image("transp", "../img/personajes/avatares/transp.png");
        game.load.image('pantera', '../img/personajes/avatares/CaraPantera80.png');
        game.load.image('gallo', '../img/personajes/avatares/CaraGallo80.png');
        game.load.image('cierva', '../img/personajes/avatares/CaraCierva80.png');
        game.load.image('jirafa', '../img/personajes/avatares/CaraJirafa80.png');
        game.load.image('leon', '../img/personajes/avatares/CaraLeon80.png');
        game.load.image('canario', '../img/personajes/avatares/CaraCanario80.png');
        game.load.image('ruisenor', '../img/personajes/avatares/CaraRuiseñor80.png');
        game.load.image('raton', '../img/personajes/avatares/CaraRatón80.png');
        game.load.image('hormiga', '../img/personajes/avatares/CaraHormiga80.png');
        //Botones de personajes de Selección de personaje, Códigos alfanuméricos y Créditos
        game.load.spritesheet('botonPantera', '../img/personajes/avatares/botonPantera.png', 125, 125);
        game.load.spritesheet('botonGallo', '../img/personajes/avatares/botonGallo.png', 125, 125);
        game.load.spritesheet('botonCierva', '../img/personajes/avatares/botonCierva.png', 125, 125);
        game.load.spritesheet('botonJirafa', '../img/personajes/avatares/botonJirafa.png', 125, 125);
        game.load.spritesheet('botonLeon', '../img/personajes/avatares/botonLeon.png', 125, 125);
        game.load.spritesheet('botonCanario', '../img/personajes/avatares/botonCanario.png', 125, 125);
        game.load.spritesheet('botonRuisenor', '../img/personajes/avatares/botonRuiseñor.png', 125, 125);
        game.load.spritesheet('botonRaton', '../img/personajes/avatares/botonRaton.png', 125, 125);
        game.load.spritesheet('botonHormiga', '../img/personajes/avatares/botonHormiga.png', 125, 125);
	},
    
	create: function () {
		this.game.stage.backgroundColor = '#B22222';
		game.physics.startSystem(Phaser.Physics.ARCADE);
        cookies.setCookie("token", rtaLogin.token);
        
        //pregunta dsi se visualiza desde un movil desde el archio movil.js
    	if(isMobile. any()!=null){
   			game.scale.forceOrientation(false, true);
   			this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
   			variablesBoot.dispositivoMovil=true;
   		}else{
   			game.scale.pageAlignHorizontally = true;
        	game.scale.pageAlignVertically = true;
   			variablesBoot.dispositivoMovil=false;
   			this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
   		}
        
        variablesBoot.musicaMapa = game.add.audio("musicaMapa");
        variablesBoot.musicaMenus = game.add.audio("musicaMenus");
        variablesBoot.musicaBatalla = game.add.audio("musicaBatalla");
        variablesBoot.sonidoBoton = game.add.audio("sonidoBoton");
        variablesBoot.musicaMapa.loop = true;
        variablesBoot.musicaMenus.loop = true;
        variablesBoot.musicaBatalla.loop = true;
        variablesBoot.musicaBatalla.play();
        variablesBoot.musicaBatalla.pause();
        this.scale.refresh();
    	game.state.start("batalla");
	},
    
    verificarMusica: function(x){
        if(variablesBoot.musicaOnOff){
            switch(x){
                case "menu":
                    variablesBoot.musicaMapa.pause();
                    variablesBoot.musicaBatalla.pause();
                    variablesBoot.musicaMenus.resume();
                    break;
                case "mapa":
                    variablesBoot.musicaMapa.resume();
                    variablesBoot.musicaMenus.pause();
                    variablesBoot.musicaBatalla.pause();
                    break;
                case "batalla":
                    variablesBoot.musicaMenus.pause();
                    variablesBoot.musicaMapa.pause();
                    variablesBoot.musicaBatalla.resume();
                    }
        }
    }
}