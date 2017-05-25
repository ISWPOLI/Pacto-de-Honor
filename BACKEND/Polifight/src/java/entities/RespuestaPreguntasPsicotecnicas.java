/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ahsierra
 */
@Entity
@Table(name = "respuesta_preguntas_psicotecnicas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RespuestaPreguntasPsicotecnicas.findAll", query = "SELECT r FROM RespuestaPreguntasPsicotecnicas r"),
    @NamedQuery(name = "RespuestaPreguntasPsicotecnicas.findByIdPreguntaPruebaPsicotecnica", query = "SELECT r FROM RespuestaPreguntasPsicotecnicas r WHERE r.respuestaPreguntasPsicotecnicasPK.idPreguntaPruebaPsicotecnica = :idPreguntaPruebaPsicotecnica"),
    @NamedQuery(name = "RespuestaPreguntasPsicotecnicas.findByIdRespuestaPsicotecnica", query = "SELECT r FROM RespuestaPreguntasPsicotecnicas r WHERE r.respuestaPreguntasPsicotecnicasPK.idRespuestaPsicotecnica = :idRespuestaPsicotecnica"),
    @NamedQuery(name = "RespuestaPreguntasPsicotecnicas.findByDescripcionPruebaPsicotecnica", query = "SELECT r FROM RespuestaPreguntasPsicotecnicas r WHERE r.descripcionPruebaPsicotecnica = :descripcionPruebaPsicotecnica")})
public class RespuestaPreguntasPsicotecnicas implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected RespuestaPreguntasPsicotecnicasPK respuestaPreguntasPsicotecnicasPK;
    @Size(max = 255)
    @Column(name = "descripcion_prueba_psicotecnica")
    private int idFactor;
    private String descripcionPruebaPsicotecnica;

    public RespuestaPreguntasPsicotecnicas() {
    }

    public RespuestaPreguntasPsicotecnicas(RespuestaPreguntasPsicotecnicasPK respuestaPreguntasPsicotecnicasPK) {
        this.respuestaPreguntasPsicotecnicasPK = respuestaPreguntasPsicotecnicasPK;
    }

    public RespuestaPreguntasPsicotecnicas(int idPreguntaPruebaPsicotecnica, int idRespuestaPsicotecnica) {
        this.respuestaPreguntasPsicotecnicasPK = new RespuestaPreguntasPsicotecnicasPK(idPreguntaPruebaPsicotecnica, idRespuestaPsicotecnica);
    }

    public RespuestaPreguntasPsicotecnicasPK getRespuestaPreguntasPsicotecnicasPK() {
        return respuestaPreguntasPsicotecnicasPK;
    }

    public void setRespuestaPreguntasPsicotecnicasPK(RespuestaPreguntasPsicotecnicasPK respuestaPreguntasPsicotecnicasPK) {
        this.respuestaPreguntasPsicotecnicasPK = respuestaPreguntasPsicotecnicasPK;
    }

    public String getDescripcionPruebaPsicotecnica() {
        return descripcionPruebaPsicotecnica;
    }

    public void setDescripcionPruebaPsicotecnica(String descripcionPruebaPsicotecnica) {
        this.descripcionPruebaPsicotecnica = descripcionPruebaPsicotecnica;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (respuestaPreguntasPsicotecnicasPK != null ? respuestaPreguntasPsicotecnicasPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RespuestaPreguntasPsicotecnicas)) {
            return false;
        }
        RespuestaPreguntasPsicotecnicas other = (RespuestaPreguntasPsicotecnicas) object;
        if ((this.respuestaPreguntasPsicotecnicasPK == null && other.respuestaPreguntasPsicotecnicasPK != null) || (this.respuestaPreguntasPsicotecnicasPK != null && !this.respuestaPreguntasPsicotecnicasPK.equals(other.respuestaPreguntasPsicotecnicasPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.RespuestaPreguntasPsicotecnicas[ respuestaPreguntasPsicotecnicasPK=" + respuestaPreguntasPsicotecnicasPK + " ]";
    }
    public void setIdFactor(int idFactor) {
        this.idFactor = idFactor;
    }
    public int getIdFactor() {
        return idFactor;
    }
    
}
