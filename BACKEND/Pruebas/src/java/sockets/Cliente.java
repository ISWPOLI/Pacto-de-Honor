/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sockets;

/**
  * @author JERR
 */
import java.io.DataOutputStream;
import java.io.IOException;

/**
 Hereda de conexión para hacer uso de los sockets
 * Espera la conexion del cliente por el puerto 8080 con metodo accept
 * Envia mensade confirmacion y Recepcion de mensajes enviados por cliente
 * y publicacion, cierre de conexión.
 */
public class Cliente extends Conexion
{
    //Se usa el constructor para cliente de Conexion
    public Cliente() throws IOException{super("cliente");} 

    public void startClient() //iniciar el cliente
    {
        try
        {            
            //Flujo de datos hacia el servidor
            salidaServidor = new DataOutputStream(cs.getOutputStream());

            //Envio dos mensajes
            for (int i = 0; i < 2; i++)
            {
                //Se escribe en el servidor con el su flujo de datos
                salidaServidor.writeUTF("Este es el mensaje número " + (i+1) + "\n");                
            }           

            cs.close();//Fin de la conexión

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}