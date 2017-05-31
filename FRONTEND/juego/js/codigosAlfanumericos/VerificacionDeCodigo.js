
//Validacon de String, ya implementada en "desbloqueo de personajes"

document.write(validarString("3AC40-RF34P"));

function validarString (cadenaAnalizar) {
    if(cadenaAnalizar.length!=11){
        return alert("Tu codigo de regalo tiene mas o menos de 11 digitos por favor verificalo");
    }
    var mapnumeros1 = new Array();
    for(var i = 1; i <= 8 ; i++){
        mapnumeros1[i]=true;
    }
    var string ="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var mapletras1 = new Array();
    for(var i = 0 ; i <= string.length; i++){
        mapletras1[string.substr(i,1)]=true;
    }
    
  
    
     for(var i = 0; i < cadenaAnalizar.length ; i++){
        if(i==0 && mapnumeros1[cadenaAnalizar.substr(i,1)]==undefined){
            return alert("Tu codigo esta mal escrito o no existe");;
        }else if(((i>=1 && i<=4)||(i>=6 && i<=9)) && mapletras1[cadenaAnalizar.substr(i,1)]==undefined){
            return alert("Tu codigo esta mal escrito o no existe");;
        }else if(i==5 && cadenaAnalizar.substr(i,1)!="-"){
            return alert("Tu codigo esta mal escrito o no existe");;
        }else if(i==10 && (cadenaAnalizar.substr(i,1)!="E"&&cadenaAnalizar.substr(i,1)!="P")){
            return alert("Tu codigo esta mal escrito o no existe");
        }
    }
    return alert("Has desbloqueado a tu personaje con exito");
}  