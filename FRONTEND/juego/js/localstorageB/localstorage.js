//Carga y validacion inicial de datos de perfil
var mundoMayor=1;
var nivelMundoMayor=1;
//arreglo niveles de campeones
var Npersonaje = [0,0,0,0,0,0,0,0,0];
//arreglo campeones comprados
var CampeonesComprados = [true, false,false ,false , false,false ,false ,false,false ];//arreglo que copia al localStorage
var NpersonajeLocalS = [0,0,0,0,0,0,0,0,0];//arreglo que copia al localStorage
//arreglo campeones comprados
var CampeonesCompradosLocalS = [true, false,false ,false , false,false ,false ,false,false ];
function cargaInicial(){
//Verificacion de local storage si esta vacio
  if(localStorage.length!=0){
    mundoMayor=parseInt(obtenerLocalStorage("Mundo"));
    nivelMundoMayor=parseInt(obtenerLocalStorage("NivelMundo"));
    datosperfil.monedas = obtenerLocalStorage('Oro');
    datosperfil.experiencia = obtenerLocalStorage("Xp");
    var llave =utf8_to_b64("NivelPersonajes");
    var temp=localStorage.getItem(llave);
    Npersonaje=verificarArreglo(temp,Npersonaje);
    var llavec =utf8_to_b64("CampeonesComprados");
    var tempc=localStorage.getItem(llavec);
    variablesCompraPersonajes.comprado = CampeonesComprados=verificarArregloBoleaano(tempc,CampeonesComprados);
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
       añadirLocalStorage("Nickname",variablesPerfilJugador.NicknamePerfil);
       añadirLocalStorage("Xp",variablesPerfilJugador.ExperienciaPerfil);
       añadirLocalStorage("Oro",variablesPerfilJugador.MonedasPerfil);
       añadirLocalStorage("NivelMundo",1);
       añadirLocalStorage("NivelPersonaje",variablesPerfilJugador.NivelPerfil);
       añadirLocalStorage("Mundo",1);
       for (var i = 0; i < Npersonaje.length; i++) {

         var tempNp= Npersonaje[i];
         var tempCC= CampeonesComprados[i];

         NpersonajeLocalS[i]=utf8_to_b64(tempNp);
         CampeonesCompradosLocalS[i]=utf8_to_b64(tempCC);
       }

       localStorage.setItem(utf8_to_b64("NivelPersonajes"), JSON.stringify(NpersonajeLocalS));
       localStorage.setItem(utf8_to_b64("CampeonesComprados"), JSON.stringify(CampeonesCompradosLocalS));

     }
    }
//Metodo encargado de decodificar el arreglo de nivelesExp y copiarlo al arreglo de clase
function verificarArreglo(arregloCodificado,arreglo) {
var tempalfabeto="";
var posarreglo=0;

for (var i = 0; i <= arregloCodificado.length; i++) {
  var caracter = arregloCodificado.charAt(i);
    if(caracter=='['){
      continue;
      }
      else{
        if(arregloCodificado.charAt(i)==',' || caracter==']'){
          if(caracter==']'){
              arreglo[posarreglo]=tempalfabeto;
              break;
            }
            else{
              arreglo[posarreglo]=tempalfabeto;
              tempalfabeto="";
              posarreglo=posarreglo+1;
            }
          }
    else{
      tempalfabeto=tempalfabeto+caracter;
        }
      }
    }
  for (var i = 0; i < arreglo.length; i++) {
    var temp=JSON.parse(arreglo[i]);
    var temp2=b64_to_utf8(temp);
    arreglo[i]=parseInt(temp2);
  }

  return arreglo;
}
//Metodo encargado de decodificar el arreglo de campeones y copiarlo al arreglo de clase
function verificarArregloBoleaano(arregloCodificado,arreglo) {
  var tempalfabeto="";
  var posarreglo=0;
  var arregloCopia= [0,0,0,0,0,0,0,0,0];

  for (var i = 0; i <= arregloCodificado.length; i++) {
  var caracter = arregloCodificado.charAt(i);
    if(caracter=='['){
    continue;
    }
    else{
      if(arregloCodificado.charAt(i)==',' || caracter==']'){
        if(caracter==']'){
          arregloCopia[posarreglo]=tempalfabeto;
          break;
        }
        else{
          arregloCopia[posarreglo]=tempalfabeto;
          tempalfabeto="";
          posarreglo=posarreglo+1;
        }
    }
    else{
        tempalfabeto=tempalfabeto+caracter;
        }
      }
    }
    for (var i = 0; i < arregloCopia.length; i++) {
      var temp=JSON.parse(arregloCopia[i]);
      var temp2=b64_to_utf8(temp);
      arregloCopia[i]=temp2;
        if(arregloCopia[i]=="true"){
          CampeonesComprados[i]=true;

        }
        else{
          CampeonesComprados[i]=false;
        }
    }


    return CampeonesComprados;
}
//Funcion que permite almacenar cualquier valor en el localstorage recibiendo la llave y su valor
function añadirLocalStorage(key, valor) {
  if(key=='NivelPersonajes' || key=='CampeonesComprados'){
  if(key=='NivelPersonajes' ){
    Npersonaje=valor;
    for (var i = 0; i < Npersonaje.length; i++) {
      var tempd=Npersonaje[i];
       NpersonajeLocalS[i]=utf8_to_b64(Npersonaje[i]);
      Npersonaje[i]=tempd;
    }
    var llave =utf8_to_b64(key);
    localStorage.setItem(llave, JSON.stringify(NpersonajeLocalS));
  }
  else{
    compraPersonajes=valor;
    for (var i = 0; i < compraPersonajes.length; i++) {
      var tempd=compraPersonajes[i];
       CampeonesCompradosLocalS[i]=utf8_to_b64(compraPersonajes[i]);
      compraPersonajes[i]=tempd;
    }
    var llave =utf8_to_b64(key);
    localStorage.setItem(llave, JSON.stringify(CampeonesCompradosLocalS));
  }

  }
    else {
      var llave =utf8_to_b64(key);
      var Valor =utf8_to_b64(valor);
      localStorage.setItem(llave, JSON.stringify(Valor));
  }
}

function utf8_to_b64( str ) {
  var a = window.btoa(unescape(encodeURIComponent( str )));
  return a;
}

function b64_to_utf8( str ) {
  var a =decodeURIComponent(escape(window.atob( str )));
return a;
}

//funcion encargada de dar al localStorage el mundo y nivel actual si gana
function nivelMundoLocalStorage(nivelo,validacion){

  if(validacion==0){

    var orotemp=parseInt(obtenerLocalStorage("Oro"));
    var xptemp=parseInt(obtenerLocalStorage("Xp"));
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
  if(nivelo.length>3){
    var temp="1"+mundo;
    mundo=temp;

    añadirLocalStorage("Oro",orotemp);
    añadirLocalStorage("Xp",xptemp);

    validarMundoyNivelMayor(nivel,mundo);
  }
  else{
    añadirLocalStorage("Oro",orotemp);
    añadirLocalStorage("Xp",xptemp);

    validarMundoyNivelMayor(nivel,mundo);
  }

  }
  else {
      var xptemp=parseInt(obtenerLocalStorage("Xp"));
    xptemp+=10;
    añadirLocalStorage("Xp",xptemp);
  }
}
//Se validan los niveles y mundo actualizando a el mayor
function validarMundoyNivelMayor(nivelactual,mundoactual){
  //caso base que permite avanzar de nivel 5 de x mundo al siguiente restableciendo nivel mayor a 1 del siguiente mundo
  if(nivelactual==5 && mundoMayor==mundoactual){

    this.nivelMundoMayor=1;
    this.mundoMayor=mundoMayor+1;
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
  var llave =utf8_to_b64(key);
  var valorf;
  var retorno=0;
  var valor =localStorage.getItem(llave);
  valorf=JSON.parse(localStorage.getItem(llave));

  try {
    if(valorf==null){
    //
    }
    else{
      if(key=='NivelPersonajes'){

          retorno=this.Npersonaje;
      }
      else if (key=='CampeonesComprados'){

          retorno=this.CampeonesComprados;
      }
      else{
      retorno =b64_to_utf8(valorf);
        }
    }
    
    }
    catch(err) {

        alert("EN DONDE ESTA TU HONOR?");
    }

return retorno;
}
