
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jrubiaob
 */
@Entity
@Table(name = "jugador")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Jugador.findAll", query = "SELECT j FROM Jugador j"),
    @NamedQuery(name = "Jugador.findByIdJugador", query = "SELECT j FROM Jugador j WHERE j.idJugador = :idJugador"),
    @NamedQuery(name = "Jugador.findByNivel", query = "SELECT j FROM Jugador j WHERE j.nivel = :nivel"),
    @NamedQuery(name = "Jugador.findByNickname", query = "SELECT j FROM Jugador j WHERE j.nickname = :nickname"),
    @NamedQuery(name = "Jugador.findByMonedaJugador", query = "SELECT j FROM Jugador j WHERE j.monedaJugador = :monedaJugador"),
    @NamedQuery(name = "Jugador.findByExperienciaJugador", query = "SELECT j FROM Jugador j WHERE j.experienciaJugador = :experienciaJugador"),
    @NamedQuery(name = "Jugador.findByNivelJugador", query = "SELECT j FROM Jugador j WHERE j.nivelJugador = :nivelJugador")})
public class Jugador implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_jugador")
    protected int idJugador;  
    
    @JoinColumn(name = "id_nivel", referencedColumnName = "id_nivel", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Nivel nivel;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "nivel_jugador")
    private int nivelJugador;    
    
      
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "nickname")    
    private String nickname;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "moneda_jugador")
    private int monedaJugador;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "experiencia_jugador")
    private int experienciaJugador;  
    
    public Jugador() {
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getMonedaJugador() {
        return monedaJugador;
    }

    public void setMonedaJugador(int monedaJugador) {
        this.monedaJugador = monedaJugador;
    }

    public int getExperienciaJugador() {
        return experienciaJugador;
    }

    public void setExperienciaJugador(int experienciaJugador) {
        this.experienciaJugador = experienciaJugador;
    }

    public int getNivelJugador() {
        return nivelJugador;
    }

    public void setNivelJugador(int nivelJugador) {
        this.nivelJugador = nivelJugador;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    public Nivel getNivel() {
        return nivel;
    }

    public void setNivel(Nivel nivel) {
        this.nivel = nivel;
    }
    
    
}
