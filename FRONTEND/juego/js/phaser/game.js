var game = new Phaser.Game (800, 600, Phaser.CANVAS, 'game');
  /* game.state.add("historieta", historieta);
    game.state.add("navegacion", navegacion);
    game.state.add("primer", primer);
    game.state.add("creditos", creditos);
    game.state.add("invitarAmigos", invitarAmigos);
    game.state.add("seleccionPersonaje", seleccionPersonaje);    
    game.state.add("seleccionavatar", seleccionavatar);
    */game.state.add("desbloqueoPersonaje", desbloqueoPersonaje);
   // game.state.add("fin", fin);    
  
	game.state.start("desbloqueoPersonaje");