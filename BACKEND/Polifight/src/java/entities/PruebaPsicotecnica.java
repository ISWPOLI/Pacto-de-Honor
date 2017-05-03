package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ahsierra
 */
@Entity
@Table(name = "prueba_psicotecnica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PruebaPsicotecnica.findAll", query = "SELECT p FROM PruebaPsicotecnica p"),
    @NamedQuery(name = "PruebaPsicotecnica.findByIdPruebaPsicotecnica", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.pruebaPsicotecnicaPK.idPruebaPsicotecnica = :idPruebaPsicotecnica"),
    @NamedQuery(name = "PruebaPsicotecnica.findByNombre", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.nombre = :nombre"),
    @NamedQuery(name = "PruebaPsicotecnica.findByFechaCreacion", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.fechaCreacion = :fechaCreacion"),
    @NamedQuery(name = "PruebaPsicotecnica.findByIdTipoPrueba", query = "SELECT p FROM PruebaPsicotecnica p WHERE p.pruebaPsicotecnicaPK.idTipoPrueba = :idTipoPrueba")})
public class PruebaPsicotecnica implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected PruebaPsicotecnicaPK pruebaPsicotecnicaPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_creacion")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaCreacion;
    @JoinColumn(name = "id_tipo_prueba", referencedColumnName = "id_tipo_prueba", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private TipoPrueba tipoPrueba;

    public PruebaPsicotecnica() {
    }

    public PruebaPsicotecnica(PruebaPsicotecnicaPK pruebaPsicotecnicaPK) {
        this.pruebaPsicotecnicaPK = pruebaPsicotecnicaPK;
    }

    public PruebaPsicotecnica(PruebaPsicotecnicaPK pruebaPsicotecnicaPK, String nombre, Date fechaCreacion) {
        this.pruebaPsicotecnicaPK = pruebaPsicotecnicaPK;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
    }

    public PruebaPsicotecnica(int idPruebaPsicotecnica, int idTipoPrueba) {
        this.pruebaPsicotecnicaPK = new PruebaPsicotecnicaPK(idPruebaPsicotecnica, idTipoPrueba);
    }

    public PruebaPsicotecnicaPK getPruebaPsicotecnicaPK() {
        return pruebaPsicotecnicaPK;
    }

    public void setPruebaPsicotecnicaPK(PruebaPsicotecnicaPK pruebaPsicotecnicaPK) {
        this.pruebaPsicotecnicaPK = pruebaPsicotecnicaPK;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public TipoPrueba getTipoPrueba() {
        return tipoPrueba;
    }

    public void setTipoPrueba(TipoPrueba tipoPrueba) {
        this.tipoPrueba = tipoPrueba;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (pruebaPsicotecnicaPK != null ? pruebaPsicotecnicaPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PruebaPsicotecnica)) {
            return false;
        }
        PruebaPsicotecnica other = (PruebaPsicotecnica) object;
        if ((this.pruebaPsicotecnicaPK == null && other.pruebaPsicotecnicaPK != null) || (this.pruebaPsicotecnicaPK != null && !this.pruebaPsicotecnicaPK.equals(other.pruebaPsicotecnicaPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.PruebaPsicotecnica[ pruebaPsicotecnicaPK=" + pruebaPsicotecnicaPK + " ]";
    }
    
}