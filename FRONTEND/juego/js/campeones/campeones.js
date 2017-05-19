variablesCampeones={
//Variables de botones
    botonVolver:null, 
    botonPacto:null, 
    botonBuenos:null, 
    botonMalos:null, 
    botonPlagios:null,
    abejalock:null,
    micolock:null,
    buitrelock:null,
    burrolock:null,
    camaleonlock:null,
    hienalock:null,
    lagartolock: null,
    osolock: null,
    peresoso : null,
    ratalock: null,
    vibora: null,
    zorro: null,
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
            game.load.image('logoPacto', '../img/Componentes/creditos/logoPacto.png');
        
            game.load.spritesheet('anaSaraAbejas', '../img/personajes/avatares/botonAbejas.png', 75, 75);
            game.load.spritesheet('fabianBabuino', '../img/personajes/avatares/botonBabuino.png', 75, 75);
            game.load.spritesheet('carlosBuitre', '../img/personajes/avatares/botonBuitre.png', 75, 75);
            game.load.spritesheet('julianBurro', '../img/personajes/avatares/botonBurro.png', 75, 75);
            game.load.spritesheet('juanCamaleon', '../img/personajes/avatares/botonCamaleon.png', 75, 75);
            game.load.spritesheet('victorHiena', '../img/personajes/avatares/botonHiena.png', 75, 75);
            game.load.spritesheet('nicolasLagarto', '../img/personajes/avatares/botonLagarto.png', 75, 75);
            game.load.spritesheet('felipeOso', '../img/personajes/avatares/botonOso.png', 75, 75);
            game.load.spritesheet('camiloPerezoso', '../img/personajes/avatares/botonPerezoso.png', 75, 75);
            game.load.spritesheet('juanRata', '../img/personajes/avatares/botonRata.png', 75, 75);
            game.load.spritesheet('luisVibora', '../img/personajes/avatares/botonVibora.png', 75, 75);
            game.load.spritesheet('andresZorro', '../img/personajes/avatares/botonZorro.png', 75, 75);
            
            game.load.spritesheet('abejaderrota', '../img/Componentes/jefes/abejaderrota.png', 400,400);
            game.load.spritesheet('micoderrota', '../img/Componentes/jefes/micoderrota.png', 400,400);
            game.load.spritesheet('buitrederrota', '../img/Componentes/jefes/buitrederrota.png', 400,400);
            game.load.spritesheet('burroderrota', '../img/Componentes/jefes/burroderrota.png', 400,400);
            game.load.spritesheet('camaleonderrota', '../img/Componentes/jefes/camaleonderrota.png', 400,400);
            game.load.spritesheet('hienaderrota', '../img/Componentes/jefes/hienaderrota.png', 400,400);
            game.load.spritesheet('lagartoderrota', '../img/Componentes/jefes/lagartoderrota.png', 400,400);
            game.load.spritesheet('osoderrota', '../img/Componentes/jefes/osoderrota.png', 400,400);
            game.load.spritesheet('peresosoderrota', '../img/Componentes/jefes/peresosoderrota.png', 400,400);
            game.load.spritesheet('rataderrota', '../img/Componentes/jefes/rataderrota.png', 400,400);
            game.load.spritesheet('viboraderrota', '../img/Componentes/jefes/serpientederrota.png', 400,400);
            game.load.spritesheet('zorroderrota', '../img/Componentes/jefes/zorroderrota.png', 400,400);
            
            game.load.spritesheet('abeja', '../img/Componentes/jefes/abeja.png', 400,400);
            game.load.spritesheet('mico', '../img/Componentes/jefes/mico.png', 400,400);
            game.load.spritesheet('buitre', '../img/Componentes/jefes/buitre.png', 400,400);
            game.load.spritesheet('burro', '../img/Componentes/jefes/burro.png', 400,400);
            game.load.spritesheet('camaleon', '../img/Componentes/jefes/camaleon.png', 400,400);
            game.load.spritesheet('hiena', '../img/Componentes/jefes/hiena.png', 400,400);
            game.load.spritesheet('lagarto', '../img/Componentes/jefes/lagarto.png', 400,400);
            game.load.spritesheet('oso', '../img/Componentes/jefes/oso.png', 400,400);
            game.load.spritesheet('peresoso', '../img/Componentes/jefes/peresoso.png', 400,400);
            game.load.spritesheet('rata', '../img/Componentes/jefes/rata.png', 400,400);
            game.load.spritesheet('vibora', '../img/Componentes/jefes/serpiente.png', 400,400);
            game.load.spritesheet('zorro', '../img/Componentes/jefes/zorro.png', 400,400);
            
            
            variablesCampeones.pj1 = heroes["idP1"];
            variablesCampeones.pj2 = heroes["idP2"];
            variablesCampeones.pj3 = heroes["idP3"];
            variablesCampeones.pj4 = heroes["idP4"];
            variablesCampeones.pj5 = heroes["idP5"];
            variablesCampeones.pj6 = heroes["idP6"];
            variablesCampeones.pj7 = heroes["idP7"];
            variablesCampeones.pj8 = heroes["idP8"];
            variablesCampeones.pj9 = heroes["idP9"];
            
            //borrar
            variablesCampeones.pj10 = jefesderrotados["idP10"];
            variablesCampeones.pj11 = jefesderrotados["idP11"];
            variablesCampeones.pj12 = jefesderrotados["idP12"];
            
            
            
          
            

       
        },
        
        create: function(){

            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Heroes", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Créditos
            
    
            //Se crean los botones de los personajes malos
            botonAbejas = game.add.button (20, 100, 'anaSaraAbejas', this.abejasClick, 1, 1, 0, 2);
            botonAbejas.angle = 10;
            
            botonBabuino = game.add.button (120, 100, 'fabianBabuino', this.babuinoClick, 1, 1, 0, 2);
            botonBabuino.angle =-10;
          
            botonBuitre = game.add.button (220, 100, 'carlosBuitre', this.buitreClick, 1, 1, 0, 2);
            botonBuitre.angle =10;
            
            botonBurro = game.add.button (20, 200, 'julianBurro', this.burroClick, 1, 1, 0, 2);
            botonBurro.angle =10;
            
            botonCamaleon = game.add.button (120, 200, 'juanCamaleon', this.camaleonClick, 1, 1, 0, 2);
            botonCamaleon.angle =-10;
            
            botonHiena = game.add.button (220, 200, 'victorHiena', this.hienaClick, 1, 1, 0, 2);
            botonHiena.angle = 10;
            
            botonLagarto = game.add.button (20, 300, 'nicolasLagarto', this.lagartoClick, 1, 1, 0, 2);
            botonLagarto.angle = -10;
            
            botonOso = game.add.button (120, 300, 'felipeOso', this.osoClick, 1, 1, 0, 2);
            botonOso.angle = 10;
            
            botonPerezoso = game.add.button (220, 300, 'camiloPerezoso', this.peresosoClick, 1, 1, 0, 2);
            botonPerezoso.angle = -10;
            
            botonRata = game.add.button (20, 400, 'juanRata', this.rataClick, 1, 1, 0, 2);
            botonRata.angle = 10;
            
            botonVibora = game.add.button (120, 400, 'luisVibora', this.viboraClick, 1, 1, 0, 2);
            botonVibora.angle =-10;
            
            botonZorro = game.add.button (220, 400, 'andresZorro', this.zorroClick, 1, 1, 0, 2);
            botonZorro.angle = 10;
            
            
            
            win();
            
              function win (){
                
                  if(variablesCampeones.pj1.estado == 0){
                      variablesCampeones.zorrolock = game.add.sprite(400,150, 'zorroderrota');
                      //variablesCampeones.zorrolock.visible = false;
                      }
                  else{
                      variablesCampeones.zorrolock  = game.add.sprite(400, 150, 'zorro');
                      //variablesCampeones.zorrolock.visible = false;
                  }
                  
                  if(variablesCampeones.pj2.estado==0){
                   variablesCampeones.osolock  = game.add.sprite(400, 150, 'osoderrota');
                   //variablesCampeones.osolock.visible = false;
                  }
                  else{
                      variablesCampeones.osolock  = game.add.sprite(400, 150, 'oso');
                     // variablesCampeones.osolock.visible = false;
                  }
                   if(variablesCampeones.pj3.estado==0){
                   variablesCampeones.burrolock  = game.add.sprite(400, 150, 'burroderrota');
                   //variablesCampeones.osolock.visible = false;
                  }
                  else{
                      variablesCampeones.burrolock  = game.add.sprite(400, 150, 'burro');
                     // variablesCampeones.osolock.visible = false;
                  }
                  if(variablesCampeones.pj4.estado==0){
                   variablesCampeones.ratalock  = game.add.sprite(400, 150, 'rataderrota');
                   }
                  else{
                      variablesCampeones.ratalock  = game.add.sprite(400, 150, 'rata');
                  }
                  if(variablesCampeones.pj5.estado==0){
                   variablesCampeones.camaleonlock  = game.add.sprite(400, 150, 'camaleonderrota');
                   }
                  else{
                      variablesCampeones.camaleonlock  = game.add.sprite(400, 150, 'camaleon');
                  }
                  if(variablesCampeones.pj6.estado==0){
                   variablesCampeones.buitrelock  = game.add.sprite(400, 150, 'buitrederrota');
                   }
                  else{
                      variablesCampeones.buitrelock  = game.add.sprite(400, 150, 'buitre');
                  }
                  if(variablesCampeones.pj7.estado==0){
                   variablesCampeones.peresosolock  = game.add.sprite(400, 150, 'peresosoderrota');
                   }
                  else{
                      variablesCampeones.peresosolock  = game.add.sprite(400, 150, 'peresoso');
                  }
                  if(variablesCampeones.pj8.estado==0){
                   variablesCampeones.abejalock  = game.add.sprite(400, 150, 'abejaderrota');
                   }
                  else{
                      variablesCampeones.abejalock  = game.add.sprite(400, 150, 'abeja');
                  }
                  if(variablesCampeones.pj9.estado==0){
                   variablesCampeones.hienalock  = game.add.sprite(400, 150, 'hienaderrota');
                   }
                  else{
                      variablesCampeones.hienalock  = game.add.sprite(400, 150, 'hiena');
                  }
                  if(variablesCampeones.pj10.estado==0){
                   variablesCampeones.lagartolock  = game.add.sprite(400, 150, 'lagartoderrota');
                   }
                  else{
                      variablesCampeones.lagartolock  = game.add.sprite(400, 150, 'lagarto');
                  }
                  if(variablesCampeones.pj11.estado==0){
                   variablesCampeones.viboralock  = game.add.sprite(400, 150, 'viboraderrota');
                   }
                  else{
                      variablesCampeones.viboralock  = game.add.sprite(400, 150, 'vibora');
                  }
                  if(variablesCampeones.pj12.estado==0){
                   variablesCampeones.micolock  = game.add.sprite(400, 150, 'micoderrota');
                   }
                  else{
                      variablesCampeones.micolock  = game.add.sprite(400, 150, 'mico');
                  }
                  
            }
            
            variablesCampeones.botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            boot.verificarMusica("menu");
            
            hideBoss();
            
        function hideBoss(){

            variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
        }

        },
    
        abejasClick: function(){
            variablesBoot.sonidoBoton.play();
            
          
            variablesCampeones.abejalock.visible = true;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
            
        },
        babuinoClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =true;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
           
       },
        buitreClick:function(){
           variablesBoot.sonidoBoton.play();
          variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = true;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        burroClick: function(){
            variablesBoot.sonidoBoton.play();
          
            variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = true;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
    
        },
        camaleonClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = true;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
         
       },
        hienaClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = true;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        
        rataClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = true;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        
        viboraClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = true;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        peresosoClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = true;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        
        zorroClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = true;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = false;
       },
        lagartoClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = false;
            variablesCampeones.lagartolock.visible = true;
       },
        osoClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesCampeones.abejalock.visible = false;
            variablesCampeones.micolock.visible =false;
            variablesCampeones.buitrelock.visible = false;
            variablesCampeones.burrolock.visible = false;
            variablesCampeones.camaleonlock.visible = false;
            variablesCampeones.hienalock.visible = false;
            variablesCampeones.ratalock.visible = false;
            variablesCampeones.viboralock.visible = false;
            variablesCampeones.peresosolock.visible = false;
            variablesCampeones.zorrolock.visible = false;
            variablesCampeones.osolock.visible = true;
            variablesCampeones.lagartolock.visible = false;
       },
    
        
        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            variablesBoot.sonidoBoton.play();
            game.state.start("perfilJugador");
        },        
        update:function(){
        }
    }