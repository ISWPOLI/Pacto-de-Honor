variablesJefes={
//Variables de botones
  botonVolver:null, 
  botonPacto:null, 
  botonBuenos:null, 
  botonMalos:null, 
  botonPlagios:null,

  
//Variables de los textos y el logo
  logoPacto:null, 
  textoPacto:null, 
  textoBuenos:null, 
  textoMalos:null, 
  textoPlagios:null
  
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

       
        },
        
        create: function(){

            game.stage.backgroundColor = "#2451A6"; //Color de fondo
            game.add.text(game.width / 2, 50, "Boss", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5); //Título de Créditos
            
    
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
            
            botonPerezoso = game.add.button (220, 300, 'camiloPerezoso', this.perezosoClick, 1, 1, 0, 2);
            botonPerezoso.angle = -10;
            
            botonRata = game.add.button (20, 400, 'juanRata', this.rataClick, 1, 1, 0, 2);
            botonRata.angle = 10;
            
            botonVibora = game.add.button (120, 400, 'luisVibora', this.viboraClick, 1, 1, 0, 2);
            botonVibora.angle =-10;
            
            botonZorro = game.add.button (220, 400, 'andresZorro', this.zorroClick, 1, 1, 0, 2);
            botonZorro.angle = 10;
            
            
            variablesJefes.botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            boot.verificarMusica("menu");

        },
        abejasClick: function(){
            variablesBoot.sonidoBoton.play();
            var s = game.add.sprite(400, 150, 'abejaderrota');
            s.rotate = 0.15;
            s.scale.setTo(1);
        },
        babuinoClick:function(){
           variablesBoot.sonidoBoton.play();
            var s = game.add.sprite(400, 150, 'micoderrota');
            s.rotate = 0.15;
            s.scale.setTo(1);
       },
        buitreClick:function(){
           variablesBoot.sonidoBoton.play();
            var s = game.add.sprite(400, 150, 'buitrederrota');
            s.rotate = 0.15;
            s.scale.setTo(1);
       },
        
        //Funcion que se llama al oprimir el boton 'Personajes Malos'
        verPersonajesMalos: function(){

           
            variablesJefes.textoMalos.setText("");

            variablesBoot.sonidoBoton.play();
        
            variablesJefes.textoPacto.visible = false;
            variablesJefes.logoPacto.visible = false;
            variablesJefes.textoBuenos.visible = false;
            variablesJefes.textoPlagios.visible=false;
     
                        
            variablesJefes.textoMalos.visible = true;
            botonAbejas.visible = true;
            botonBabuino.visible = true;
            botonBuitre.visible = true;
            botonBurro.visible = true;
            botonCamaleon.visible = true;
            botonHiena.visible = true;
            botonLagarto.visible = true;
            botonOso.visible = true;
            botonPerezoso.visible = true;
            botonRata.visible = true;
            botonVibora.visible = true;
            botonZorro.visible = true;
        },
        
        //Funcion que se llama al oprimir el boton 'Tipos de plagio'
        verPlagios: function(){

            
            variablesJefes.textoPlagios.setText("");

            variablesBoot.sonidoBoton.play();
            

            botonAbejas.visible = false;
            botonBabuino.visible = false;
            botonBuitre.visible = false;
            botonBurro.visible = false;
            botonCamaleon.visible = false;
            botonHiena.visible = false;
            botonLagarto.visible = false;
            botonOso.visible = false;
            botonPerezoso.visible = false;
            botonRata.visible = false;
            botonVibora.visible = false;
            botonZorro.visible = false;
       
        },
        
        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            variablesBoot.sonidoBoton.play();
            game.state.start("navegacion");
        },        
        update:function(){
        }
    }