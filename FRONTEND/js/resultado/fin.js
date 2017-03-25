    href=primer.js;
var fin = {

    preload: function(){
        game.load.image('poli', '../img/componentes/finBatalla/poli.jpg');
        game.load.spritesheet('gallo1', '../img/componentes/finBatalla/gallo.png', 200, 200);
        
    },
    create: function(){
        //game.add.sprite(0,0,'pause');
            //<a href="javascript:CrearVentana(../carpeta/form.htm, 300, 650)">
        //if(x<y){
          //  var z = game.add.text(50,50,'perdiste',{fill:"white"});
        
        //}else{
        game.add.sprite(0, 0, 'poli');
        gallo1 = game.add.sprite(400, 300, 'gallo1');
        gallo1.scale.setTo(1.5);
        gallo1.anchor.setTo(0.5);
        gallo1.frame = 24;
        game.add.text(300,80,'Ganador',{fill:'orange',font: '60px Arial'});
        game.add.text(200,450,'Personaje Bueno',{fill:'orange',font: '60px Arial'});
            
       // }
            
        
    },
}