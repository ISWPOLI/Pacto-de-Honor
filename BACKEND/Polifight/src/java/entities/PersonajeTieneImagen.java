package entities;

import entities.Imagen;
import entities.Personaje;
import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entidad para la tabla que tiene la relación de todas las imagenes de un personaje.
 * @author jrubiaob
 */
@Entity
@Table(name = "personaje_tiene_imagen")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PersonajeTieneImagen.findAll", query = "SELECT p FROM PersonajeTieneImagen p"),
    @NamedQuery(name = "PersonajeTieneImagen.findByIdPersonajeTieneImagen", query = "SELECT p FROM PersonajeTieneImagen p WHERE p.idPersonajeTieneImagen = :idPersonajeTieneImagen"),
    @NamedQuery(name = "PersonajeTieneImagen.findImagenForPersonaje", query = "SELECT p FROM PersonajeTieneImagen p WHERE p.idCategoriaImagen = :idCategoriaImagen AND p.idPersonaje = :idPersonaje")})
public class PersonajeTieneImagen implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_personaje_tiene_imagen")
    private Integer idPersonajeTieneImagen;
    
    @JoinColumn(name = "id_categoriaImagen", referencedColumnName = "id_categoriaImagen")
    @ManyToOne(optional = false)
    private Categoriaimagen idCategoriaImagen;
    
    @JoinColumn(name = "id_Imgen", referencedColumnName = "id_imagen")
    @ManyToOne(optional = false)
    private Imagen idImagen;
    
    @JoinColumn(name = "id_personaje", referencedColumnName = "id_personaje")
    @ManyToOne(optional = false)
    private Personaje idPersonaje;

    public PersonajeTieneImagen() {
    }

    public PersonajeTieneImagen(Integer idPersonajeTieneImagen) {
        this.idPersonajeTieneImagen = idPersonajeTieneImagen;
    }

    public Integer getIdPersonajeTieneImagen() {
        return idPersonajeTieneImagen;
    }

    public void setIdPersonajeTieneImagen(Integer idPersonajeTieneImagen) {
        this.idPersonajeTieneImagen = idPersonajeTieneImagen;
    }

    public Categoriaimagen getIdcategoriaImagen() {
        return idCategoriaImagen;
    }

    public void setIdcategoriaImagen(Categoriaimagen idCategoriaImagen) {
        this.idCategoriaImagen = idCategoriaImagen;
    }

    public Imagen getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(Imagen idImagen) {
        this.idImagen = idImagen;
    }

    public Personaje getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(Personaje idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPersonajeTieneImagen != null ? idPersonajeTieneImagen.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PersonajeTieneImagen)) {
            return false;
        }
        PersonajeTieneImagen other = (PersonajeTieneImagen) object;
        if ((this.idPersonajeTieneImagen == null && other.idPersonajeTieneImagen != null) || (this.idPersonajeTieneImagen != null && !this.idPersonajeTieneImagen.equals(other.idPersonajeTieneImagen))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "testentidades.PersonajeTieneImagen[ idPersonajeTieneImagen=" + idPersonajeTieneImagen + " ]";
    }
    
}
