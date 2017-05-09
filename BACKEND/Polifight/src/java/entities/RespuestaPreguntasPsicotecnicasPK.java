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
public class RespuestaPreguntasPsicotecnicasPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_pregunta_prueba_psicotecnica")
    private int idPreguntaPruebaPsicotecnica;
    @Basic(optional = false)
    @Column(name = "id_respuesta_psicotecnica")
    private int idRespuestaPsicotecnica;

    public RespuestaPreguntasPsicotecnicasPK() {
    }

    public RespuestaPreguntasPsicotecnicasPK(int idPreguntaPruebaPsicotecnica, int idRespuestaPsicotecnica) {
        this.idPreguntaPruebaPsicotecnica = idPreguntaPruebaPsicotecnica;
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
    }

    public int getIdPreguntaPruebaPsicotecnica() {
        return idPreguntaPruebaPsicotecnica;
    }

    public void setIdPreguntaPruebaPsicotecnica(int idPreguntaPruebaPsicotecnica) {
        this.idPreguntaPruebaPsicotecnica = idPreguntaPruebaPsicotecnica;
    }

    public int getIdRespuestaPsicotecnica() {
        return idRespuestaPsicotecnica;
    }

    public void setIdRespuestaPsicotecnica(int idRespuestaPsicotecnica) {
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idPreguntaPruebaPsicotecnica;
        hash += (int) idRespuestaPsicotecnica;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RespuestaPreguntasPsicotecnicasPK)) {
            return false;
        }
        RespuestaPreguntasPsicotecnicasPK other = (RespuestaPreguntasPsicotecnicasPK) object;
        if (this.idPreguntaPruebaPsicotecnica != other.idPreguntaPruebaPsicotecnica) {
            return false;
        }
        if (this.idRespuestaPsicotecnica != other.idRespuestaPsicotecnica) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.RespuestaPreguntasPsicotecnicasPK[ idPreguntaPruebaPsicotecnica=" + idPreguntaPruebaPsicotecnica + ", idRespuestaPsicotecnica=" + idRespuestaPsicotecnica + " ]";
    }
    
}
