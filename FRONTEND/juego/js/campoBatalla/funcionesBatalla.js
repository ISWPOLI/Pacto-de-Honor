          
var funcionesBatalla={
    //funcion que se encarga de cargar todos los elementos del campo de batalla
    cargar:function(idPJ, idPC, caa, idNivel){
        game.load.image('fondo', niveles[idNivel].fondo);
		game.load.spritesheet('personajeJugador', personajesBuenos[idPJ].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeJugador', personajesBuenos[idPJ].rutaAvatar);
		game.load.spritesheet('personajeComputadora', personajesMalos[idPC].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeComputadora', personajesMalos[idPC].rutaAvatar);
		game.load.image('pausa', '../img/componentes/botones/pausa.png');
		game.load.image('menup', '../img/componentes/botones/menup.png');
		game.load.image('ataquePersonalidadV', personajesMalos[idPC].rutaAtaque);
		game.load.spritesheet('ataquePlagio', personajesMalos[idPC].rutaAtaquePlagio, 500, 500);
		game.load.image('ataquePersonalidadB', personajesBuenos[idPJ].rutaAtaque);
		game.load.spritesheet('botonPoder', personajesBuenos[idPJ].rutaBotonPoder, 62, 62);
        game.load.spritesheet('impactoPersonalidadJugador', personajesBuenos[idPJ].rutaImpactoPersonalidad, 201, 160);
        game.load.spritesheet('impactoPersonalidadComputadora', personajesMalos[idPC].rutaImpactoPersonalidad, 161, 145);
        game.load.spritesheet('impactoPlagioComputadora', personajesMalos[idPC].rutaImpactoPlagio, 277, 277);
        game.load.spritesheet('gamepad','../img/componentes/joystick/gamepad_spritesheet.png',100,100);
        game.load.spritesheet('botonEscudo', '../img/componentes/joystick/gamepad_spritesheet.png', 100, 100);
        game.load.image('caja', boxes[caa].root);
        game.load.audio('punoalaire', '../img/componentes/sonidos/efectosDePelea/sonidogolpealaire.mp3');
        game.load.audio('punoalcuerpo', '../img/componentes/sonidos/efectosDePelea/sonidogolpealcuerpo.mp3');
        game.load.image('escudo1', '../img/componentes/batalla/escudo1.png');
        game.load.image('escudo2', '../img/componentes/batalla/escudo2.png');
        game.load.image('flechaIzquierda','../img/componentes/batalla/izquierdapc.png');
        game.load.image('flechaDerecha','../img/componentes/batalla/derechapc.png');
        game.load.image('flechaArriba','../img/componentes/batalla/arribapc.png');
        game.load.image('flechaAbajo','../img/componentes/batalla/abajopc.png');
        game.load.image('teclam','../img/componentes/batalla/teclam.png');
        game.load.image('teclan','../img/componentes/batalla/teclan.png');
        game.load.image('espacio','../img/componentes/batalla/space.png');
        game.load.image('abajom','../img/componentes/batalla/abajo.png');
        game.load.image('arribam','../img/componentes/batalla/arriba.png');
        game.load.image('izquierdam','../img/componentes/batalla/izquierda.png');
        game.load.image('derecham','../img/componentes/batalla/derecha.png');
        game.load.image('pulsem','../img/componentes/batalla/pulse.png');
        if (caa == 8) {
             game.load.image('cajaOpen', boxes[caa].fatalityBox);
         }else{
             game.load.image('cajaOpen', boxes[caa].rootOpen);
         }
    },
    
    //inicializa todos los estados de los sprites de los personajes 
	iniciarSprite:function(sprite){
		sprite.animations.add('quieto', [1], 10, true);
    	sprite.animations.add('correr', [6, 7, 8, 9, 11, 12, 13, 14], 10, true);
        variablesCampoBatalla.animP=sprite.animations.add('punos', [16, 17, 18, 19], 9, true);
        variablesCampoBatalla.animP.onLoop.add(this.cicloPunos,this);
        variablesCampoBatalla.animP.onComplete.add(this.finPunos,this);
    	sprite.animations.add('defensa', [21], 10, true);
        variablesCampoBatalla.animE=sprite.animations.add('especial', [23, 24], 10, true);
        variablesCampoBatalla.animE.onLoop.add(this.cicloPunos,this);
        variablesCampoBatalla.animE.onComplete.add(this.finPunos,this);
    	sprite.animations.play('quieto');
		game.physics.arcade.enable(sprite);
		sprite.body.collideWorldBounds = true; 
        sprite.body.gravity.y=300;
        variablesCampoBatalla.golpeAlAire = game.add.audio('punoalaire');
        variablesCampoBatalla.golpe_al_cuerpo = game.add.audio('punoalcuerpo');
        
	},

    finEspecial:function(sprite,animation){
       animation.loop=true;
       sprite.frame = 1;
    },
    //mejora la visualizacion del golpe
    cicloEspecial:function(sprite,animation){
        if(animation.loopCount>3){
            animation.loop=false;
        }
    },
    finPunos:function(sprite,animation){
       animation.loop=true;
       sprite.frame = 1;
    },
    //mejora la visualizacion del golpe
    cicloPunos:function(sprite,animation){
        if(animation.loopCount>2)
            animation.loop=false;
        },
    //Esta funcion se activa al dar click en el logo del poli y despliega el menu de pausa 
	pausar:function(){
		game.paused=true;
		lal=game.add.image(270,170,'menup');
		lal.scale.setTo(1.5);
	},
    //Es la funcion que ese encarga de controlar el menu de pausa 
	unpause:function (event){
            // Only act if paused
        if(game.paused){
                //Condicional si se oprime en Continuar
            if(event.x > 380 && event.x < 475 && event.y > 255 && event.y < 280){
                lal.destroy();
                game.paused = false;
            }
                //Condicional si se oprime en Reiniciar
            else if(event.x > 380 && event.x < 475 && event.y > 300 && event.y < 330) {
                game.paused = false;
                game.state.start(game.state.current);
                counter = 0;
            }
            //Condicional si se oprime en Salir
            else if (event.x > 390 && event.x < 465 && event.y > 350 && event.y < 380) {
                game.paused = false;
                game.state.start("navegacion");
            }
            //Condicional si se oprime en Sonido
            else if (event.x > 410 && event.x < 450 && event.y > 390 && event.y < 425) {
                if(!variablesBoot.musicaOnOff){variablesBoot.musicaOnOff = true; variablesBoot.musicaBatalla.resume();}
                else{variablesBoot.musicaOnOff = false; variablesBoot.musicaBatalla.pause();}
            }
        }
    },
    tutorial:function(){
         texto1 = game.add.text(450,270,"Presione las teclas \n                y \n \npara moverse por el \n  campo de batalla ");
        vida = game.add.text(255,40,"vida",{fill:"red"});
        energia = game.add.text(210,100,"energia",{fill:"green"});
         texto1.stroke = "white";
            texto1.strokeThickness = 4;
            texto1.stroke = "white";
            texto1.anchor.setTo(0.5);
            vida.strokeThickness = 4;
            vida.stroke = "white";
            energia.strokeThickness = 4;
            energia.stroke = "white";
            izquierda = game.add.sprite(330,210,'flechaIzquierda');
            izquierda.scale.setTo(0.4);
            derecha = game.add.sprite(470,210,'flechaDerecha');
            derecha.scale.setTo(0.4);
       
    },
    tutorial2:function(){
         texto2 = game.add.text(450,270,"Utilice la tecla \n \n \n  para saltar ");
         texto2.stroke = "white";
            texto2.strokeThickness = 4;
            texto2.stroke = "white";
            texto2.strokeThickness = 4;
            texto2.anchor.setTo(0.5);
            arriba = game.add.sprite(400,230,'flechaArriba');
            arriba.scale.setTo(0.4);
    },
      tutorial3:function(){
         texto3 = game.add.text(450,270,"  Con la tecla \n \n \npodra usar uno\nde sus escudos ");
         texto3.stroke = "white";
            texto3.strokeThickness = 4;
            texto3.stroke = "white";
            texto3.strokeThickness = 4;
            texto3.anchor.setTo(0.5);
            abajo = game.add.sprite(400,210,'flechaAbajo');
            abajo.scale.setTo(0.4);
    },
    tutorial4:function(){
         texto4 = game.add.text(450,270,"Si presiona la tecla \n \nusted activará otro escudo");
         texto4.stroke = "white";
            texto4.strokeThickness = 4;
            texto4.stroke = "white";
            texto4.strokeThickness = 4;
            texto4.anchor.setTo(0.5);
            m = game.add.sprite(370,240,'teclam');
            m.scale.setTo(1.8);
    },
       tutorial5:function(){
         texto5 = game.add.text(450,270,"Si presiona la tecla \n \nusted podrá golpear a su rival");
         texto5.stroke = "white";
            texto5.strokeThickness = 4;
            texto5.stroke = "white";
            texto5.strokeThickness = 4;
            texto5.anchor.setTo(0.5);
            espacio = game.add.sprite(300,240,'espacio');
            espacio.scale.setTo(0.1);
    },   tutorial6:function(){
         texto6 = game.add.text(450,270,"Finalmente si presiona la tecla \n \n  o pulsando el boton azul, \n  usted podra usar el poder especial");
         texto6.stroke = "white";
        btnpoder = game.add.text (150,150,"boton de poder",{fill:"blue"});
            texto6.strokeThickness = 4;
            texto6.stroke = "white";
            btnpoder.strokeThickness = 4;
            btnpoder.stroke = "white";
            texto6.anchor.setTo(0.5);
            n = game.add.sprite(370,230,'teclan');
            n.scale.setTo(1.8);
    },
    tutorialM:function(){
         texto1 = game.add.text(450,270,"Deslice su dedo hacia los lados\npara moverse en el campo",{font:"40px roboto"});
        vida = game.add.text(260,30,"vida",{fill:"red",font:"40px roboto"});
        energia = game.add.text(210,100,"energia",{fill:"green",font:"40px roboto"});
         texto1.stroke = "white";
            texto1.strokeThickness = 4;
            texto1.stroke = "white";
            texto1.anchor.setTo(0.5);
            vida.strokeThickness = 4;
            vida.stroke = "white";
            energia.strokeThickness = 4;
            energia.stroke = "white";
            derecha = game.add.sprite(45,460,'derecham');
            derecha.scale.setTo(0.3);
            izquierda = game.add.sprite(22,460,'izquierdam');
            izquierda.scale.setTo(0.3);
       
    },
    tutorial2M:function(){
         texto2 = game.add.text(450,270,"Deslice su dedo hacia arriba \n               para saltar",{font:"40px roboto"});
         texto2.stroke = "white";
            texto2.strokeThickness = 4;
            texto2.stroke = "white";
            texto2.strokeThickness = 4;
            texto2.anchor.setTo(0.5);
            arriba = game.add.sprite(10,430,'arribam');
            arriba.scale.setTo(0.4);
    },
      tutorial3M:function(){
         texto3 = game.add.text(450,270,"   Deslice su dedo hacia abajo \npara usar uno de sus escudos",{font:"40px roboto"});
         texto3.stroke = "white";
            texto3.strokeThickness = 4;
            texto3.stroke = "white";
            texto3.strokeThickness = 4;
            texto3.anchor.setTo(0.5);
            abajo = game.add.sprite(10,430,'abajom');
            abajo.scale.setTo(0.4);
    },
    tutorial4M:function(){
         texto4 = game.add.text(450,270,"      Si presiona acá \nusted activará otro escudo",{font:"40px roboto"});
         texto4.stroke = "white";
            texto4.strokeThickness = 4;
            texto4.stroke = "white";
            texto4.strokeThickness = 4;
            texto4.anchor.setTo(0.5);
            m = game.add.sprite(650,265,'pulsem');
            m.scale.setTo(0.35);
    },
       tutorial5M:function(){
         texto5 = game.add.text(450,270,"       Presionando acá\nusted podrá golpear a su rival",{font:"40px roboto"});
         texto5.stroke = "white";
            texto5.strokeThickness = 4;
            texto5.stroke = "white";
            texto5.strokeThickness = 4;
            texto5.anchor.setTo(0.5);
            espacio = game.add.sprite(650,475,'pulsem');
            espacio.scale.setTo(0.35);
    },   tutorial6M:function(){
         texto6 = game.add.text(450,270,"    Finalmente si presiona acá\nusted podra usar el poder especial",{font:"40px roboto"});
         texto6.stroke = "white";
            texto6.strokeThickness = 4;
            texto6.stroke = "white";
            texto6.anchor.setTo(0.5);
            n = game.add.sprite(650,365,'pulsem');
            n.scale.setTo(0.35);
    },
    
    //con esta funcion se refelja el daño causado
    actualizarVida: function(barra,dano){
        if(barra.width-dano>0)
            barra.width=barra.width-dano;
        else{
            barra.width=0;
            this.finJuego();
        }
    },
    //esta funcion se encarga de gestionar todos los que se inicien solo con oprimir la tecla
    movimientoJugador: function(){
        if(variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("punos")==0
            &&variablesCampoBatalla.personajeJugador.animations.currentAnim.isPlaying){
                variablesCampoBatalla.movH[1]=true;
                 if(variablesCampoBatalla.cambioOrientacion)
                    variablesCampoBatalla.personajeJugador.body.x-=1;
                else
                    variablesCampoBatalla.personajeJugador.body.x+=1;
        }else{
            variablesCampoBatalla.movH[1]=false;
        }
        variablesCampoBatalla.movH[0]=false;        
        variablesCampoBatalla.movH[3]=false;
        variablesCampoBatalla.personajeJugador.body.velocity.x=0;
        if(variablesCampoBatalla.escudo1!=null)
            variablesCampoBatalla.escudo1.kill();
        if(variablesCampoBatalla.escudo2!=null)
            variablesCampoBatalla.escudo2.kill();
        game.input.keyboard.onUpCallback = function( key ){    
                if(key.keyCode == Phaser.Keyboard.UP&&(variablesCampoBatalla.personajeJugador.body.y>355)&&(game.time.now > variablesCampoBatalla.saltoJ)){
                           variablesCampoBatalla.personajeJugador.body.velocity.y-=400;
                }   
                else if (key.keyCode == Phaser.Keyboard.SPACEBAR){            
                    variablesCampoBatalla.personajeJugador.animations.play('punos');
                }
                else if (key.keyCode == Phaser.Keyboard.N){                
                    if(!variablesCampoBatalla.movH[2]&&energiaVerdeJugador.width>=variablesCampoBatalla.costoAtaqueJ){
                        energiaVerdeJugador.width=energiaVerdeJugador.width-variablesCampoBatalla.costoAtaqueJ;
                        variablesCampoBatalla.personajeJugador.animations.play('especial');
                        game.time.events.add(100,function(){
                        funcionesBatalla.activarPersonalidadJ();
                            
                            variablesCampoBatalla.movH[2]=true;
                        },this);
                    }   
                }           
        };
        if (cursores.right.isDown) {
            variablesCampoBatalla.personajeJugador.body.velocity.x+=150;
            variablesCampoBatalla.personajeJugador.animations.play('correr');
        } else if (cursores.left.isDown) {
            variablesCampoBatalla.personajeJugador.body.velocity.x+=-150;
            variablesCampoBatalla.personajeJugador.animations.play('correr');
        } else if (cursores.down.isDown) {
            if(variablesCampoBatalla.cambioOrientacion)
                 variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x, variablesCampoBatalla.personajeJugador.body.y, 'escudo1');
             else
                 variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x+200, variablesCampoBatalla.personajeJugador.body.y, 'escudo1');
            variablesCampoBatalla.escudo1.anchor.setTo(0.5,0);
            variablesCampoBatalla.personajeJugador.animations.play('defensa')
            variablesCampoBatalla.movH[0]=true;
        }else if(teclaEscudo.isDown){
             variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x, variablesCampoBatalla.personajeJugador.body.y, 'escudo2');
            variablesCampoBatalla.personajeJugador.animations.play('defensa')
            variablesCampoBatalla.movH[3]=true;

        }else{

            if(variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("correr")==0||
                variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("defensa")==0){
                variablesCampoBatalla.personajeJugador.frame = 1;
            }
            
        }
    },
   
    //Esta función se activa al oprimir el botón del poder del personaje
    clickBotonPoder: function(){
        if(variablesCampoBatalla.movH[2]){
            if(variablesCampoBatalla.ataquePersonalidadJ.body.onFloor()){
                    variablesCampoBatalla.ataquePersonalidadJ.kill();
                    variablesCampoBatalla.movH[2]=false;
                }
        }
        if(!variablesCampoBatalla.movH[2]&&energiaVerdeJugador.width>=variablesCampoBatalla.costoAtaqueJ){
                energiaVerdeJugador.width=energiaVerdeJugador.width-variablesCampoBatalla.costoAtaqueJ;
                variablesCampoBatalla.personajeJugador.animations.play('especial');
                game.time.events.add(100,function(){
                    funcionesBatalla.activarPersonalidadJ();
                    variablesCampoBatalla.movH[2]=true;
                 },this);
            }
    },
    
    //esta funcion activa el poder de la computadora y lo inicializa como una bala
    activarPersonalidadC :function(){
         if(!variablesCampoBatalla.movV[2]&&energiaVerdeComputadora.width>=variablesCampoBatalla.costoAtaqueC){
                energiaVerdeComputadora.width=energiaVerdeComputadora.width-variablesCampoBatalla.costoAtaqueC;
                variablesCampoBatalla.personajeComputadora.animations.play('especial');
                game.time.events.add(100,function(){
                    variablesCampoBatalla.ataquePersonalidadC = game.add.weapon(10, 'ataquePersonalidadV');
                    game.physics.arcade.enable(variablesCampoBatalla.ataquePersonalidadC);
                    variablesCampoBatalla.ataquePersonalidadC.trackSprite(variablesCampoBatalla.personajeComputadora, 0, 0, true);
                    variablesCampoBatalla.ataquePersonalidadC.fireAtSprite(variablesCampoBatalla.personajeJugador);
                    variablesCampoBatalla.ataquePersonalidadC.bulletCollideWorldBounds=true;
                    variablesCampoBatalla.movV[2]=true;
                 },this);
            }   
        
    },
    //esta funcion activa el poder plagio  de la computadora y lo inicializa como una bala
    activarPlagioC :function(){
         if(!variablesCampoBatalla.movV[3]&&energiaVerdeComputadora.width>=variablesCampoBatalla.costoPlagioC){
                energiaVerdeComputadora.width=energiaVerdeComputadora.width-variablesCampoBatalla.costoPlagioC;
                variablesCampoBatalla.personajeComputadora.animations.play('especial');
                game.time.events.add(100,function(){
                    variablesCampoBatalla.ataquePlagio = game.add.sprite(game.height/2,game.width/2, 'ataquePlagio');
                    game.physics.arcade.enable(variablesCampoBatalla.ataquePlagio);
                    variablesCampoBatalla.ataquePlagio.collideWorldBounds = true; 
                    variablesCampoBatalla.ataquePlagio.scale.setTo(0.8);
                    variablesCampoBatalla.ataquePlagio.anchor.setTo(0.4);
                    variablesCampoBatalla.ataquePlagio.animations.add('especial', [1, 2, 3, 4, 5, 6, 7, 8], 8, false,true);
                    variablesCampoBatalla.ataquePlagio.animations.play('especial');
                    variablesCampoBatalla.movV[3]=true;
                    variablesCampoBatalla.primerImpacto=true;
                 },this);
            }   
        
    },
    //esta funcion activa el poder del jugador
    activarPersonalidadJ :function(){
        variablesCampoBatalla.ataquePersonalidadJ=game.add.sprite(variablesCampoBatalla.personajeComputadora.body.x,0,'ataquePersonalidadB');
        game.physics.arcade.enable(variablesCampoBatalla.ataquePersonalidadJ);
        variablesCampoBatalla.ataquePersonalidadJ.body.collideWorldBounds = true; 
        variablesCampoBatalla.ataquePersonalidadJ.body.gravity.y = 300;
    },
    /*Se llama cuando la energia no esta al 100%
    */
    cargarEnergia: function(barra){
        //el 200 es temporal
        if(barra.width<200){
            barra.width=barra.width+0.9;
        }
    },
     /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoPlagioC : function(personaje,ataque){
        variablesCampoBatalla.golpe_al_cuerpo.play();
        game.time.events.add(1000,function(){ataque.kill();},this);
        variablesCampoBatalla.movV[3]=false;
        if(!variablesCampoBatalla.movH[3]&&variablesCampoBatalla.primerImpacto){
            variablesCampoBatalla.primerImpacto=false;
            funcionesBatalla.actualizarVida(vidaRojoJugador,variablesCampoBatalla.danoV[2]);
            funcionesBatalla.spriteImpactoPlagioComputadora();    
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueJugador : function(personaje,ataque){
        variablesCampoBatalla.golpe_al_cuerpo.play();
        ataque.kill();
        variablesCampoBatalla.movH[2]=false;
        if(!variablesCampoBatalla.movV[0]){
            funcionesBatalla.actualizarVida(vidaRojoComputadora,variablesCampoBatalla.danoH[1]);
            funcionesBatalla.spriteImpactoJugador();
            variablesCampoBatalla.golpe_al_cuerpo.play();
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueComputadora : function(personaje,ataque){
        variablesCampoBatalla.golpe_al_cuerpo.play();
        ataque.kill();
        variablesCampoBatalla.movV[2]=false;
        if(!variablesCampoBatalla.movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,variablesCampoBatalla.danoV[1]);
            funcionesBatalla.spriteImpactoComputadora();
        }
    },
    /*Muestra el sprite de impacto del jugador en la poscicion del rival
    *Lo muestra por un segundo y luego lo destruye
    */
    spriteImpactoJugador : function(){
       var impacto = game.add.sprite(variablesCampoBatalla.personajeComputadora.body.x,variablesCampoBatalla.personajeComputadora.body.y, 'impactoPersonalidadJugador');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especial', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especial');
        game.time.events.add(1000,function(){impacto.kill();},this);
        
    },
    /*Muestra el sprite de impacto de la computadora en la poscicion del jugador 
    *Lo muestra por un segundo y luego lo destruye
    */
    spriteImpactoComputadora : function(){
       var impacto = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x,variablesCampoBatalla.personajeJugador.body.y, 'impactoPersonalidadComputadora');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especiall');
        game.time.events.add(1000,function(){impacto.kill();},this);
    },
    spriteImpactoPlagioComputadora : function(){
       var impacto = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x,variablesCampoBatalla.personajeJugador.body.y, 'impactoPlagioComputadora');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especiall');
        game.time.events.add(1000,function(){impacto.kill();},this);
        
    },
    /*Cada vez que hay colision entre los dos personajes se llama esta funcion 
    *Verifica si hay daño por ataque normal 
    */
    colision : function(){
        if(variablesCampoBatalla.cambioOrientacion){
                    variablesCampoBatalla.personajeJugador.position.x +=100;
                    variablesCampoBatalla.personajeComputadora.position.x-=200;
                }else{
                    variablesCampoBatalla.personajeJugador.position.x -=100;
                    variablesCampoBatalla.personajeComputadora.position.x+=200;
                }
        if(variablesCampoBatalla.movV[1]||variablesCampoBatalla.movH[1]){
            
        }
        
        //si se resta vida al jugador 
        if(variablesCampoBatalla.movV[1]==true&&!variablesCampoBatalla.movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,variablesCampoBatalla.danoV[0]);
            variablesCampoBatalla.movV[0]=false;
            funcionesBatalla.spriteImpactoComputadora();
        }
        //si se resta vida a la computadora
        if(variablesCampoBatalla.movH[1]&&!variablesCampoBatalla.movV[0]){

            funcionesBatalla.actualizarVida(vidaRojoComputadora,variablesCampoBatalla.danoH[0]);
            variablesCampoBatalla.movH[0]=false;
            funcionesBatalla.spriteImpactoJugador();
            
        }
     },
     /* Se llama cuando se acaba el juego 
     * Cada vez que se llama muestra un letrero por 2 segundo y despues cambia de pantalla
     */
     finJuego : function(){
        
        game.add.text(game.width/4,game.height/2,'JUEGO TERMINADO', {font:'45px', fill:'#fff'});
		 if(vidaRojoComputadora.width==0){
				variablesCampoBatalla.ganador = true;
			}else{
				variablesCampoBatalla.ganador = false;
			}
           
        game.time.events.add(2000,function(){ game.state.start('fin');},this);
     },
     numeroAleatorio:function(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
    },  
    /*Esta funcion ejecuta las siguientes acciones 
    *El personaje avanza
    *El personaje ataca
    *El personaje se defiende
    */  
    primerMovimientoComputadora:function(){ 
        variablesCampoBatalla.secuencia=true;
        game.time.events.add(3000,function(){ 
            variablesCampoBatalla.movimientoComputadora="punos";
            game.time.events.add(500,function(){
            variablesCampoBatalla.movimientoComputadora="defensa";
            game.time.events.add(100,function(){
                variablesCampoBatalla.movimientoComputadora="adelante";
                variablesCampoBatalla.secuencia=false;
                },this);
            },this);
        },this); 
    },
    /*Esta funcion ejecuta las siguientes acciones 
    *El personaje retrocede
    *El personaje se defiende
    *El lanza el ataque personalidad 
    */  
    segundoMovimientoComputadora:function(){ 
        variablesCampoBatalla.secuencia=true;
        variablesCampoBatalla.movimientoComputadora="atras";
        game.time.events.add(500,function(){ 
            variablesCampoBatalla.movimientoComputadora="defensa";
            game.time.events.add(2000,function(){ 
                variablesCampoBatalla.movimientoComputadora="quieto";
                variablesCampoBatalla.personajeComputadora.animations.play("quieto");
                
                this.activarPersonalidadC();
                game.time.events.add(2000,function(){ 
                    variablesCampoBatalla.secuencia=false;
                    movimientoComputadora="atras";
                },this);   
             },this); 
        },this); 

       
    },
    /*Esta funcion ejecuta las siguientes acciones 
    *El personaje ataca
    *El personaje retrocede
    *El personaje lanza el ataque plagio
    */  
    tercerMovimientoComputadora:function(){ 
        variablesCampoBatalla.secuencia=true;
        variablesCampoBatalla.movimientoComputadora="punos";
        game.time.events.add(1000,function(){ 
            variablesCampoBatalla.movimientoComputadora="atras";
            game.time.events.add(2000,function(){ 
                variablesCampoBatalla.movimientoComputadora="quieto";
                variablesCampoBatalla.personajeComputadora.animations.play("quieto");
                this.activarPlagioC();
                    game.time.events.add(2000,function(){ 
                    movimientoComputadora="adelante";
                    game.time.events.add(3000,function(){
                        variablesCampoBatalla.secuencia=false;
                    },this);
                },this);   
             },this); 
        },this); 

       
    },
    /*Con esta funcion se hace un movimiento en el update
    */
    guiaComputadora:function(string){
        variablesCampoBatalla.movV[0]=false;
        variablesCampoBatalla.movV[1]=false;
        variablesCampoBatalla.personajeComputadora.body.velocity.x=0;
        if(string.localeCompare("adelante")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('correr');
            if(variablesCampoBatalla.cambioOrientacion){
                variablesCampoBatalla.personajeComputadora.body.x+=150;
            }else{
                 variablesCampoBatalla.personajeComputadora.body.velocity.x-=150;
            } 
        }else if (string.localeCompare("atras")==0){
            if(variablesCampoBatalla.cambioOrientacion){
                variablesCampoBatalla.personajeComputadora.body.velocity.x-=150;
            }else{
                variablesCampoBatalla.personajeComputadora.body.velocity.x+=150;
            } 
            variablesCampoBatalla.personajeComputadora.animations.play('correr');
            
        }else if (string.localeCompare("defensa")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('defensa');
            variablesCampoBatalla.movV[0]=true;
        }else if (string.localeCompare("punos")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('punos');
            if(variablesCampoBatalla.cambioOrientacion){
                variablesCampoBatalla.personajeComputadora.body.x+=1;
            }else{
                 variablesCampoBatalla.personajeComputadora.body.x-=1;
            } 
            variablesCampoBatalla.personajeComputadora.body.x-=1;
            variablesCampoBatalla.movV[1]=true;
        }
    },
    /*Con esta funcion se muestra la caja misteriosa
    */
     showBox:function(){
               if (!caja.visible) {
                caja.visible = true;
               };
        },
    /*Con esta funcion se oculta la caja misteriosa
    */
     hideBox:function(){
               if (caja.visible) {
                caja.visible = false;
               };
        },
    /*Con esta funcion se verifica si el usuario atrapo o no la caja misteriosa
    */
    catchedBox:function(){
        caja.visible = false;
        if (!openBox.visible) {
            openBox.visible =true;
            
        }    
    },
    /*Con esta funcion se oculta la caja misteriosa abierta
    */
    hideOpenBox:function(){
               if (openBox.visible) {
                openBox.visible = false;
               };

    },
    /*Con esta funcion  la caja misteriosa da 20 segundos mas
    */
    giftbox:function(){
        return 20;
    },
     /*Con esta funcion  la caja misteriosa da vida al personaje del jugador
    */
    giftlife:function(life){
        if (life.width<=200) {
            if (life.width + 40 >= 200) {
                return 200;
            }
            else{
                return life.width + 40;
            }
        }
        else{
            return 200;
        }
    },
     /*Con esta funcion  la caja misteriosa roba vida del enemigo 
    */
    steallife(life){
        var vida = (life.width*20)/100;
        return life.width-vida;
    },
     /*Con esta funcion  la caja misteriosa cambia de vida
    */
    changelife(ulife,cpulife){
        var blood = [ulife.width,cpulife.width];
        return blood;
    },
     /*Con esta funcion  la caja misteriosa deja con 1% de la vida a los dos personajes
    */
    fatality(ulife,cpulife){
        fatalityu = (ulife.width*1)/100;
        fatalitycpu = (cpulife.width*1)/100;
        newlife =[fatalityu,fatalitycpu];
        return newlife;
    },
     /*Con esta funcion  la caja misteriosa da mas daño al pj
    */
    getstrong(dano){
        var newStrong = [1,1];
        for (var i = dano.length - 1; i >= 0; i--) {
            newStrong[i] = dano[i]*8;
        };
        return newStrong;
    },
    llamarSecuencia:function(indice){
        if(indice==1)
            this.primerMovimientoComputadora();
        else if(indice==2)
            this.segundoMovimientoComputadora();
        else if(indice==3)
            this.tercerMovimientoComputadora();
    },
    joystick:function(joy,button){
        if(variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("punos")==0
            &&variablesCampoBatalla.personajeJugador.animations.currentAnim.isPlaying){
                variablesCampoBatalla.movH[1]=true;
                 if(variablesCampoBatalla.cambioOrientacion)
                    variablesCampoBatalla.personajeJugador.body.x-=1;
                else
                    variablesCampoBatalla.personajeJugador.body.x+=1;
        }else{
            variablesCampoBatalla.movH[1]=false;
        }
        variablesCampoBatalla.movH[0]=false;        
        variablesCampoBatalla.movH[3]=false;
        variablesCampoBatalla.personajeJugador.body.velocity.x=0;
        if(variablesCampoBatalla.escudo1!=null)
            variablesCampoBatalla.escudo1.kill();
        if(variablesCampoBatalla.escudo2!=null)
            variablesCampoBatalla.escudo2.kill();
            if (joy.properties.right) {
                variablesCampoBatalla.personajeJugador.body.x+=2;
                variablesCampoBatalla.personajeJugador.animations.play('correr');
                } else if (joy.properties.left) {
                    variablesCampoBatalla.personajeJugador.body.x-=2;
                    variablesCampoBatalla.personajeJugador.animations.play('correr');
                } else if (joy.properties.down) {
                    if(variablesCampoBatalla.cambioOrientacion)
                        variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x, variablesCampoBatalla.personajeJugador.body.y, 'escudo1');
                    else
                        variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x+200, variablesCampoBatalla.personajeJugador.body.y, 'escudo1');
                    variablesCampoBatalla.escudo1.anchor.setTo(0.5,0);
                    variablesCampoBatalla.personajeJugador.animations.play('defensa')
                    variablesCampoBatalla.movH[0]=true;
                }else if (joy.properties.up&&(variablesCampoBatalla.personajeJugador.body.y>355)&&(game.time.now > variablesCampoBatalla.saltoJ)){                
                           variablesCampoBatalla.personajeJugador.body.velocity.y-=500;
                }
                else if (button.isDown&&!variablesCampoBatalla.unClick){
                    variablesCampoBatalla.unClick=true;
                }else if (variablesCampoBatalla.unClick){
                    variablesCampoBatalla.unClick=false;
                    variablesCampoBatalla.personajeJugador.animations.play('punos');
                    variablesCampoBatalla.personajeJugador.body.x+=1;
                    variablesCampoBatalla.movH[1]=true;
                }else if(variablesCampoBatalla.unClickEscudo){
                    variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x, variablesCampoBatalla.personajeJugador.body.y, 'escudo2');
                    variablesCampoBatalla.personajeJugador.animations.play('defensa')
                    variablesCampoBatalla.movH[3]=true;
                }else{
                      if(variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("correr")==0||
                        variablesCampoBatalla.personajeJugador.animations.currentAnim.name.localeCompare("defensa")==0){
                        variablesCampoBatalla.personajeJugador.frame = 1;
            }
                }
    }
}