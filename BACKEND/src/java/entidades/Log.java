/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "log")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Log.findAll", query = "SELECT l FROM Log l"),
    @NamedQuery(name = "Log.findByIdLog", query = "SELECT l FROM Log l WHERE l.logPK.idLog = :idLog"),
    @NamedQuery(name = "Log.findByIdJugador", query = "SELECT l FROM Log l WHERE l.logPK.idJugador = :idJugador"),
    @NamedQuery(name = "Log.findByTiempoLog", query = "SELECT l FROM Log l WHERE l.tiempoLog = :tiempoLog"),
    @NamedQuery(name = "Log.findByFechaInicio", query = "SELECT l FROM Log l WHERE l.fechaInicio = :fechaInicio"),
    @NamedQuery(name = "Log.findByFechaFinal", query = "SELECT l FROM Log l WHERE l.fechaFinal = :fechaFinal")})
public class Log implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected LogPK logPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "tiempo_log")
    @Temporal(TemporalType.TIME)
    private Date tiempoLog;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_inicio")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaInicio;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_final")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaFinal;
    @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Jugador jugador;

    public Log() {
    }

    public Log(LogPK logPK) {
        this.logPK = logPK;
    }

    public Log(LogPK logPK, Date tiempoLog, Date fechaInicio, Date fechaFinal) {
        this.logPK = logPK;
        this.tiempoLog = tiempoLog;
        this.fechaInicio = fechaInicio;
        this.fechaFinal = fechaFinal;
    }

    public Log(int idLog, int idJugador) {
        this.logPK = new LogPK(idLog, idJugador);
    }

    public LogPK getLogPK() {
        return logPK;
    }

    public void setLogPK(LogPK logPK) {
        this.logPK = logPK;
    }

    public Date getTiempoLog() {
        return tiempoLog;
    }

    public void setTiempoLog(Date tiempoLog) {
        this.tiempoLog = tiempoLog;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        this.fechaFinal = fechaFinal;
    }

    public Jugador getJugador() {
        return jugador;
    }

    public void setJugador(Jugador jugador) {
        this.jugador = jugador;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (logPK != null ? logPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Log)) {
            return false;
        }
        Log other = (Log) object;
        if ((this.logPK == null && other.logPK != null) || (this.logPK != null && !this.logPK.equals(other.logPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Log[ logPK=" + logPK + " ]";
    }
    
}
