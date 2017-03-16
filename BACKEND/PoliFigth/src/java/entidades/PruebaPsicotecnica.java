/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
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
@Table(name = "prueba_psicotecnica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PruebaPsicotecnica.findAll", query = "SELECT p FROM PruebaPsicotecnica p"),
    @NamedQuery(name = "PruebaPsicotecnica.findByIdPruebaPsicotecnica", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.idPruebaPsicotecnica = :idPruebaPsicotecnica"),
    @NamedQuery(name = "PruebaPsicotecnica.findByDescripcionPruebaPsicotecnica", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.descripcionPruebaPsicotecnica = :descripcionPruebaPsicotecnica")})
public class PruebaPsicotecnica implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_prueba_psicotecnica")
    private Integer idPruebaPsicotecnica;
    @Size(max = 255)
    @Column(name = "descripcion_prueba_psicotecnica")
    private String descripcionPruebaPsicotecnica;
    @ManyToMany(mappedBy = "pruebaPsicotecnicaList")
    private List<PreguntaPsicotecnica> preguntaPsicotecnicaList;

    public PruebaPsicotecnica() {
    }

    public PruebaPsicotecnica(Integer idPruebaPsicotecnica) {
        this.idPruebaPsicotecnica = idPruebaPsicotecnica;
    }

    public Integer getIdPruebaPsicotecnica() {
        return idPruebaPsicotecnica;
    }

    public void setIdPruebaPsicotecnica(Integer idPruebaPsicotecnica) {
        this.idPruebaPsicotecnica = idPruebaPsicotecnica;
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
        hash += (idPruebaPsicotecnica != null ? idPruebaPsicotecnica.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PruebaPsicotecnica)) {
            return false;
        }
        PruebaPsicotecnica other = (PruebaPsicotecnica) object;
        if ((this.idPruebaPsicotecnica == null && other.idPruebaPsicotecnica != null) || (this.idPruebaPsicotecnica != null && !this.idPruebaPsicotecnica.equals(other.idPruebaPsicotecnica))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.PruebaPsicotecnica[ idPruebaPsicotecnica=" + idPruebaPsicotecnica + " ]";
    }
    
}
