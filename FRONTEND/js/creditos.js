//Variables de botones
var botonVolver, botonPacto, botonBuenos, botonMalos, botonPlagios;
//Descripcion del Pacto de Honor
var descripcionPacto = "Es aquel compromiso que haces contigo mismo, un pacto que firmas de corazón y con el cual aportas a nuestro objetivo de celebrar los buenos comportamientos de los miembros de la familia grancolombiana.\n\nQueremos que sepas que desde el primer día en que llegas a la Institución, nosotros asumimos el compromiso de guiarte en tu proyecto profesional y de vida y por ello, incentivamos las buenas actitudes, porque te facilitarán la toma de decisiones responsable y autónoma por el resto de tu vida.\n\nEn ese sentido, es a través de este pacto de honor que expresamos nuestro rechazo hacia las conductas anti éticas y que se alejan de los valores grancolombianos, como el respeto, la tolerancia y principalmente la HONESTIDAD. Por eso, como estudiante del Politécnico Grancolombiano me comprometo con mi proceso de aprendizaje, adopto una conducta honesta e integra en todas mis actuaciones y te invito a que hagas parte de esta gran familia y el futuro que nos espera."
//Descripciones de los personajes buenos
var descripcionesBuenos = ["Ana Pantera\n\nAna tiene buenos amigos y un gran grupo social, los sigue a todos lados y los apoya sin dudar. Pero si algo no le parece o ve que la puede afectar, no se toma ni un segundo para pensar, sus buenos principios los defiende y no los va a negociar",
                           "Andrés Gallo\n\nQue siempre Madruga, que nunca llega tarde, son algunas teorias sobre el puntual Andrés. Debo decirles que están en lo correcto, desde el primer dia que sus estudios iniciaron, se puso a él mismo un gran reto: la puntualidad y asistencia lo caracterizarían en todo momento",
                     "Cata Cierva\n\nSiempre una cara tierna y una sonrisa despierta, para Cata la amabilidad es su mejor receta, por eso saludar y dar las gracias, son pasos básicos, que para ella, ayudan a tratar bien a la gente",
                     "Daniela Jirafa\n\nSu estatura no es lo único que vamos a observar, lo verdaderamente importante es lo alto que quiere llegar. Sus metas y sus sueños muy lejos la van a llevar, pues lo que busca cada día es mirar siempre más allá",
                     "Daniel León\n\nMejor amigo de Pedro Ratón, parece que no tienen nada que ver, ni en tamaño ni en color hay alguna comparación, pero existe algo que los hace tener conexión: una amistad incondicional que desde primer semestre se creó y nos demuestra que para ser amigos no hay ninguna limitación",
                     "Fabián Canario\n\nFabián es un pequeñín sin igual, sus buenos modales no son cuestión del azar. Una excelente educación en la universidad y el hogar, crearon reglas básicas que lo hacen resaltar: un saludo, un por favor y dar las gracias nunca están de más",
                     "Iván Ruiseñor\n\nIván tiene buena presencia y bastante galantería, pero tiene claro que eso no le da derecho a la grosería, por eso, como le enseñó su mamá, trata a sus amigas con respeto y caballerosidad, logrando que de su melodiosa voz, jamás salgan sandeces ni palabras soeces",
                     "Pedro Ratón\n\nMejor amigo de Daniel León, parece que no tienen nada que ver, ni en tamaño ni en color hay alguna comparación, pero existe algo que los hace tener conexión: una amistad incondicional que desde primer semestre se creó y nos demuestra que para ser amigos no hay ninguna limitación",
                     "Tati Hormiga\n\nQue su tamaño no los confunda, Tati es una gran líder sin lugar a duda. A grandes y pequeños ella trata por igual, formando grupos en sus asignaturas es organizada y muy social, distribuye el trabajo y dirige de forma muy natural"];
//Descripciones de los personajes malos
var descripcionesMalos = ["Ana y Sara Abejas\n\nSon realmente hermosas, les encanta salir a reunirse con sus amigos a compartir, participan poco en clase y sus prioridades siempre son las fiestas y sus amigos que el estudio. Son bastante reconocidas por ser descubiertas realizando fraude en un examen",
                          "Fabián Babuino\n\n Es una persona temperamental, de malgenio, sociable únicamente con su grupo de amigos, conflictiva para ganar territorio y reconocimiento. Su habilidad se caracteriza por su gran fuerza al momento de atacar y excelente defensa.",
                          "Carlos Buitre\n\nEs una persona perspicaz, aparenta una vida correcta y realizada, pero en el fondo existe una persona engañosa y estafadora. Su habilidad principal es falsificar documentos para escabullirse de cualquier evento que pueda afectar su imagen y sobre todo sus planes. Utiliza razones falsas para derrotar a sus oponentes.",
                          "Julián Burro\n\nUna persona de estrato medio, que intenta obtener logros para su beneficio a costa de los demás. Es conocido por contratar terceros para hacer sus trabajos y parciales estudiantiles, avances laborales y proyectos. Su habilidad es conseguir equipamiento sin necesidad de gemas ni códigos.",
                          "Juan Camaleón\n\nEs una persona comprometida con sus deberes, reflejando buenos valores y poco conflictivo. Sin embargo, depende de la opinión de los demás para tomar alguna decisión laboral, estudiantil o sentimental.",
                          "Víctor Hiena\n\nEs una persona tranquila, fría, viste muy bien, sin preocupaciones, pero NO es totalmente feliz ya que habla mal de las demás personas. Su habilidad especial se manifiesta al hablar generando un veneno mortal para los oponentes de cualquier clase, por lo tanto, no socializa con nadie, sin embargo, por intuición cree que puede observar las personas.",
                          "Nicolás Lagarto\n\nEs una persona alegre, perezoso, y deportista. Bastante competitivo y cuenta con unas orejas pequeñas que permiten escuchar a más distancia de lo habitual.",
                          "Felipe Oso\n\nEs una persona que viste muy formal, pero no debes confiar en su apariencia. Es conocido por no sonreír, por su indisposición ante las situaciones y especialista en copiar movimientos, poderes y gestos. Intuitivamente puede obtener los poderes de sus compañeros o enemigos para su beneficio propio.",
                          "Camilo Perezoso\n\nCasual, al mantener una de sus manos en el bolsillo, indica la falta de compromiso con el estudio y sobre todo el poco interés para tomar decisiones en cualquier ámbito de su vida. Sus ojos bien abiertos, pero con mente distraída y síntomas de cansancio por falta de sueño, debido a sus frecuentes salidas nocturnas. Aparece al final de la batalla con un poderoso ataque.",
                          "Juan Rata\n\nEs una persona que vive en un mundo fraudulento. Se provee de artículos importantes realizar distribuciones a cambio de dinero. Su habilidad principal es quitar parte del equipamiento del oponente únicamente al tocarlo.",
                          "Luis Víbora\n\nEs una persona naturalmente solitaria, aprovecha su tiempo al máximo para realizar descargas frecuentes de Internet y romper los derechos de autor Copyright para su beneficio monetario.",
                          "Andrés Zorro\n\nEs una persona joven, compañerita y de muy buen ambiente. Sin embargo, se ha visto preocupado e inestable emocionalmente por la serie de evidencias que lo involucran en colarse en sistemas de transporte universitario. Su habilidad tiene como finalidad saltar turnos de batalla para su beneficio."];
//Descripciones de los Tipos de Plagio
var descripcionesPlagios = ["Clonación\tPresentar como creación propia el trabajo idéntico de alguien más.\t9.5\n",
                            "Copiado y Pegado\t\tContiene una porción significante de texto sin alteración y procedente de una misma fuente.\t\tFrecuencia: 8.9\n\n",
                            "Búsqueda y Reemplazo\t\tCambiar palabras y frases clave, pero conservando la esencial del trabajo original.\t\tFrecuencia: 3.9",
                            "Resumir\t\tRealizar paráfrasis de diversos textos.\t\tFrecuencia: 5.6",
                            "Reciclar\t\tApropiarse del trabajo de un autor, al no citar el texto.\t\tFrecuencia: 5.5",
                            "Hibrido\t\tCombinar citas realizadas correctamente y texto copiado sin cita.\t\tFrecuencia: 0.5",
                            "Mezclar\t\tCopiar material de diversas fuentes.\t\tFrecuencia: 9.1",
                            "Error\t\tLas citas se realizan de manera inadecuada, al presenta información inexacta de las fuentes.\t\tFrecuencia: 0.6",
                            "Agregar\t\tSe cita como propio el trabajo a pesar de contar con la mayoría de información no original.\t\tFrecuencia: 2.8",
                            "Reutilización\t\tSe cita como propio el trabajo, pero la redacción se basa en otro texto.\t\tFrecuencia: 4.4"]
//Variables de los textos y el logo
var logoPacto, textoPacto, textoBuenos, textoMalos, textoTipos, textoPlagios;


var creditos = function(game){};
    creditos.prototype = {
        preload: function(){
            game.scale.pageAlignHorizontally = true;
            game.scale.pageAlignVertically = true;
            //Carga de imagenes
            game.load.image('logoPacto', 'images/logoPacto.png');            
            //Carga de botones principales
            game.load.spritesheet('botonPacto', 'assets/botonPacto.png', 192, 71);
            game.load.spritesheet('botonBuenos', 'assets/botonBuenos.png', 192, 71);
            game.load.spritesheet('botonMalos', 'assets/botonMalos.png', 192, 71);
            game.load.spritesheet('botonPlagios', 'assets/botonPlagios.png', 192, 71);
            game.load.spritesheet('botonVolver', 'assets/botonVolver.png', 62, 62);  
            //Carga de botones de personajes buenos
            game.load.spritesheet('anaPantera', 'images/botonPantera.png', 125, 125);
            game.load.spritesheet('andresGallo', 'images/botonGallo.png', 125, 125);
            game.load.spritesheet('cataCierva', 'images/botonCierva.png', 125, 125);
            game.load.spritesheet('danielaJirafa', 'images/botonJirafa.png', 125, 125);
            game.load.spritesheet('danielLeon', 'images/botonLeon.png', 125, 125);
            game.load.spritesheet('fabianCanario', 'images/botonCanario.png', 125, 125);
            game.load.spritesheet('ivanRuisenor', 'images/botonRuisenor.png', 125, 125);
            game.load.spritesheet('pedroRaton', 'images/botonRaton.png', 125, 125);
            game.load.spritesheet('tatiHormiga', 'images/botonHormiga.png', 125, 125);
            //Carga de botones de personajes malos
            game.load.spritesheet('anaSaraAbejas', 'images/botonAbejas.png', 75, 75);
            game.load.spritesheet('fabianBabuino', 'images/botonBabuino.png', 75, 75);
            game.load.spritesheet('carlosBuitre', 'images/botonBuitre.png', 75, 75);
            game.load.spritesheet('julianBurro', 'images/botonBurro.png', 75, 75);
            game.load.spritesheet('juanCamaleon', 'images/botonCamaleon.png', 75, 75);
            game.load.spritesheet('victorHiena', 'images/botonHiena.png', 75, 75);
            game.load.spritesheet('nicolasLagarto', 'images/botonLagarto.png', 75, 75);
            game.load.spritesheet('felipeOso', 'images/botonOso.png', 75, 75);
            game.load.spritesheet('camiloPerezoso', 'images/botonPerezoso.png', 75, 75);
            game.load.spritesheet('juanRata', 'images/botonRata.png', 75, 75);
            game.load.spritesheet('luisVibora', 'images/botonVibora.png', 75, 75);
            game.load.spritesheet('andresZorro', 'images/botonZorro.png', 75, 75);
            //Carga de botones de Tipos de Plagio

           
        },
        
        create: function(){
            game.stage.backgroundColor = "#0060b2";
            game.add.text(game.width / 2, 50, "Créditos", {font: "30px Roboto", fill: "#ffffff"}).anchor.set(0.5);
            
            //Se agregan los botones principales
            botonVolver = game.add.button(5, 5, 'botonVolver', this.volver, 1, 1, 0, 2);
            botonPacto = game.add.button(5, 100, 'botonPacto', this.verPacto, 1, 1, 0, 2);
            botonBuenos = game.add.button(205, 100, 'botonBuenos', this.verPersonajesBuenos, 1, 1, 0, 2);
            botonMalos = game.add.button(400, 100, 'botonMalos', this.verPersonajesMalos, 1, 1, 0, 2);
            botonPlagios = game.add.button(600, 100, 'botonPlagios', this.verPlagios, 1, 1, 0, 2);
            
            //Se crean los botones de los personajes buenos        
            botonPantera = game.add.button (10, 200, 'anaPantera', this.panteraClick, 1, 1, 0, 2);
            botonGallo = game.add.button (140, 200, 'andresGallo', this.galloClick, 1, 1, 0, 2);
            botonCierva = game.add.button (270, 200, 'cataCierva', this.ciervaClick, 1, 1, 0, 2);
            botonJirafa = game.add.button (10, 330, 'danielaJirafa', this.jirafaClick, 1, 1, 0, 2);
            botonLeon = game.add.button (140, 330, 'danielLeon', this.leonClick, 1, 1, 0, 2);
            botonCanario = game.add.button (270, 330, 'fabianCanario', this.canarioClick, 1, 1, 0, 2);
            botonRuisenor = game.add.button (10, 460, 'ivanRuisenor', this.ruisenorClick, 1, 1, 0, 2);
            botonRaton = game.add.button (140, 460, 'pedroRaton', this.ratonClick, 1, 1, 0, 2);
            botonHormiga = game.add.button (270, 460, 'tatiHormiga', this.hormigaClick, 1, 1, 0, 2);
            
            //Se crean los botones de los personajes malos
            botonAbejas = game.add.button (20, 200, 'anaSaraAbejas', this.abejasClick, 1, 1, 0, 2);
            botonBabuino = game.add.button (120, 200, 'fabianBabuino', this.babuinoClick, 1, 1, 0, 2);
            botonBuitre = game.add.button (220, 200, 'carlosBuitre', this.buitreClick, 1, 1, 0, 2);
            botonBurro = game.add.button (20, 300, 'julianBurro', this.burroClick, 1, 1, 0, 2);
            botonCamaleon = game.add.button (120, 300, 'juanCamaleon', this.camaleonClick, 1, 1, 0, 2);
            botonHiena = game.add.button (220, 300, 'victorHiena', this.hienaClick, 1, 1, 0, 2);
            botonLagarto = game.add.button (20, 400, 'nicolasLagarto', this.lagartoClick, 1, 1, 0, 2);
            botonOso = game.add.button (120, 400, 'felipeOso', this.osoClick, 1, 1, 0, 2);
            botonPerezoso = game.add.button (220, 400, 'camiloPerezoso', this.perezosoClick, 1, 1, 0, 2);
            botonRata = game.add.button (20, 500, 'juanRata', this.rataClick, 1, 1, 0, 2);
            botonVibora = game.add.button (120, 500, 'luisVibora', this.viboraClick, 1, 1, 0, 2);
            botonZorro = game.add.button (220, 500, 'andresZorro', this.zorroClick, 1, 1, 0, 2);
            
            //Se ocultan los botones de los personajes buenos
            botonPantera.visible = false;
            botonGallo.visible = false;
            botonCierva.visible = false;
            botonJirafa.visible = false;
            botonLeon.visible = false;
            botonCanario.visible = false;
            botonRuisenor.visible = false;
            botonRaton.visible = false;
            botonHormiga.visible = false;
            
            //Se ocultan los botones de los personajes malos
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
            
            //Se crea el texto de la descripción del Pacto y se oculta    
            textoPacto = game.add.text(50, 190, descripcionPacto, {font: "12px Roboto", fill: "#ffffff", align: "left", boundsAlignH: "left", boundsAlignV: "top", wordWrap: true, wordWrapWidth: 350});                    
            textoPacto.visible = false;
            
            //Se crean los textos de las descripciones de los tipos de plagio
            textoTipos = game.add.text(20, 200, "TIPO\tDESCRIPCIÓN\tFRECUENCIA (1-10)", {font: "18px Roboto", fill: "#ffffff", fontWeight: 'bold', tabs: 300});
            textoPlagios = game.add.text(10, 270, descripcionesPlagios, {font: "12px Roboto", fill: "#ffffff", tabs: 132, align: "left", boundsAlignH: "left", boundsAlignV: "top", wordWrap: true, wordWrapWidth: 800});    
            textoTipos.visible = false;
            textoPlagios.visible = false;
            
            //Se crean dos textos vacíos para las descripciones de los personajes buenos y malos
            textoBuenos = game.add.text(450, 230, "", {font: "18px Roboto", fill: "#ffffff", align: "left", boundsAlignH: "left", boundsAlignV:       "top", wordWrap: true, wordWrapWidth: 300});
            textoMalos = game.add.text(450, 230, "", {font: "18px Roboto", fill: "#ffffff", align: "left", boundsAlignH: "left", boundsAlignV:       "top", wordWrap: true, wordWrapWidth: 300});
            
            //Se crea el logo del Pacto y se oculta
            logoPacto = game.add.image(500, 300, 'logoPacto');
            logoPacto.visible = false;
        },      
        
        /*Funciones que se llaman al oprimir el boton de cada personaje
        Dentro de estas funciones se sobreescribe la variable de texto de las descripciones de los personajes segun corresponde*/
        panteraClick: function(){
            textoBuenos.setText(descripcionesBuenos[0]);
        },        
        galloClick: function(){
            textoBuenos.setText(descripcionesBuenos[1]);           
        },
        ciervaClick: function(){
            textoBuenos.setText(descripcionesBuenos[2]);           
        },
        jirafaClick: function(){
            textoBuenos.setText(descripcionesBuenos[3]);           
        },
        leonClick: function(){
            textoBuenos.setText(descripcionesBuenos[4]);           
        },
        canarioClick: function(){
            textoBuenos.setText(descripcionesBuenos[5]);           
        },
        ruisenorClick: function(){
            textoBuenos.setText(descripcionesBuenos[6]);           
        },
        ratonClick: function(){
            textoBuenos.setText(descripcionesBuenos[7]);           
        },
        hormigaClick: function(){
            textoBuenos.setText(descripcionesBuenos[8]);           
        },
        abejasClick: function(){
            textoMalos.setText(descripcionesMalos[0]);           
        },
        babuinoClick: function(){
            textoMalos.setText(descripcionesMalos[1]);           
        },
        buitreClick: function(){
            textoMalos.setText(descripcionesMalos[2]);           
        },
        burroClick: function(){
            textoMalos.setText(descripcionesMalos[3]);           
        },
        camaleonClick: function(){
            textoMalos.setText(descripcionesMalos[4]);           
        },
        hienaClick: function(){
            textoMalos.setText(descripcionesMalos[5]);           
        },
        lagartoClick: function(){
            textoMalos.setText(descripcionesMalos[6]);           
        },
        osoClick: function(){
            textoMalos.setText(descripcionesMalos[7]);           
        },
        perezosoClick: function(){
            textoMalos.setText(descripcionesMalos[8]);           
        },
        rataClick: function(){
            textoMalos.setText(descripcionesMalos[9]);           
        },
        viboraClick: function(){
            textoMalos.setText(descripcionesMalos[10]);           
        },
        zorroClick: function(){
            textoMalos.setText(descripcionesMalos[11]);           
        },
        
        //Dentro de las siguientes funciones se ponen visibles o no visibles los elementos de la pantalla según corresponda
        
        //Funcion que se llama al oprimir el boton '¿Qué es el Pacto de Honor?'
        verPacto: function(){
            botonPantera.visible = false;
            botonGallo.visible = false;
            botonCierva.visible = false;
            botonJirafa.visible = false;
            botonLeon.visible = false;
            botonCanario.visible = false;
            botonRuisenor.visible = false;
            botonRaton.visible = false;
            botonHormiga.visible = false;
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
            textoBuenos.visible = false;
            textoMalos.visible = false;
            textoPlagios.visible=false;
            textoTipos.visible = false;
            
            textoPacto.visible = true;
            logoPacto.visible = true;          
        },
        
        //Funcion que se llama al oprimir el boton 'Personajes Buenos'
        verPersonajesBuenos: function(){
            textoBuenos.setText("");
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
            textoPacto.visible = false;
            logoPacto.visible = false;
            textoMalos.visible = false;
            textoPlagios.visible=false;
            textoTipos.visible = false;
            
            botonPantera.visible = true;
            botonGallo.visible = true;
            botonCierva.visible = true;
            botonJirafa.visible = true;
            botonLeon.visible = true;
            botonCanario.visible = true;
            botonRuisenor.visible = true;
            botonRaton.visible = true;
            botonHormiga.visible = true;
            textoBuenos.visible = true;
        },
        
        //Funcion que se llama al oprimir el boton 'Personajes Malos'
        verPersonajesMalos: function(){
            textoMalos.setText("");
            botonPantera.visible = false;
            botonGallo.visible = false;
            botonCierva.visible = false;
            botonJirafa.visible = false;
            botonLeon.visible = false;
            botonCanario.visible = false;
            botonRuisenor.visible = false;
            botonRaton.visible = false;
            botonHormiga.visible = false;
            textoPacto.visible = false;
            logoPacto.visible = false;
            textoBuenos.visible = false;
            textoPlagios.visible=false;
            textoTipos.visible = false;
            
            textoMalos.visible = true;
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
            botonPantera.visible = false;
            botonGallo.visible = false;
            botonCierva.visible = false;
            botonJirafa.visible = false;
            botonLeon.visible = false;
            botonCanario.visible = false;
            botonRuisenor.visible = false;
            botonRaton.visible = false;
            botonHormiga.visible = false;
            textoPacto.visible = false;
            logoPacto.visible = false;
            textoBuenos.visible = false;
            textoMalos.visible = false;
            
            textoPlagios.visible = true;
            textoTipos.visible = true;
        },
        
        //Funcion que se llama al oprimir el botón de regreso
        volver: function(){
            game.state.start("navegacion");
        },        
        update:function(){
            
        }            
    }