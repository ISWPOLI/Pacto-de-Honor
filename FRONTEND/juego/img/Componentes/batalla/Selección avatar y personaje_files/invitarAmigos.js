var botonVolver;

var invitarAmigos = function(game){};
    invitarAmigos.prototype = {
        preload: function(){
            game.scale.pageAlignHorizontally = true;
            game.scale.pageAlignVertically = true;
            
            //Se carga el boton para volver al mapa de navegación
            game.load.spritesheet('botonVolver', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);
        },
        
        create: function(){
            game.stage.backgroundColor = "#0060b2"; //Color de fondo
            game.add.text(game.width / 2, 50, "Invitar amigos", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Invitar Amigos
            
            //Se agrega el botón para volver al mapa de navegación
            botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
        },
        
        volver: function(){
            game.state.start("navegacion");
        },   
        
        update: function(){
            
        }
    }