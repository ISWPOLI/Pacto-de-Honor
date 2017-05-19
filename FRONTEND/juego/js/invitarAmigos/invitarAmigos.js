variablesInvitarAmigos={
    botonVolver:null
}


var invitarAmigos = function(game){};
    invitarAmigos.prototype = {
        preload: function(){
        },
        
        create: function(){
            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Invitar amigos", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Invitar Amigos
            
            //Se agrega el botón para volver al mapa de navegación
            variablesInvitarAmigos.botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            
            boot.verificarMusica("menu");
        },
        
        volver: function(){
            game.state.start("navegacion");
            variablesBoot.sonidoBoton.play();
        },
        
        update: function(){
            
        }
    }