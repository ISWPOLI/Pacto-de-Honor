var speedMult = 0.2;
var friction = 0.99;
var namesCharactersl;
var Logroslooked = [null];
var description;
var character;
var apodo;
var musicButton;
var startButton;
var LogrosJugador;
//catidad de Monedas del Jugador
var moneyLogros = 0;
//posicion del ranking del jugador
var rankingLogros = 0;
//Tiempo de juego del jugador
var timeplayedLogros =0;
//Varible que permite identificar si el jugador tiene o no todos los heroes
var allHeros = false;
//experiencia de juego del jugador
var xpLogros;
// Descripción de los logros
var descriptionsl;    
var logros = function(game){};
    logros.prototype = {
        preload: function(){            
            namesCharactersl = SetUplogros.nombre;
            descriptionsl = SetUplogros.descripcion;
            moneyLogros = SetUplogros.monedas;
            rankingLogros = SetUplogros.ranking;
            timeplayedLogros = SetUplogros.tiempo;
            xpLogros = SetUplogros.exp;
            LogrosJugador = SetUplogros.jugador_tiene_logros;

            for (var i = namesCharactersl.length - 1; i >= 0; i--) {
              Logroslooked[i] = true;
            }
            // Se cargan las imagenes de los 10 logros
            game.load.spritesheet(namesCharactersl[0], '../img/Componentes/logros/KuPlagio.png');
            game.load.spritesheet(namesCharactersl[1], '../img/Componentes/logros/LifePlagio.png');
            game.load.spritesheet(namesCharactersl[2], '../img/Componentes/logros/SkillPlagio.png');
            game.load.spritesheet(namesCharactersl[3], '../img/Componentes/logros/OriginalPlagio.png');
            game.load.spritesheet(namesCharactersl[4], '../img/Componentes/logros/HitBackground.png');
            game.load.spritesheet(namesCharactersl[5], '../img/Componentes/logros/experiencia.png');
            game.load.spritesheet(namesCharactersl[6], '../img/Componentes/logros/Richest.png');
            game.load.spritesheet(namesCharactersl[7], '../img/Componentes/logros/Unlocker.png');
            game.load.spritesheet(namesCharactersl[8], '../img/Componentes/logros/Alist.png');
            game.load.spritesheet(namesCharactersl[9], '../img/Componentes/logros/FiveRow.png');
            game.load.image(namesCharactersl[0]+'Loock', '../img/Componentes/logros/KuPlagioLoock.png');
            game.load.image(namesCharactersl[1]+'Loock', '../img/Componentes/logros/LifePlagioLoock.png');
            game.load.image(namesCharactersl[2]+'Loock', '../img/Componentes/logros/SkillPlagioLoock.png');
            game.load.image(namesCharactersl[3]+'Loock', '../img/Componentes/logros/OriginalPlagioLoock.png');
            game.load.image(namesCharactersl[4]+'Loock', '../img/Componentes/logros/HitBackgroundLoock.png');
            game.load.image(namesCharactersl[5]+'Loock', '../img/Componentes/logros/experienciaLoock.png');
            game.load.image(namesCharactersl[6]+'Loock', '../img/Componentes/logros/RichestLoock.png');
            game.load.image(namesCharactersl[7]+'Loock', '../img/Componentes/logros/UnlockerLoock.png');
            game.load.image(namesCharactersl[8]+'Loock', '../img/Componentes/logros/AlistLoock.png');
            game.load.image(namesCharactersl[9]+'Loock', '../img/Componentes/logros/FiveRowLoock.png');
            // Se carga el sprite del boton seleccionar
            game.load.spritesheet('button', '../img/Componentes/botones/Spritebloq.png', 150, 40);
        },
        
        create: function(){            
          // Se coloca como fondo de la ventana el color #2451A6
          game.stage.backgroundColor = "#2451A6";
          // Se agrega un titulo para la ventana, el cual sera "Logros", de tamaño 30 px, y "Roboto" como tipo de letra
          // Se coloca en una posición especifica, con la instrucción ".anchor.set(0.5)" se centra en la posición dada
          game.add.text(game.width / 2, 50, "Logros", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);
          // Se agrega la funcion ScrollingMap a la ventana, con una posición especifica, y se agrega la imagen transparente
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + namesCharactersl.length * 90 + 64, game.height, "transp");
          this.scrollingMap.inputEnabled = true;
          this.scrollingMap.input.enableDrag(false);
          // Se guarda la posición
          this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          this.scrollingMap.isBeingDragged = false; 
          this.scrollingMap.movingSpeed = 0;
          // Se especifica que el ScrollingMap sera solo horizontal
          this.scrollingMap.input.allowVerticalDrag = false;
          this.scrollingMap.input.boundsRect = new Phaser.Rectangle(game.width - this.scrollingMap.width, game.height - this.scrollingMap.height, this.scrollingMap.width * 2 - game.width, this.scrollingMap.height * 2 - game.height);
          playedUnloock();
          isUnloocked();
          for(var i = 0; i < namesCharactersl.length; i++){
              // se agrega cada una de las 10 imagenes cargadas previamente de los 10 logros
              if (Logroslooked[i]) character = game.add.image(game.width / 2 + i * 90, 130, namesCharactersl[i]+"Loock");
                else character = game.add.image(game.width / 2 + i * 90, 130, namesCharactersl[i]);
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
          apodo = game.add.text(game.world.centerX, 230, "", { font: "24px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          apodo.anchor.set(0.5);
          // Se agrega un texto a la ventana para representar las descripciones de los logros, con 20px de tamaño y "Roboto" como tipo de letra
          // Tambien se agrega un color de fondo y se alinea el texto en el centro
          description = game.add.text(game.world.centerX, 380, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          description.anchor.set(0.5);
          // Se agrega un boton con posiciones especificas, con diferentes estados (Cargados previamente en la funcion onload)
          startButton = game.add.button(game.world.width / 2, 540, 'button', null, this, 2, 1, 0); // over, out, down, up
          startButton.anchor.set(0.5);
          game.add.button(5, 5,'botonVolver', this.verPerfil, 1, 1, 0, 2);
          //metdo que verica si esta o no bloqueado un logro de ser asi llama al metodo del logro para validar si cumple con los requsitos de desbloqueo
          function isUnloocked(){
           for(var i = 0; i < Logroslooked.length; i++){
            if(Logroslooked[i]){
              if(i == 0) isMikuplagio(i);
              else if (i == 1) isMiLifePlagio(i); 
              else if (i == 2) isMiSkillPlagio(i);
              else if (i == 3) isTheOriginalPlagio(i);
              else if (i == 4) isMiHitckGround(i);
              else if (i == 5) isMyMater(i);
              else if (i == 6) isTheRichest(i);
              else if (i == 7) isTheUnloocker(i);
              else if (i == 8) isTheAList(i);
              else if (i == 9) {
                is5InaRow(i);
                isMyMater(5);
              }
              else{}
            }
          }
        }
        function playedUnloock(){
          for (var i = namesCharactersl.length - 1; i >= 0; i--) {
            for (var k = LogrosJugador.length - 1; k >= 0; k--) {
              if (namesCharactersl[i] == LogrosJugador[k]) {
                Logroslooked[i] = false;
              }
            }
          }
        }
        //funcion encargada de dar las recompensas de los logros
        function recompensa(exp,mon){
          xpLogros = xpLogros + exp;
          moneyLogros = moneyLogros + mon;
        }
        //funcion que comprueba que el jugador lleve porlomenos 100 horas jugadas
        function isMikuplagio(i){
          var timeHours = timeplayedLogros/60;
          if (timeHours>=100) {
              recompensa(20,2500);
              Logroslooked[i]= false;

              pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
              pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          };
        }
        //funcion que Identifica si el jugador esta entre el top 5
        function isMiLifePlagio(i){
          if (rankingLogros<= 5) {
            recompensa(20,1000);
            Logroslooked[i]= false;
              pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
              pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          };
        }
        //funcion que identifica si el jugador ha desbloqueado el  70% como minimo de los logros
        function isMiSkillPlagio(i){
          var logrosdes = 0;
          for(var j = 0; j < Logroslooked.length; j++){
            if (!Logroslooked[j]) {
              logrosdes++;
            };
          }
          if (((logrosdes*100)/Logroslooked.length)>=70) {
            recompensa(15,800);
            Logroslooked[i] =false;
            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
            pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          };
        }
        //por implementar
        function isTheOriginalPlagio(i){
          recompensa(5,1000);
            pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
            pruebasPsicotecnicas.setPrueba227(true);
          //por implentar no es de servicios Rest
        }
        //por implementar
        function isMiHitckGround(i){
          recompensa(20,1000);
          pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
          pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          //por implentar no es de Rest
        }
        //funcion que comprueba que si el jugaro tienen o no todos los heroes
        function isTheUnloocker(i){
          if (allHeros) {
            recompensa(10,200);
            Logroslooked[i] = false;
              pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
              pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          };
        }
        //funcion que comprueba si el jugador tiene porlomenos 1000000 monedas
        function isTheRichest(i){
          if (monedas >=1000000) {
            recompensa(30,300);
            Logroslooked[i] = false;
              pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
              pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba227(true);
          };
        }
        //funcion que Identifica si el jugador esta entre el top 1
        function isTheAList(i){
          if (rankingLogros ==1) {
            Logroslooked[i] = false;
          };
        }
        //por Implementar
        function is5InaRow(i){
          recompensa(50,4000);
          pruebasPsicotecnicas.pruebasPsicotecnicas.getElementsByTagName('getPrueba227');
          pruebasPsicotecnicas.pruebasPsicotecnicas.setPrueba14(true);
          //por implentar falta que todo un mundo este implentado
        }
        //funcion que comprueba que el jugador tenga porlomenos 1000 de experiencia
        function isMyMater(i){
          if (xpLogros>=1000) {
            recompensa(0,4000);
            Logroslooked[i] = false;
          };
        }
      },
        verPerfil: function(){
            game.state.start("perfilJugador");
            sonidoBoton.play();
        },
        update:function(){
           // Se declara una variable llamada "zoomed" de tipo booleana, que representara cuando un elemento del scrolling map este seleccionada
          var zoomed = false;
          // Este ciclo recorre el scrollingMap
          for(var i = 0; i < this.scrollingMap.children.length; i++){
               if(Math.abs(this.scrollingMap.children[i].world.x - game.width / 2) < 46 && !zoomed){
                    // Se agranda la imagen al 150%
                    this.scrollingMap.getChildAt(i).scale.setTo(1.5);
                    // Se pone la variable zoomed en true cuando la imagen del scrollingMap aumente su tamaño
                    zoomed = true;
                    for (var j = 0; j < descriptionsl.length; j++) {
                         if(i == j){
                              // Se va modificando los nombres de los personajes de acuerdo al personaje en el que se este
                              apodo.setText(namesCharactersl[j]);
                              // Se va modificando las descripciones de los personajes de acuerdo al personaje en el que se este
                              description.setText(descriptionsl[j]);
                              if (Logroslooked[j]) { 
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
               else this.scrollingMap.getChildAt(i).scale.setTo(1); // Se vuelve al tamaño normal a resto de imagenes del scrollingMap 
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