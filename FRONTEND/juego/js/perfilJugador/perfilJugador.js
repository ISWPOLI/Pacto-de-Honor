variablesPerfilJugador={
     NicknamePerfil:null,
     MonedasPerfil:null,
     NivelPerfil:null,
     MundoPerfil:null
}

//var MundoPerfil;
//var NivelPerfil;
//var MonedasPerfil;

var perfilJugador = function(game){};
    perfilJugador.prototype = {
        preload : function(){
            game.load.image('avatar','../img/Componentes/perfilJugador/avatar.png');
		    game.load.spritesheet('boton-personaje', '../img/Componentes/botones/boton-personaje.png');
            game.load.spritesheet('boton-jefes', '../img/Componentes/botones/boton-jefes.png');
            game.load.spritesheet('boton-trofeo', '../img/Componentes/botones/boton-trofeo.png');
            game.load.spritesheet('boton-alfanumerico', '../img/Componentes/botones/boton-alfanumerico.png');
        },

        create : function (){
            variablesPerfilJugador.NicknamePerfil = datosperfil["datos"].nickname;
            variablesPerfilJugador.MundoPerfil = datosperfil["datos"].mundo;
            variablesPerfilJugador.NivelPerfil = datosperfil["datos"].nivel;
            variablesPerfilJugador.MonedasPerfil = datosperfil["datos"].monedas;
            game.stage.backgroundColor = "#2451A6";
		    game.add.sprite(50, 50,'avatar');
		
            game.add.button(5, 5,'botonVolver', this.verNavegacion, 1, 1, 0, 2);
            game.add.button(90, 290,'boton-personaje', null, 0, 0, 0, 0);
            game.add.button(450, 290,'boton-jefes', null, 0, 0, 0, 0);
            game.add.button(90, 450,'boton-trofeo', this.verLogros, 0, 0, 0, 0);
            game.add.button(450, 450,'boton-alfanumerico', this.verAlfanumercios, 0, 0, 0, 0);

            game.add.text(400, 50, "Perfil del usuario", {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(400, 130, "Nickname: " + variablesPerfilJugador.NicknamePerfil, {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(590, 130, "Mundo: " +variablesPerfilJugador.MundoPerfil, {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(360, 200, "Nivel: " +variablesPerfilJugador.NivelPerfil, {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            game.add.text(590, 200, "Monedas: " +variablesPerfilJugador.MonedasPerfil, {font: "25px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            
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
        verAlfanumercios:function(){
            game.state.start("desbloqueoPersonaje");
            variablesBoot.sonidoBoton.play();
        },

        update : function(){

	   }
}