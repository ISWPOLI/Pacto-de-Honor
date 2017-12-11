//Carga y validacion inicial de datos de perfil
var mundoMayor=1;
var nivelMundoMayor=1;
function cargaInicial(){
//Verificacion de local storage si esta vacio
if(localStorage.length!=0){

mundoMayor=parseInt(obtenerLocalStorage("Mundo"));
nivelMundoMayor=parseInt(obtenerLocalStorage("NivelMundo"));



}
else {
  variablesPerfilJugador.NicknamePerfil = datosperfil["datos"].nickname;
  variablesPerfilJugador.MundoPerfil = datosperfil["datos"].mundo;
  variablesPerfilJugador.NivelPerfil = datosperfil["datos"].nivel;
  variablesPerfilJugador.MonedasPerfil = datosperfil["datos"].monedas;
  variablesPerfilJugador.ExperienciaPerfil= datosperfil["datos"].experiencia;
  variablesPerfilJugador.NivelMundoPerfil= datosperfil["datos"].escenario;
  añadirLocalStorage("Nickname",variablesPerfilJugador.NicknamePerfil);
  añadirLocalStorage("Xp",variablesPerfilJugador.ExperienciaPerfil);
  añadirLocalStorage("Oro",variablesPerfilJugador.MonedasPerfil);
  añadirLocalStorage("NivelMundo",1);
  añadirLocalStorage("NivelPersonaje",variablesPerfilJugador.NivelPerfil);
  añadirLocalStorage("Mundo",1);


}

}
//Funcion que permite almacenar cualquier valor en el localstorage recibiendo la llave y su valor
function añadirLocalStorage(key, valor) {

  localStorage.setItem(key, valor);

}
//funcion encargada de dar al localStorage el mundo y nivel actual si gana
function nivelMundoLocalStorage(nivelo,validacion){
  if(validacion==0){
    var orotemp=parseInt(localStorage.getItem("Oro"));
    var xptemp=parseInt(localStorage.getItem("Xp"));
    orotemp+=200;
    xptemp+=100;
    var mundo;
    var nivel;
    for (var i = 0; i < nivelo.length; i++) {
      var caracter = nivelo.charAt(i);
  //obtenemos el nivel
      if(caracter=="-"){
        for (var x= i+1; x < nivelo.length; x++) {
        nivel=+nivelo.charAt(x);
      }
      break;

    }
      else{
      //obtenemoselmundo
        mundo=+nivelo.charAt(i);
        }
  }
    añadirLocalStorage("Oro",orotemp);
    añadirLocalStorage("Xp",xptemp);
    validarMundoyNivelMayor(nivel,mundo);
  }
  else {
    xptemp+=10;
    añadirLocalStorage("Xp",xptemp);
  }
}
function validarMundoyNivelMayor(nivelactual,mundoactual){
  console.log("validando metodo");
//caso base que permite avanzar de nivel 5 de x mundo al siguiente restableciendo nivel mayor a 1 del siguiente mundo
if(nivelactual==5 && mundoMayor==mundoactual){
this.nivelMundoMayor=1;
this.mundoMayor=mundoMayor+1;
console.log("nivel"+nivelMundoMayor);
console.log("mundo"+mundoMayor);
  añadirLocalStorage("NivelMundo",nivelMundoMayor);
  añadirLocalStorage("Mundo",mundoMayor);
}
else if(nivelactual!=5 && mundoMayor==mundoactual){
  this.nivelMundoMayor=nivelMundoMayor+1;
  añadirLocalStorage("NivelMundo",nivelMundoMayor);

}


}
//devuelve valor de la lla
function obtenerLocalStorage (key){
var valor;
valor=localStorage.getItem(key);
return valor;
}
