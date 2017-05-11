package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ahsierra
 */
@Entity
@Table(name = "poder")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Poder.findAll", query = "SELECT p FROM Poder p"),
    @NamedQuery(name = "Poder.findByIdPoder", query = "SELECT p FROM Poder p WHERE p.poderPK.idPoder = :idPoder"),
    @NamedQuery(name = "Poder.findByIdImagen", query = "SELECT p FROM Poder p WHERE p.poderPK.idImagen = :idImagen"),
    @NamedQuery(name = "Poder.findByNombrePoder", query = "SELECT p FROM Poder p WHERE p.nombrePoder = :nombrePoder"),
    @NamedQuery(name = "Poder.findByDescripcionPoder", query = "SELECT p FROM Poder p WHERE p.descripcionPoder = :descripcionPoder"),
    @NamedQuery(name = "Poder.findByTipoPoder", query = "SELECT p FROM Poder p WHERE p.tipoPoder = :tipoPoder"),
    @NamedQuery(name = "Poder.findByFormaPoder", query = "SELECT p FROM Poder p WHERE p.formaPoder = :formaPoder"),
    @NamedQuery(name = "Poder.findByPotenciaPoder", query = "SELECT p FROM Poder p WHERE p.potenciaPoder = :potenciaPoder")})
public class Poder implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected PoderPK poderPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_poder")
    private String nombrePoder;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "descripcion_poder")
    private String descripcionPoder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "tipo_poder")
    private int tipoPoder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "forma_poder")
    private int formaPoder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "potencia_poder")
    private int potenciaPoder;
    @JoinColumn(name = "id_imagen", referencedColumnName = "id_imagen", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Imagen imagen;

    public Poder() {
    }

    public Poder(PoderPK poderPK) {
        this.poderPK = poderPK;
    }

    public Poder(PoderPK poderPK, String nombrePoder, String descripcionPoder, int tipoPoder, int formaPoder, int potenciaPoder) {
        this.poderPK = poderPK;
        this.nombrePoder = nombrePoder;
        this.descripcionPoder = descripcionPoder;
        this.tipoPoder = tipoPoder;
        this.formaPoder = formaPoder;
        this.potenciaPoder = potenciaPoder;
    }

    public Poder(int idPoder, int idImagen) {
        this.poderPK = new PoderPK(idPoder, idImagen);
    }

    public PoderPK getPoderPK() {
        return poderPK;
    }

    public void setPoderPK(PoderPK poderPK) {
        this.poderPK = poderPK;
    }

    public String getNombrePoder() {
        return nombrePoder;
    }

    public void setNombrePoder(String nombrePoder) {
        this.nombrePoder = nombrePoder;
    }

    public String getDescripcionPoder() {
        return descripcionPoder;
    }

    public void setDescripcionPoder(String descripcionPoder) {
        this.descripcionPoder = descripcionPoder;
    }

    public int getTipoPoder() {
        return tipoPoder;
    }

    public void setTipoPoder(int tipoPoder) {
        this.tipoPoder = tipoPoder;
    }

    public int getFormaPoder() {
        return formaPoder;
    }

    public void setFormaPoder(int formaPoder) {
        this.formaPoder = formaPoder;
    }

    public int getPotenciaPoder() {
        return potenciaPoder;
    }

    public void setPotenciaPoder(int potenciaPoder) {
        this.potenciaPoder = potenciaPoder;
    }

    public Imagen getImagen() {
        return imagen;
    }

    public void setImagen(Imagen imagen) {
        this.imagen = imagen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (poderPK != null ? poderPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Poder)) {
            return false;
        }
        Poder other = (Poder) object;
        if ((this.poderPK == null && other.poderPK != null) || (this.poderPK != null && !this.poderPK.equals(other.poderPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Poder[ poderPK=" + poderPK + " ]";
    }
    
}