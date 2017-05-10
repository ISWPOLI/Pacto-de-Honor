var ganadorBatalla;
var funcionesBatalla={
    //funcion que se encarga de cargar todos los elementos del campo de batalla
    cargar:function(idPJ, idPC, caa, idNivel){
        game.load.image('fondo', niveles[idNivel].fondo);
		game.load.spritesheet('personajeJugador', personajesBuenos[idPJ].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeJugador', personajesBuenos[idPJ].rutaAvatar);
		game.load.spritesheet('personajeComputadora', personajesMalos[idPC].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeComputadora', personajesMalos[idPC].rutaAvatar);
		game.load.image('pausa', '../img/Componentes/botones/pausa.png');
		game.load.image('menup', '../img/Componentes/botones/menup.png');
		game.load.image('ataquePersonalidadV', personajesMalos[idPC].rutaAtaque);
		game.load.spritesheet('ataquePlagio', personajesMalos[idPC].rutaAtaquePlagio, 500, 500);
		game.load.image('ataquePersonalidadB', personajesBuenos[idPJ].rutaAtaque);
		game.load.spritesheet('botonPoder', personajesBuenos[idPJ].rutaBotonPoder, 62, 62);
        game.load.spritesheet('impactoPersonalidadJugador', personajesBuenos[idPJ].rutaImpactoPersonalidad, 201, 160);
        game.load.spritesheet('impactoPersonalidadComputadora', personajesMalos[idPC].rutaImpactoPersonalidad, 161, 145);
        game.load.spritesheet('impactoPlagioComputadora', personajesMalos[idPC].rutaImpactoPlagio, 277, 277);
        game.load.spritesheet('gamepad','../img/Componentes/joystick/gamepad_spritesheet.png',100,100);
        game.load.image('caja', boxes[caa].root);
        game.load.image('escudo1', '../img/componentes/batalla/escudo1.png');
        game.load.image('escudo2', '../img/componentes/batalla/escudo2.png');
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
        variablesCampoBatalla.movH[0]=false;
        variablesCampoBatalla.movH[1]=false;
        variablesCampoBatalla.movH[3]=false;
        if(variablesCampoBatalla.escudo1!=null)
            variablesCampoBatalla.escudo1.kill();
        if(variablesCampoBatalla.escudo2!=null)
            variablesCampoBatalla.escudo2.kill();
       
        if (cursores.right.isDown) {
            variablesCampoBatalla.personajeJugador.body.x+=2;
            variablesCampoBatalla.personajeJugador.animations.play('correr');
        } else if (cursores.left.isDown) {
            variablesCampoBatalla.personajeJugador.body.x-=2;
            variablesCampoBatalla.personajeJugador.animations.play('correr');
        } else if (cursores.down.isDown) {
            variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x+200, variablesCampoBatalla.personajeJugador.body.y, 'escudo1');
            variablesCampoBatalla.escudo1.anchor.setTo(0.5,0);
            
            variablesCampoBatalla.personajeJugador.animations.play('defensa')
            variablesCampoBatalla.personajeJugador.body.velocity.y=0;
            variablesCampoBatalla.movH[0]=true;
        }else if(cursores.up.isDown){
            variablesCampoBatalla.escudo2 = game.add.sprite(variablesCampoBatalla.personajeJugador.body.x+150, variablesCampoBatalla.personajeJugador.body.y, 'escudo2');
            variablesCampoBatalla.escudo2.anchor.setTo(0.5,0);
            variablesCampoBatalla.movH[3]=true;
        } else if (esp.isDown){
            variablesCampoBatalla.personajeJugador.animations.play('punos');
            variablesCampoBatalla.personajeJugador.body.x+=1;
            variablesCampoBatalla.movH[1]=true;
        }else{
            variablesCampoBatalla.personajeJugador.animations.play('quieto');
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
        game.time.events.add(1000,function(){ataque.kill();},this);
        variablesCampoBatalla.movV[3]=false;
        if(!variablesCampoBatalla.movH[0]&&variablesCampoBatalla.primerImpacto){
            variablesCampoBatalla.primerImpacto=false;
            funcionesBatalla.actualizarVida(vidaRojoJugador,variablesCampoBatalla.danoV[2]);
            funcionesBatalla.spriteImpactoPlagioComputadora();
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueJugador : function(personaje,ataque){
        ataque.kill();
        variablesCampoBatalla.movH[2]=false;
        if(!variablesCampoBatalla.movV[0]){
            funcionesBatalla.actualizarVida(vidaRojoComputadora,variablesCampoBatalla.danoH[1]);
            funcionesBatalla.spriteImpactoJugador();
        }

    },
    /*Cuando impacta el ataque pregunta si el jugador se estaba defendiendo
    *Si no se estaba defendiendo causa daño y llama al sprite de impacto 
    */
    impactoAtaqueComputadora : function(personaje,ataque){
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
        if(variablesCampoBatalla.movV[1]||variablesCampoBatalla.movH[1]){
            variablesCampoBatalla.personajeJugador.position.x -=100;
            variablesCampoBatalla.personajeComputadora.position.x+=200;
        }
        //si se resta vida al jugador 
        if(variablesCampoBatalla.movV[1]==true&&variablesCampoBatalla.movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[0]);
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
        game.add.text(game.width/4,game.height/2,'JUEGO TERMINADO', {font:'45px'});
		 if(vidaRojoComputadora.width==0){
				ganadorBatalla = false;
			}else{
				ganadorBatalla = true;
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
        game.time.events.add(1000,function(){ 
            variablesCampoBatalla.movimientoComputadora="punos";
            game.time.events.add(500,function(){
            variablesCampoBatalla.movimientoComputadora="defensa";
            game.time.events.add(500,function(){
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
                    game.time.events.add(2000,function(){
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
        if(string.localeCompare("adelante")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('correr');
            variablesCampoBatalla.personajeComputadora.body.x -= 2; 
        }else if (string.localeCompare("atras")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('correr');
            variablesCampoBatalla.personajeComputadora.body.x += 2; 
        }else if (string.localeCompare("defensa")==0){
            variablesCampoBatalla.escudo1 = game.add.sprite(variablesCampoBatalla.personajeComputadora.body.x, variablesCampoBatalla.personajeComputadora.body.y, 'escudo1');
            variablesCampoBatalla.escudo1.anchor.setTo(0.5,0);
            variablesCampoBatalla.personajeComputadora.animations.play('defensa');
            variablesCampoBatalla.movV[0]=true;
        }else if (string.localeCompare("punos")==0){
            variablesCampoBatalla.personajeComputadora.animations.play('punos'); 
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
        
            variablesCampoBatalla.movH[0]=false;
            variablesCampoBatalla.movH[1]=false;
            if (joy.properties.right) {
                variablesCampoBatalla.personajeJugador.body.x+=2;
                variablesCampoBatalla.personajeJugador.animations.play('correr');
                } else if (joy.properties.left) {
                    variablesCampoBatalla.personajeJugador.body.x-=2;
                    variablesCampoBatalla.personajeJugador.animations.play('correr');
                } else if (joy.properties.down) {
                    variablesCampoBatalla.personajeJugador.animations.play('defensa');
                    variablesCampoBatalla.movH[0]=true;
                }
                else if (button.isDown){
                    variablesCampoBatalla.personajeJugador.animations.play('punos');
                    variablesCampoBatalla.personajeJugador.body.x+=1;
                    variablesCampoBatalla.movH[1]=true;
                }else{
                    variablesCampoBatalla.personajeJugador.animations.play('quieto');
                }
    }
}