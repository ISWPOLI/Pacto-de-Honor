//Carga y validacion inicial de datos de perfil
function cargaInicial(){

if(localStorage.length!=0){



  console.log("No esta vacio");


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
  añadirLocalStorage("NivelMundo",variablesPerfilJugador.NivelMundoPerfil);
  añadirLocalStorage("NivelPersonaje",variablesPerfilJugador.NivelPerfil);
  añadirLocalStorage("Mundo",variablesPerfilJugador.MundoPerfil);
console.log("Esta vacio");

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
  console.log(nivelo);
  console.log("NIVEL MUNDO " +nivel);
  console.log("MUNDO " +mundo);
    orotemp+=200;
    xptemp+=100;


    añadirLocalStorage("Oro",orotemp);
    añadirLocalStorage("Xp",xptemp);
    añadirLocalStorage("NivelMundo",nivel);
    añadirLocalStorage("Mundo",mundo);
  }
  else {
    xptemp+=10;
    añadirLocalStorage("Xp",xptemp);
  }
}

function obtenerLocalStorage (key){
var valor;
valor=localStorage.getItem(key);
return valor;
}
