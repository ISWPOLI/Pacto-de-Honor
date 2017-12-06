var closeButton2;
var popup2;
var nivelactual;
var mundoctual;
var Mundo12 = {
    preload:function (){
        game.load.image('bloquei', '../img/componentes/navegacionMapa/bloqueICampus.png');//rdy
        game.load.image('fondo', '../img/componentes/navegacionMapa/mapaNavegacionb.png');
        game.load.image('close', '../img/componentes/navegacionMapa/orb.png');
        game.load.spritesheet('nivel1', '../img/componentes/navegacionMapa/nivel1.png', 192,71);
        game.load.spritesheet('nivel2', '../img/componentes/navegacionMapa/nivel2.png', 192,71);
        game.load.spritesheet('nivel3', '../img/componentes/navegacionMapa/nivel3.png', 192,71);
        game.load.spritesheet('nivel4', '../img/componentes/navegacionMapa/nivel4.png', 192,71);
        game.load.spritesheet('nivel5', '../img/componentes/navegacionMapa/nivel5.png', 192,71);
        game.load.spritesheet('nivel2b', '../img/componentes/navegacionMapa/nivel2b.png', 192,71);
        game.load.spritesheet('nivel3b', '../img/componentes/navegacionMapa/nivel3b.png', 192,71);
        game.load.spritesheet('nivel4b', '../img/componentes/navegacionMapa/nivel4b.png', 192,71);
        game.load.spritesheet('nivel5b', '../img/componentes/navegacionMapa/nivel5b.png', 192,71);
    },

    create:function(){
        nivelactual =parseInt (obtenerLocalStorage('NivelMundo'));
        mundoctual = parseInt(obtenerLocalStorage('Mundo'));
        game.add.sprite(0, 0, 'fondo');
        //se agrega ventana emergente popup (medidas en x, medidas en y, nombre imagen)
        popup2 = game.add.sprite(game.world.centerX, game.world.centerY, 'bloquei');
        // se agrega la posicion
        popup2.anchor.set(0.7);
        popup2.inputEnabled = true;

        //se crean dos variables las cuales daran la ubicacion del boton de cerrar el popup

        //se crea el botton cerrar del popup(medidas en x, medidas en y, nombre de la imgagen, nombre de la funcion, sprites)
        closeButton2 = game.add.button(95,-200, 'close', closeWindow, 0, 0, 0, 1);
        //se le da un tamaño
        closeButton2.scale.setTo(2, 2);
        //se agrega al popup
        popup2.addChild(closeButton2);

        //se crean los 5 botones que son los que sirven para elegir nivel
        var nivelButton = game.add.button (180, -250, 'nivel1', iniciarNivel1, null, 2, 1, 0);
        function iniciarNivel1(){
            navegacion.prototype.iniciarNivel("12-1");
        }

        nivelButton.inputEnabled = true;
        nivelButton.input.priorityID = 1;
        nivelButton.input.useHandCursor = true;
        //se agregan al popup
        popup2.addChild(nivelButton);


        //valida si el nivel actual es inferior al que desea jugar
        if(nivelactual<2&&mundoctual<13){
          var nivelButton1 = game.add.button (180, -170, 'nivel2b', iniciarNivel2, null, 2, 1, 0);
            function iniciarNivel2(){
              navegacion.prototype.iniciarNivel("1-2");
            }
          nivelButton1.inputEnabled = false;
          nivelButton1.input.priorityID = 1;
          nivelButton1.input.useHandCursor = true;
          popup2.addChild(nivelButton1);
        }
        //si el nivel actual no es inferior al que desea jugar habilita el boton
          else{  var nivelButton1 = game.add.button (180, -170, 'nivel2', iniciarNivel2, null, 2, 1, 0);
            function iniciarNivel2(){
                navegacion.prototype.iniciarNivel("1-2");
            }
          nivelButton1.inputEnabled = true;
          nivelButton1.input.priorityID = 1;
          nivelButton1.input.useHandCursor = true;
          popup2.addChild(nivelButton1);
        }

        if(nivelactual<3&&mundoctual<13){
          var nivelButton2 = game.add.button (180, -90, 'nivel3b', iniciarNivel3, null,2, 1, 0);
            function iniciarNivel3(){
              navegacion.prototype.iniciarNivel("1-3");
            }
            nivelButton2.inputEnabled = false;
            nivelButton2.input.priorityID = 1;
            nivelButton2.input.useHandCursor = true;

        popup2.addChild(nivelButton2);
        }

          else{
            var nivelButton2 = game.add.button (180, -90, 'nivel3', iniciarNivel3, null,2, 1, 0);
              function iniciarNivel3(){
                navegacion.prototype.iniciarNivel("1-3");
      }
        nivelButton2.inputEnabled = true;
        nivelButton2.input.priorityID = 1;
        nivelButton2.input.useHandCursor = true;
        popup2.addChild(nivelButton2);
      }


      if(nivelactual<4&&mundoctual<13){
        var nivelButton3 = game.add.button (180, -10, 'nivel4b', iniciarNivel4, null,2, 1, 0);
          function iniciarNivel4(){
            navegacion.prototype.iniciarNivel("1-4");
        }
        nivelButton3.inputEnabled = false;
        nivelButton3.input.priorityID = 1;
        nivelButton3.input.useHandCursor = true;
        popup2.addChild(nivelButton3);
      }
        else{
          var nivelButton3 = game.add.button (180, -10, 'nivel4', iniciarNivel4, null,2, 1, 0);
            function iniciarNivel4(){
              navegacion.prototype.iniciarNivel("1-4");
          }
          nivelButton3.inputEnabled = true;
          nivelButton3.input.priorityID = 1;
          nivelButton3.input.useHandCursor = true;
          popup2.addChild(nivelButton3);
        }

      if(nivelactual<5&&mundoctual<13){
        var nivelButton4 = game.add.button (180, 70, 'nivel5b', iniciarNivel5, null,2, 1, 0);
        function iniciarNivel5(){
            navegacion.prototype.iniciarNivel("1-5");
        }
        nivelButton4.inputEnabled = false;
        nivelButton4.input.priorityID = 1;
        nivelButton4.input.useHandCursor = true;
        popup2.addChild(nivelButton4);
      }
        else{
          var nivelButton4 = game.add.button (180, 70, 'nivel5', iniciarNivel5, null,2, 1, 0);
            function iniciarNivel5(){
              navegacion.prototype.iniciarNivel("1-5");
          }
          nivelButton4.inputEnabled = true;
          nivelButton4.input.priorityID = 1;
          nivelButton4.input.useHandCursor = true;
          popup2.addChild(nivelButton4);
        }
        //se le da una escala al popup cuando sale
        popup2.scale.set(0.8);

        function closeWindow() {
            variablesBoot.sonidoBoton.play();
            game.state.start("navegacion");
            // crea una variable tween que lo que hara sera la funcion para cerrar el popup
        }
    }
}
