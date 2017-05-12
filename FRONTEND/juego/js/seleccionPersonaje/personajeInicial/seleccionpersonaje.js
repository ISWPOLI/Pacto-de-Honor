var musicButton;
var startButton;
var seleccionado;
var txtSeleccionado;
var botones = [];

var seleccionpersonaje = function(game){};
seleccionpersonaje.prototype = {
    preload: function(){
        game.scale.pageAlignHorizontally = true;
        game.scale.pageAlignVertically = true;
        //Se cargan las imagenes de los botones de los personajes
        game.load.spritesheet('pantera', '../img/personajes/avatares/botonPantera.png', 125, 125);
        game.load.spritesheet('gallo', '../img/personajes/avatares/botonGallo.png', 125, 125);
        game.load.spritesheet('cierva', '../img/personajes/avatares/botonCierva.png', 125, 125);
        game.load.spritesheet('jirafa', '../img/personajes/avatares/botonJirafa.png', 125, 125);
        game.load.spritesheet('leon', '../img/personajes/avatares/botonLeon.png', 125, 125);
        game.load.spritesheet('canario', '../img/personajes/avatares/botonCanario.png', 125, 125);
        game.load.spritesheet('ruisenor', '../img/personajes/avatares/botonRuiseñor.png', 125, 125);
        game.load.spritesheet('raton', '../img/personajes/avatares/botonRaton.png', 125, 125);
        game.load.spritesheet('hormiga', '../img/personajes/avatares/botonHormiga.png', 125, 125);
        game.load.spritesheet('button', '../img/Componentes/botones/botonSeleccionar.png', 150, 40);
         
        game.load.audio('sonidoBoton', '../img/Componentes/sonidos/Botones/1.mp3');
     },
    create: function(){
        musicButton = game.add.audio('sonidoBoton');
        game.stage.backgroundColor = "#2451A6"; //Fondo
        this.pageText = game.add.text(game.width / 2, 45, "Selección de Personaje", {font: "32px Roboto", fill: "#ffffff"})
        this.pageText.anchor.set(0.5); //Se crea el titulo
        txtSeleccionado = game.add.text(10, 540, "Personaje Seleccionado", {font: "20px Roboto", fill: "#ffffff"}); //Texto para pj seleccionado
        avatarSeleccionado = game.add.image (270, 550, null); //Se crea una imagen vacia para el pj seleccionado
        avatarSeleccionado.anchor.setTo(0.5);
        avatarSeleccionado.scale.setTo(0.5);
        txtSeleccionado.visible = false; 
        avatarSeleccionado.visible = false; //Se ocultan el texto y la imagen del pj seleccionado
        
        //Se crean los botones de los personajes
        botones[0] = game.add.button(175, 75, 'pantera', this.clickPantera, 1, 1, 0, 2);
        botones[1] = game.add.button(325, 75, 'gallo', this.clickGallo, 1, 1, 0, 2);
        botones[2] = game.add.button(475, 75, 'cierva', this.clickCierva, 1, 1, 0, 2);
        botones[3] = game.add.button(175, 225, 'jirafa', this.clickJirafa, 1, 1, 0, 2);
        botones[4] = game.add.button(325, 225, 'leon', this.clickLeon, 1, 1, 0, 2);
        botones[5] = game.add.button(475, 225, 'canario', this.clickCanario, 1, 1, 0, 2);
        botones[6] = game.add.button(175, 375, 'ruisenor', this.clickRuisenor, 1, 1, 0, 2);
        botones[7] = game.add.button(325, 375, 'raton', this.clickRaton, 1, 1, 0, 2);
        botones[8] = game.add.button(475, 375, 'hormiga', this.clickHormiga, 1, 1, 0, 2);
                 
        startButton = game.add.button(game.world.width / 2, 550, 'button', this.verbatalla, this, 2, 1, 0); // over, out, down, up
        startButton.anchor.set(0.5);

        if(startButton==true){
            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba1');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba1('false');
        }

    },
    //Cada una de las siguientes funciones modifica la variable del campo de batalla idPJ y hace visible el texto y la imagen del pj seleccionado
    clickPantera: function(){
        variablesCampoBatalla.idPJ="idPUno";
        avatarSeleccionado.loadTexture('pantera');
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickGallo: function(){
        variablesCampoBatalla.idPJ="idPDos";
        avatarSeleccionado.loadTexture('gallo');
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickCierva: function(){
        variablesCampoBatalla.idPJ="idPTres";
        avatarSeleccionado.loadTexture('cierva');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickJirafa: function(){
        variablesCampoBatalla.idPJ="idPCuatro";
        avatarSeleccionado.loadTexture('jirafa');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickLeon: function(){
        variablesCampoBatalla.idPJ="idPCinco";
        avatarSeleccionado.loadTexture('leon');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickCanario: function(){
        variablesCampoBatalla.idPJ="idPSeis";
        avatarSeleccionado.loadTexture('canario');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickRuisenor: function(){
        variablesCampoBatalla.idPJ="idPSiete";
        avatarSeleccionado.loadTexture('ruisenor');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickRaton: function(){
        variablesCampoBatalla.idPJ="idPOcho";
        avatarSeleccionado.loadTexture('raton');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    clickHormiga: function(){
        variablesCampoBatalla.idPJ="idPNueve";
        avatarSeleccionado.loadTexture('hormiga');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
    },
    
    verbatalla: function () {
        musicButton.play();
        if(variablesCampoBatalla.idPJ == null){
            alert("Selecciona un personaje");
        }
        else{
        this.state.start ("batalla");
        }
    }
}