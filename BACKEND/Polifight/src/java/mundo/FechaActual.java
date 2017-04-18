/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mundo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Clase que contiene los métodos para las fechas
 * @author jrubiaob
 */
public class FechaActual {
    
   private static Date date = new Date();
	
   /**
    * Genera la fecha y hora actual
    * @return 
    */
    public static String timestamp(){
        DateFormat hourdateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss ");
        return hourdateFormat.format(date);
    }
	
    /**
     * Genera la hora y fecha para concatener al token
     * @return String con la fecha y hora sin espacios
     */
    public static String timeToken(){
        DateFormat hourDateFormat = new SimpleDateFormat("ddMMyyHHmmss");
        return hourDateFormat.format(date);
    }
}
