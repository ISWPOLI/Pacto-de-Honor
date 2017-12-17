variablesCampeones={
//Variables de botones
    botonVolver:null,
    canariobloqlock:null,
    ciervabloqlock:null,
    gallobloqlock:null,
    hormigabloqlock:null,
    jirafabloqlock:null,
    leonbloqlock:null,
    panterabloqlock: null,
    ratonbloqlock: null,
    ruisenorlock : null,
    pj1:null,
    pj2:null,
    pj3:null,
    pj4:null,
    pj5:null,
    pj6:null,
    pj7:null,
    pj8:null,
    pj9:null,
    pjsname: null,
    pjslock: null,
    rata:null
}

var comprados;
var campeones = function(game){};
    campeones.prototype = {
        preload: function(){

            //Arreglo del local storage de los campeones comprados (boolean)
            comprados = obtenerLocalStorage('CampeonesComprados');
            //Carga de imagenes para el logo del pacto
            game.load.image('logoPacto', '../img/componentes/creditos/logoPacto.png');
            game.load.spritesheet('canarioboton', '../img/personajes/avatares/botonCanario.png', 125, 125);
            game.load.spritesheet('ciervaboton', '../img/personajes/avatares/botonCierva.png', 125, 125);
            game.load.spritesheet('galloboton', '../img/personajes/avatares/botonGallo.png', 125, 125);
            game.load.spritesheet('hormigaboton', '../img/personajes/avatares/botonHormiga.png', 125, 125);
            game.load.spritesheet('jirafaboton', '../img/personajes/avatares/botonJirafa.png', 125, 125);
            game.load.spritesheet('leonboton', '../img/personajes/avatares/botonLeon.png', 125, 125);
            game.load.spritesheet('panteraboton', '../img/personajes/avatares/botonPantera.png', 125, 125);
            game.load.spritesheet('ratonboton', '../img/personajes/avatares/botonRaton.png', 125, 125);
            game.load.spritesheet('ruisenorboton', '../img/personajes/avatares/botonRuisenor.png', 125, 125);
            game.load.spritesheet('blockoboton', '../img/personajes/avatares/block.png', 125, 125);
            game.load.spritesheet('caracanario', '../img/personajes/avatares/caraCanario.png', 400,400);
            game.load.spritesheet('caracierva','../img/personajes/avatares/caraCierva.png', 400,400);
            game.load.spritesheet('caragallo', '../img/personajes/avatares/caraGallo.png', 400,400);
            game.load.spritesheet('carahormiga', '../img/personajes/avatares/caraHormiga.png', 400,400);
            game.load.spritesheet('carajirafa','../img/personajes/avatares/caraJirafa.png', 400,400);
            game.load.spritesheet('caraleon', '../img/personajes/avatares/caraLeon.png', 400,400);
            game.load.spritesheet('carapantera', '../img/personajes/avatares/caraPantera.png', 400,400);
            game.load.spritesheet('cararaton', '../img/personajes/avatares/caraRaton.png',400,400);
            game.load.spritesheet('cararuisenor',  '../img/personajes/avatares/caraRuisenor.png', 400,400);

          /*game.load.spritesheet('canariobloq', '../img/componentes/heroes/caraCanariolock.png', 400,400);
            game.load.spritesheet('ciervabloq', '../img/componentes/heroes/caraCiervalock.png', 400,400);
            game.load.spritesheet('gallobloq', '../img/componentes/heroes/caraGallolock.png', 400,400);
            game.load.spritesheet('hormigabloq', '../img/componentes/heroes/caraHormigalock.png', 400,400);
            game.load.spritesheet('jirafabloq', '../img/componentes/heroes/caraJirafalock.png', 400,400);
            game.load.spritesheet('leonbloq', '../img/componentes/heroes/caraLeonlock.png', 400,400);
            game.load.spritesheet('panterabloq', '../img/componentes/heroes/caraPanteralock.png', 400,400);
            game.load.spritesheet('ratonbloq', '../img/componentes/heroes/caraRatonlock.png', 400,400);
            game.load.spritesheet('ruisenorlock', '../img/componentes/heroes/caraRuisenorlock.png', 400,400);
            */

            variablesCampeones.pj1 = heroes["idP1"];
            variablesCampeones.pj2 = heroes["idP2"];
            variablesCampeones.pj3 = heroes["idP3"];
            variablesCampeones.pj4 = heroes["idP4"];
            variablesCampeones.pj5 = heroes["idP5"];
            variablesCampeones.pj6 = heroes["idP6"];
            variablesCampeones.pj7 = heroes["idP7"];
            variablesCampeones.pj8 = heroes["idP8"];
            variablesCampeones.pj9 = heroes["idP9"];
            },

        create: function(){

            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Heroes", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Créditos

            //Se crean los botones de los personajes buenos si estan comprados
            if(comprados[5]){
            var  botoncanariobloqs = game.add.button (20, 100, 'canarioboton', this.canariobloqsClick, 0, 0, 0, 1);
              botoncanariobloqs.angle = 10;
            }
              else{
            var  block = game.add.button (20, 100, 'blockoboton',0, 0, 0, 1);
                block.angle = 10;
              }
            if(comprados[2]){
            botonCiervabloq = game.add.button (120, 100, 'ciervaboton', this.ciervabloqClick, 0, 0, 0, 1);
            botonCiervabloq.angle =-10;
            }
            else{
              block = game.add.button (120, 100, 'blockoboton', 0, 0, 0, 1);
              block.angle =-10;
             }
            if(comprados[1]){
            botongallobloq = game.add.button (220, 100, 'galloboton', this.gallobloqClick, 0, 0, 0, 1);
            botongallobloq.angle =10;
            }
            else{
              botongallobloq = game.add.button (220, 100, 'blockoboton', 0, 0, 0, 1);
              botongallobloq.angle =10;
              }
            if(comprados[8]){
            botonhormigabloq = game.add.button (20, 200, 'hormigaboton', this.hormigabloqClick, 0, 0, 0, 1);
            botonhormigabloq.angle =10;
            }
            else{
              botonhormigabloq = game.add.button (20, 200, 'blockoboton', 0, 0, 0, 1);
              botonhormigabloq.angle =10;
              }
            if(comprados[3]){
            botonjirafabloq = game.add.button (120, 200, 'jirafaboton', this.jirafabloqClick, 0, 0, 0, 1);
            botonjirafabloq.angle =-10;
            }
            else{
              botonjirafabloq = game.add.button (120, 200, 'blockoboton', 0, 0, 0, 1);
              botonjirafabloq.angle =-10;
              }
            if(comprados[4]){
            botonleonbloq = game.add.button (220, 200, 'leonboton', this.leonbloqClick, 0, 0, 0, 1);
            botonleonbloq.angle = 10;
            }
            else{
              botonleonbloq = game.add.button (220, 200, 'blockoboton', 0, 0, 0, 1);
              botonleonbloq.angle = 10;
              }

            botonpanterabloq = game.add.button (20, 300, 'panteraboton', this.panterabloqClick, 0, 0, 0, 1);
            botonpanterabloq.angle = -10;

            if(comprados[7]){
            botonratonbloq = game.add.button (120, 300, 'ratonboton', this.ratonbloqClick, 0, 0, 0, 1);
            botonratonbloq.angle = 10;
            }
            else{
              botonratonbloq = game.add.button (120, 300, 'blockoboton', 0, 0, 0, 1);
              botonratonbloq.angle = 10;
              }
            if(comprados[6]){
            botonPerezratonbloq = game.add.button (220, 300, 'ruisenorboton', this.ruisenorlockClick, 0, 0, 0, 1);
            botonPerezratonbloq.angle = -10;
            }
            else{
              botonPerezratonbloq = game.add.button (220, 300, 'blockoboton', 0, 0, 0, 1);
              botonPerezratonbloq.angle = -10;
              }
            win();

            //Agrega la imagen del personaje actual
            function win (){
                  if(variablesCampeones.pj7.estado==0){
                  variablesCampeones.ratonbloqlock  = game.add.sprite(450,170, 'cararaton');
                  }
                  else{
                      variablesCampeones.ratonbloqlock  = game.add.sprite(450,170, 'ratonbloq');
                    }
                  if(variablesCampeones.pj1.estado==0){
                  variablesCampeones.hormigabloqlock  = game.add.sprite(450,170, 'carahormiga');
                  }
                  else{
                      variablesCampeones.hormigabloqlock  = game.add.sprite(450,170, 'hormigabloq');
                    }
                  if(variablesCampeones.pj4.estado==0){
                  variablesCampeones.jirafabloqlock  = game.add.sprite(450,170, 'carajirafa');
                  }
                  else{
                      variablesCampeones.jirafabloqlock  = game.add.sprite(450,170, 'carajirafa');
                    }
                  if(variablesCampeones.pj2.estado==0){
                  variablesCampeones.gallobloqlock  = game.add.sprite(450,170, 'caragallo');
                  }
                  else{
                      variablesCampeones.gallobloqlock  = game.add.sprite(450,170, 'caragallo');
                    }
                  if(variablesCampeones.pj9.estado==0){
                  variablesCampeones.ruisenorlocklock  = game.add.sprite(450,170, 'cararuisenor');
                  }
                  else{
                      variablesCampeones.ruisenorlocklock  = game.add.sprite(450,170, 'cararuisenor');
                    }
                  if(variablesCampeones.pj8.estado==0){
                  variablesCampeones.canariobloqlock  = game.add.sprite(450, 170, 'caracanario');
                  }
                  else{
                      variablesCampeones.canariobloqlock  = game.add.sprite(450, 170, 'caracanario');
                    }
                  if(variablesCampeones.pj6.estado==0){
                  variablesCampeones.leonbloqlock  = game.add.sprite(450,170, 'caraleon');
                  }
                  else{
                      variablesCampeones.leonbloqlock  = game.add.sprite(450,170, 'caraleon');
                    }
                  if(variablesCampeones.pj3.estado==0){
                  variablesCampeones.panterabloqlock  = game.add.sprite(450,170,'carapantera');
                  }
                  else{
                      variablesCampeones.panterabloqlock  = game.add.sprite(450,170, 'carapantera');
                    }
                  if(variablesCampeones.pj5.estado==0){
                  variablesCampeones.ciervabloqlock  = game.add.sprite(450,170, 'caracierva');
                  }
                  else{
                      variablesCampeones.ciervabloqlock  = game.add.sprite(450,170, 'caracierva');
                    }
            }

            variablesCampeones.botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 0, 0, 0, 1);
            boot.verificarMusica("menu");
            hideBoss();

        function hideBoss(){

            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
          }

        },

        canariobloqsClick: function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = true;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
        },

        gallobloqClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = true;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
       },

        hormigabloqClick: function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = true;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
        },

        jirafabloqClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = true;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
       },

        leonbloqClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = true;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
       },

        ruisenorlockClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = true;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = false;
       },

        panterabloqClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = false;
            variablesCampeones.panterabloqlock.visible = true;
       },

        ratonbloqClick:function(){
            variablesBoot.sonidoBoton.play();
            variablesCampeones.canariobloqlock.visible = false;
            variablesCampeones.ciervabloqlock.visible =false;
            variablesCampeones.gallobloqlock.visible = false;
            variablesCampeones.hormigabloqlock.visible = false;
            variablesCampeones.jirafabloqlock.visible = false;
            variablesCampeones.leonbloqlock.visible = false;
            variablesCampeones.ruisenorlocklock.visible = false;
            variablesCampeones.ratonbloqlock.visible = true;
            variablesCampeones.panterabloqlock.visible = false;
       },

       ciervabloqClick:function(){
            variablesBoot.sonidoBoton.play();
           variablesCampeones.canariobloqlock.visible = false;
           variablesCampeones.ciervabloqlock.visible =true;
           variablesCampeones.gallobloqlock.visible = false;
           variablesCampeones.hormigabloqlock.visible = false;
           variablesCampeones.jirafabloqlock.visible = false;
           variablesCampeones.leonbloqlock.visible = false;
           variablesCampeones.ruisenorlocklock.visible = false;
           variablesCampeones.ratonbloqlock.visible = false;
           variablesCampeones.panterabloqlock.visible = false;
      },

        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            variablesBoot.sonidoBoton.play();
            game.state.start("perfilJugador");
        },

        update:function(){
        }
    }
