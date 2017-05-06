var speedMult = 0.2;
var friction = 0.99;
var nameBox;
// Nombres personajes Pacto de honor
//var nameBox = ["Mi KuPlagio", "Mi LifePlagio ", "Mi SkillPlagio ", "The originalPlagio ", "Mi HitBackground  \n“Es poseedor de la experiencia, “Campeón de habilidades”", "Trendy  \n“Este logro indica que eres súper popular”", "The Richest  \n“Podrás presumir tu fortuna”", "The Unlocker \n“Eres el encargado para recuperar a todos los héroes”"];
var boxloocked = [false,false,false,false,false,false,false,false,false];
var description;
var character;
var apodo;
var startButton;

var moneyLogros = 0;
var rankingLogros = 0;
var timeplayedLogros =0;
var allHeros = false;
var xpLogros = 0;
var imgDesBox;

// Descripción de los logros
var boxDescription;    
var cajaMisteriosa = function(game){};
    cajaMisteriosa.prototype = {
        preload: function(){
            nameBox = boxesDes["boxMistery"].nameBox;
            boxDescription = boxesDes["boxMistery"].desc;
            game.scale.pageAlignHorizontally = true;
            game.scale.pageAlignVertically = true;
            
            // Se carga una imagen transparente para colocar detras de las imagenes que apareceran en el Scrolling
            game.load.image("transp", "../img/personajes/avatares/transp.png");
            // Se cargan las imagenes de los 10 logros
            game.load.spritesheet(nameBox[0], boxes[1].root);
            game.load.spritesheet(nameBox[1], boxes[2].root);
            game.load.spritesheet(nameBox[2], boxes[3].root);
            game.load.spritesheet(nameBox[3], boxes[4].root);
            game.load.spritesheet(nameBox[4], boxes[5].root);
            game.load.spritesheet(nameBox[5], boxes[6].root);
            game.load.spritesheet(nameBox[6], boxes[7].root);
            game.load.spritesheet(nameBox[7], boxes[8].root);


            game.load.spritesheet(nameBox[0]+"explosion", boxes[1].rootOpen);
            game.load.spritesheet(nameBox[1]+"explosion", boxes[2].rootOpen);
            game.load.spritesheet(nameBox[2]+"explosion", boxes[3].rootOpen);
            game.load.spritesheet(nameBox[3]+"explosion", boxes[4].rootOpen);
            game.load.spritesheet(nameBox[4]+"explosion", boxes[5].rootOpen);
            game.load.spritesheet(nameBox[5]+"explosion", boxes[6].rootOpen);
            game.load.spritesheet(nameBox[6]+"explosion", boxes[7].rootOpen);
            game.load.spritesheet(nameBox[7]+"explosion", boxes[8].rootOpen);
   
    

            game.load.spritesheet('atras', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);

  
            // Se carga el sprite del boton seleccionar
            game.load.spritesheet('button', '../img/Componentes/botones/Spritebloq.png', 150, 40);   
        },

        create: function(){
   


          // Se coloca como fondo de la ventana el color #2451A6
          game.stage.backgroundColor = "#2451A6";
          
          // Se agrega un titulo para la ventana, el cual sera "Logros", de tamaño 30 px, y "Roboto" como tipo de letra
          // Se coloca en una posición especifica, con la instrucción ".anchor.set(0.5)" se centra en la posición dada
          game.add.text(game.width / 2, 20, "Cajas Sorpresa", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);

          // Se agrega la funcion ScrollingMap a la ventana, con una posición especifica, y se agrega la imagen transparente
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + nameBox.length * 90 + 64, game.height, "transp");
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
          for(var i = 0; i < nameBox.length; i++){
              // se agrega cada una de las 10 imagenes cargadas previamente de los 10 logros
              if (boxloocked[i]) {//se verifica si esta o no bloqueado
                  character = game.add.image(game.width / 2 + i * 90, 130, nameBox[i]);
                }else{
                  character = game.add.image(game.width / 2 + i * 90, 130, nameBox[i]);
                }

              // Se centra la imagen cargada en la posición puesta en la linea anterior
              character.anchor.set(0.5);

              // Se agrega al scrollingMap cada una de las imagenes cargadas
              this.scrollingMap.addChild(character);
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
          apodo = game.add.text(game.world.centerX/2, 230, "", { font: "24px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          apodo.anchor.set(0.5);

          // Se agrega un texto a la ventana para representar las descripciones de los logros, con 20px de tamaño y "Roboto" como tipo de letra
          // Tambien se agrega un color de fondo y se alinea el texto en el centro
          description = game.add.text(550, 300, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          description.anchor.set(0.5);


          // Se agrega un boton con posiciones especificas, con diferentes estados (Cargados previamente en la funcion onload)
          startButton = game.add.button(game.world.width / 2, 540, 'button', null, this, 2, 1, 0); // over, out, down, up
          startButton.anchor.set(0.5);

          imgDesBox =game.add.image(game.world.centerX/2,350,nameBox[0]);
          imgDesBox.anchor.set(0.5);
                              

    
          game.add.button(5, 5,'atras', this.verPerfil, 1, 1, 0, 2);
          //metdo que verica si esta o no bloqueado un logro de ser asi llama al metodo del logro para validar si cumple con los requsitos de desbloqueo
          function isUnloocked(){
           for(var i = 0; i < boxloocked.length; i++){
            if(boxloocked[i]){
              if(i == 0){
                isMikuplagio(i);
                }
              else if (i == 1) {
                isMiLifePlagio(i);
              }  
              else if (i == 2) {
                isMiSkillPlagio(i);
              }
              else if (i == 3) {
                isTheOriginalPlagio(i);
              }
              else if (i == 4) {
                isMiHitckGround(i);
              }
              else if (i == 5) {
                isMyMater(i);
              }
              else if (i == 6) {
                isTheRichest(i);
              }
              else if (i == 7) {
                isTheUnloocker(i);
              }
              else if (i == 8) {
                isTheAList(i);
              }
              else if (i == 9) {
                is5InaRow(i);
                isMyMater(5);
              }
              else{}


            }

          }

        }
        function recompensa(exp,mon){
          xpLogros = xpLogros + exp;
          moneyLogros = moneyLogros + mon;
        }
        function isMikuplagio(i){
          var timeHours = timeplayedLogros/60;
          if (timeHours>=100) {
            recompensa(20,2500);
            boxloocked[i]= false;
          };

        }
        function isMiLifePlagio(i){
          if (rankingLogros<= 5) {
            recompensa(20,1000);
            boxloocked[i]= false;
          };

        }
        function isMiSkillPlagio(i){
          var logrosdes = 0;
          for(var j = 0; j < boxloocked.length; j++){
            if (!boxloocked[j]) {
              logrosdes++;
            };
          }
          if (((logrosdes*100)/boxloocked.length)>=70) {
            recompensa(15,800);
            boxloocked[i] =false;

          };
        }
        function isTheOriginalPlagio(i){

          recompensa(5,1000);
          //por implentar no es de servicios Rest
        }
        function isMiHitckGround(i){
          recompensa(20,1000);
          //por implentar no es de Rest
        }
        function isTheUnloocker(i){
          if (allHeros) {
            recompensa(10,200);
            boxloocked[i] = false;
          };
        }
        function isTheRichest(i){
          if (moneyLogros >=1000000) {
            recompensa(30,300);
            boxloocked[i] = false;
          };
        }
        function isTheAList(i){
          if (rankingLogros ==1) {
            boxloocked[i] = false;
          };
        }
        function is5InaRow(i){
          recompensa(50,4000);
          //por implentar falta que todo un mundo este implentado
        }
        function isMyMater(i){
          if (xpLogros>=1000) {
            recompensa(0,4000);
            boxloocked[i] = false;
          };
        }
      },

        verPerfil: function(){
            game.state.start("navegacion");
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
                    for (var j = 0; j < boxDescription.length; j++) {
                         if(i == j){
                              // Se va modificando los nombres de los personajes de acuerdo al personaje en el que se este
                              apodo.setText(nameBox[j]);
                             // startButton.pendingDestroy = true;

                              // Se va modificando las descripciones de los personajes de acuerdo al personaje en el que se este
                              description.setText(boxDescription[j]);
                              imgDesBox.pendingDestroy = true;
                              imgDesBox =game.add.image(game.world.centerX/2,350,nameBox[j]+"explosion");
                              imgDesBox.anchor.set(0.5);
                              

                              if (boxloocked[j]) {
                                
                                 // this.scrollingMap.game.add.image(game.width / 2 + i * 90, 130, characters[i]);
                                  startButton = game.add.button(game.world.width / 2, 540, 'button',null, this, 2, 2, 2); 
                                  startButton.anchor.set(0.5);

                              }
                              else{
                                  startButton = game.add.button(game.world.width / 2, 540, 'button',null, this, 1, 1, 1); 
                                  startButton.anchor.set(0.5);
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
                    this.scrollingMap.movingSpeed *= friction;
                    this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
               }
               else{
                    var distance = this.scrollingMap.savedPosition.distance(this.scrollingMap.position);
                    var angle = this.scrollingMap.savedPosition.angle(this.scrollingMap.position);
                    if(distance > 4){
                         this.scrollingMap.movingSpeed = distance * speedMult;
                         this.scrollingMap.movingangle = angle;
                    }
               }
          }

        

         }
         
}