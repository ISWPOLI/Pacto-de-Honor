variablesJefes={
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
var jefes = function(game){};
    jefes.prototype = {
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
            
            
            variablesJefes.pj1 = jefesderrotados["idP1"];
            variablesJefes.pj2 = jefesderrotados["idP2"];
            variablesJefes.pj3 = jefesderrotados["idP3"];
            variablesJefes.pj4 = jefesderrotados["idP4"];
            variablesJefes.pj5 = jefesderrotados["idP5"];
            variablesJefes.pj6 = jefesderrotados["idP6"];
            variablesJefes.pj7 = jefesderrotados["idP7"];
            variablesJefes.pj8 = jefesderrotados["idP8"];
            variablesJefes.pj9 = jefesderrotados["idP9"];
            variablesJefes.pj10 = jefesderrotados["idP10"];
            variablesJefes.pj11 = jefesderrotados["idP11"];
            variablesJefes.pj12 = jefesderrotados["idP12"];
            
            
            
          
            

       
        },
        
        create: function(){

            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Jefes", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Créditos
            
    
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
                
                  if(variablesJefes.pj1.estado == 0){
                      variablesJefes.zorrolock = game.add.sprite(400,150, 'zorroderrota');
                      //variablesJefes.zorrolock.visible = false;
                      }
                  else{
                      variablesJefes.zorrolock  = game.add.sprite(400, 150, 'zorro');
                      //variablesJefes.zorrolock.visible = false;
                  }
                  
                  if(variablesJefes.pj2.estado==0){
                   variablesJefes.osolock  = game.add.sprite(400, 150, 'osoderrota');
                   //variablesJefes.osolock.visible = false;
                  }
                  else{
                      variablesJefes.osolock  = game.add.sprite(400, 150, 'oso');
                     // variablesJefes.osolock.visible = false;
                  }
                   if(variablesJefes.pj3.estado==0){
                   variablesJefes.burrolock  = game.add.sprite(400, 150, 'burroderrota');
                   //variablesJefes.osolock.visible = false;
                  }
                  else{
                      variablesJefes.burrolock  = game.add.sprite(400, 150, 'burro');
                     // variablesJefes.osolock.visible = false;
                  }
                  if(variablesJefes.pj4.estado==0){
                   variablesJefes.ratalock  = game.add.sprite(400, 150, 'rataderrota');
                   }
                  else{
                      variablesJefes.ratalock  = game.add.sprite(400, 150, 'rata');
                  }
                  if(variablesJefes.pj5.estado==0){
                   variablesJefes.camaleonlock  = game.add.sprite(400, 150, 'camaleonderrota');
                   }
                  else{
                      variablesJefes.camaleonlock  = game.add.sprite(400, 150, 'camaleon');
                  }
                  if(variablesJefes.pj6.estado==0){
                   variablesJefes.buitrelock  = game.add.sprite(400, 150, 'buitrederrota');
                   }
                  else{
                      variablesJefes.buitrelock  = game.add.sprite(400, 150, 'buitre');
                  }
                  if(variablesJefes.pj7.estado==0){
                   variablesJefes.peresosolock  = game.add.sprite(400, 150, 'peresosoderrota');
                   }
                  else{
                      variablesJefes.peresosolock  = game.add.sprite(400, 150, 'peresoso');
                  }
                  if(variablesJefes.pj8.estado==0){
                   variablesJefes.abejalock  = game.add.sprite(400, 150, 'abejaderrota');
                   }
                  else{
                      variablesJefes.abejalock  = game.add.sprite(400, 150, 'abeja');
                  }
                  if(variablesJefes.pj9.estado==0){
                   variablesJefes.hienalock  = game.add.sprite(400, 150, 'hienaderrota');
                   }
                  else{
                      variablesJefes.hienalock  = game.add.sprite(400, 150, 'hiena');
                  }
                  if(variablesJefes.pj10.estado==0){
                   variablesJefes.lagartolock  = game.add.sprite(400, 150, 'lagartoderrota');
                   }
                  else{
                      variablesJefes.lagartolock  = game.add.sprite(400, 150, 'lagarto');
                  }
                  if(variablesJefes.pj11.estado==0){
                   variablesJefes.viboralock  = game.add.sprite(400, 150, 'viboraderrota');
                   }
                  else{
                      variablesJefes.viboralock  = game.add.sprite(400, 150, 'vibora');
                  }
                  if(variablesJefes.pj12.estado==0){
                   variablesJefes.micolock  = game.add.sprite(400, 150, 'micoderrota');
                   }
                  else{
                      variablesJefes.micolock  = game.add.sprite(400, 150, 'mico');
                  }
                  
            }
            
            variablesJefes.botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            boot.verificarMusica("menu");
            
            hideBoss();
            
        function hideBoss(){

            variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
        }

        },
    
        abejasClick: function(){
            variablesBoot.sonidoBoton.play();
            
          
            variablesJefes.abejalock.visible = true;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
            
        },
        babuinoClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =true;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
           
       },
        buitreClick:function(){
           variablesBoot.sonidoBoton.play();
          variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = true;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        burroClick: function(){
            variablesBoot.sonidoBoton.play();
          
            variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = true;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
    
        },
        camaleonClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = true;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
         
       },
        hienaClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = true;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        
        rataClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = true;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        
        viboraClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = true;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        peresosoClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = true;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        
        zorroClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = true;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = false;
       },
        lagartoClick:function(){
           variablesBoot.sonidoBoton.play();
            
           variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = false;
            variablesJefes.lagartolock.visible = true;
       },
        osoClick:function(){
           variablesBoot.sonidoBoton.play();
            variablesJefes.abejalock.visible = false;
            variablesJefes.micolock.visible =false;
            variablesJefes.buitrelock.visible = false;
            variablesJefes.burrolock.visible = false;
            variablesJefes.camaleonlock.visible = false;
            variablesJefes.hienalock.visible = false;
            variablesJefes.ratalock.visible = false;
            variablesJefes.viboralock.visible = false;
            variablesJefes.peresosolock.visible = false;
            variablesJefes.zorrolock.visible = false;
            variablesJefes.osolock.visible = true;
            variablesJefes.lagartolock.visible = false;
       },
    
        
        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            variablesBoot.sonidoBoton.play();
            game.state.start("perfilJugador");
        },        
        update:function(){
        }
    }