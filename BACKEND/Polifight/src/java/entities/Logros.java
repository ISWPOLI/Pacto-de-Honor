package entities;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
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
 * @author Juan Lancheros
 */
@Entity
@Table(name = "logros")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Logros.findAll", query = "SELECT l FROM Logros l")
    , @NamedQuery(name = "Logros.findByIdLogro", query = "SELECT l FROM Logros l WHERE l.idLogro = :idLogro")
    , @NamedQuery(name = "Logros.findByNombre", query = "SELECT l FROM Logros l WHERE l.nombre = :nombre")
    , @NamedQuery(name = "Logros.findByDescripcion", query = "SELECT l FROM Logros l WHERE l.descripcion = :descripcion")
    , @NamedQuery(name = "Logros.findByEsModenas", query = "SELECT l FROM Logros l WHERE l.esModenas = :esModenas")
    , @NamedQuery(name = "Logros.findByEsRanking", query = "SELECT l FROM Logros l WHERE l.esRanking = :esRanking")
    , @NamedQuery(name = "Logros.findByEsTiempo", query = "SELECT l FROM Logros l WHERE l.esTiempo = :esTiempo")
    , @NamedQuery(name = "Logros.findByMonedas", query = "SELECT l FROM Logros l WHERE l.monedas = :monedas")
    , @NamedQuery(name = "Logros.findByRanking", query = "SELECT l FROM Logros l WHERE l.ranking = :ranking")
    , @NamedQuery(name = "Logros.findByTiempoJugado", query = "SELECT l FROM Logros l WHERE l.tiempoJugado = :tiempoJugado")})
public class Logros implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_logro")
    private Integer idLogro;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "esModenas")
    private boolean esModenas;
    @Basic(optional = false)
    @NotNull
    @Column(name = "esRanking")
    private boolean esRanking;
    @Basic(optional = false)
    @NotNull
    @Column(name = "esTiempo")
    private boolean esTiempo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "monedas")
    private int monedas;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ranking")
    private int ranking;
    @Basic(optional = false)
    @NotNull
    @Column(name = "tiempoJugado")
    private int tiempoJugado;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idLogros")
    private Collection<JugadorTieneLogros> jugadorTieneLogrosCollection;

    public Logros() {
    }

    public Logros(Integer idLogro) {
        this.idLogro = idLogro;
    }

    public Logros(Integer idLogro, String nombre, String descripcion, boolean esModenas, boolean esRanking, boolean esTiempo, int monedas, int ranking, int tiempoJugado) {
        this.idLogro = idLogro;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.esModenas = esModenas;
        this.esRanking = esRanking;
        this.esTiempo = esTiempo;
        this.monedas = monedas;
        this.ranking = ranking;
        this.tiempoJugado = tiempoJugado;
    }

    public Integer getIdLogro() {
        return idLogro;
    }

    public void setIdLogro(Integer idLogro) {
        this.idLogro = idLogro;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean getEsModenas() {
        return esModenas;
    }

    public void setEsModenas(boolean esModenas) {
        this.esModenas = esModenas;
    }

    public boolean getEsRanking() {
        return esRanking;
    }

    public void setEsRanking(boolean esRanking) {
        this.esRanking = esRanking;
    }

    public boolean getEsTiempo() {
        return esTiempo;
    }

    public void setEsTiempo(boolean esTiempo) {
        this.esTiempo = esTiempo;
    }

    public int getMonedas() {
        return monedas;
    }

    public void setMonedas(int monedas) {
        this.monedas = monedas;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }

    public int getTiempoJugado() {
        return tiempoJugado;
    }

    public void setTiempoJugado(int tiempoJugado) {
        this.tiempoJugado = tiempoJugado;
    }

    @XmlTransient
    public Collection<JugadorTieneLogros> getJugadorTieneLogrosCollection() {
        return jugadorTieneLogrosCollection;
    }

    public void setJugadorTieneLogrosCollection(Collection<JugadorTieneLogros> jugadorTieneLogrosCollection) {
        this.jugadorTieneLogrosCollection = jugadorTieneLogrosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idLogro != null ? idLogro.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Logros)) {
            return false;
        }
        Logros other = (Logros) object;
        if ((this.idLogro == null && other.idLogro != null) || (this.idLogro != null && !this.idLogro.equals(other.idLogro))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Logros[ idLogro=" + idLogro + " ]";
    }
    
}
