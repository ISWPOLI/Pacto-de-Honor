var game = new Phaser.Game (800, 600, Phaser.AUTO, 'game');
    game.state.add("historieta", historieta);    
    game.state.add("navegacion", navegacion);  
    game.state.add("creditos", creditos);
    game.state.add("primer", primer);
    game.state.add("seleccionpersonaje", seleccionpersonaje);    
    game.state.add("seleccionavatar", seleccionavatar);    
	game.state.start("seleccionavatar");