package Entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "frase")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Frase.findAll", query = "SELECT f FROM Frase f"),
    @NamedQuery(name = "Frase.findByIdFrase", query = "SELECT f FROM Frase f WHERE f.idFrase = :idFrase"),
    @NamedQuery(name = "Frase.findByDescripcion", query = "SELECT f FROM Frase f WHERE f.descripcion = :descripcion")})
public class Frase implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_frase")
    private Integer idFrase;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "descripcion")
    private String descripcion;

    public Frase() {
    }

    public Frase(Integer idFrase) {
        this.idFrase = idFrase;
    }

    public Frase(Integer idFrase, String descripcion) {
        this.idFrase = idFrase;
        this.descripcion = descripcion;
    }

    public Integer getIdFrase() {
        return idFrase;
    }

    public void setIdFrase(Integer idFrase) {
        this.idFrase = idFrase;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFrase != null ? idFrase.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Frase)) {
            return false;
        }
        Frase other = (Frase) object;
        if ((this.idFrase == null && other.idFrase != null) || (this.idFrase != null && !this.idFrase.equals(other.idFrase))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Frase[ idFrase=" + idFrase + " ]";
    }
    
}