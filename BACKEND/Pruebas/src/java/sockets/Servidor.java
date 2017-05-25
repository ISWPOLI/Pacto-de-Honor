/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sockets;

/**
 * @author JERR
 */
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import sockets.Conexion;

/**
 Hereda de conexión para hacer uso de los sockets y establece conexion con servidor
 * Envia los mensajes el servidor los recibe y ciera la conexion.
 */

public class Servidor extends Conexion 

        
{
    public Servidor() throws IOException{super("servidor");} //Se usa el constructor para servidor de Conexion

    public void startServer()//iniciar el servidor
    {
        try
        {
            System.out.println("Esperando..."); //Esperando conexión

            cs = ss.accept(); //Accept inicia el socket y espera una conexión desde cliente.

            System.out.println("Cliente en línea");

            //Flujo de salida del cliente para enviarle mensajes
            salidaCliente = new DataOutputStream(cs.getOutputStream());

            //Envío un mensaje al cliente usando su flujo de salida
            salidaCliente.writeUTF("Petición recibida y aceptada");
            
            //Flujo entrante desde el cliente get en entrada
            BufferedReader entrada = new BufferedReader(new InputStreamReader(cs.getInputStream()));
            
            while((mensajeServidor = entrada.readLine()) != null) //Mientras el cliente emita mensajes
            {
                //Se publica el mensaje recibido
                System.out.println(mensajeServidor);
            }
            
            System.out.println("Fin de la conexión");
            
            ss.close();//Se finaliza la conexión con el cliente
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}
    