/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Will
 */
@Embeddable
public class LogPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_log", nullable = false)
    private int idLog;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_jugador", nullable = false)
    private int idJugador;

    public LogPK() {
    }

    public LogPK(int idLog, int idJugador) {
        this.idLog = idLog;
        this.idJugador = idJugador;
    }

    public int getIdLog() {
        return idLog;
    }

    public void setIdLog(int idLog) {
        this.idLog = idLog;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idLog;
        hash += (int) idJugador;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LogPK)) {
            return false;
        }
        LogPK other = (LogPK) object;
        if (this.idLog != other.idLog) {
            return false;
        }
        if (this.idJugador != other.idJugador) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.LogPK[ idLog=" + idLog + ", idJugador=" + idJugador + " ]";
    }
    
}
