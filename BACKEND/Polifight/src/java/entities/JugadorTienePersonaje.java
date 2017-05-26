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
 * Entidad para la tabla: jugador_tiene_personaje
 * @author jrubiaob
 */
@Entity
@Table(name = "jugador_tiene_personaje")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "JugadorTienePersonaje.findAll", query = "SELECT j FROM JugadorTienePersonaje j"),
    @NamedQuery(name = "JugadorTienePersonaje.findByIdJugadortienepersonaje", query = "SELECT j FROM JugadorTienePersonaje j WHERE j.idJugadortienepersonaje = :idJugadortienepersonaje"),
    @NamedQuery(name = "JugadorTienePersonaje.findPlayerJugador", query = "SELECT j FROM JugadorTienePersonaje j WHERE j.jugador.idJugador = :idJugador"),
    @NamedQuery(name = "JugadorTienePersonaje.personajeAndJugador", query = "SELECT j FROM JugadorTienePersonaje j WHERE j.jugador.idJugador = :idJugador AND j.personaje.idPersonaje = :idPersonaje")})
public class JugadorTienePersonaje implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_Jugador_tiene_personaje")
    private Integer idJugadortienepersonaje;
    
    @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Jugador jugador;
     
    @JoinColumn(name = "id_personaje", referencedColumnName = "id_personaje", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Personaje personaje;
    
    @Column(name = "nivel_personaje")
    private Integer nivelPersonaje;
    
    public JugadorTienePersonaje() {
    }

    public JugadorTienePersonaje(Integer idJugadortienepersonaje) {
        this.idJugadortienepersonaje = idJugadortienepersonaje;
    }

    public Integer getIdJugadortienepersonaje() {
        return idJugadortienepersonaje;
    }

    public void setIdJugadortienepersonaje(Integer idJugadortienepersonaje) {
        this.idJugadortienepersonaje = idJugadortienepersonaje;
    }

    public Jugador getJugador() {
        return jugador;
    }

    public void setJugador(Jugador jugador) {
        this.jugador = jugador;
    }

    public Personaje getPersonaje() {
        return personaje;
    }

    public Integer getNivelPersonaje() {
        return nivelPersonaje;
    }

    public void setNivelPersonaje(Integer nivelPersonaje) {
        this.nivelPersonaje = nivelPersonaje;
    }

    public void setPersonaje(Personaje personaje) {
        this.personaje = personaje;
    }  
    
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idJugadortienepersonaje != null ? idJugadortienepersonaje.hashCode() : 0);
        return hash;
    }
    
}