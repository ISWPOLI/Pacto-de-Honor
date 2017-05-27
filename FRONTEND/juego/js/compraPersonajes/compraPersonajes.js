variablesCompraPersonajes={
  speedMult : 0.2,
  friction :0.99,
  animals : ["pantera","gallo","cierva","jirafa","leon","canario","ruisenor","raton","hormiga"],
  // Nombres personajes Pacto de honor
  names : ["Ana Pantera", 
                     "Andrés Gallo",
                     "Cata Cierva", 
                     "Daniela Jirafa", 
                     "Daniel León", 
                     "Fabián Canario", 
                     "Iván Ruiseñor", 
                     "Pedro Ratón", 
                     "Tati Hormiga"],
  scrollText:null,
  comprado : [false,true,false,false,false,false,false,false,true],
  animal:null,
  monedas : 4000,
  xp : 8000,
  nickname:null,
  startButton:null, 
  botonVolver:null,
  compradoL:null,
  pos:null,
  musicButton:null,

  // Especificaciones de compra de los personajes
  texts : ["Necesitas: 2.000 monedas \n \n Recompensas: \n 1.000 monedas \n 50 puntos de experiencia",
                  "Necesitas: 1.300 monedas \n \n Recompensas: \n 500 monedas \n 10 puntos de experiencia",
                  "Necesitas: 1.350 monedas \n \n Recompensas: \n 550 monedas \n 15 puntos de experiencia",
                  "Necesitas: 1.400 monedas \n \n Recompensas: \n 600 monedas \n 20 puntos de experiencia",
                  "Necesitas: 1.450 monedas \n \n Recompensas: \n 650 monedas \n 30 puntos de experiencia",
                  "Necesitas: 1.600 monedas \n \n Recompensas: \n 800 monedas \n 35 puntos de experiencia",
                  "Necesitas: 1.500 monedas \n \n Recompensas: \n 700 monedas \n 30 puntos de experiencia",
                  "Necesitas: 1.450 monedas \n \n Recompensas: \n 650 monedas \n 30 puntos de experiencia",
                  "Necesitas: 1.800 monedas \n \n Recompensas: \n 900 monedas \n 40 puntos de experiencia"],

  //Especificaciones de costo en monedas del personaje
  cMonedas : [2000, 1300, 1350, 1400, 1450, 1600, 1500, 1450, 1800],


  //Especificaciones de recompensas - monedas
  rMonedas : [1000, 500, 550, 600, 650, 800, 700, 650, 900],

  //Especificaciones de recompensas - puntos de experiencia
  rExperiencia : [50, 10, 15, 20, 30, 35, 30, 30, 40]      

}
var compraPersonajes = function(game){};
compraPersonajes.prototype = {
    preload: function(){
        // Se carga el sprite del botón de compra
        game.load.spritesheet('button', '../img/componentes/botones/SpriteButtonC.png', 140, 52);
    },
    
    create: function(){  
        // Se coloca como fondo de la ventana el color #2451A6
        game.stage.backgroundColor = "#2451A6";
          
          // Se agrega un título para la ventana de tamaño 30 px
          // Se coloca en una posición especifica, con la instrucción ".anchor.set(0.5)" se centra en la posición dada
          game.add.text(game.width / 2, 50, "Compra de personajes", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);

          // Se agrega la función ScrollingMap a la ventana, con una posición especifica, y se agrega la imagen transparente
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + variablesCompraPersonajes.animals.length * 90 + 64, game.height, "transp");
          this.scrollingMap.inputEnabled = true;
          this.scrollingMap.input.enableDrag(false);

          // Se guarda la posición
          this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          this.scrollingMap.isBeingDragged = false; 
          this.scrollingMap.movingSpeed = 0;

          // Se especifica que el ScrollingMap será sólo horizontal
          this.scrollingMap.input.allowVerticalDrag = false;
          this.scrollingMap.input.boundsRect = new Phaser.Rectangle(game.width - this.scrollingMap.width, game.height - this.scrollingMap.height, this.scrollingMap.width * 2 - game.width, this.scrollingMap.height * 2 - game.height);
          
          for(var i = 0; i < variablesCompraPersonajes.animals.length; i++){
               // See agregan las 9 imágenes cargadas previamente de los 9 personajes buenos
               variablesCompraPersonajes.animal = game.add.image(game.width / 2 + i * 90, 170, variablesCompraPersonajes.animals[i]);

               // Se centra la imagen cargada en la posición puesta en la linea anterior
               variablesCompraPersonajes.animal.anchor.set(0.5);

               // Se agrega al scrollingMap cada una de las imágenes cargadas
               this.scrollingMap.addChild(variablesCompraPersonajes.animal);
          }

          // Se agregan eventos a las imágenes del scrollingMap para cuando este en movimiento
          this.scrollingMap.events.onDragStart.add(function(){
               this.scrollingMap.isBeingDragged = true;
               this.scrollingMap.movingSpeed = 0;
          }, this);

          // Se agregan enventos a las imágenes del scrollingMap para cuando este quieto
          this.scrollingMap.events.onDragStop.add(function(){
               this.scrollingMap.isBeingDragged = false;
          }, this);


          // Se agrega un texto a la ventana para representar los nombres de los personajes, con 24px de tamaño y "Roboto" como tipo de letra
          // También se agrega un color de fondo y se alinea el texto en el centro
          variablesCompraPersonajes.nickname = game.add.text(game.world.centerX, 270, "", { font: "24px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          variablesCompraPersonajes.nickname.anchor.set(0.5);

          // Se agrega un texto a la ventana para representar las recompensas de los personajes, con 20px de tamaño y "Roboto" como tipo de letra
          // Se agrega un color de fondo y se alinea el texto en el centro
          variablesCompraPersonajes.scrollText = game.add.text(game.world.centerX, 400, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          variablesCompraPersonajes.scrollText.anchor.set(0.5);


          variablesCompraPersonajes.startButton = game.add.button(game.world.width / 2, 510, 'button', this.compra, this, 2, 1, 0); // over, out, down, up
          variablesCompraPersonajes.startButton.anchor.set(0.5);

          if(startButton==true){
            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba5');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba5('false');
         }
         
          variablesCompraPersonajes.botonVolver = game.add.button(5, 5, 'botonVolver', this.verMapa, 1, 1, 0, 2);

          //compradoL = game.add.text(game.world.centerX, 510, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          //compradoL.anchor.set(0.5);
        
        pages = game.add.text(game.world.width/2, 235, null, { font: "14px Roboto", fill: "#ffffff"});
        pages.anchor.setTo(0.5);
        pages.alpha = 0.5;
        
        boot.verificarMusica("menu");

     },
     compra: function(){  
     	if(variablesCompraPersonajes.comprado[variablesCompraPersonajes.pos]){
         variablesBoot.sonidoBoton.play();
     		alert("¡Ya posees este personaje!");
     	} else {
     		//Si no ha comprado el personaje, realiza el proceso necesario para su compra y recibir las recompensas
     		if(variablesCompraPersonajes.monedas >= variablesCompraPersonajes.cMonedas[variablesCompraPersonajes.pos]){
     			//Si tiene suficientes monedas
	          	variablesCompraPersonajes.monedas = variablesCompraPersonajes.monedas - variablesCompraPersonajes.cMonedas[variablesCompraPersonajes.pos] + variablesCompraPersonajes.rMonedas[variablesCompraPersonajes.pos];
	          	variablesCompraPersonajes.xp = variablesCompraPersonajes.xp + variablesCompraPersonajes.rExperiencia[variablesCompraPersonajes.pos];
	          	variablesCompraPersonajes.comprado[variablesCompraPersonajes.pos] = true;
	          	alert("Personaje comprado exitosamente");
     		}
     	}
     },
    
    verMapa: function(){
        game.state.start("navegacion");
        variablesBoot.sonidoBoton.play();
    },
    
    update:function(){
          // Se declara una variable llamada "zoomed" de tipo booleana, que representara cuando un elemento del scrolling map este seleccionada
          var zoomed = false;

          // Este ciclo recorre el scrollingMap
          for(var i = 0; i < this.scrollingMap.children.length; i++){
               if(Math.abs(this.scrollingMap.children[i].world.x - game.width / 2) < 46 && !zoomed){
                    // Se agranda la imagen al 150%
                    this.scrollingMap.getChildAt(i).scale.setTo(1.3);

                    // Se pone la variable zoomed en true cuando la imagen del scrollingMap aumente su tamaño
                    zoomed = true;
                    for (var j = 0; j < variablesCompraPersonajes.texts.length; j++) {
                         if(i == j){
                             variablesCompraPersonajes.pos = j;
                             // Se va modificando los nombres de los personajes de acuerdo al personaje en el que se esté
                             variablesCompraPersonajes.nickname.setText(variablesCompraPersonajes.names[j]);
                             // Se modifican los parámetros de compra de acuerdo al personaje en el que se esté
                             variablesCompraPersonajes.scrollText.setText(variablesCompraPersonajes.texts[j]);
                             pages.setText(j+1+"/9");
                         }
                    }

               }
               else{
                    // Se vuelve al tamaño normal el resto de imágenes del scrollingMap
                    this.scrollingMap.getChildAt(i).scale.setTo(1);   
               }
          }
          if(this.scrollingMap.isBeingDragged){
               // Si el scrollingMap esta en movimiento se va guardando la posición
               this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          }
          else{
               if(this.scrollingMap.movingSpeed > 1){
                    this.scrollingMap.x += this.scrollingMap.movingSpeed * Math.cos(this.scrollingMap.movingangle);
                    // Si la posición en x es menor al ancho definido para el scrollingMap, se define la velocidad en que se mueve dentro del ScrollingMap
                    if(this.scrollingMap.x < game.width - this.scrollingMap.width){
                         this.scrollingMap.x = game.width - this.scrollingMap.width;
                         this.scrollingMap.movingSpeed *= 0.5;
                         this.scrollingMap.movingangle += Math.PI;
                         
                    }
                    // Cuando la posición en x dentro del scrollingMap este sobre el limite, no se debe mover más
                    if(this.scrollingMap.x > 0){
                         this.scrollingMap.x = 0;
                         this.scrollingMap.movingSpeed *= 0.5;
                         this.scrollingMap.movingangle += Math.PI;
                    }
                    this.scrollingMap.movingSpeed *= variablesCompraPersonajes.friction;
                    this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
               }
               else{
                    var distance = this.scrollingMap.savedPosition.distance(this.scrollingMap.position);
                    var angle = this.scrollingMap.savedPosition.angle(this.scrollingMap.position);
                    if(distance > 4){
                         this.scrollingMap.movingSpeed = distance * variablesCompraPersonajes.speedMult;
                         this.scrollingMap.movingangle = angle;
                    }
               }
          }
     }
}