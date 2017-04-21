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
            game.scale.pageAlignHorizontally = true;
            game.scale.pageAlignVertically = true;
            
            //Se carga el boton para volver al mapa de navegación
            game.load.spritesheet('botonVolver', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);
            
            //Carga de imagenes para los botones principales
            game.load.spritesheet('botonDiario', '../img/Componentes/rankings/botonDiario.png', 192, 71);
            game.load.spritesheet('botonSemanal', '../img/Componentes/rankings/botonSemanal.png', 192, 71);
            game.load.spritesheet('botonPoli', '../img/Componentes/rankings/botonPoli.png', 192, 71);
            game.load.spritesheet('botonGeneral', '../img/Componentes/rankings/botonGeneral.png', 192, 71);
            
            //Carga de imagen para el top 5
            game.load.image('top5', '../img/Componentes/Rankings/top5.png');
            
            //Carga de imagenes para los cinco avatares
            game.load.image('avatarUno', jugadores[j1].rutaAvatar);
            game.load.image('avatarDos', jugadores[j2].rutaAvatar);
            game.load.image('avatarTres', jugadores[j3].rutaAvatar);
            game.load.image('avatarCuatro', jugadores[j4].rutaAvatar);
            game.load.image('avatarCinco', jugadores[j5].rutaAvatar);
        },
        
        create: function(){
            game.stage.backgroundColor = "#0060b2"; //Color de fondo
            game.add.text(game.width / 2, 50, "Rankings", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Rankings
            
            top5 = game.add.sprite(30, 260, 'top5');
            
            //Se agrega el botón para volver al mapa de navegación
            botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            //Se agregan los 4 botones de Rankings
            botonDiario = game.add.button(5, 80, 'botonDiario', this.verDiario, 1, 1, 0, 2);
            botonSemanal = game.add.button(205, 80, 'botonSemanal', this.verSemanal, 1, 1, 0, 2);
            botonPoli = game.add.button(400, 80, 'botonPoli', this.verPoli, 1, 1, 0, 2);
            botonGeneral = game.add.button(600, 80, 'botonGeneral', this.verGeneral, 1, 1, 0, 2);
            
            textoRanking = game.add.text(game.width / 2, 180, "", {font: "30px Roboto", fill: "#ffffff"});
            textoRanking.anchor.set(0.5);
            
            textoHead = game.add.text(50, 220, "", { font: "24px Roboto", fill: "#ffffff", tabs: [200, 200, 200]});            
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
                return a.nivel-b.nivel;
            });
            
            //La variable tablaJ es la que se muestra en la pantalla
            var tablaJ = [
                [arregloJugadores[0].nombre, arregloJugadores[0].nivel],
                [arregloJugadores[1].nombre, arregloJugadores[1].nivel],
                [arregloJugadores[2].nombre, arregloJugadores[2].nivel],
                [arregloJugadores[3].nombre, arregloJugadores[3].nivel],
                [arregloJugadores[4].nombre, arregloJugadores[4].nivel],
                ];
            
            imgAvatar1 = game.add.image(270, 260, arregloJugadores[0].keyAvatar);
            imgAvatar1.scale.setTo(0.6);
            imgAvatar2 = game.add.image(270, 330, arregloJugadores[1].keyAvatar);
            imgAvatar2.scale.setTo(0.6);
            imgAvatar3 = game.add.image(270, 400, arregloJugadores[2].keyAvatar);
            imgAvatar3.scale.setTo(0.6);
            imgAvatar4 = game.add.image(270, 470, arregloJugadores[3].keyAvatar);
            imgAvatar4.scale.setTo(0.6);
            imgAvatar5 = game.add.image(270, 540, arregloJugadores[4].keyAvatar);
            imgAvatar5.scale.setTo(0.6);
            
            textoRank = game.add.text(420, 280, "", { font: "24px Roboto", fill: "#ffffff", tabs: [250]});
            textoRank.lineSpacing = 35;
            textoRank.parseList(tablaJ);
            
            top5.visible = false;
            textoHead.visible = false;
            textoRank.visible = false;
            imgAvatar1.visible = false;
            imgAvatar2.visible = false;
            imgAvatar3.visible = false;
            imgAvatar4.visible = false;
            imgAvatar5.visible = false;
        },
        
        volver: function(){
            game.state.start("navegacion");
        },
        
        verDiario: function(){
            textoRanking.setText("Ranking Diario");
            
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
            textoRanking.setText("Ranking Semanal");
            
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
            textoRanking.setText("Ranking Poli");
            
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
            textoRanking.setText("Ranking General");
            
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