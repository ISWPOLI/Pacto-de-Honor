var speedMult = 0.2;
var friction = 0.99;
var characters = ["pantera","gallo","cierva","girafa","leon","canario","ruisenor","raton","hormiga"];
var namesCharacters = ["Ana Pantera", "Andres Gallo", "Cata Cierva", "Daniela Girafa", "Daniel León", "Fabian Canario", "Iván Ruiseñor", "Pedro Raton", "Tati Hormiga"];
var description;
var apodo;
var music;
var musicButton;
var startButton;
var descriptions = ["Ana tiene buenos amigos y un gran\ngrupo social, los sigue a todos\nlados y los apoya sin dudar. Pero si\nalgo no le parece o ve que la puede\nafectar, no se toma ni un segundo\npara pensar, sus buenos principios\nlos defiende y no los va a negociar",
                     "Que siempre Madruga, que nunca\nllega tarde, son algunas teorias sobre\nel puntual Andrés. Debo decirles que\nestán en lo correcto, desde el primer\ndia que sus estudios iniciaron, se\npuso a él mismo un gran reto: la\npuntualidad y asistencia lo\ncaracterizarían en todo momento",
                     "Siempre una cara tierna y una\nsonrisa despierta, para Cata la\namabilidad es su mejor receta, por\neso saludar y dar las gracias, son\npasos básicos, que para ella,\nayudan a tratar bien a la gente",
                     "Su estatura no es lo único que vamos\na observar, lo verdaderamente\nimportante es lo alto que quiere\nllegar. Sus metas y sus sueños muy\nlejos la van a llevar, pues lo que busca\ncada día es mirar siempre más allá",
                     "Pedro y Daniel parece que no\ntienen nada que ver, ni en\ntamaño ni en color hay alguna\ncomparación, pero existe algo\nque los hace tener conexión: una\namistad incondicional que desde\nprimer semestre se creó y nos\ndemuestra que para ser amigos\nno hay ninguna limitación",
                     "Fabián es un pequeñín sin igual, sus\nbuenos modales no son cuestión del\nazar. Una excelente educación en la\nuniversidad y el hogar, crearon reglas\nbásicas que lo hacen resaltar: un\nsaludo, un por favor y dar las gracias\nnunca están de más",
                     "Iván tiene buena presencia y\nbastante galantería, pero tiene\nclaro que eso no le da derecho a la\ngrosería, por eso, como le enseñó\nsu mamá, trata a sus amigas con\nrespeto y caballerosidad, logrando\nque de su melodiosa voz, jamás\nsalgan sandeces ni palabras soeces",
                     "Pedro y Daniel parece que no\ntienen nada que ver, ni en\ntamaño ni en color hay alguna\ncomparación, pero existe algo\nque los hace tener conexión: una\namistad incondicional que desde\nprimer semestre se creó y nos\ndemuestra que para ser amigos\nno hay ninguna limitación",
                     "Que su tamaño no los confunda,\nTati es una gran líder sin lugar a\nduda. A grandes y pequeños ella\ntrata por igual, formando grupos\nen sus asignaturas es organizada y\nmuy social, distribuye el trabajo\ny dirige de forma muy natural"];

var seleccionavatar = function(game){};
seleccionavatar.prototype = {
     preload: function(){
          game.scale.pageAlignHorizontally = true;
          game.scale.pageAlignVertically = true;

          game.load.image("transp", "../img/Componentes/selecccion avartar/transp.png");
          game.load.image('pantera', '../img/Componentes/selecccion avartar/AnaPantera.png');
          game.load.image('gallo', '../img/Componentes/selecccion avartar/AndresGallo.png');
          game.load.image('cierva', '../img/Componentes/selecccion avartar/CataCierva.png');
          game.load.image('girafa', '../img/Componentes/selecccion avartar/DanielaGirafa.png');
          game.load.image('leon', '../img/Componentes/selecccion avartar/DanielLeon.png');
          game.load.image('canario', '../img/Componentes/selecccion avartar/FabianCanario.png');
          game.load.image('ruisenor', '../img/Componentes/selecccion avartar/IvanRuisenor.png');
          game.load.image('raton', '../img/Componentes/selecccion avartar/PedroRaton.png');
          game.load.image('hormiga', '../img/Componentes/selecccion avartar/TatiHormiga.png');
          game.load.spritesheet('button', '../img/Componentes/selecccion avartar/SpriteButton.png', 150, 40);
         game.load.audio('sonidos','../img/Componentes/sonidos/seleccionAvatar.mp3');     
          game.load.audio('sonidoBoton', '../img/Componentes/sonidos/Botones/1.mp3');
     },
     create: function(){  
          game.stage.backgroundColor = "#2451A6"; 
          game.add.text(game.width / 2, 50, "Selección de avatar", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);
          this.scrollingMap = game.add.tileSprite(0, 0, 650 + characters.length * 90 + 64, game.height, "transp");
          this.scrollingMap.inputEnabled = true;
          this.scrollingMap.input.enableDrag(false);
          this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          this.scrollingMap.isBeingDragged = false; 
          this.scrollingMap.movingSpeed = 0; 
          this.scrollingMap.input.allowVerticalDrag = false;
          this.scrollingMap.input.boundsRect = new Phaser.Rectangle(game.width - this.scrollingMap.width, game.height - this.scrollingMap.height, this.scrollingMap.width * 2 - game.width, this.scrollingMap.height * 2 - game.height);
          
          for(var i = 0; i < characters.length; i++){
               fish = game.add.image(game.width / 2 + i * 90, 130, characters[i]);
               fish.anchor.set(0.5);
               this.scrollingMap.addChild(fish);
          }

          this.scrollingMap.events.onDragStart.add(function(){
               this.scrollingMap.isBeingDragged = true;
               this.scrollingMap.movingSpeed = 0;
          }, this);
          this.scrollingMap.events.onDragStop.add(function(){
               this.scrollingMap.isBeingDragged = false;
          }, this);

          apodo = game.add.text(game.world.centerX, 230, "", { font: "24px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          apodo.anchor.set(0.5);
          description = game.add.text(game.world.centerX, 380, "", { font: "20px Roboto", fill: "#ffffff", align: "center", backgroundColor: "#2451A6"});
          description.anchor.set(0.5);
          startButton = game.add.button(game.world.width / 2, 540, 'button', this.verH, this, 2, 1, 0); // over, out, down, up
          startButton.anchor.set(0.5);
         musicButton = game.add.audio('sonidoBoton');
         music = game.add.audio('sonidos'); 
         music.loop=true;
         music.play();
    },
    verH:function(){
         this.state.start("historieta");
         musicButton.play(); 
        music.pause();
    },
    update:function(){
          var zoomed = false;
          for(var i = 0; i < this.scrollingMap.children.length; i++){
               if(Math.abs(this.scrollingMap.children[i].world.x - game.width / 2) < 46 && !zoomed){
                    this.scrollingMap.getChildAt(i).scale.setTo(1.5);
                    zoomed = true;
                    for (var j = 0; j < descriptions.length; j++) {
                         if(i == j){
                              apodo.setText(namesCharacters[j]);
                              description.setText(descriptions[j]);
                         }
                    }

               }
               else{
                    this.scrollingMap.getChildAt(i).scale.setTo(1);   
               }
          }
          if(this.scrollingMap.isBeingDragged){
               this.scrollingMap.savedPosition = new Phaser.Point(this.scrollingMap.x, this.scrollingMap.y);
          }
          else{
               if(this.scrollingMap.movingSpeed > 1){
                    this.scrollingMap.x += this.scrollingMap.movingSpeed * Math.cos(this.scrollingMap.movingangle);
                    if(this.scrollingMap.x < game.width - this.scrollingMap.width){
                         this.scrollingMap.x = game.width - this.scrollingMap.width;
                         this.scrollingMap.movingSpeed *= 0.5;
                         this.scrollingMap.movingangle += Math.PI;
                         
                    }
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