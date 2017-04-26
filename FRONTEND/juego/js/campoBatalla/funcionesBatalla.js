var funcionesBatalla={
    //funcion que se encarga de cargar todos los elementos del campo de batalla
    cargar:function(idPJ,idPC){
        game.load.image('fondo', "../img/escenarios/escenariosSecundarios/nivel1.png");
		game.load.spritesheet('personajeJugador', personajesBuenos[idPJ].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeJugador', personajesBuenos[idPJ].rutaAvatar);
		game.load.spritesheet('personajeComputadora', personajesMalos[idPC].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeComputadora', personajesMalos[idPC].rutaAvatar);
		game.load.image('pausa', '../img/componentes/batalla/pausa.png');
		game.load.image('menup', '../img/componentes/batalla/menup.png');
		game.load.image('ataquePersonalidadV', personajesMalos[idPC].rutaAtaque);
		game.load.spritesheet('ataquePlagio', personajesMalos[idPC].rutaAtaquePlagio, 500, 500);
		game.load.image('ataquePersonalidadB', personajesBuenos[idPJ].rutaAtaque);
		game.load.spritesheet('botonPoder', personajesBuenos[idPJ].rutaBotonPoder, 62, 62);
        game.load.spritesheet('impactoPersonalidadJugador', personajesBuenos[idPJ].rutaImpactoPersonalidad, 201, 160);
        game.load.spritesheet('impactoPersonalidadComputadora', personajesMalos[idPC].rutaImpactoPersonalidad, 161, 145);
        game.load.spritesheet('impactoPlagioComputadora', personajesMalos[idPC].rutaImpactoPlagio, 277, 277);
        game.load.spritesheet('gamepad','../img/Componentes/joystick/gamepad_spritesheet.png',100,100);


    },
    //inicializa todos los estados de los sprites de los personajes 
	iniciarSprite:function(sprite){
		sprite.animations.add('quieto', [1], 10, true);
    	sprite.animations.add('correr', [6, 7, 8, 9, 11, 12, 13, 14], 10, true);
    	sprite.animations.add('punos', [16, 17, 18, 19], 7, true);
    	sprite.animations.add('defensa', [21], 10, true);
    	sprite.animations.add('especial', [23, 24], 10, true);
    	sprite.animations.play('quieto');
		game.physics.arcade.enable(sprite);
		sprite.body.collideWorldBounds = true; 
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
            if(event.x > 320 && event.x < 530 && event.y > 250 && event.y < 300){
                lal.destroy();
                game.paused = false;
            }
                //Condicional si se oprime en Reiniciar
            else if(event.x > 320 && event.x < 530 && event.y > 320 && event.y < 370) {
                game.paused = false;
                game.state.start(game.state.current);
                counter = 0;
            }
            //Condicional si se oprime en Salir
            else if (event.x > 320 && event.x < 530 && event.y > 380 && event.y < 420) {
                game.paused = false;
                game.state.start("navegacion");
            }
        }
    },
    //con esta funcion se refelja el daño causado
    actualizarVida: function(barra,daño){
        if(barra.width-daño>0)
            barra.width=barra.width-daño;
        else{
            barra.width=0;
            this.finJuego();
        }
    },
    //esta funcion se encarga de gestionar todos los mivimientos del jugador 
    movimientoJugador: function(barra){
        movH[0]=false;
        movH[1]=false;
        // if(movH[2]){
        //     if(ataquePersonalidadJ.body.onFloor()){
        //             ataquePersonalidadJ.kill();
        //             movH[2]=false;
        //         }
        // }
        if (cursores.right.isDown) {
            personajeJugador.body.x+=2;
            personajeJugador.animations.play('correr');
        } else if (cursores.left.isDown) {
            personajeJugador.body.x-=2;
            personajeJugador.animations.play('correr');
        } else if (cursores.down.isDown) {
            personajeJugador.animations.play('defensa');
            movH[0]=true;

        // } else if (cursores.up.isDown) {
        //     if(!movH[2]&&barra.width>=costoAtaqueJ){
        //         barra.width=barra.width-costoAtaqueJ;
        //         personajeJugador.animations.play('especial');
        //         game.time.events.add(100,function(){
        //             this.activarPersonalidadJ();
        //              movH[2]=true;
        //          },this);
        //     }   
        } else if (esp.isDown){
            personajeJugador.animations.play('punos');
            personajeJugador.body.x+=1;
            movH[1]=true;
        }else{
            personajeJugador.animations.play('quieto');
        }
    },
    
    //Esta función se activa al oprimir el botón del poder del personaje
    clickBotonPoder: function(){
        if(movH[2]){
            if(ataquePersonalidadJ.body.onFloor()){
                    ataquePersonalidadJ.kill();
                    movH[2]=false;
                }
        }
        if(!movH[2]&&energiaVerdeJugador.width>=costoAtaqueJ){
                energiaVerdeJugador.width=energiaVerdeJugador.width-costoAtaqueJ;
                personajeJugador.animations.play('especial');
                game.time.events.add(100,function(){
                    funcionesBatalla.activarPersonalidadJ();
                    movH[2]=true;
                 },this);
            }
    },
    
    //esta funcion activa el poder de la computadora y lo inicializa como una bala
    activarPersonalidadC :function(){
         if(!movV[2]&&energiaVerdeComputadora.width>=costoAtaqueC){
                energiaVerdeComputadora.width=energiaVerdeComputadora.width-costoAtaqueC;
                personajeComputadora.animations.play('especial');
                game.time.events.add(100,function(){
                    ataquePersonalidadC = game.add.weapon(10, 'ataquePersonalidadV');
                    game.physics.arcade.enable(ataquePersonalidadC);
                    ataquePersonalidadC.trackSprite(personajeComputadora, 0, 0, true);
                    ataquePersonalidadC.fireAtSprite(personajeJugador);
                    ataquePersonalidadC.bulletCollideWorldBounds=true;
                    movV[2]=true;
                 },this);
            }   
        
    },
    //esta funcion activa el poder plagio  de la computadora y lo inicializa como una bala
    activarPlagioC :function(){
         if(!movV[3]&&energiaVerdeComputadora.width>=costoPlagioC){
                energiaVerdeComputadora.width=energiaVerdeComputadora.width-costoPlagioC;
                personajeComputadora.animations.play('especial');
                game.time.events.add(100,function(){
                    ataquePlagio = game.add.sprite(game.height/2,game.width/2, 'ataquePlagio');
                    game.physics.arcade.enable(ataquePlagio);
                    ataquePlagio.collideWorldBounds = true; 
                    ataquePlagio.scale.setTo(0.8);
                    ataquePlagio.anchor.setTo(0.4);
                    ataquePlagio.animations.add('especial', [1, 2, 3, 4, 5, 6, 7, 8], 8, false,true);
                    ataquePlagio.animations.play('especial');
                    movV[3]=true;
                    primerImpacto=true;
                 },this);
            }   
        
    },
    //esta funcion activa el poder del jugador
    activarPersonalidadJ :function(){
        ataquePersonalidadJ=game.add.sprite(personajeComputadora.body.x,0,'ataquePersonalidadB');
        game.physics.arcade.enable(ataquePersonalidadJ);
        ataquePersonalidadJ.body.collideWorldBounds = true; 
        ataquePersonalidadJ.body.gravity.y = 300;
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
        game.time.events.add(1000,function(){ataque.kill();},this);
        movV[3]=false;
        if(!movH[0]&&primerImpacto){
            primerImpacto=false;
            funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[2]);
            funcionesBatalla.spriteImpactoPlagioComputadora();
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueJugador : function(personaje,ataque){
        ataque.kill();
        movH[2]=false;
        if(!movV[0]){
            funcionesBatalla.actualizarVida(vidaRojoComputadora,danoH[1]);
            funcionesBatalla.spriteImpactoJugador();
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueComputadora : function(personaje,ataque){
        ataque.kill();
        movV[2]=false;
        if(!movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[1]);
            funcionesBatalla.spriteImpactoComputadora();
        }
    },
    /*Muestra el sprite de impacto del jugador en la poscicion del rival
    *Lo muestra por un segundo y luego lo destruye
    */
    spriteImpactoJugador : function(){
       var impacto = game.add.sprite(personajeComputadora.body.x,personajeComputadora.body.y, 'impactoPersonalidadJugador');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especial', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especial');
        game.time.events.add(1000,function(){impacto.kill();},this);
        
    },
    /*Muestra el sprite de impacto de la computadora en la poscicion del jugador 
    *Lo muestra por un segundo y luego lo destruye
    */
    spriteImpactoComputadora : function(){
       var impacto = game.add.sprite(personajeJugador.body.x,personajeJugador.body.y, 'impactoPersonalidadComputadora');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especiall');
        game.time.events.add(1000,function(){impacto.kill();},this);
    },
    spriteImpactoPlagioComputadora : function(){
       var impacto = game.add.sprite(personajeJugador.body.x,personajeJugador.body.y, 'impactoPlagioComputadora');
        game.physics.arcade.enable(impacto);
        impacto.animations.add('especiall', [1, 2, 3, 4, 5, 6, 7, 8], 9, false,true);
        impacto.animations.play('especiall');
        game.time.events.add(1000,function(){impacto.kill();},this);
        
    },
    /*Cada vez que hay colision entre los dos personajes se llama esta funcion 
    *Verifica si hay daño por ataque normal 
    */
    colision : function(){
        if(movV[1]||movH[1]){
            personajeJugador.position.x -=100;
            personajeComputadora.position.x+=200;
        }
        //si se resta vida al jugador 
        if(movV[1]==true&&!movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[0]);
            movV[0]=false;
            funcionesBatalla.spriteImpactoComputadora();
        }
        //si se resta vida a la computadora
        if(movH[1]&&!movV[0]){
            funcionesBatalla.actualizarVida(vidaRojoComputadora,danoH[0]);
            movH[0]=false;
            funcionesBatalla.spriteImpactoJugador();
            
        }
     },
     /* Se llama cuando se acaba el juego 
     * Cada vez que se llama muestra un letrero por 2 segundo y despues cambia de pantalla
     */
     finJuego : function(){
        game.add.text(game.width/4,game.height/2,'JUEGO TERMINADO', {font:'45px'});
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
        secuencia=true;
        game.time.events.add(1000,function(){ 
            movimientoComputadora="punos";
            game.time.events.add(500,function(){
            movimientoComputadora="defensa";
            game.time.events.add(500,function(){
                movimientoComputadora="adelante";
                secuencia=false;
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
        secuencia=true;
        movimientoComputadora="atras";
        game.time.events.add(500,function(){ 
            movimientoComputadora="defensa";
            game.time.events.add(2000,function(){ 
                movimientoComputadora="quieto";
                personajeComputadora.animations.play("quieto");
                
                this.activarPersonalidadC();
                game.time.events.add(2000,function(){ 
                    secuencia=false;
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
        secuencia=true;
        movimientoComputadora="punos";
        game.time.events.add(1000,function(){ 
            movimientoComputadora="atras";
            game.time.events.add(2000,function(){ 
                movimientoComputadora="quieto";
                personajeComputadora.animations.play("quieto");
                this.activarPlagioC();
                game.time.events.add(2000,function(){ 
                    movimientoComputadora="adelante";
                    game.time.events.add(2000,function(){
                        secuencia=false;
                    },this);
                },this);   
             },this); 
        },this); 

       
    },
    /*Con esta funcion se hace un movimiento en el update
    */
    guiaComputadora:function(string){
        movV[0]=false;
        movV[1]=false;
        if(string.localeCompare("adelante")==0){
            personajeComputadora.animations.play('correr');
            personajeComputadora.body.x -= 2; 
        }else if (string.localeCompare("atras")==0){
             personajeComputadora.animations.play('correr');
             personajeComputadora.body.x += 2; 
        }else if (string.localeCompare("defensa")==0){
             personajeComputadora.animations.play('defensa');
             movV[0]=true;
        }else if (string.localeCompare("punos")==0){
             personajeComputadora.animations.play('punos'); 
             personajeComputadora.body.x-=1;
             movV[1]=true;
        }
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
        
            movH[0]=false;
            movH[1]=false;
            if (joy.properties.right) {
                personajeJugador.body.x+=2;
                personajeJugador.animations.play('correr');
                } else if (joy.properties.left) {
                    personajeJugador.body.x-=2;
                    personajeJugador.animations.play('correr');
                } else if (joy.properties.down) {
                    personajeJugador.animations.play('defensa');
                    movH[0]=true;
                }
                else if (button.isDown){
                    personajeJugador.animations.play('punos');
                    personajeJugador.body.x+=1;
                    movH[1]=true;
                }else{
                    personajeJugador.animations.play('quieto');
                }
    }
}