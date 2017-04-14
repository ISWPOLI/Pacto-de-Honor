var popup, popup2, popup3 , popup4, popup5, popup6, popup7,popup7 
,popup9, popup10, popup11, popup12;

var closeButton, closeButton2, closeButton3, closeButton4, closeButton5, closeButton6, closeButton7
, closeButton8, closeButton9, closeButton10, closeButton11, closeButton12;
var tween;

var btMundo, btMundo2, btMundo3, btMundo4, btMundo5 ,btMundo6 ,btMundo7 ,btMundo8 ,btMundo9 ,btMundo10
,btMundo11,btMundo12;

var navegacion = function(game){};
navegacion.prototype = {
    preload: function() {
        game.load.spritesheet('btMundo2', '../img/Componentes/navegacionMapa/pause.png', 50,50);
        //fondo y escenarios
        game.load.image('fondo', '../img/Componentes/navegacionMapa/mapaNavegacion.png');

        game.load.image('posGrados', '../img/Componentes/navegacionMapa/sedePosgradosBogota.png');//rdy
        game.load.image('medellin', '../img/Componentes/navegacionMapa/sedeMedellin.png');//rdy
        game.load.image('excelencia', '../img/Componentes/navegacionMapa/sedeExcelencia.png');//rdy
        game.load.image('paradero','../img/Componentes/navegacionMapa//paraderoBogota.png');//dy
        game.load.image('mercadeo', '../img/Componentes/navegacionMapa/bloqueJCampus.png');//rdy cambiar imagen facultad mercadeo
        game.load.image('bloqueJ', '../img/Componentes/navegacionMapa/bloqueJCampus.png');//rdy
        game.load.image('bienestar', '../img/Componentes/navegacionMapa/mesaPingPongCampus.png');//rdy
        game.load.image('fcs', '../img/Componentes/navegacionMapa/bloqueJCampus.png');//rdy falta imagen facultad ciencas sociales
        game.load.image('plazoleta', '../img/Componentes/navegacionMapa/plazoletaCampus.png');//rdy
        game.load.image('fca', '../img/Componentes/navegacionMapa/bloqueJCampus.png');//rdy falta imagen facultad cieencias administrativas
        game.load.image('cancha', '../img/Componentes/navegacionMapa/canchaCampus.png');//rdy
        game.load.image('ing', '../img/Componentes/navegacionMapa/bloqueJCampus.png');//dry falta imagen facultad ingenieria
        game.load.image('bloquei', '../img/Componentes/navegacionMapa/bloqueICampus.png');//rdy
        game.load.image('monedas', '../img/Componentes/navegacionMapa/monedas.png');
     
        //botones
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
        game.load.image('close', '../img/Componentes/navegacionMapa/orb.png');
    },

    //se agrega el fondo y se crean los botones de los mundos en donde tenemos button(medida en x, medida en y, nombre de la imagen, la funcion, sprites)
    create:function() {
        game.add.sprite(0, 0, 'fondo');
        game.add.sprite(80, 10, 'monedas');
        botonPerfil = game.add.button(5, 5, 'botonPerfil', this.verPerfil, 1, 1, 0, 2); //El estado de perfil lo está creando Juan Carlos
        botonCreditos = game.add.button(735, 5, 'botonCreditos', this.verCreditos, 1, 1, 0, 2);
        botonAmigos = game.add.button(670, 5, 'botonAmigos', this.verInvitarAmigos, 1, 1, 0, 2);        
        botonRanking = game.add.button(605, 5, 'botonRanking', null, 1, 1, 0, 2); //El estado de Rankings aun no esta creado
        botonCompraPersonajes = game.add.button(540, 5, 'botonCompraPersonajes', this.verCompraPersonajes, 1, 1, 0, 2);
        game.add.text(160, 20, "999999", {font: "16px Roboto", fill: "#ffffff"}); //Label monedas
     
       
    btMundo = game.add.button (80, 60, 'pause13', this.onMundo1, 0, 0, 0, 1);
    btMundo.scale.setTo(0.5, 0.5);
    btMundo.input.useHandCursor = true;
    var text = game.add.text(13,1, "1", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo.addChild(text);
    

     btMundo2 = game.add.button (90, 500, 'pause13',this.onMundo2, 0, 0, 0, 1);
    btMundo2.scale.setTo(0.5, 0.5);
     btMundo.input.useHandCursor = true;
      var text2 = game.add.text(13,1, "2", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo2.addChild(text2);
    
    
    btMundo3 = game.add.button (250, 450, 'pause13', this.onMundo3, 0, 0, 0, 1);
    btMundo3.scale.setTo(0.5, 0.5);
     var text3 = game.add.text(13,1, "3", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo3.addChild(text3);
    

    btMundo4 = game.add.button (280, 220, 'pause13', this.onMundo4, 0, 0, 0, 1);
    btMundo4.scale.setTo(0.5, 0.5);
 var text4 = game.add.text(13,1, "4", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo4.addChild(text4);
    

    btMundo5 = game.add.button (330, 80, 'pause13', this.onMundo5, 0, 0, 0, 1);
    btMundo5.scale.setTo(0.5, 0.5);
     var text5 = game.add.text(13,1, "5", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo5.addChild(text5);
    

    btMundo6 = game.add.button (430, 500, 'pause13', this.onMundo6, 0, 0, 0, 1);
    btMundo6.scale.setTo(0.5, 0.5);
     var text6 = game.add.text(13,1, "6", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo6.addChild(text6);
    

    btMundo7 = game.add.button (520, 220, 'pause13',this.onMundo7, 0, 0, 0, 1);
    btMundo7.scale.setTo(0.5, 0.5);
     var text7 = game.add.text(15,1, "7", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo7.addChild(text7);
    
    
    btMundo8 = game.add.button (580, 200, 'pause13', this.onMundo8, 0, 0, 0, 1);
    btMundo8.scale.setTo(0.5, 0.5);
     var text8 = game.add.text(13,1, "8", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo8.addChild(text8);
    

    btMundo9 = game.add.button (550, 80, 'pause13', this.onMundo9, 0, 0, 0, 1);
    btMundo9.scale.setTo(0.5, 0.5);
    var text9 = game.add.text(13,1, "9", 
    	{ font: "40px Arial", fill: "#ff0044"});
    btMundo9.addChild(text9);
    
    btMundo10 = game.add.button (680, 140, 'pause13', this.onMundo10, 0, 0, 0, 1);
    btMundo10.scale.setTo(0.5, 0.5);
     var text10 = game.add.text(6,3, "10", 
    	{ font: "35px Arial", fill: "#ff0044"});
    btMundo10.addChild(text10);
    
   
    btMundo11 = game.add.button (700, 240, 'pause13', this.onMundo11, 0, 0, 0, 1);
    btMundo11.scale.setTo(0.5, 0.5);
    var text11 = game.add.text(9,3, "11", 
    	{ font: "35px Arial", fill: "#ff0044"});
    btMundo11.addChild(text11);
    

    btMundo12 = game.add.button (750, 480, 'pause14',this.onMundo12, 0, 0, 0, 1);
    btMundo12.scale.setTo(0.5, 0.5);

     var text12 = game.add.text(5,1, "12", 
    	{ font: "35px Arial", fill: "#FFFF00"});
    btMundo12.addChild(text12);

    },
    
    verCreditos: function(){
        game.state.start("creditos");
    },
    
    verInvitarAmigos: function(){
        game.state.start("invitarAmigos");
    },
    
    verPerfil: function(){
        game.state.start("perfilJugador");
    },
    
    verCompraPersonajes: function(){
        game.state.start("compraPersonajes");
        
    },
    
    //se crea la funcion que ira adentro de cada boton de cada mundo, lo que hara sera abrir el popup con la imagen de el escenario y sus respectivos niveles.
    onMundo1 :function () {
        //se agrega ventana emergente popup (medidas en x, medidas en y, nombre imagen)
        popup2 = game.add.sprite(game.world.centerX, game.world.centerY, 'medellin');
        // se agrega la posicion
        popup2.anchor.set(0.7);
        popup2.inputEnabled = true;
 
        //se crean dos variables las cuales daran la ubicacion del boton de cerrar el popup
        var pw = (popup2.width / 2) - 120;
        var ph = (popup2.height / 2) -350;
        //se crea el botton cerrar del popup(medidas en x, medidas en y, nombre de la imgagen, nombre de la funcion, sprites)
        closeButton2 = game.add.button(pw,ph, 'close',closeWindow, 0, 0, 0, 1);
        //se le da un tamaño
        closeButton2.scale.setTo(0.5, 0.5);
        //se agrega al popup
        popup2.addChild(closeButton2);

        //se crean los 5 botones que son los que sirven para elejir nivel
        var nivelButton = game.add.button (180, -250, 'nivel1', iniciarnivel1 ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 1 nivel 1
    
        function iniciarnivel1(){
            game.state.start("seleccionpersonaje");
        }

        nivelButton.inputEnabled = true;
        nivelButton.input.priorityID = 1;
        nivelButton.input.useHandCursor = true;
        //se agregan al popup
        popup2.addChild(nivelButton);

        var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 1 nivel 2

        nivelButton1.inputEnabled = true;
        nivelButton1.input.priorityID = 1;
        nivelButton1.input.useHandCursor = true;

        popup2.addChild(nivelButton1);

        var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 1 nivel 3

        nivelButton2.inputEnabled = true;
        nivelButton2.input.priorityID = 1;
        nivelButton2.input.useHandCursor = true;

        popup2.addChild(nivelButton2);

        var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 1 nivel 4

        nivelButton3.inputEnabled = true;
        nivelButton3.input.priorityID = 1;
        nivelButton3.input.useHandCursor = true;

        popup2.addChild(nivelButton3);

        var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 1 nivel 5

        nivelButton4.inputEnabled = true;
        nivelButton4.input.priorityID = 1;
        nivelButton4.input.useHandCursor = true;

        popup2.addChild(nivelButton4);
        //se le da una escala al popup cuando sale  
        popup2.scale.set(0.8);

        function closeWindow() {
            // crea una variable tween que lo que hara sera la funcion para cerrar el popup
            tween = game.add.tween(popup2.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);
        }
        
        //***************************************************Todo el codigo de aqui para abajo se repite haciendole cambio a variables para crear los demas botones de los mundos*************************************************************
    
    },
    
    onMundo2 :function() { 
        var popup = game.add.sprite(game.world.centerX, game.world.centerY, 'posGrados');
 popup.anchor.set(0.7);
 popup.inputEnabled = true;


    closeButton = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton.scale.setTo(0.5, 0.5);
popup.addChild(closeButton);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 2 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 2 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 2 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 2 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 2 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup.addChild(nivelButton4);

    popup.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);
}



},
//*************************** No se encontro el error de esta creacion de popup "onMundo3" donde el popup es mas grande de lo normal *************************************
 onMundo3 :function() {


  popup3 = game.add.sprite(game.world.centerX, game.world.centerY, 'excelencia');
 popup3.anchor.set(0.7);
 popup3.inputEnabled = true;



    closeButton3 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton3.scale.setTo(0.5, 0.5);
popup3.addChild(closeButton3);
var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 3 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup3.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 3 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup3.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 3 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup3.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 3 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup3.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 3 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup3.addChild(nivelButton4);



    popup3.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup3.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo4 :function() {


  popup4 = game.add.sprite(game.world.centerX, game.world.centerY, 'paradero');
 popup4.anchor.set(0.7);
 popup4.inputEnabled = true;
 


    closeButton4 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton4.scale.setTo(0.5, 0.5);
popup4.addChild(closeButton4);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 4 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup4.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 4 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup4.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 4 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup4.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 4 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup4.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo  4 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup4.addChild(nivelButton4);

    popup4.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup4.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo5 :function() {


  popup5 = game.add.sprite(game.world.centerX, game.world.centerY, 'mercadeo');
 popup5.anchor.set(0.7);
 popup5.inputEnabled = true;


    closeButton5 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton5.scale.setTo(0.5, 0.5);
popup5.addChild(closeButton5);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 5 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup5.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 5 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup5.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 5 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup5.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 5 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup5.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 5 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup5.addChild(nivelButton4);

    popup5.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup5.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo6 :function() {


  popup6 = game.add.sprite(game.world.centerX, game.world.centerY, 'fcs');
 popup6.anchor.set(0.7);
 popup6.inputEnabled = true;
 

    closeButton6 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton6.scale.setTo(0.5, 0.5);
popup6.addChild(closeButton6);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup6.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup6.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup6.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup6.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup6.addChild(nivelButton4);

    popup6.scale.set(0.8);

    var nivelButton5 = game.add.button (180, 150, 'nivel6', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 6 nivel 5

    nivelButton5.inputEnabled = true;
    nivelButton5.input.priorityID = 1;
    nivelButton5.input.useHandCursor = true;

 popup6.addChild(nivelButton5);

    popup6.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup6.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo7 :function() {


popup7 = game.add.sprite(game.world.centerX, game.world.centerY, 'bienestar');
 popup7.anchor.set(0.7);
 popup7.inputEnabled = true;
 

    closeButton7 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton7.scale.setTo(0.5, 0.5);
popup7.addChild(closeButton7);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 7 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup7.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 7 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup7.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 7 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup7.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 7 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup7.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 7 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup7.addChild(nivelButton4);

    popup7.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup7.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo8 :function() {


popup8 = game.add.sprite(game.world.centerX, game.world.centerY, 'plazoleta');
 popup8.anchor.set(0.7);
 popup8.inputEnabled = true;
 


    closeButton8 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton8.scale.setTo(0.5, 0.5);
popup8.addChild(closeButton8);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 8 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup8.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 8 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup8.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 8 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup8.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 8 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup8.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 8 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup8.addChild(nivelButton4);

    popup8.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup8.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo9 :function() {


popup9 = game.add.sprite(game.world.centerX, game.world.centerY, 'fca');
 popup9.anchor.set(0.7);
 popup9.inputEnabled = true;
 


    closeButton9 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton9.scale.setTo(0.5, 0.5);
popup9.addChild(closeButton9);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 9 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup9.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 9 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup9.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 9 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup9.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 9 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup9.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 9 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup9.addChild(nivelButton4);

    popup9.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup9.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo10 :function() {


popup10 = game.add.sprite(game.world.centerX, game.world.centerY, 'cancha');
 popup10.anchor.set(0.7);
 popup10.inputEnabled = true;



    closeButton10 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton10.scale.setTo(0.5, 0.5);
popup10.addChild(closeButton10);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 10 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup10.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 10 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup10.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 10 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup10.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 10 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup10.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 10 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup10.addChild(nivelButton4);

    popup10.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup10.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo11 :function() {


popup11 = game.add.sprite(game.world.centerX, game.world.centerY, 'ing');
 popup11.anchor.set(0.7);
 popup11.inputEnabled = true;



    closeButton11 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton11.scale.setTo(0.5, 0.5);
popup11.addChild(closeButton11);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 11 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup11.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 11 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup11.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 11 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup11.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 11 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup11.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 11 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup11.addChild(nivelButton4);

    popup11.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup11.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

    }
},
onMundo12 :function() {


popup12 = game.add.sprite(game.world.centerX, game.world.centerY, 'bloquei');
 popup12.anchor.set(0.7);
 popup12.inputEnabled = true;
 

    closeButton12 = game.add.button(130,-200, 'close',closeWindow, 0, 0, 0, 1);
    closeButton12.scale.setTo(0.5, 0.5);
popup12.addChild(closeButton12);

var nivelButton = game.add.button (180, -250, 'nivel1', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 12 nivel 1

    nivelButton.inputEnabled = true;
    nivelButton.input.priorityID = 1;
    nivelButton.input.useHandCursor = true;

 popup12.addChild(nivelButton);

 var nivelButton1 = game.add.button (180, -170, 'nivel2', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 12 nivel 2

    nivelButton1.inputEnabled = true;
    nivelButton1.input.priorityID = 1;
    nivelButton1.input.useHandCursor = true;

 popup12.addChild(nivelButton1);

 var nivelButton2 = game.add.button (180, -90, 'nivel3', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 13 nivel 3

    nivelButton2.inputEnabled = true;
    nivelButton2.input.priorityID = 1;
    nivelButton2.input.useHandCursor = true;

 popup12.addChild(nivelButton2);

 var nivelButton3 = game.add.button (180, -10, 'nivel4', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 14 nivel 4

    nivelButton3.inputEnabled = true;
    nivelButton3.input.priorityID = 1;
    nivelButton3.input.useHandCursor = true;

 popup12.addChild(nivelButton3);

 var nivelButton4 = game.add.button (180, 70, 'nivel5', null ,null,2, 1, 0);//En el null va la funcion de cambio de estado para el mundo 15 nivel 5

    nivelButton4.inputEnabled = true;
    nivelButton4.input.priorityID = 1;
    nivelButton4.input.useHandCursor = true;

 popup12.addChild(nivelButton4);

    popup12.scale.set(0.8);

function closeWindow() {
    tween = game.add.tween(popup12.scale).to( { x: 0.0, y: 0.0 }, 500, Phaser.Easing.Elastic.In, true);

         }
    }
}