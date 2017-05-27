
﻿variablesCajaMisteriosa={ 
  speedMult : 0.2,
  friction :0.99,
  nameBox:null,
  boxloocked : [false,false,false,false,false,true,false,false,true],
  description:null,
  character:null,
  apodo:null,
  startButton:null,
  imgDesBox:null,
  boxDescription:null
}


// Descripción de los logros
   
var cajaMisteriosa = function(game){};
    cajaMisteriosa.prototype = {
        preload: function(){
            variablesCajaMisteriosa.nameBox = boxesDes["boxMistery"].nameBox;
            variablesCajaMisteriosa.boxDescription = boxesDes["boxMistery"].desc;
            
            // Se cargan las imagenes de los 10 logros
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [0], boxes[1].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [1], boxes[2].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [2], boxes[3].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [3], boxes[4].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [4], boxes[5].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [5], boxes[6].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [6], boxes[7].root);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox [7], boxes[8].root);


            game.load.spritesheet(variablesCajaMisteriosa.nameBox[0]+"explosion", boxes[1].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[1]+"explosion", boxes[2].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[2]+"explosion", boxes[3].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[3]+"explosion", boxes[4].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[4]+"explosion", boxes[5].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[5]+"explosion", boxes[6].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[6]+"explosion", boxes[7].rootOpen);
            game.load.spritesheet(variablesCajaMisteriosa.nameBox[7]+"explosion", boxes[8].rootOpen);
   
    

            //game.load.spritesheet('atras', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);

  
            // Se carga el sprite del boton seleccionar
            game.load.spritesheet('button', '../img/componentes/botones/Spritebloq.png', 150, 40);   
        },

        create: function(){
            // Se coloca como fondo de la ventana el color #2451A6
            game.stage.backgroundColor = "#2451A6";
          
          // Se agrega un titulo para la ventana, el cual sera "Logros", de tamaño 30 px, y "Roboto" como tipo de letra
          // Se coloca en una posición especifica, con la instrucción ".anchor.set(0.5)" se centra en la posición dada
          game.add.text(game.width / 2, 20, "Cajas Sorpresa", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);

          // Se agrega la funcion ScrollingMap a la ventana, con una posición especifica, y se agrega la imagen transparente
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + variablesCajaMisteriosa.nameBox.length * 90 + 64, game.height, "transp");
          this.scrollingMap.inputEnabled = true;
          this.scrollingMap.input.enableDrag(false);

          // Se guarda la posición
          this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          this.scrollingMap.isBeingDragged = false; 
          this.scrollingMap.movingSpeed = 0;

          // Se especifica que el ScrollingMap sera solo horizontal
          this.scrollingMap.input.allowVerticalDrag = false;
          this.scrollingMap.input.boundsRect = new Phaser.Rectangle(game.width - this.scrollingMap.width, game.height - this.scrollingMap.height, this.scrollingMap.width * 2 - game.width, this.scrollingMap.height * 2 - game.height);
          
          //isUnloocked();
          for(var i = 0; i < variablesCajaMisteriosa.nameBox.length; i++){
              // se agrega cada una de las 10 imagenes cargadas previamente de los 10 logros
              if (variablesCajaMisteriosa.boxloocked[i]) {//se verifica si esta o no bloqueado
                  variablesCajaMisteriosa.character = game.add.image(game.width / 2 + i * 90, 130, variablesCajaMisteriosa.nameBox[i]);
                }else{
                  variablesCajaMisteriosa.character = game.add.image(game.width / 2 + i * 90, 130, variablesCajaMisteriosa.nameBox[i]);
                }

              // Se centra la imagen cargada en la posición puesta en la linea anterior
              variablesCajaMisteriosa.character.anchor.set(0.5);

              // Se agrega al scrollingMap cada una de las imagenes cargadas
              this.scrollingMap.addChild(variablesCajaMisteriosa.character);
          }

          // Se agrega enventos a las imagenes del scrollingMap para cuando este en movimiento
          this.scrollingMap.events.onDragStart.add(function(){
               this.scrollingMap.isBeingDragged = true;
               this.scrollingMap.movingSpeed = 0;
          }, this);

          // Se agrega enventos a las imagenes del scrollingMap para cuando este quieto
          this.scrollingMap.events.onDragStop.add(function(){
               this.scrollingMap.isBeingDragged = false;
          }, this);


          // Se agrega un texto a la ventana para representar los nombres de los logros, con 24px de tamaño y "Roboto" como tipo de letra
          // Tambien se agrega un color de fondo y se alinea el texto en el centro
          variablesCajaMisteriosa.apodo = game.add.text(game.world.centerX/2, 230, "", { font: "24px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          variablesCajaMisteriosa.apodo.anchor.set(0.5);

          // Se agrega un texto a la ventana para representar las descripciones de los logros, con 20px de tamaño y "Roboto" como tipo de letra
          // Tambien se agrega un color de fondo y se alinea el texto en el centro
          variablesCajaMisteriosa.description = game.add.text(550, 300, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          variablesCajaMisteriosa.description.anchor.set(0.5);


          // Se agrega un boton con posiciones especificas, con diferentes estados (Cargados previamente en la funcion onload)
          variablesCajaMisteriosa.startButton = game.add.button(game.world.width / 2, 540, 'button', null, this, 2, 1, 0); // over, out, down, up
          variablesCajaMisteriosa.startButton.anchor.set(0.5);

          variablesCajaMisteriosa.imgDesBox =game.add.image(game.world.centerX/2,350,variablesCajaMisteriosa.nameBox[0]);
          variablesCajaMisteriosa.imgDesBox.anchor.set(0.5);
            
            pages = game.add.text(game.world.width/2, 220, null, { font: "14px Roboto", fill: "#ffffff"});
            pages.anchor.setTo(0.5);
            pages.alpha = 0.5;
            
            game.add.button(5, 5,'botonVolver', this.verNavegacion, 1, 1, 0, 2);

          //metdo que verica si esta o no bloqueado un logro de ser asi llama al metodo del logro para validar si cumple con los requsitos de desbloqueo
            boot.verificarMusica("menu");
            },

        verNavegacion: function(){
            game.state.start("navegacion");
            variablesBoot.sonidoBoton.play();
        },
        
        update:function(){
          var zoomed = false;

          // Este ciclo recorre el scrollingMap
          for(var i = 0; i < this.scrollingMap.children.length; i++){
               if(Math.abs(this.scrollingMap.children[i].world.x - game.width / 2) < 46 && !zoomed){
                    // Se agranda la imagen al 150%
                    this.scrollingMap.getChildAt(i).scale.setTo(1.5);

                    // Se pone la variable zoomed en true cuando la imagen del scrollingMap aumente su tamaño
                    zoomed = true;
                    for (var j = 0; j < variablesCajaMisteriosa.boxDescription.length; j++) {
                         if(i == j){
                             pages.setText(j+1+"/8");
                             // Se va modificando los nombres de los personajes de acuerdo al personaje en el que se este
                             variablesCajaMisteriosa.apodo.setText(variablesCajaMisteriosa.nameBox[j]);
                             // startButton.pendingDestroy = true;

                             // Se va modificando las descripciones de los personajes de acuerdo al personaje en el que se este
                             variablesCajaMisteriosa.description.setText(variablesCajaMisteriosa.boxDescription[j]);
                             variablesCajaMisteriosa.imgDesBox.pendingDestroy = true;
                             variablesCajaMisteriosa.imgDesBox =game.add.image(game.world.centerX/2,350,variablesCajaMisteriosa.nameBox[j]+"explosion");
                             variablesCajaMisteriosa.imgDesBox.anchor.set(0.5);
                              

                             if (variablesCajaMisteriosa.boxloocked[j]) {
                                
                                 // this.scrollingMap.game.add.image(game.width / 2 + i * 90, 130, characters[i]);
                                  variablesCajaMisteriosa.startButton = game.add.button(game.world.width / 2, 540, 'button',null, this, 2, 2, 2); 
                                  variablesCajaMisteriosa.startButton.anchor.set(0.5);

                              }
                              else{
                                  variablesCajaMisteriosa.startButton = game.add.button(game.world.width / 2, 540, 'button',null, this, 1, 1, 1); 
                                  variablesCajaMisteriosa.startButton.anchor.set(0.5);
                              }

                         }
                    }

               }
               else{
                    // Se vuelve al tamaño normal a resto de imagenes del scrollingMap
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
                    // Cuando la posicion en x dentro del scrollingMap este sobre el limite, no se debe mover mas
                    if(this.scrollingMap.x > 0){
                         this.scrollingMap.x = 0;
                         this.scrollingMap.movingSpeed *= 0.5;
                         this.scrollingMap.movingangle += Math.PI;
                    }
                    this.scrollingMap.movingSpeed *= variablesCajaMisteriosa.friction;
                    this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
               }
               else{
                    var distance = this.scrollingMap.savedPosition.distance(this.scrollingMap.position);
                    var angle = this.scrollingMap.savedPosition.angle(this.scrollingMap.position);
                    if(distance > 4){
                         this.scrollingMap.movingSpeed = distance * variablesCajaMisteriosa.speedMult;
                         this.scrollingMap.movingangle = angle;
                    }
               }
          }

        

         }
         
}