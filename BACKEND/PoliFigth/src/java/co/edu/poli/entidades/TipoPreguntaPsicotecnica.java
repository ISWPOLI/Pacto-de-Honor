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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "tipo_pregunta_psicotecnica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoPreguntaPsicotecnica.findAll", query = "SELECT t FROM TipoPreguntaPsicotecnica t"),
    @NamedQuery(name = "TipoPreguntaPsicotecnica.findByIdTipoPreguntaPsicotecnica", query = "SELECT t FROM TipoPreguntaPsicotecnica t WHERE t.idTipoPreguntaPsicotecnica = :idTipoPreguntaPsicotecnica"),
    @NamedQuery(name = "TipoPreguntaPsicotecnica.findByClasePregunta", query = "SELECT t FROM TipoPreguntaPsicotecnica t WHERE t.clasePregunta = :clasePregunta")})
public class TipoPreguntaPsicotecnica implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_pregunta_psicotecnica")
    private Integer idTipoPreguntaPsicotecnica;
    @Column(name = "clase_pregunta")
    private Integer clasePregunta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tipoPreguntaPsicotecnica")
    private List<PreguntaPsicotecnica> preguntaPsicotecnicaList;

    public TipoPreguntaPsicotecnica() {
    }

    public TipoPreguntaPsicotecnica(Integer idTipoPreguntaPsicotecnica) {
        this.idTipoPreguntaPsicotecnica = idTipoPreguntaPsicotecnica;
    }

    public Integer getIdTipoPreguntaPsicotecnica() {
        return idTipoPreguntaPsicotecnica;
    }

    public void setIdTipoPreguntaPsicotecnica(Integer idTipoPreguntaPsicotecnica) {
        this.idTipoPreguntaPsicotecnica = idTipoPreguntaPsicotecnica;
    }

    public Integer getClasePregunta() {
        return clasePregunta;
    }

    public void setClasePregunta(Integer clasePregunta) {
        this.clasePregunta = clasePregunta;
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
        hash += (idTipoPreguntaPsicotecnica != null ? idTipoPreguntaPsicotecnica.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoPreguntaPsicotecnica)) {
            return false;
        }
        TipoPreguntaPsicotecnica other = (TipoPreguntaPsicotecnica) object;
        if ((this.idTipoPreguntaPsicotecnica == null && other.idTipoPreguntaPsicotecnica != null) || (this.idTipoPreguntaPsicotecnica != null && !this.idTipoPreguntaPsicotecnica.equals(other.idTipoPreguntaPsicotecnica))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.TipoPreguntaPsicotecnica[ idTipoPreguntaPsicotecnica=" + idTipoPreguntaPsicotecnica + " ]";
    }
    
}
