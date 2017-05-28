variablesCampeones={
//Variables de botones
    botonVolver:null, 
    botonPacto:null, 
    botonBuenos:null, 
    botonMalos:null, 
    botonPlagios:null,
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
    pj10:null,
    pj11:null,
    pj12:null,
    pjsname: null,
    pjslock: null,
    
    rata:null
    
    
      
}
var campeones = function(game){};
    campeones.prototype = {
        preload: function(){
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

            
            game.load.spritesheet('caracanario', '../img/personajes/avatares/caraCanario.png', 400,400);
            game.load.spritesheet('caracierva','../img/personajes/avatares/caraCierva.png', 400,400);
            game.load.spritesheet('caragallo', '../img/personajes/avatares/caraGallo.png', 400,400);
            game.load.spritesheet('carahormiga', '../img/personajes/avatares/caraHormiga.png', 400,400);
            game.load.spritesheet('carajirafa','../img/personajes/avatares/caraJirafa.png', 400,400);
            game.load.spritesheet('caraleon', '../img/personajes/avatares/caraLeon.png', 400,400);
            game.load.spritesheet('carapantera', '../img/personajes/avatares/caraPantera.png', 400,400);
            game.load.spritesheet('cararaton', '../img/personajes/avatares/caraRaton.png',400,400);
            game.load.spritesheet('cararuisenor',  '../img/personajes/avatares/caraRuisenor.png', 400,400);
       
            
            game.load.spritesheet('canariobloq', '../img/componentes/heroes/caraCanariolock.png', 400,400);
            game.load.spritesheet('ciervabloq', '../img/componentes/heroes/caraCiervalock.png', 400,400);
            game.load.spritesheet('gallobloq', '../img/componentes/heroes/caraGallolock.png', 400,400);
            game.load.spritesheet('hormigabloq', '../img/componentes/heroes/caraHormigalock.png', 400,400);
            game.load.spritesheet('jirafabloq', '../img/componentes/heroes/caraJirafalock.png', 400,400);
            game.load.spritesheet('leonbloq', '../img/componentes/heroes/caraLeonlock.png', 400,400);
            game.load.spritesheet('panterabloq', '../img/componentes/heroes/caraPanteralock.png', 400,400);
            game.load.spritesheet('ratonbloq', '../img/componentes/heroes/caraRatonlock.png', 400,400);
            game.load.spritesheet('ruisenorlock', '../img/componentes/heroes/caraRuisenorlock.png', 400,400);
  
            
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
            
    
            //Se crean los botones de los personajes malos
            botoncanariobloqs = game.add.button (20, 100, 'canarioboton', this.canariobloqsClick, 0, 0, 0, 1);
            botoncanariobloqs.angle = 10;
            
           botonCiervabloq = game.add.button (120, 100, 'ciervaboton', this.babuinoClick, 0, 0, 0, 1);
           botonCiervabloq.angle =-10;
          
            botongallobloq = game.add.button (220, 100, 'galloboton', this.gallobloqClick, 0, 0, 0, 1);
            botongallobloq.angle =10;
            
            botonhormigabloq = game.add.button (20, 200, 'hormigaboton', this.hormigabloqClick, 0, 0, 0, 1);
            botonhormigabloq.angle =10;
            
            botonjirafabloq = game.add.button (120, 200, 'jirafaboton', this.jirafabloqClick, 0, 0, 0, 1);
            botonjirafabloq.angle =-10;
            
            botonleonbloq = game.add.button (220, 200, 'leonboton', this.leonbloqClick, 0, 0, 0, 1);
            botonleonbloq.angle = 10;
            
            botonpanterabloq = game.add.button (20, 300, 'panteraboton', this.panterabloqClick, 0, 0, 0, 1);
            botonpanterabloq.angle = -10;
            
            botonratonbloq = game.add.button (120, 300, 'ratonboton', this.ratonbloqClick, 0, 0, 0, 1);
            botonratonbloq.angle = 10;
            
            botonPerezratonbloq = game.add.button (220, 300, 'ruisenorboton', this.ruisenorlockClick, 0, 0, 0, 1);
            botonPerezratonbloq.angle = -10;
            
       
            
            
            win();
            
              function win (){
                
         
                  
                  if(variablesCampeones.pj7.estado==0){
                   variablesCampeones.ratonbloqlock  = game.add.sprite(450,170, 'cararaton');
                   //variablesCampeones.ratonbloqlock.visible = false;
                  }
                  else{
                      variablesCampeones.ratonbloqlock  = game.add.sprite(450,170, 'ratonbloq');
                     // variablesCampeones.ratonbloqlock.visible = false;
                  }
                   if(variablesCampeones.pj1.estado==0){
                   variablesCampeones.hormigabloqlock  = game.add.sprite(450,170, 'carahormiga');
                   //variablesCampeones.ratonbloqlock.visible = false;
                  }
                  else{
                      variablesCampeones.hormigabloqlock  = game.add.sprite(450,170, 'hormigabloq');
                     // variablesCampeones.ratonbloqlock.visible = false;
                  }
                  if(variablesCampeones.pj4.estado==0){
                   variablesCampeones.jirafabloqlock  = game.add.sprite(450,170, 'carajirafa');
                   }
                  else{
                      variablesCampeones.jirafabloqlock  = game.add.sprite(450,170, 'jirafabloq');
                  }
                  if(variablesCampeones.pj2.estado==0){
                   variablesCampeones.gallobloqlock  = game.add.sprite(450,170, 'caragallo');
                   }
                  else{
                      variablesCampeones.gallobloqlock  = game.add.sprite(450,170, 'gallobloq');
                  }
                  if(variablesCampeones.pj9.estado==0){
                   variablesCampeones.ruisenorlocklock  = game.add.sprite(450,170, 'cararuisenor');
                   }
                  else{
                      variablesCampeones.ruisenorlocklock  = game.add.sprite(450,170, 'ruisenorlock');
                  }
                  if(variablesCampeones.pj8.estado==0){
                   variablesCampeones.canariobloqlock  = game.add.sprite(450, 170, 'caracanario');
                   }
                  else{
                      variablesCampeones.canariobloqlock  = game.add.sprite(450, 170, 'canariobloq');
                  }
                  if(variablesCampeones.pj6.estado==0){
                   variablesCampeones.leonbloqlock  = game.add.sprite(450,170, 'caraleon');
                   }
                  else{
                      variablesCampeones.leonbloqlock  = game.add.sprite(450,170, 'leonbloq');
                  }
                  if(variablesCampeones.pj3.estado==0){
                   variablesCampeones.panterabloqlock  = game.add.sprite(450,170,'carapantera');
                   }
                  else{
                      variablesCampeones.panterabloqlock  = game.add.sprite(450,170, 'panterabloq');
                  }
               
                  if(variablesCampeones.pj5.estado==0){
                   variablesCampeones.ciervabloqlock  = game.add.sprite(450,170, 'caracierva');
                   }
                  else{
                      variablesCampeones.ciervabloqlock  = game.add.sprite(450,170, 'ciervabloq');
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
    
        
        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            variablesBoot.sonidoBoton.play();
            game.state.start("perfilJugador");
        },        
        update:function(){
        }
    }