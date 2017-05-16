/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author ahsierra
 */
@Embeddable
public class PruebaPsicotecnicaPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_prueba_psicotecnica")
    private int idPruebaPsicotecnica;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_tipo_prueba")
    private int idTipoPrueba;

    public PruebaPsicotecnicaPK() {
    }

    public PruebaPsicotecnicaPK(int idPruebaPsicotecnica, int idTipoPrueba) {
        this.idPruebaPsicotecnica = idPruebaPsicotecnica;
        this.idTipoPrueba = idTipoPrueba;
    }

    public int getIdPruebaPsicotecnica() {
        return idPruebaPsicotecnica;
    }

    public void setIdPruebaPsicotecnica(int idPruebaPsicotecnica) {
        this.idPruebaPsicotecnica = idPruebaPsicotecnica;
    }

    public int getIdTipoPrueba() {
        return idTipoPrueba;
    }

    public void setIdTipoPrueba(int idTipoPrueba) {
        this.idTipoPrueba = idTipoPrueba;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idPruebaPsicotecnica;
        hash += (int) idTipoPrueba;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PruebaPsicotecnicaPK)) {
            return false;
        }
        PruebaPsicotecnicaPK other = (PruebaPsicotecnicaPK) object;
        if (this.idPruebaPsicotecnica != other.idPruebaPsicotecnica) {
            return false;
        }
        if (this.idTipoPrueba != other.idTipoPrueba) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.PruebaPsicotecnicaPK[ idPruebaPsicotecnica=" + idPruebaPsicotecnica + ", idTipoPrueba=" + idTipoPrueba + " ]";
    }
    
}
