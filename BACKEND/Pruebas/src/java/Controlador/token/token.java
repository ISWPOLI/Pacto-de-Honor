/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.token;

import java.util.Random;
import java.util.UUID;


/**
 *
 * @author JERR
 */
public class token {
    String token="";
    UUID tokenUUID;

    public token(UUID tokenUUID) {
        this.tokenUUID = tokenUUID;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public UUID getTokenUUID() {
        return tokenUUID;
    }

    public void setTokenUUID(UUID tokenUUID) {
        this.tokenUUID = tokenUUID;
    }
    
    
    public token() {
    }
    
    
    
String  getCadenaAlfanumAleatoria (int longitud){

// obtengo milisegundos para generar el Ramdon y no depender rangos 
long milis = new java.util.GregorianCalendar().getTimeInMillis();
    System.out.println(milis);
Random r = new Random(100);// aleatoriedad
System.out.println(r);
int i = 0;
while ( i < longitud){ // segun la longitud que no puede ser < 0
char c = (char)r.nextInt(255);//se generan caracteres
if ( (c >= '0' && c <='9') || (c >='A' && c <='Z') ){ //validando numeros o letras
token += c;// los guardo en token
i ++;
}
}
return token;//devuelvo el token
}    

/**UUID identificador único universal # 128 bit*
 * representación textual canónica los dieciséis octetos de un UUID se representan como 32
 * hexadecimal (base 16) dígitos  8-4-4-4-12 */


    public static void main(String[] args) {
        token token1=new token();
        String token =token1.getCadenaAlfanumAleatoria (16);
        
        UUID TokenUuid= UUID.randomUUID();
        System.out.println(token);
        System.out.println(UUID.randomUUID());
        System.out.println();
    }


}
