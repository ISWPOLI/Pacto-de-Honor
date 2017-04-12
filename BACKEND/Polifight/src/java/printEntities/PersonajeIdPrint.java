/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package printEntities;

/**
 *
 * @author jrubiaob
 */
public class PersonajeIdPrint {
    
    private int idPersonaje;
    private String nombrePersonaje;

    public PersonajeIdPrint(int idPersonaje, String nombrePersonaje) {
        this.idPersonaje = idPersonaje;
        this.nombrePersonaje = nombrePersonaje;
    }
    
    

    public int getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(int idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    public String getNombrePersonaje() {
        return nombrePersonaje;
    }

    public void setNombrePersonaje(String nombrePersonaje) {
        this.nombrePersonaje = nombrePersonaje;
    }
    
    
}
