package entities;

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
 * Entidad para la tabla que tiene la relación de todas las imagenes de un mundo.
 * @author jrubiaob
 */
@Entity
@Table(name = "mundo_tiene_imagen")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MundoTieneImagen.findAll", query = "SELECT p FROM MundoTieneImagen p")})
public class MundoTieneImagen implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_mundo_tiene_imagen")
    private Integer idMundoTieneImagen;
    
    @JoinColumn(name = "id_imagen", referencedColumnName = "id_imagen")
    @ManyToOne(optional = false)
    private Imagen idImagen;
    
    @JoinColumn(name = "id_mundo", referencedColumnName = "id_mundo")
    @ManyToOne(optional = false)
    private Mundo idMundo;

    public MundoTieneImagen() {
    }

    public Integer getIdMundoTieneImagen() {
        return idMundoTieneImagen;
    }

    public void setIdMundoTieneImagen(Integer idMundoTieneImagen) {
        this.idMundoTieneImagen = idMundoTieneImagen;
    }

    public Imagen getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(Imagen idImagen) {
        this.idImagen = idImagen;
    }

    public Mundo getIdMundo() {
        return idMundo;
    }

    public void setIdMundo(Mundo idMundo) {
        this.idMundo = idMundo;
    }

    
    
}
