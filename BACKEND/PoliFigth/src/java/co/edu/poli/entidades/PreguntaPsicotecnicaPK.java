/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.poli.entidades;

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
public class PreguntaPsicotecnicaPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_pregunta_psicotecnica")
    private int idPreguntaPsicotecnica;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_respuesta_psicotecnica")
    private int idRespuestaPsicotecnica;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_tipo_pregunta_psicotecnica")
    private int idTipoPreguntaPsicotecnica;

    public PreguntaPsicotecnicaPK() {
    }

    public PreguntaPsicotecnicaPK(int idPreguntaPsicotecnica, int idRespuestaPsicotecnica, int idTipoPreguntaPsicotecnica) {
        this.idPreguntaPsicotecnica = idPreguntaPsicotecnica;
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
        this.idTipoPreguntaPsicotecnica = idTipoPreguntaPsicotecnica;
    }

    public int getIdPreguntaPsicotecnica() {
        return idPreguntaPsicotecnica;
    }

    public void setIdPreguntaPsicotecnica(int idPreguntaPsicotecnica) {
        this.idPreguntaPsicotecnica = idPreguntaPsicotecnica;
    }

    public int getIdRespuestaPsicotecnica() {
        return idRespuestaPsicotecnica;
    }

    public void setIdRespuestaPsicotecnica(int idRespuestaPsicotecnica) {
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
    }

    public int getIdTipoPreguntaPsicotecnica() {
        return idTipoPreguntaPsicotecnica;
    }

    public void setIdTipoPreguntaPsicotecnica(int idTipoPreguntaPsicotecnica) {
        this.idTipoPreguntaPsicotecnica = idTipoPreguntaPsicotecnica;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idPreguntaPsicotecnica;
        hash += (int) idRespuestaPsicotecnica;
        hash += (int) idTipoPreguntaPsicotecnica;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PreguntaPsicotecnicaPK)) {
            return false;
        }
        PreguntaPsicotecnicaPK other = (PreguntaPsicotecnicaPK) object;
        if (this.idPreguntaPsicotecnica != other.idPreguntaPsicotecnica) {
            return false;
        }
        if (this.idRespuestaPsicotecnica != other.idRespuestaPsicotecnica) {
            return false;
        }
        if (this.idTipoPreguntaPsicotecnica != other.idTipoPreguntaPsicotecnica) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.PreguntaPsicotecnicaPK[ idPreguntaPsicotecnica=" + idPreguntaPsicotecnica + ", idRespuestaPsicotecnica=" + idRespuestaPsicotecnica + ", idTipoPreguntaPsicotecnica=" + idTipoPreguntaPsicotecnica + " ]";
    }
    
}
