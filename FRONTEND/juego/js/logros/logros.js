var speedMult = 0.2;
var friction = 0.99;
var logros = ["Mi KuPlagio","Mi LifePlagio","Mi SkillPlagio","The originalPlagio","Mi HitBackground","Trendy","The Richest","The Unlocker","The A – List","5 in a row"];
// Nombres personajes Pacto de honor
var namesLogros = ["Mi KuPlagio", "Mi LifePlagio ", "Mi SkillPlagio ", "The originalPlagio ", "Mi HitBackground  \n“Es poseedor de la experiencia, “Campeón de habilidades”", "Trendy  \n“Este logro indica que eres súper popular”", "The Richest  \n“Podrás presumir tu fortuna”", "The Unlocker \n“Eres el encargado para recuperar a todos los héroes”", "The A – List \n“Aquí mostrarás tus habilidades al llegar al top”","5 in a row \n“Cambio de un mundo a otro con un desempeño perfecto”",];
var Logroslooked = [true, true, false , false, false, false, false, false, false, true];
var description;
var logro;
var apodo;
var startButton;
// Descripción de los logros
var descriptions = [ "Para adquirir este codiciado objetivo debes\nacumular 2 horas de juego ¿Cuestión de tiempo no? \nPues para obtener el logro debes realizar dicho\nproceso con cada uno de los niveles de cada mundo. \nAl final sólo queda un dilema, ¿termino una carrera, o el juego?",
                     "Su nombre lo dice todo. \nPara obtenerlo debes encabezar las tablas de posición.\nObtendrás 100 monedas por la permanencia durante 2 días \nen las primeras cinco posiciones de la tabla.\n No hay vía fácil, no hay camino rápido.\nSimplemente debes ser el mejor en los combates. ¿Te atreverías a intentar conseguirlo?",
                     "Para obtenerlo debes ganar cada batalla de cada escenario. \nLas monedas obtenidas podrán ser cambiadas en puntos de vida.\n Barra de vida que incrementara de acuerdo al número de batallas ganadas. \nPrincipalmente debes ser el mejor en los enfrentamientos.\n¿Te atreverías a intentar?",
                     "Para adquirir este codiciado logro \ndebes acumular 3 batallas victoriosas \n¿Cuestión de estrategia no? Pues para obtener el logro \ndebes realizar dicho proceso antes de la batalla final de cada nivel.",
                     "Su nombre lo dice todo. \nPara obtenerlo debes encabezar las tablas de posición.\nObtendrás 100 monedas por la permanencia durante 2 días \nen las primeras cinco posiciones de la tabla.\n No hay vía fácil, no hay camino rápido.\nSimplemente debes ser el mejor en los combates. ¿Te atreverías a intentar conseguirlo?",
                     "Realmente has logrado ser muy popular, \n¿cómo lo sabemos?: \n¡Hemos detectado que has realizado más de 10 interacciones, es decir, \nentre tu cantidad de amigos y los códigos que has recibido, \nlogran demostrarnos que definitivamente eres un hit!",
                     "Este logro tiene 3 etapas, la primera cuando \nposeas tus primeras 50 monedas, la segunda etapa \ncuando obtengas 200 monedas y por último \ncuando tu fortuna llegue a 500 monedas.",
                     "Este logro también tiene 3 etapas: \nLa primera al desbloquear al primer personaje en el mundo 2, \nen la segunda etapa desbloquearás de nuevo este logro al obtener \ntu quinto personaje y, por último, al desbloquear todos los \npersonajes y estar listo para la batalla final.",
                     "Para obtener las recompensas de este logro \ndebes cumplir 3 objetivos: Llegar al top 10 \nde al menos 1 ranking, como segundo objetivo debes llegar \nal top 5 de al menos 2 rankings y por último debes \nestar entre el top 3 de TODOS los rankings. \n¿Estás listo/lista para resaltar?",
                     "Para obtener este logro de perfección es necesario \nque pases todo un mundo sin perder ni una sola vez. \n¿Crees ser capaz de cumplir el reto?",
                     ];

var logros = function(game){};
    logros.prototype = {
        preload: function(){
            game.scale.pageAlignHorizontally = true;
            game.scale.pageAlignVertically = true;

            // Se carga una imagen transparente para colocar detras de las imagenes que apareceran en el Scrolling
            game.load.image('transp', '../img/Componentes/logros/transp.png');
            // Se cargan las imagenes de los 10 logros
            game.load.image('Mi KuPlagio', '../img/Componentes/logros/KuPlagio.png');
            game.load.image('Mi LifePlagio', '../img/Componentes/logros/LifePlagio.png');
            game.load.image('Mi SkillPlagio', '../img/Componentes/logros/SkillPlagio.png');
            game.load.image('The originalPlagio', '../img/Componentes/logros/OriginalPlagio.png');
            game.load.image('Mi HitBackground', '../img/Componentes/logros/HitBackground.png');
            game.load.image('Trendy', '../img/Componentes/logros/Trendy.png');
            game.load.image('The Richest', '../img/Componentes/logros/Richest.png');
            game.load.image('The Unlocker', '../img/Componentes/logros/Unlocker.png');
            game.load.image('The A – List', '../img/Componentes/logros/Alist.png');
            game.load.image('5 in a row', '../img/Componentes/logros/FiveRow.png');
            game.load.spritesheet('botonVolver', '../img/Componentes/navegacionMapa/botonVolver.png', 62, 62);
            
            // Se carga el sprite del boton seleccionar
            game.load.spritesheet('button', '../img/Componentes/logros/Spritebloq.png', 150, 40);     
        },

        create: function(){  
            // Se coloca como fondo de la ventana el color #2451A6
            game.stage.backgroundColor = "#2451A6";
          
            // Se agrega un titulo para la ventana, el cual sera "Logros", de tamaño 30 px, y "Roboto" como tipo de letra
          // Se coloca en una posición especifica, con la instrucción ".anchor.set(0.5)" se centra en la posición dada
          game.add.text(game.width / 2, 50, "Logros", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);

          // Se agrega la funcion scrollingMap a la ventana, con una posición especifica, y se agrega la imagen transparente
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + logros.length * 90 + 64, game.height, "transp");
          this.scrollingMap.inputEnabled = true;
          this.scrollingMap.input.enableDrag(false);

          // Se guarda la posición
          this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          this.scrollingMap.isBeingDragged = false; 
          this.scrollingMap.movingSpeed = 0;

          // Se especifica que el scrollingMap sera solo horizontal
          this.scrollingMap.input.allowVerticalDrag = false;
          this.scrollingMap.input.boundsRect = new Phaser.Rectangle(game.width - this.scrollingMap.width, game.height - this.scrollingMap.height, this.scrollingMap.width * 2 - game.width, this.scrollingMap.height * 2 - game.height);
          
          for(var i = 0; i < logros.length; i++){
               // se agrega cada una de las 10 imagenes cargadas previamente de los 10 logros
               logro = game.add.image(game.width / 2 + i * 90, 130, logros[i]);

               // Se centra la imagen cargada en la posición puesta en la linea anterior
               logro.anchor.set(0.5);

               // Se agrega al scrollingMap cada una de las imagenes cargadas
               this.scrollingMap.addChild(logro);
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

          game.add.button(0, 0,'botonVolver', this.verPerfil, 1, 1, 0, 2);

     },
        
        verPerfil: function(){
            game.state.start("perfilJugador");
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
                    for (var j = 0; j < descriptions.length; j++) {
                         if(i == j){
                              // Se va modificando los nombres de los personajes de acuerdo al personaje en el que se este
                              apodo.setText(namesLogros[j]);

                              // Se va modificando las descripciones de los personajes de acuerdo al personaje en el que se este
                              description.setText(descriptions[j]);

                              if (!Logroslooked[j]) {
                                
                                 // this.scrollingMap.game.add.image(game.width / 2 + i * 90, 130, logros[i]);
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
                    // Si la posición en x es menor al ancho definido para el scrollingMap, se define la velocidad en que se mueve dentro del scrollingMap
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