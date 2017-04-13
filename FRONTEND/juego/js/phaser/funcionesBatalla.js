var funcionesBatalla={
    //funcion que se encarga de caragar todos los elementos del campo de batalla
	cargar:function(idPJ,idPC){
		game.load.image('fondo', "../img/escenarios/escenariosSecundarios/nivel1.png");
		game.load.spritesheet('personajeJugador', personajesBuenos[idPJ].rutaSprite, 200, 200);
		game.load.image('avatarPersonajeJugador', personajesBuenos[idPJ].rutaAvatar);
		game.load.spritesheet('personajeComputadora', personajesMalos[idPC].rutaSprite,200,200);
		game.load.image('avatarPersonajeComputadora', personajesMalos[idPC].rutaAvatar);
		game.load.image('pausa', '../img/componentes/batalla/pausa.png');
		game.load.image('menup', '../img/componentes/batalla/menup.png');
		game.load.image('ataquePersonalidadV', personajesMalos[idPC].rutaAtaque);
		game.load.spritesheet('ataquePlagio', personajesMalos[idPC].rutaAtaquePlagio,500,500);
		game.load.image('ataquePersonalidadB', personajesBuenos[idPJ].rutaAtaque);
        game.load.spritesheet('impactoPersonalidadJugador', personajesBuenos[idPJ].rutaImpactoPersonalidad,201,160);
        game.load.spritesheet('impactoPersonalidadComputadora', personajesMalos[idPC].rutaImpactoPersonalidad,161,145);
        game.load.spritesheet('impactoPlagioComputadora', personajesMalos[idPC].rutaImpactoPlagio,277,277);
	},
    //inicinializa todos los estados de los sprites de los personajes 
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
    actualizarVida: function(barra,daño){
        if(barra.width-daño>0)
            barra.width=barra.width-daño;
        else{
            barra.width=0;
            this.finJuego();
        }
    },
    movimientoJugador: function(){
        if (cursores.right.isDown) {
            personajeJugador.body.x+=2;
            personajeJugador.animations.play('correr');
        } else if (cursores.left.isDown) {
            personajeJugador.body.x-=2;
            personajeJugador.animations.play('correr');
        } else if (cursores.down.isDown) {
            personajeJugador.animations.play('defensa');
            movH[3]=true;

        } else if (cursores.up.isDown) {
            personajeJugador.animations.play('especial');
            movH[1]=true;

        } else if (esp.isDown){
            personajeJugador.animations.play('punos');
            personajeJugador.body.x+=2;
            movH[0]=true;
        }else{          
            personajeJugador.animations.play('quieto')
            movH[0]=false;
        }
    },
    colision : function(){
        personajeJugador.position.x -=100;
        personajeComputadora.position.x+=200;
        if(movV[0]==true&&!movH[3]){
            funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[0]);
            movH[3]=false;
            movV[0]=false;
        }
        if(movH[0]){
            funcionesBatalla.actualizarVida(vidaRojoComputadora,danoH[0]);
            movH[0]=false;
        }if(movV[2]==true){
            if(!movH[3]){
                funcionesBatalla.actualizarVida(vidaRojoJugador,danoV[2]);
                movH[3]=false;
            }
            //destruirSprite(ataquePlagio);
        }
     },
     finJuego : function(){
        game.add.text(game.width/4,game.height/2,'JUEGO TERMINADO', {font:'45px'});
        game.time.events.add(2000,function(){
                game.state.start('fin');},this);
     }
    
}
