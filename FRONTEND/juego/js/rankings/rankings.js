var botonVolver;
var textoRanking;
var textoHead, textoRank;

var encabezados = ['Top', 'Avatar', 'Nombre', 'Nivel'];
var rank = [
    ['1', '[avatar1]', 'name1', 'lvl1'],
    ['2', '[avatar2]', 'name2', 'lvl2'],
    ['3', '[avatar3]', 'name3', 'lvl3'],
    ['4', '[avatar4]', 'name4', 'lvl4'],
    ['5', '[avatar5]', 'name5', 'lvl5']
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
        },
        
        create: function(){
            game.stage.backgroundColor = "#0060b2"; //Color de fondo
            game.add.text(game.width / 2, 50, "Rankings", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Rankings
            
            //Se agrega el botón para volver al mapa de navegación
            botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            
            botonPacto = game.add.button(5, 100, 'botonDiario', this.verDiario, 1, 1, 0, 2);
            botonBuenos = game.add.button(205, 100, 'botonSemanal', this.verSemanal, 1, 1, 0, 2);
            botonMalos = game.add.button(400, 100, 'botonPoli', this.verPoli, 1, 1, 0, 2);
            botonPlagios = game.add.button(600, 100, 'botonGeneral', this.verGeneral, 1, 1, 0, 2);
            
            textoRanking = game.add.text(game.width / 2, 220, "", {font: "30px Roboto", fill: "#ffffff"});
            textoRanking.anchor.set(0.5);
            
            var style = { font: "24px Roboto", fill: "#ffffff", tabs: [200, 200, 200]};
            textoHead = game.add.text(50, 270, "", style);
            textoHead.parseList(encabezados);
            textoRank = game.add.text(50, 320, "", style);
            textoRank.lineSpacing = 20;
            textoRank.parseList(rank);
            
            textoHead.visible = false;
            textoRank.visible = false;
        },
        
        volver: function(){
            game.state.start("navegacion");
        },
        
        verDiario: function(){
            textoRanking.setText("Ranking Diario");
            textoHead.visible =! textoHead.visible;
            textoRank.visible =! textoRank.visible;
        },
        
        verSemanal: function(){
            textoRanking.setText("Ranking Semanal");
            textoHead.visible =! textoHead.visible;
            textoRank.visible =! textoRank.visible;
        },
        
        verPoli: function(){
            textoRanking.setText("Ranking Poli");
            textoHead.visible =! textoHead.visible;
            textoRank.visible =! textoRank.visible;
        },
        
        verGeneral: function(){
            textoRanking.setText("Ranking General");
            textoHead.visible =! textoHead.visible;
            textoRank.visible =! textoRank.visible;
        },
        
        update: function(){
            
        }
    }