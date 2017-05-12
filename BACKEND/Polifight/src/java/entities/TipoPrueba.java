package entities;

import java.io.Serializable;
import java.util.Collection;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author ahsierra
 */
@Entity
@Table(name = "tipo_prueba")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoPrueba.findAll", query = "SELECT t FROM TipoPrueba t"),
    @NamedQuery(name = "TipoPrueba.findByIdTipoPrueba", query = "SELECT t FROM TipoPrueba t WHERE t.idTipoPrueba = :idTipoPrueba"),
    @NamedQuery(name = "TipoPrueba.findByTipoPrueba", query = "SELECT t FROM TipoPrueba t WHERE t.tipoPrueba = :tipoPrueba"),
    @NamedQuery(name = "TipoPrueba.findByDescripcionTipoPrueba", query = "SELECT t FROM TipoPrueba t WHERE t.descripcionTipoPrueba = :descripcionTipoPrueba")})
public class TipoPrueba implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_prueba")
    private Integer idTipoPrueba;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "tipo_prueba")
    private String tipoPrueba;
    @Size(max = 255)
    @Column(name = "descripcion_tipo_prueba")
    private String descripcionTipoPrueba;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tipoPrueba")
    private Collection<PruebaPsicotecnica> pruebaPsicotecnicaCollection;

    public TipoPrueba() {
    }

    public TipoPrueba(Integer idTipoPrueba) {
        this.idTipoPrueba = idTipoPrueba;
    }

    public TipoPrueba(Integer idTipoPrueba, String tipoPrueba) {
        this.idTipoPrueba = idTipoPrueba;
        this.tipoPrueba = tipoPrueba;
    }

    public Integer getIdTipoPrueba() {
        return idTipoPrueba;
    }

    public void setIdTipoPrueba(Integer idTipoPrueba) {
        this.idTipoPrueba = idTipoPrueba;
    }

    public String getTipoPrueba() {
        return tipoPrueba;
    }

    public void setTipoPrueba(String tipoPrueba) {
        this.tipoPrueba = tipoPrueba;
    }

    public String getDescripcionTipoPrueba() {
        return descripcionTipoPrueba;
    }

    public void setDescripcionTipoPrueba(String descripcionTipoPrueba) {
        this.descripcionTipoPrueba = descripcionTipoPrueba;
    }

    @XmlTransient
    public Collection<PruebaPsicotecnica> getPruebaPsicotecnicaCollection() {
        return pruebaPsicotecnicaCollection;
    }

    public void setPruebaPsicotecnicaCollection(Collection<PruebaPsicotecnica> pruebaPsicotecnicaCollection) {
        this.pruebaPsicotecnicaCollection = pruebaPsicotecnicaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoPrueba != null ? idTipoPrueba.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoPrueba)) {
            return false;
        }
        TipoPrueba other = (TipoPrueba) object;
        if ((this.idTipoPrueba == null && other.idTipoPrueba != null) || (this.idTipoPrueba != null && !this.idTipoPrueba.equals(other.idTipoPrueba))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.TipoPrueba[ idTipoPrueba=" + idTipoPrueba + " ]";
    }
    
}