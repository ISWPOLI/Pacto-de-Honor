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
 *
 * @author jrubiaob
 */
public class FechaActual {
    
    public static String timestamp(){
        Date date = new Date();
        DateFormat hourDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return hourDateFormat.format(date);
    }
}
