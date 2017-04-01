/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.poli.entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "pregunta_psicotecnica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PreguntaPsicotecnica.findAll", query = "SELECT p FROM PreguntaPsicotecnica p"),
    @NamedQuery(name = "PreguntaPsicotecnica.findByIdPreguntaPsicotecnica", query = "SELECT p FROM PreguntaPsicotecnica p WHERE p.preguntaPsicotecnicaPK.idPreguntaPsicotecnica = :idPreguntaPsicotecnica"),
    @NamedQuery(name = "PreguntaPsicotecnica.findByIdRespuestaPsicotecnica", query = "SELECT p FROM PreguntaPsicotecnica p WHERE p.preguntaPsicotecnicaPK.idRespuestaPsicotecnica = :idRespuestaPsicotecnica"),
    @NamedQuery(name = "PreguntaPsicotecnica.findByIdTipoPreguntaPsicotecnica", query = "SELECT p FROM PreguntaPsicotecnica p WHERE p.preguntaPsicotecnicaPK.idTipoPreguntaPsicotecnica = :idTipoPreguntaPsicotecnica"),
    @NamedQuery(name = "PreguntaPsicotecnica.findByDescripcionPruebaPsicotecnica", query = "SELECT p FROM PreguntaPsicotecnica p WHERE p.descripcionPruebaPsicotecnica = :descripcionPruebaPsicotecnica")})
public class PreguntaPsicotecnica implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @EmbeddedId
    protected PreguntaPsicotecnicaPK preguntaPsicotecnicaPK;
    
    @Size(max = 255)
    @Column(name = "descripcion_prueba_psicotecnica")
    private String descripcionPruebaPsicotecnica;
    
    @JoinColumn(name = "id_respuesta_psicotecnica", referencedColumnName = "id_respuesta_psicotecnica", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private RespuestaPsicotecnica respuestaPsicotecnica;
    
    @JoinColumn(name = "id_tipo_pregunta_psicotecnica", referencedColumnName = "id_tipo_pregunta_psicotecnica", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private TipoPreguntaPsicotecnica tipoPreguntaPsicotecnica;

    public PreguntaPsicotecnica() {
    }

    public PreguntaPsicotecnica(PreguntaPsicotecnicaPK preguntaPsicotecnicaPK) {
        this.preguntaPsicotecnicaPK = preguntaPsicotecnicaPK;
    }

    public PreguntaPsicotecnica(int idPreguntaPsicotecnica, int idRespuestaPsicotecnica, int idTipoPreguntaPsicotecnica) {
        this.preguntaPsicotecnicaPK = new PreguntaPsicotecnicaPK(idPreguntaPsicotecnica, idRespuestaPsicotecnica, idTipoPreguntaPsicotecnica);
    }

    public PreguntaPsicotecnicaPK getPreguntaPsicotecnicaPK() {
        return preguntaPsicotecnicaPK;
    }

    public void setPreguntaPsicotecnicaPK(PreguntaPsicotecnicaPK preguntaPsicotecnicaPK) {
        this.preguntaPsicotecnicaPK = preguntaPsicotecnicaPK;
    }

    public String getDescripcionPruebaPsicotecnica() {
        return descripcionPruebaPsicotecnica;
    }

    public void setDescripcionPruebaPsicotecnica(String descripcionPruebaPsicotecnica) {
        this.descripcionPruebaPsicotecnica = descripcionPruebaPsicotecnica;
    }
    
    public RespuestaPsicotecnica getRespuestaPsicotecnica() {
        return respuestaPsicotecnica;
    }

    public void setRespuestaPsicotecnica(RespuestaPsicotecnica respuestaPsicotecnica) {
        this.respuestaPsicotecnica = respuestaPsicotecnica;
    }

    public TipoPreguntaPsicotecnica getTipoPreguntaPsicotecnica() {
        return tipoPreguntaPsicotecnica;
    }

    public void setTipoPreguntaPsicotecnica(TipoPreguntaPsicotecnica tipoPreguntaPsicotecnica) {
        this.tipoPreguntaPsicotecnica = tipoPreguntaPsicotecnica;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (preguntaPsicotecnicaPK != null ? preguntaPsicotecnicaPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PreguntaPsicotecnica)) {
            return false;
        }
        PreguntaPsicotecnica other = (PreguntaPsicotecnica) object;
        if ((this.preguntaPsicotecnicaPK == null && other.preguntaPsicotecnicaPK != null) || (this.preguntaPsicotecnicaPK != null && !this.preguntaPsicotecnicaPK.equals(other.preguntaPsicotecnicaPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.PreguntaPsicotecnica[ preguntaPsicotecnicaPK=" + preguntaPsicotecnicaPK + " ]";
    }
    
}
