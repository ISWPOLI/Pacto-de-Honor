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
public class JugadorPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_jugador", nullable = false)
    private int idJugador;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_nivel", nullable = false)
    private int idNivel;

    public JugadorPK() {
    }

    public JugadorPK(int idJugador, int idNivel) {
        this.idJugador = idJugador;
        this.idNivel = idNivel;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    public int getIdNivel() {
        return idNivel;
    }

    public void setIdNivel(int idNivel) {
        this.idNivel = idNivel;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idJugador;
        hash += (int) idNivel;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof JugadorPK)) {
            return false;
        }
        JugadorPK other = (JugadorPK) object;
        if (this.idJugador != other.idJugador) {
            return false;
        }
        if (this.idNivel != other.idNivel) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.JugadorPK[ idJugador=" + idJugador + ", idNivel=" + idNivel + " ]";
    }
    
}
