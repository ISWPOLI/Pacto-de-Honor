package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Juan Lancheros
 */
@Entity
@Table(name = "jugador_tiene_logros")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "JugadorTieneLogros.findAll", query = "SELECT j FROM JugadorTieneLogros j")
    , @NamedQuery(name = "JugadorTieneLogros.findByJugador", query = "SELECT j FROM JugadorTieneLogros j where j.idJugador =: idJugador")
    , @NamedQuery(name = "JugadorTieneLogros.findByIdJugadorTieneLogros", query = "SELECT j FROM JugadorTieneLogros j WHERE j.idJugadorTieneLogros = :idJugadorTieneLogros")})
public class JugadorTieneLogros implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_Jugador_Tiene_Logros")
    private Integer idJugadorTieneLogros;
    @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador")
    @ManyToOne(optional = false)
    private Jugador idJugador;
    @JoinColumn(name = "id_logro", referencedColumnName = "id_logro")
    @ManyToOne(optional = false)
    private Logros idLogro;

    public JugadorTieneLogros() {
    }

    public JugadorTieneLogros(Integer idJugadorTieneLogros) {
        this.idJugadorTieneLogros = idJugadorTieneLogros;
    }

    public Integer getIdJugadorTieneLogros() {
        return idJugadorTieneLogros;
    }

    public void setIdJugadorTieneLogros(Integer idJugadorTieneLogros) {
        this.idJugadorTieneLogros = idJugadorTieneLogros;
    }

    public Jugador getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(Jugador idJugador) {
        this.idJugador = idJugador;
    }

    public Logros getIdLogro() {
        return idLogro;
    }

    public void setIdLogro(Logros idLogro) {
        this.idLogro = idLogro;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idJugadorTieneLogros != null ? idJugadorTieneLogros.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof JugadorTieneLogros)) {
            return false;
        }
        JugadorTieneLogros other = (JugadorTieneLogros) object;
        if ((this.idJugadorTieneLogros == null && other.idJugadorTieneLogros != null) || (this.idJugadorTieneLogros != null && !this.idJugadorTieneLogros.equals(other.idJugadorTieneLogros))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.JugadorTieneLogros[ idJugadorTieneLogros=" + idJugadorTieneLogros + " ]";
    }

}
