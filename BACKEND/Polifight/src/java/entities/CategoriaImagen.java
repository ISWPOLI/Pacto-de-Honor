package entities;

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
 * Entidad para las Categorias de las Imagenes
 * @author jrubiaob
 */
@Entity
@Table(name = "categoriaimagen")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Categoriaimagen.findAll", query = "SELECT c FROM CategoriaImagen c"),
    @NamedQuery(name = "Categoriaimagen.findByIdcategoriaImagen", query = "SELECT c FROM CategoriaImagen c WHERE c.idcategoriaImagen = :idcategoriaImagen"),
    @NamedQuery(name = "Categoriaimagen.findByDescCategoriaImagen", query = "SELECT c FROM CategoriaImagen c WHERE c.descCategoriaImagen = :descCategoriaImagen")})
public class CategoriaImagen implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_categoriaImagen")
    private Integer idcategoriaImagen;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "descCategoriaImagen")
    private String descCategoriaImagen;    
    
    public CategoriaImagen() {
    }

    public CategoriaImagen(Integer idcategoriaImagen) {
        this.idcategoriaImagen = idcategoriaImagen;
    }

    public CategoriaImagen(Integer idcategoriaImagen, String descCategoriaImagen) {
        this.idcategoriaImagen = idcategoriaImagen;
        this.descCategoriaImagen = descCategoriaImagen;
    }

    public Integer getIdcategoriaImagen() {
        return idcategoriaImagen;
    }

    public void setIdcategoriaImagen(Integer idcategoriaImagen) {
        this.idcategoriaImagen = idcategoriaImagen;
    }

    public String getDescCategoriaImagen() {
        return descCategoriaImagen;
    }

    public void setDescCategoriaImagen(String descCategoriaImagen) {
        this.descCategoriaImagen = descCategoriaImagen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcategoriaImagen != null ? idcategoriaImagen.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CategoriaImagen)) {
            return false;
        }
        CategoriaImagen other = (CategoriaImagen) object;
        if ((this.idcategoriaImagen == null && other.idcategoriaImagen != null) || (this.idcategoriaImagen != null && !this.idcategoriaImagen.equals(other.idcategoriaImagen))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "testentidades.Categoriaimagen[ idcategoriaImagen=" + idcategoriaImagen + " ]";
    }
    
}
