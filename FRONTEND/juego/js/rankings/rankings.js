var musicButton;
var botonVolver;
var top5;
var textoRanking;
var textoHead, textoRank;
var imgAvatar1, imgAvatar2, imgAvatar3, imgAvatar4, imgAvatar5; 

var j1 = "jugadorUno";
var j2 = "jugadorDos";
var j3 = "jugadorTres";
var j4 = "jugadorCuatro";
var j5 = "jugadorCinco";

var encabezados = ['Top', 'Avatar', 'Nombre', 'Nivel'];

var rankings = function(game){};
    rankings.prototype = {
        preload: function(){
            //Carga de imagen para el top 5
            game.load.image('top5', '../img/componentes/rankings/top5.png');
            //Carga de imagenes para los botones principales
            game.load.spritesheet('botonDiario', '../img/componentes/botones/botonDiario.png', 192, 71);
            game.load.spritesheet('botonSemanal', '../img/componentes/botones/botonSemanal.png', 192, 71);
            game.load.spritesheet('botonPoli', '../img/componentes/botones/botonPoli.png', 192, 71);
            game.load.spritesheet('botonGeneral', '../img/componentes/botones/botonGeneral.png', 192, 71);            
            //Carga de imagenes para los cinco avatares
            game.load.image('avatarUno', jugadores[j1].rutaAvatar);
            game.load.image('avatarDos', jugadores[j2].rutaAvatar);
            game.load.image('avatarTres', jugadores[j3].rutaAvatar);
            game.load.image('avatarCuatro', jugadores[j4].rutaAvatar);
            game.load.image('avatarCinco', jugadores[j5].rutaAvatar);
        },
        
        create: function(){
            musicButton = game.add.audio('variablesBoot.sonidoBoton');
            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Rankings", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Rankings
            top5 = game.add.sprite(0, 230, 'top5'); //Imagen del top 5
            
            //Se agrega el botón para volver al mapa de navegación
            botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            //Se agregan los 4 botones de Rankings
            botonDiario = game.add.button(5, 80, 'botonDiario', this.verDiario, 1, 1, 0, 2);
            botonSemanal = game.add.button(205, 80, 'botonSemanal', this.verSemanal, 1, 1, 0, 2);
            botonPoli = game.add.button(400, 80, 'botonPoli', this.verPoli, 1, 1, 0, 2);
            botonGeneral = game.add.button(600, 80, 'botonGeneral', this.verGeneral, 1, 1, 0, 2);
            
            //textoRanking varía según el botón oprimido
            textoRanking = game.add.text(game.width / 2, 180, "", {font: "30px Roboto", fill: "#ffffff"});
            textoRanking.anchor.set(0.5);
            
            //textoHead son los encabezados de cada columna
            textoHead = game.add.text(50, 200, "", { font: "24px Roboto", fill: "#ffffff", tabs: [150, 150, 150]});            
            textoHead.stroke = "rgb(244,152,49)";
            textoHead.strokeThickness = 3;
            textoHead.parseList(encabezados);
                        
            //arregloJugadores es un Array que contiene los 5 jugadores que son Objects
            var arregloJugadores = [];
            arregloJugadores[0]=jugadores[j1];
            arregloJugadores[1]=jugadores[j2];
            arregloJugadores[2]=jugadores[j3];
            arregloJugadores[3]=jugadores[j4];
            arregloJugadores[4]=jugadores[j5];
            
            //El método sort ordena los jugadores por nivel
            arregloJugadores.sort(function(a, b){
                return b.nivel-a.nivel;
            });
            
            //Las tablas representan a los jugadores ordenados
            var tablaJ = [
                [arregloJugadores[0].nombre, arregloJugadores[0].nivel],
                [arregloJugadores[1].nombre, arregloJugadores[1].nivel],
                [arregloJugadores[2].nombre, arregloJugadores[2].nivel],
                [arregloJugadores[3].nombre, arregloJugadores[3].nivel],
                [arregloJugadores[4].nombre, arregloJugadores[4].nivel],
            ];            
            var tablaFacultad = [
                [arregloJugadores[0].facultad],
                [arregloJugadores[1].facultad],
                [arregloJugadores[2].facultad],
                [arregloJugadores[3].facultad],
                [arregloJugadores[4].facultad],
            ];            
            var tablaUniversidad = [
                [arregloJugadores[0].universidad],
                [arregloJugadores[1].universidad],
                [arregloJugadores[2].universidad],
                [arregloJugadores[3].universidad],
                [arregloJugadores[4].universidad],
            ]; 
            
            //Se añaden los avatares de los jugadores
            imgAvatar1 = game.add.image(200, 244, arregloJugadores[0].keyAvatar);
            imgAvatar1.scale.setTo(0.3);
            imgAvatar2 = game.add.image(200, 313, arregloJugadores[1].keyAvatar);
            imgAvatar2.scale.setTo(0.3);
            imgAvatar3 = game.add.image(200, 382, arregloJugadores[2].keyAvatar);
            imgAvatar3.scale.setTo(0.3);
            imgAvatar4 = game.add.image(200, 450, arregloJugadores[3].keyAvatar);
            imgAvatar4.scale.setTo(0.3);
            imgAvatar5 = game.add.image(200, 520, arregloJugadores[4].keyAvatar);
            imgAvatar5.scale.setTo(0.3);
            
            //textoRank, textoFacultad y textoUniversidad son las tablas de datos que se muestran en pantalla
            textoRank = game.add.text(320, 265, "", { font: "18px Roboto", fill: "#ffffff", tabs: [200]});
            textoRank.lineSpacing = 42;
            textoRank.parseList(tablaJ);
            
            textoFacultad = game.add.text(600, 265, "", { font: "18px Roboto", fill: "#ffffff", tabs: [200]});
            textoFacultad.lineSpacing = 42;
            textoFacultad.parseList(tablaFacultad);
            
            textoUniversidad = game.add.text(600, 265, "", { font: "18px Roboto", fill: "#ffffff", tabs: [200]});
            textoUniversidad.lineSpacing = 42;
            textoUniversidad.parseList(tablaUniversidad);
            
            //textx es el texto que cambia entre Facultad y Universidad en los encabezados de las columnas
            textx = game.add.text (630, 200, "", { font: "24px Roboto", fill: "#ffffff"});
            textx.stroke = "rgb(244,152,49)";
            textx.strokeThickness = 3;
            
            //Se ocultan los tops hasta que un botón sea oprimido
            top5.visible = false;
            textoHead.visible = false;
            textoRank.visible = false;
            textoFacultad.visible = false;
            textoUniversidad.visible = false;
            imgAvatar1.visible = false;
            imgAvatar2.visible = false;
            imgAvatar3.visible = false;
            imgAvatar4.visible = false;
            imgAvatar5.visible = false;
            
            boot.verificarMusica("menu");
        },
        
        //Función para volver al mapa de navegación
        volver: function(){
            game.state.start("navegacion");
            variablesBoot.sonidoBoton.play();
        },
        
        //En las siguientes funciones se ocultan las variables según corresponda
        verDiario: function(){
            variablesBoot.sonidoBoton.play();
            textoRanking.setText("Ranking Diario");            
            textx.visible = false;
            textoFacultad.visible = false;
            textoUniversidad.visible = false;
            
            top5.visible = true;
            textoHead.visible = true;
            textoRank.visible = true;
            imgAvatar1.visible = true;
            imgAvatar2.visible = true;
            imgAvatar3.visible = true;
            imgAvatar4.visible = true;
            imgAvatar5.visible = true;
        },
        
        verSemanal: function(){
            variablesBoot.sonidoBoton.play();
            textoRanking.setText("Ranking Semanal");
            textx.visible = false;
            textoFacultad.visible = false;
            textoUniversidad.visible = false;
            
            top5.visible = true;
            textoHead.visible = true;
            textoRank.visible = true;
            imgAvatar1.visible = true;
            imgAvatar2.visible = true;
            imgAvatar3.visible = true;
            imgAvatar4.visible = true;
            imgAvatar5.visible = true;
            imgAvatar5.visible = true;
        },
        
        verPoli: function(){
            variablesBoot.sonidoBoton.play();
            textoRanking.setText("Ranking Poli");
            textx.setText("Facultad");
            
            textx.visible = true;
            textoFacultad.visible = true;
            textoUniversidad.visible = false;
            top5.visible = true;
            textoHead.visible = true;
            textoRank.visible = true;
            imgAvatar1.visible = true;
            imgAvatar2.visible = true;
            imgAvatar3.visible = true;
            imgAvatar4.visible = true;
            imgAvatar5.visible = true;
        },
        
        verGeneral: function(){
            variablesBoot.sonidoBoton.play();
            textoRanking.setText("Ranking General");
            textx.setText("Universidad");
            
            textx.visible = true;
            textoFacultad.visible = false;
            textoUniversidad.visible = true;
            top5.visible = true;
            textoHead.visible = true;
            textoRank.visible = true;
            imgAvatar1.visible = true;
            imgAvatar2.visible = true;
            imgAvatar3.visible = true;
            imgAvatar4.visible = true;
            imgAvatar5.visible = true;
        },
        
        update: function(){
            
        }
    }