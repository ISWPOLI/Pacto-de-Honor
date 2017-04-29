
var music;
var musicButton;
var btMundo, btMundo2, btMundo3, btMundo4, btMundo5 ,btMundo6 ,btMundo7 ,btMundo8 ,btMundo9 ,btMundo10, btMundo11, btMundo12;

var navegacion = function(game){};
navegacion.prototype = {
    preload: function() {
        game.scale.pageAlignHorizontally = true;
        game.scale.pageAlignVertically = true;
       game.load.audio('sonidos','../img/Componentes/sonidos/mapa/mapa.mp3');
         game.load.audio('sonidoBoton', '../img/Componentes/sonidos/Botones/1.mp3');
        game.load.spritesheet('btMundo2', '../img/Componentes/navegacionMapa/pause.png', 50,50);
        //fondo y escenarios

        game.load.image('monedas', '../img/Componentes/navegacionMapa/monedas.png');
     
        //botones********************
           game.load.image('fondo', '../img/Componentes/navegacionMapa/mapaNavegacion.png');
  game.load.image('close', '../img/Componentes/navegacionMapa/orb.png');
        
        game.load.spritesheet('nivel1', '../img/Componentes/navegacionMapa/nivel1.png', 192,71);
        game.load.spritesheet('nivel2', '../img/Componentes/navegacionMapa/nivel2.png', 192,71);
        game.load.spritesheet('nivel3', '../img/Componentes/navegacionMapa/nivel3.png', 192,71);
        game.load.spritesheet('nivel4', '../img/Componentes/navegacionMapa/nivel4.png', 192,71);
        game.load.spritesheet('nivel5', '../img/Componentes/navegacionMapa/nivel5.png', 192,71);
        game.load.spritesheet('nivel6', '../img/Componentes/navegacionMapa/nivel6.png', 192,71);


        game.load.spritesheet('botonCreditos', '../img/Componentes/navegacionMapa/botonCreditos.png', 62, 62);
        game.load.spritesheet('botonAmigos', '../img/Componentes/navegacionMapa/botonAmigos.png', 62, 62);
        game.load.spritesheet('botonPerfil', '../img/Componentes/navegacionMapa/botonPerfil.png', 62, 62);
        game.load.spritesheet('botonRanking', '../img/Componentes/navegacionMapa/botonRanking.png', 62, 62);
        game.load.spritesheet('botonCompraPersonajes', '../img/Componentes/navegacionMapa/botonCompraPersonajes.png', 62, 62);

        game.load.spritesheet('pause12', '../img/Componentes/navegacionMapa/pause12.png', 50,50);
        game.load.spritesheet('pause13', '../img/Componentes/navegacionMapa/pause13.png', 50,50);
        game.load.spritesheet('pause14', '../img/Componentes/navegacionMapa/pause14.png', 50,50);
      

        
    },

    //se agrega el fondo y se crean los botones de los mundos en donde tenemos button(medida en x, medida en y, nombre de la imagen, la funcion, sprites)
    create:function() {
        game.add.sprite(0, 0, 'fondo');
        game.add.sprite(80, 10, 'monedas');

        botonCreditos = game.add.button(735, 5, 'botonCreditos', this.verCreditos, 1, 1, 0, 2);
        botonAmigos = game.add.button(670, 5, 'botonAmigos', this.verInvitarAmigos, 1, 1, 0, 2);
        botonPerfil = game.add.button(5, 5, 'botonPerfil', this.verPerfil, 1, 1, 0, 2);
        botonRanking = game.add.button(605, 5, 'botonRanking', this.verRankings, 1, 1, 0, 2);
        botonCompraPersonajes = game.add.button(540, 5, 'botonCompraPersonajes', this.verCompraPersonajes, 1, 1, 0, 2);
        game.add.text(160, 20, "999999", {font: "16px Roboto", fill: "#ffffff"}); //Label monedas     
       
        btMundo = game.add.button (80, 60, 'pause13', this.mundo1, 0, 0, 0, 1);
        btMundo.scale.setTo(0.8, 0.8);
        btMundo.input.useHandCursor = true;
        var text = game.add.text(13,1, "1", { font: "40px Arial", fill: "#ff0044"});
        btMundo.addChild(text);
    
        btMundo2 = game.add.button (90, 500, 'pause13',this.mundo2, 0, 0, 0, 1);
        btMundo2.scale.setTo(0.8, 0.8);
        btMundo.input.useHandCursor = true;
        var text2 = game.add.text(13,1, "2", {font: "40px Arial", fill: "#ff0044"});
        btMundo2.addChild(text2);
        
        btMundo3 = game.add.button (250, 450, 'pause13', this.mundo3, 0, 0, 0, 1);
        btMundo3.scale.setTo(0.8, 0.8);
        var text3 = game.add.text(13,1, "3", { font: "40px Arial", fill: "#ff0044"});
        btMundo3.addChild(text3);    

        btMundo4 = game.add.button (280, 220, 'pause13', this.mundo4, 0, 0, 0, 1);
        btMundo4.scale.setTo(0.8, 0.8);
        var text4 = game.add.text(13,1, "4", { font: "40px Arial", fill: "#ff0044"});
        btMundo4.addChild(text4);
        
        btMundo5 = game.add.button (330, 80, 'pause13', this.mundo5, 0, 0, 0, 1);
        btMundo5.scale.setTo(0.8, 0.8);
        var text5 = game.add.text(13,1, "5", { font: "40px Arial", fill: "#ff0044"});
        btMundo5.addChild(text5);    

        btMundo6 = game.add.button (430, 500, 'pause13', this.mundo6, 0, 0, 0, 1);
        btMundo6.scale.setTo(0.8, 0.8);
        var text6 = game.add.text(13,1, "6", { font: "40px Arial", fill: "#ff0044"});
        btMundo6.addChild(text6);    

        btMundo7 = game.add.button (520, 220, 'pause13',this.mundo7, 0, 0, 0, 1);
        btMundo7.scale.setTo(0.8, 0.8);
        var text7 = game.add.text(15,1, "7", { font: "40px Arial", fill: "#ff0044"});
        btMundo7.addChild(text7);
        
        btMundo8 = game.add.button (580, 200, 'pause13', this.mundo8, 0, 0, 0, 1);
        btMundo8.scale.setTo(0.8, 0.8);
        var text8 = game.add.text(13,1, "8", { font: "40px Arial", fill: "#ff0044"});
        btMundo8.addChild(text8);    

        btMundo9 = game.add.button (550, 80, 'pause13', this.mundo9, 0, 0, 0, 1);
        btMundo9.scale.setTo(0.8, 0.8);
        var text9 = game.add.text(13,1, "9", { font: "40px Arial", fill: "#ff0044"});
        btMundo9.addChild(text9);
    
        btMundo10 = game.add.button (680, 140, 'pause13', this.mundo10, 0, 0, 0, 1);
        btMundo10.scale.setTo(0.8, 0.8);
        var text10 = game.add.text(6,3, "10", { font: "35px Arial", fill: "#ff0044"});
        btMundo10.addChild(text10);    
   
        btMundo11 = game.add.button (700, 240, 'pause13', this.mundo11, 0, 0, 0, 1);
        btMundo11.scale.setTo(0.8, 0.8);
        var text11 = game.add.text(9,3, "11", { font: "35px Arial", fill: "#ff0044"});
        btMundo11.addChild(text11);    

        btMundo12 = game.add.button (750, 480, 'pause14',this.mundo12, 0, 0, 0, 1);
        btMundo12.scale.setTo(0.8, 0.8);
        var text12 = game.add.text(5,1, "12", { font: "35px Arial", fill: "#FFFF00"});
        btMundo12.addChild(text12);

        music = game.add.audio('sonidos');
        musicButton = game.add.audio('sonidoBoton');
        music.loop = true;
        music.play();
        

    },
  
    
    verCreditos: function(){
        game.state.start("creditos");
        musicButton.play();
        music.pause();
    },    
    verInvitarAmigos: function(){
        game.state.start("invitarAmigos");
        musicButton.play();
        music.pause();
    },    
    verPerfil: function(){
        game.state.start("perfilJugador");
        musicButton.play();
        music.pause();
    },    
    verRankings: function(){
        game.state.start("rankings");
        musicButton.play();
        music.pause();
    },    
    verCompraPersonajes: function(){
        game.state.start("compraPersonajes");
        musicButton.play();
        music.pause();
    },

        mundo1: function(){            
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo1");
        },
        mundo2:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo2");
        },
        mundo3:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo3");
        },
        mundo4:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo4");
        },
        mundo5:function(){
            pruebasPsicotecnicas.set19(true);            
            game.state.start("Mundo5");
        },
        mundo6:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo6");
        },
        mundo7:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo7");
        },
        mundo8:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo8");
        },
        mundo9:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo9");
        },
        mundo10:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo10");
        },
        mundo11:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo11");
        },
        mundo12:function(){
            pruebasPsicotecnicas.set19(true);
            game.state.start("Mundo12");
        }}