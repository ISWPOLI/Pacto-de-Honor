package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entidad para la tabla Log
 * Se realiza a mano
 * @author jrubiaob
 */
@Entity
@Table(name="log")
public class Log implements Serializable {
    
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Basic(optional = false)
   @Column(name = "id_log")
   protected int idLog;
     
   @Column(name="id_jugador")
   private int idJugador;
   
   @Column(name="tiempo_log")
   private String tiempo;
   
   @Column(name="fecha_inicio")
   private String fechaInicio;
   
   @Column(name="fecha_final")
   private String fechaFinal;

    public int getIdUsuario() {
        return idLog;
    }

    public void setIdUsuario(int idLog) {
        this.idLog = idLog;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    public String getTiempo() {
        return tiempo;
    }

    public void setTiempo(String tiempo) {
        this.tiempo = tiempo;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(String fechaFinal) {
        this.fechaFinal = fechaFinal;
    }
   
   
   
}