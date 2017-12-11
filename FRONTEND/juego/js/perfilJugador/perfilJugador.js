variablesPerfilJugador={
     NicknamePerfil:null,
     MonedasPerfil:null,
     NivelPerfil:null,
     MundoPerfil:null,
     ExperienciaPerfil:null,
     NivelMundoPerfil:null
}

var perfilJugador = function(game){};
    perfilJugador.prototype = {
        preload : function(){
            game.load.image('avatar', datosperfil["datos"].avatar);
		    game.load.spritesheet('boton-personaje', '../img/componentes/botones/botonPersonaje.png');
            game.load.spritesheet('boton-jefes', '../img/componentes/botones/botonJefes.png');
            game.load.spritesheet('boton-trofeo', '../img/componentes/botones/botonTrofeo.png');
            game.load.spritesheet('boton-alfanumerico', '../img/componentes/botones/botonAlfanumerico.png');
        },

        create : function (){


            game.stage.backgroundColor = "#2451A6";
    		    game.add.sprite(80, 50,'avatar').scale.setTo(0.8);

            game.add.button(5, 5,'botonVolver', this.verNavegacion, 1, 1, 0, 2);
            game.add.button(90, 290,'boton-personaje', this.verCampeones, 0, 0, 0, 0);
            game.add.button(450, 290,'boton-jefes', this.verJefes, 0, 0, 0, 0);
            game.add.button(90, 450,'boton-trofeo', this.verLogros, 0, 0, 0, 0);
            game.add.button(450, 450,'boton-alfanumerico', this.verAlfanumercios, 0, 0, 0, 0);

            game.add.text(400, 50, "Perfil del usuario", {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(400, 100, "Nickname: " + obtenerLocalStorage("Nickname"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(590, 100, "Mundo: " +obtenerLocalStorage("Mundo"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(360, 150, "Nivel: " +obtenerLocalStorage("NivelPersonaje"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(590, 150, "Monedas: " +obtenerLocalStorage("Oro"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(360, 200, "Experiencia: " +obtenerLocalStorage("Xp"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(590, 200, "Nivel Mundo: " +obtenerLocalStorage("NivelMundo"), {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);


            boot.verificarMusica("menu");
        },

        verNavegacion: function(){
            game.state.start("navegacion");
            variablesBoot.sonidoBoton.play();
        },

        verLogros: function(){
            game.state.start("logros");
            variablesBoot.sonidoBoton.play();
        },
        verCampeones: function(){
            game.state.start("campeones");
            variablesBoot.sonidoBoton.play();
        },
         verJefes: function(){
            game.state.start("boss");
            variablesBoot.sonidoBoton.play();
        },
        verAlfanumercios:function(){
            game.state.start("desbloqueoPersonaje");
            variablesBoot.sonidoBoton.play();
        },

        update : function(){

	   }
}
