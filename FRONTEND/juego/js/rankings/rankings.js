var botonVolver;
var top5;
var textoRanking;
var textoHead, textoRank;

var j1 = "jugadorUno";
var j2 = "jugadorDos";
var j3 = "jugadorTres";
var j4 = "jugadorCuatro";
var j5 = "jugadorCinco";

var encabezados = ['Top', 'Avatar', 'Nombre', 'Nivel'];
var rank = [
    ['', '[avatar1]', jugadores[j1].nombre, jugadores[j1].nivel],
    ['', '[avatar2]', 'name2', 'lvl2'],
    ['', '[avatar3]', 'name3', 'lvl3'],
    ['', '[avatar4]', 'name4', 'lvl4'],
    ['', '[avatar5]', 'name5', 'lvl5']
    ];

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
            
            var style = { font: "24px Roboto", fill: "#ffffff", tabs: [200, 200, 200]};
            textoHead = game.add.text(50, 220, "", style);
            textoHead.parseList(encabezados);
            textoRank = game.add.text(50, 270, "", style);
            textoRank.lineSpacing = 30;
            textoRank.parseList(rank);
        },
        
        volver: function(){
            game.state.start("navegacion");
        },
        
        verDiario: function(){
            textoRanking.setText("Ranking Diario");            
        },
        
        verSemanal: function(){
            textoRanking.setText("Ranking Semanal");
        },
        
        verPoli: function(){
            textoRanking.setText("Ranking Poli");            
        },
        
        verGeneral: function(){
            textoRanking.setText("Ranking General");            
        },
        
        update: function(){
            console.log(game.input.mousePointer.x);
            console.log(game.input.mousePointer.y);
        }
    }