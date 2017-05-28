vN = {// Variables encapsuladas del los botones y textos de los botones.
    btMundo:null, 
    btMundo2:null, 
    btMundo3:null, 
    btMundo4:null, 
    btMundo5:null,
    btMundo6:null,
    btMundo7:null,
    btMundo8:null,
    btMundo9:null,
    btMundo10:null, 
    btMundo11:null, 
    btMundo12:null,
    btnCaja:null,
    text:0,
    text2:0,
    text3:0,
    text4:0,
    text5:0,
    text6:0,
    text7:0,
    text8:0,
    text9:0,
    text10:0,
    text11:0,
    text12:0,
};

var navegacion = function(game){};
    navegacion.prototype = {
    preload: function() {
    	//Se agregan las imagenes y los sptritesheets.
        game.load.spritesheet('btMundo2', '../img/componentes/navegacionMapa/pause.png', 50,50);
        game.load.image('monedas', '../img/componentes/navegacionMapa/monedas.png');
        game.load.image('xp', '../img/componentes/finBatalla/experiencia.png');
        game.load.image('fondo', '../img/componentes/navegacionMapa/mapaNavegacion.png');
        game.load.image('close', '../img/componentes/navegacionMapa/orb.png');
        game.load.spritesheet('nivel1', '../img/componentes/navegacionMapa/nivel1.png', 192,71);
        game.load.spritesheet('nivel2', '../img/componentes/navegacionMapa/nivel2.png', 192,71);
        game.load.spritesheet('nivel3', '../img/componentes/navegacionMapa/nivel3.png', 192,71);
        game.load.spritesheet('nivel4', '../img/componentes/navegacionMapa/nivel4.png', 192,71);
        game.load.spritesheet('nivel5', '../img/componentes/navegacionMapa/nivel5.png', 192,71);
        game.load.spritesheet('nivel6', '../img/componentes/navegacionMapa/nivel6.png', 192,71);
        game.load.spritesheet('botonCreditos', '../img/componentes/navegacionMapa/botonCreditos.png', 62, 62);
        game.load.spritesheet('botonAmigos', '../img/componentes/navegacionMapa/botonAmigos.png', 62, 62);
        game.load.spritesheet('botonPerfil', '../img/componentes/navegacionMapa/botonPerfil.png', 62, 62);
        game.load.spritesheet('botonRanking', '../img/componentes/navegacionMapa/botonRanking.png', 62, 62);
        game.load.spritesheet('botonSonido', '../img/componentes/navegacionMapa/botonSonido.png', 62, 62);
        game.load.spritesheet('botonCerrarSesion', '../img/componentes/navegacionMapa/botonCerrarSesion.png', 62, 62);
        game.load.spritesheet('botonAjustes', '../img/componentes/navegacionMapa/botonAjustes.png', 62, 62);
        //game.load.spritesheet('botonCajaSorpresa', '../img/componentes/cajas/cajam.png', 132, 216);
        game.load.spritesheet('botonCajaSorpresa', '../img/componentes/navegacionMapa/cajanegra.png', 62, 62);
        game.load.spritesheet('botonCompraPersonajes', '../img/componentes/navegacionMapa/botonCompraPersonajes.png', 62, 62);
        game.load.spritesheet('pause12', '../img/componentes/navegacionMapa/pause12.png', 50,50);
        game.load.spritesheet('pause13', '../img/componentes/navegacionMapa/pause13.png', 50,50);
        game.load.spritesheet('pause14', '../img/componentes/navegacionMapa/pause14.png', 50,50);
    },

    //se agrega el fondo y se crean los botones de los mundos en donde tenemos button(medida en x, medida en y, nombre de la imagen, la funcion, sprites)
    create:function() {
        game.add.sprite(0, 0, 'fondo');//Se agrega un fondo.
        game.add.sprite(80, 10, 'monedas');//imagen monedas
        game.add.sprite(220, 10, 'xp').scale.setTo(0.4);//Imagen experiencia.
       //BOTONES DE LOS NIVELES Y MENUS-
        botonCreditos = game.add.button(735, 70, 'botonCreditos', this.verCreditos, 0, 0, 0, 1);
        botonSonido = game.add.button(735, 135, 'botonSonido', this.quitarSonido, 0, 0, 0, 1);
        botonCerrarSesion = game.add.button(735, 200, 'botonCerrarSesion', this.cerrarSesion, 0, 0, 0, 1);
        botonCreditos.visible = false;
        botonSonido.visible = false;
        botonCerrarSesion.visible = false;
        botonAjustes = game.add.button(735, 5, 'botonAjustes', this.verAjustes, 0, 0, 0, 1);
        botonAmigos = game.add.button(670, 5, 'botonAmigos', this.verInvitarAmigos, 0, 0, 0, 1);
        botonPerfil = game.add.button(5, 5, 'botonPerfil', this.verPerfil, 0, 0, 0, 1);
        botonRanking = game.add.button(605, 5, 'botonRanking', this.verRankings, 0, 0, 0, 1);
       //btnCaja = game.add.button(415, 5, 'botonCajaSorpresa', this.verCajaMisteriosa);//475
        vN.btnCaja = game.add.button(475, 5, 'botonCajaSorpresa', this.verCajaMisteriosa,1,1,0,2);//475
        botonCompraPersonajes = game.add.button(540, 5, 'botonCompraPersonajes', this.verCompraPersonajes, 0, 0, 0, 1);
        game.add.text(160, 20, datosperfil["datos"].monedas, {font: "16px Roboto", fill: "#ffffff"}); //Label monedas desde perfilJugador
        game.add.text(275, 20, datosperfil["datos"].experiencia, {font: "16px Roboto", fill: "#ffffff"}); //Label EXP desde perfilJugador
       
        vN.btMundo = game.add.button (80, 60, 'pause13', this.mundo1, 0, 0, 0, 1);
        vN.btMundo.scale.setTo(0.8, 0.8);
        vN.btMundo.input.useHandCursor = true;
        vN.text = game.add.text(13,1, "1", { font: "40px Arial", fill: "#030300"});
        vN.btMundo.addChild(vN.text);
    
        vN.btMundo2 = game.add.button (90, 500, 'pause13',this.mundo2, 0, 0, 0, 1);
        vN.btMundo2.scale.setTo(0.8, 0.8);
        vN.btMundo.input.useHandCursor = true;
        vN.text2 = game.add.text(13,1, "2", {font: "40px Arial", fill: "#030300"});
        vN.btMundo2.addChild(vN.text2);
        
        vN.btMundo3 = game.add.button (250, 450, 'pause13', this.mundo3, 0, 0, 0, 1);
        vN.btMundo3.scale.setTo(0.8, 0.8);
        vN.text3 = game.add.text(13,1, "3", { font: "40px Arial", fill: "#030300"});
        vN.btMundo3.addChild(vN.text3);    

        vN.btMundo4 = game.add.button (280, 220, 'pause13', this.mundo4, 0, 0, 0, 1);
        vN.btMundo4.scale.setTo(0.8, 0.8);
        vN.text4 = game.add.text(13,1, "4", { font: "40px Arial", fill: "#030300"});
        vN.btMundo4.addChild(vN.text4);
        
        vN.btMundo5 = game.add.button (330, 80, 'pause13', this.mundo5, 0, 0, 0, 1);
        vN.btMundo5.scale.setTo(0.8, 0.8);
        vN.text5 = game.add.text(13,1, "5", { font: "40px Arial", fill: "#030300"});
        vN.btMundo5.addChild(vN.text5);    

        vN.btMundo6 = game.add.button (430, 500, 'pause13', this.mundo6, 0, 0, 0, 1);
        vN.btMundo6.scale.setTo(0.8, 0.8);
        vN.text6 = game.add.text(13,1, "6", { font: "40px Arial", fill: "#030300"});
        vN.btMundo6.addChild(vN.text6);    

        vN.btMundo7 = game.add.button (520, 220, 'pause13',this.mundo7, 0, 0, 0, 1);
        vN.btMundo7.scale.setTo(0.8, 0.8);
        vN.text7 = game.add.text(15,1, "7", { font: "40px Arial", fill: "#030300"});
        vN.btMundo7.addChild(vN.text7);
        
        vN.btMundo8 = game.add.button (580, 200, 'pause13', this.mundo8, 0, 0, 0, 1);
        vN.btMundo8.scale.setTo(0.8, 0.8);
        vN.text8 = game.add.text(13,1, "8", { font: "40px Arial", fill: "#030300"});
        vN.btMundo8.addChild(vN.text8);    

        vN.btMundo9 = game.add.button (550, 80, 'pause13', this.mundo9, 0, 0, 0, 1);
        vN.btMundo9.scale.setTo(0.8, 0.8);
        vN.text9 = game.add.text(13,1, "9", { font: "40px Arial", fill: "#030300"});
        vN.btMundo9.addChild(vN.text9);
    
        vN.btMundo10 = game.add.button (680, 140, 'pause13', this.mundo10, 0, 0, 0, 1);
        vN.btMundo10.scale.setTo(0.8, 0.8);
        vN.text10 = game.add.text(6,3, "10", { font: "35px Arial", fill: "#030300"});
        vN.btMundo10.addChild(vN.text10);    
   
        vN.btMundo11 = game.add.button (700, 240, 'pause13', this.mundo11, 0, 0, 0, 1);
        vN.btMundo11.scale.setTo(0.8, 0.8);
        vN.text11 = game.add.text(9,3, "11", { font: "35px Arial", fill: "#030300"});
        vN.btMundo11.addChild(vN.text11);    

        vN.btMundo12 = game.add.button (750, 480, 'pause14',this.mundo12, 0, 0, 0, 1);
        vN.btMundo12.scale.setTo(0.8, 0.8);
        vN.text12 = game.add.text(5,1, "12", { font: "35px Arial", fill: "#030300"});
        vN.btMundo12.addChild(vN.text12);
        
        boot.verificarMusica("mapa");
    },
  
    verAjustes: function(){
        variablesBoot.sonidoBoton.play();
        botonCreditos.visible =! botonCreditos.visible;
        botonSonido.visible =! botonSonido.visible;
        botonCerrarSesion.visible =! botonCerrarSesion.visible;
    },        
    verCreditos: function(){
        game.state.start("creditos");
        variablesBoot.sonidoBoton.play();
    },
    quitarSonido: function(){
            if(!variablesBoot.musicaOnOff){
                variablesBoot.musicaOnOff = true;
                variablesBoot.musicaMapa.resume();
            }
        else{
            variablesBoot.musicaOnOff = false;
            variablesBoot.musicaMapa.pause();
        }
    },
    cerrarSesion: function(){
        variablesBoot.sonidoBoton.play();
        alert("Sesion cerrada");
    },
    verInvitarAmigos: function(){
        game.state.start("invitarAmigos");
        variablesBoot.sonidoBoton.play();
    },    
    verPerfil: function(){
        game.state.start("perfilJugador");
        variablesBoot.sonidoBoton.play();
    },
    verCajaMisteriosa: function(){
        game.state.start("cajaMisteriosa");
        variablesBoot.sonidoBoton.play();
    },     
    verRankings: function(){
        game.state.start("rankings");
        variablesBoot.sonidoBoton.play();
    },    
    verCompraPersonajes: function(){
        game.state.start("compraPersonajes");
        variablesBoot.sonidoBoton.play();
    },
//SE INICIA UN NUEVO ESTA DONDE ENRTARA A EL MUNDO ELEJIDO.
        mundo1: function(){            
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo1");
        },
        mundo2:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo2");
        },
        mundo3:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo3");
        },
        mundo4:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo4");
        },
        mundo5:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo5");
        },
        mundo6:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo6");
        },
        mundo7:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo7");
        },
        mundo8:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo8");
        },
        mundo9:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo9");
        },
        mundo10:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo10");
        },
        mundo11:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo11");
        },
        mundo12:function(){
            pruebasPsicotecnicas.setPrueba19(true);
            variablesBoot.sonidoBoton.play();
            game.state.start("Mundo12");
        },
    // SE INICIA EL ESTADO DEL NIVEL.
    iniciarNivel: function(lvl) {
        pruebasPsicotecnicas.setPrueba20(true);
        variablesCampoBatalla.idNivel = lvl;
        variablesCampoBatalla.idPC = niveles[lvl].idEnemigo;
        game.state.start("seleccionpersonaje");
        variablesBoot.sonidoBoton.play();
    }
}