//Carga y validacion inicial de datos de perfil
var mundoMayor=1;
var nivelMundoMayor=1;
//arreglo campoenes comprados
var CampeonesComprados = [true, false,false ,false , false,false ,false ,false,false];
//arreglo experiencia de personajes
var Exp = [0,0,0,0,0,0,0,0,0];

function cargaInicial(){
//Verificacion de local storage si esta vacio
  if(localStorage.length!=0){

    mundoMayor=parseInt(obtenerLocalStorage("Mundo"));
    nivelMundoMayor=parseInt(obtenerLocalStorage("NivelMundo"));
    datosperfil.monedas = obtenerLocalStorage('Oro');
    datosperfil.experiencia = obtenerLocalStorage("Xp");
    variablesCompraPersonajes.comprado = obtenerLocalStorage("CampeonesComprados");

  }
    else {

      variablesPerfilJugador.NicknamePerfil = datosperfil["datos"].nickname;
      variablesPerfilJugador.MundoPerfil = datosperfil["datos"].mundo;
      variablesPerfilJugador.NivelPerfil = datosperfil["datos"].nivel;
      variablesPerfilJugador.MonedasPerfil = datosperfil["datos"].monedas;
      variablesPerfilJugador.ExperienciaPerfil= datosperfil["datos"].experiencia;
      variablesPerfilJugador.NivelMundoPerfil= datosperfil["datos"].escenario;
      variablesCompraPersonajes.monedas = datosperfil["datos"].monedas;
      variablesCompraPersonajes.xp = datosperfil["datos"].experiencia;
      variablesCompraPersonajes.comprado = CampeonesComprados;
      //Carga inicial del localstorage
      añadirLocalStorage("Nickname",variablesPerfilJugador.NicknamePerfil);
      añadirLocalStorage("Xp",variablesPerfilJugador.ExperienciaPerfil);
      añadirLocalStorage("Oro",variablesPerfilJugador.MonedasPerfil);
      añadirLocalStorage("NivelMundo",1);
      añadirLocalStorage("NivelPersonaje",variablesPerfilJugador.NivelPerfil);
      añadirLocalStorage("Mundo",1);
      añadirLocalStorage("ExpPersonajes",Exp);
      añadirLocalStorage("CampeonesComprados",CampeonesComprados);
      }
}
//Funcion que permite almacenar cualquier valor en el localstorage recibiendo la llave y su valor
function añadirLocalStorage(key, valor) {
  localStorage.setItem(key, JSON.stringify(valor));
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
//metodo para añadir al arreglo NIVELES
function SumarNivelHeroe (key, indice , valor){
  this.Npersonaje[indice]=valor;
  añañadirLocalStorage(key,Npersonaje);
}
  //metodo para añadir al  arreglo de heroes comrpados
  function HeroeComprado(key,indice,valor){
    this.CampeonesComprados[indice]=valor;
    añañadirLocalStorage(key,CampeonesComprados);
  }
}

//devuelve valor de la lla
function obtenerLocalStorage (key){
  var valor;
  valor=JSON.parse(localStorage.getItem(key));
  return valor;
}
