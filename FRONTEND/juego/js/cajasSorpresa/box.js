/*Este archivo se crea para declarar los personajes como se va a hecer en la base de datos
*Con esto nos aseguramos que vaya a funcionar cuando de consuman los servicios 
*/
var boxes={
	1:{"root":"../img/componentes/cajas/caja1.png","rootOpen":"../img/componentes/cajas/caja1explosion.png"},
	2:{"root":"../img/componentes/cajas/caja2.png","rootOpen":"../img/componentes/cajas/caja2explosion.png"},
	3:{"root":"../img/componentes/cajas/caja3.png","rootOpen":"../img/componentes/cajas/caja3explosion.png"},
	4:{"root":"../img/componentes/cajas/caja4.png","rootOpen":"../img/componentes/cajas/caja4explosion.png"},
	5:{"root":"../img/componentes/cajas/caja5.png","rootOpen":"../img/componentes/cajas/caja5explosion.png"},
	6:{"root":"../img/componentes/cajas/caja6.png","rootOpen":"../img/componentes/cajas/caja6explosion.png"},
	7:{"root":"../img/componentes/cajas/caja7.png","rootOpen":"../img/componentes/cajas/caja7explosion.png"},
	8:{"root":"../img/componentes/cajas/caja8.png","rootOpen":"../img/componentes/cajas/caja8explosion.png","fatalityBox":"../img/componentes/cajas/fatality.png"}
}
var boxesDes ={
	"boxMistery":{
		"nameBox":["caja 1","caja 2","caja 3","caja 4","caja 5","caja 6","caja 7","Fatality"],
		"desc":["Esta caja ayudara al usuario con tiempo extra \n(20 segundos) para poder derrotar a su oponente.",
                 "Esta caja ayudara al usuario \ncon un aumento de la barra de energía. ",
                 "Esta caja ayudara al usuario \ncon una porción  pequeña de vida.",
                 "Esta caja robara vida al usuario \n en un 20 por ciento.",
                 "Esta caja intercambia la barra de vida \n entre el usuario y el enemigo.",
                 "Esta caja deshabilitará el poder \nde ataque del usuario por 3 segundos",
                 "Esta caja ayudara al usuario con el poder, \n sera mas poderoso de lo normal.",
                 "Esta caja deja al usuario y al oponente \n con un minimo de vida."]
	}
}
