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
        game.load.audio('sonidoBoton', '../img/componentes/sonidos/sonidoBoton.mp3');
        game.load.audio('musicaMenus','../img/componentes/sonidos/musicaMenus.mp3');
        game.load.audio('musicaMapa','../img/componentes/sonidos/musicaMapa.mp3');
        game.load.audio('musicaBatalla','../img/componentes/sonidos/musicaBatalla.mp3');
        //Barra de carga, boton de volver de todos los estados y boton seleccionar de Seleccion de avatar y personaje
		game.load.image('barraCarga','../img/componentes/carga/barraCarga.png');
        game.load.spritesheet('botonVolver', '../img/componentes/navegacionMapa/botonVolver.png', 62, 62);
        game.load.spritesheet('botonSeleccionar', '../img/componentes/botones/botonSeleccionar.png', 150, 40);
        //Imágenes de los ScrollingMaps de Selección avatar, rankings y compra personajes
        game.load.image("transp", "../img/personajes/avatares/transp.png");
        game.load.image('pantera', '../img/personajes/avatares/caraPantera80.png');
        game.load.image('gallo', '../img/personajes/avatares/caraGallo80.png');
        game.load.image('cierva', '../img/personajes/avatares/caraCierva80.png');
        game.load.image('jirafa', '../img/personajes/avatares/caraJirafa80.png');
        game.load.image('leon', '../img/personajes/avatares/caraLeon80.png');
        game.load.image('canario', '../img/personajes/avatares/caraCanario80.png');
        game.load.image('ruisenor', '../img/personajes/avatares/caraRuisenor80.png');
        game.load.image('raton', '../img/personajes/avatares/caraRaton80.png');
        game.load.image('hormiga', '../img/personajes/avatares/caraHormiga80.png');
        //Botones de personajes de Selección de personaje, Códigos alfanuméricos y Créditos
        game.load.spritesheet('botonPantera', '../img/personajes/avatares/botonPantera.png', 125, 125);
        game.load.spritesheet('botonGallo', '../img/personajes/avatares/botonGallo.png', 125, 125);
        game.load.spritesheet('botonCierva', '../img/personajes/avatares/botonCierva.png', 125, 125);
        game.load.spritesheet('botonJirafa', '../img/personajes/avatares/botonJirafa.png', 125, 125);
        game.load.spritesheet('botonLeon', '../img/personajes/avatares/botonLeon.png', 125, 125);
        game.load.spritesheet('botonCanario', '../img/personajes/avatares/botonCanario.png', 125, 125);
        game.load.spritesheet('botonRuisenor', '../img/personajes/avatares/botonRuisenor.png', 125, 125);
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
        this.verificarNivelJugador();
        this.verificarNivelPersonajes();
        game.state.start("seleccionavatar");
	},
    
    //Función que revisa el nivel del Jugador
    verificarNivelJugador: function(){
        var nuevoNivel = 0; //variable de ayuda para el nivel
        $.each(nivelJugador, function (key, data) { //Recorre todos los objetos dentro de NivelJugador (archivo nivelExperiencia.js)
            if(datosperfil["datos"].experiencia >= nivelJugador[key].exp){ //Si la exp del Jugador es mayor o igual al campo exp en nivelJugador
                nuevoNivel++; //Aumenta en 1 el nuevoNivel
                datosperfil["datos"].nivel = nuevoNivel; //Asigna nuevoNivel al nivel del Jugador
                }
        });
    },
    
    //Función para verificar el nivel de los Personajes
    verificarNivelPersonajes: function(){
        $.each(personajesBuenos, function (key, data) { //Recorre todos los objetos dentro de personajesBuenos (archivo personajes.js)
            var nuevoNivelPJ = 0; //Variable de ayuda para el nivel de personaje
            $.each(nivelPersonaje, function (key2, data2) { //Recorre todos los objetos dentro de NivelPersonaje (archivo nivelExperiencia.js)
                if(personajesBuenos[key].exp >= nivelPersonaje[key2].exp){ //Si la exp del pj es mayor o igual al campo exp en nivelPersonaje
                    nuevoNivelPJ++; //Aumenta en 1 el nuevoNivelPJ
                    //Se asignan los valores de daño, energia, defensa, vida y nivel dependiendo de la experiencia de cada personaje
                    personajesBuenos[key].dano = nivelPersonaje[key2].dano;
                    personajesBuenos[key].energia = nivelPersonaje[key2].energia;
                    personajesBuenos[key].defensa = nivelPersonaje[key2].defensa;
                    personajesBuenos[key].vida = nivelPersonaje[key2].vida;
                    personajesBuenos[key].nivel = nuevoNivelPJ;
                    }
            });
        });
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