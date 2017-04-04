/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.edu.poli.entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "respuesta_psicotecnica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RespuestaPsicotecnica.findAll", query = "SELECT r FROM RespuestaPsicotecnica r"),
    @NamedQuery(name = "RespuestaPsicotecnica.findByIdRespuestaPsicotecnica", query = "SELECT r FROM RespuestaPsicotecnica r WHERE r.idRespuestaPsicotecnica = :idRespuestaPsicotecnica"),
    @NamedQuery(name = "RespuestaPsicotecnica.findByDescripcionPruebaPsicotecnica", query = "SELECT r FROM RespuestaPsicotecnica r WHERE r.descripcionPruebaPsicotecnica = :descripcionPruebaPsicotecnica")})
public class RespuestaPsicotecnica implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_respuesta_psicotecnica")
    private Integer idRespuestaPsicotecnica;
    @Size(max = 255)
    @Column(name = "descripcion_prueba_psicotecnica")
    private String descripcionPruebaPsicotecnica;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "respuestaPsicotecnica")
    private List<PreguntaPsicotecnica> preguntaPsicotecnicaList;

    public RespuestaPsicotecnica() {
    }

    public RespuestaPsicotecnica(Integer idRespuestaPsicotecnica) {
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
    }

    public Integer getIdRespuestaPsicotecnica() {
        return idRespuestaPsicotecnica;
    }

    public void setIdRespuestaPsicotecnica(Integer idRespuestaPsicotecnica) {
        this.idRespuestaPsicotecnica = idRespuestaPsicotecnica;
    }

    public String getDescripcionPruebaPsicotecnica() {
        return descripcionPruebaPsicotecnica;
    }

    public void setDescripcionPruebaPsicotecnica(String descripcionPruebaPsicotecnica) {
        this.descripcionPruebaPsicotecnica = descripcionPruebaPsicotecnica;
    }

    @XmlTransient
    public List<PreguntaPsicotecnica> getPreguntaPsicotecnicaList() {
        return preguntaPsicotecnicaList;
    }

    public void setPreguntaPsicotecnicaList(List<PreguntaPsicotecnica> preguntaPsicotecnicaList) {
        this.preguntaPsicotecnicaList = preguntaPsicotecnicaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRespuestaPsicotecnica != null ? idRespuestaPsicotecnica.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RespuestaPsicotecnica)) {
            return false;
        }
        RespuestaPsicotecnica other = (RespuestaPsicotecnica) object;
        if ((this.idRespuestaPsicotecnica == null && other.idRespuestaPsicotecnica != null) || (this.idRespuestaPsicotecnica != null && !this.idRespuestaPsicotecnica.equals(other.idRespuestaPsicotecnica))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.RespuestaPsicotecnica[ idRespuestaPsicotecnica=" + idRespuestaPsicotecnica + " ]";
    }
    
}
