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
public class NivelPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_nivel", nullable = false)
    private int idNivel;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_mundo", nullable = false)
    private int idMundo;

    public NivelPK() {
    }

    public NivelPK(int idNivel, int idMundo) {
        this.idNivel = idNivel;
        this.idMundo = idMundo;
    }

    public int getIdNivel() {
        return idNivel;
    }

    public void setIdNivel(int idNivel) {
        this.idNivel = idNivel;
    }

    public int getIdMundo() {
        return idMundo;
    }

    public void setIdMundo(int idMundo) {
        this.idMundo = idMundo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idNivel;
        hash += (int) idMundo;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof NivelPK)) {
            return false;
        }
        NivelPK other = (NivelPK) object;
        if (this.idNivel != other.idNivel) {
            return false;
        }
        if (this.idMundo != other.idMundo) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.NivelPK[ idNivel=" + idNivel + ", idMundo=" + idMundo + " ]";
    }
    
}
