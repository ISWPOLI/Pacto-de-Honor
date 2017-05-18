var musicButton;
var startButton;
var seleccionado;
var txtSeleccionado;
var botones = [];

var seleccionpersonaje = function(game){};
seleccionpersonaje.prototype = {
    preload: function(){
        
     },
    
    create: function(){
        game.stage.backgroundColor = "#2451A6"; //Fondo
        botonVolver = game.add.button(5, 5, 'botonVolver', this.verNavegacion, 1, 1, 0, 2);
        this.pageText = game.add.text(game.width / 2, 45, "Selección de Personaje", {font: "32px Roboto", fill: "#ffffff"})
        this.pageText.anchor.set(0.5); //Se crea el titulo
        txtSeleccionado = game.add.text(10, 540, "Personaje Seleccionado", {font: "20px Roboto", fill: "#ffffff"}); //Texto para pj seleccionado
        avatarSeleccionado = game.add.image (270, 550, null); //Se crea una imagen vacia para el pj seleccionado
        avatarSeleccionado.anchor.setTo(0.5);
        avatarSeleccionado.scale.setTo(0.5);
        txtSeleccionado.visible = false; 
        avatarSeleccionado.visible = false; //Se ocultan el texto y la imagen del pj seleccionado
        
        //Se crean los botones de los personajes
        botones[0] = game.add.button(175, 75, 'botonPantera', this.clickPantera, 1, 1, 0, 2);
        botones[1] = game.add.button(325, 75, 'botonGallo', this.clickGallo, 1, 1, 0, 2);
        botones[2] = game.add.button(475, 75, 'botonCierva', this.clickCierva, 1, 1, 0, 2);
        botones[3] = game.add.button(175, 225, 'botonJirafa', this.clickJirafa, 1, 1, 0, 2);
        botones[4] = game.add.button(325, 225, 'botonLeon', this.clickLeon, 1, 1, 0, 2);
        botones[5] = game.add.button(475, 225, 'botonCanario', this.clickCanario, 1, 1, 0, 2);
        botones[6] = game.add.button(175, 375, 'botonRuisenor', this.clickRuisenor, 1, 1, 0, 2);
        botones[7] = game.add.button(325, 375, 'botonRaton', this.clickRaton, 1, 1, 0, 2);
        botones[8] = game.add.button(475, 375, 'botonHormiga', this.clickHormiga, 1, 1, 0, 2);
                 
        startButton = game.add.button(game.world.width / 2, 550, 'botonSeleccionar', this.verbatalla, this, 2, 1, 0); // over, out, down, up
        startButton.anchor.set(0.5);

        if(startButton==true){
            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getpregunta26');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setpregunta26('false');

            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getpregunta269');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setpregunta269('true');

            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getpregunta254');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setpregunta254('true');
        }
        
        boot.verificarMusica("menu");
    },
    
    verNavegacion: function(){
        sonidoBoton.play();
        game.state.start("navegacion");
    },
                         
    //Cada una de las siguientes funciones modifica la variable del campo de batalla idPJ y hace visible el texto y la imagen del pj seleccionado
    clickPantera: function(){
        variablesCampoBatalla.idPJ="idPUno";
        avatarSeleccionado.loadTexture('pantera');
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickGallo: function(){
        variablesCampoBatalla.idPJ="idPDos";
        avatarSeleccionado.loadTexture('gallo');
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickCierva: function(){
        variablesCampoBatalla.idPJ="idPTres";
        avatarSeleccionado.loadTexture('cierva');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickJirafa: function(){
        variablesCampoBatalla.idPJ="idPCuatro";
        avatarSeleccionado.loadTexture('jirafa');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickLeon: function(){
        variablesCampoBatalla.idPJ="idPCinco";
        avatarSeleccionado.loadTexture('leon');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickCanario: function(){
        variablesCampoBatalla.idPJ="idPSeis";
        avatarSeleccionado.loadTexture('canario');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickRuisenor: function(){
        variablesCampoBatalla.idPJ="idPSiete";
        avatarSeleccionado.loadTexture('ruisenor');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickRaton: function(){
        variablesCampoBatalla.idPJ="idPOcho";
        avatarSeleccionado.loadTexture('raton');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    clickHormiga: function(){
        variablesCampoBatalla.idPJ="idPNueve";
        avatarSeleccionado.loadTexture('hormiga');
        avatarSeleccionado.visible = true;
        txtSeleccionado.visible = true;
        avatarSeleccionado.visible = true;
        sonidoBoton.play();
    },
    
    verbatalla: function () {
        sonidoBoton.play();
        if(variablesCampoBatalla.idPJ == null){
            alert("Selecciona un personaje");
        }
        else{
        this.state.start ("batalla");
        }
    }
}