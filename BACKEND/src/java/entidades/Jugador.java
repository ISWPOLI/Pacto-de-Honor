/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
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
 * @author Will
 */
@Entity
@Table(name = "jugador")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Jugador.findAll", query = "SELECT j FROM Jugador j"),
    @NamedQuery(name = "Jugador.findByIdJugador", query = "SELECT j FROM Jugador j WHERE j.jugadorPK.idJugador = :idJugador"),
    @NamedQuery(name = "Jugador.findByIdNivel", query = "SELECT j FROM Jugador j WHERE j.jugadorPK.idNivel = :idNivel"),
    @NamedQuery(name = "Jugador.findByNickname", query = "SELECT j FROM Jugador j WHERE j.nickname = :nickname"),
    @NamedQuery(name = "Jugador.findByMonedaJugador", query = "SELECT j FROM Jugador j WHERE j.monedaJugador = :monedaJugador"),
    @NamedQuery(name = "Jugador.findByExperienciaJugador", query = "SELECT j FROM Jugador j WHERE j.experienciaJugador = :experienciaJugador"),
    @NamedQuery(name = "Jugador.findByNivelJugador", query = "SELECT j FROM Jugador j WHERE j.nivelJugador = :nivelJugador")})
public class Jugador implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected JugadorPK jugadorPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
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
    @Basic(optional = false)
    @NotNull
    @Column(name = "nivel_jugador")
    private int nivelJugador;
    @JoinTable(name = "jugador_tiene_personaje", joinColumns = {
        @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador")}, inverseJoinColumns = {
        @JoinColumn(name = "id_personaje", referencedColumnName = "id_personaje")})
    @ManyToMany
    private List<Personaje> personajeList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "jugador")
    private List<Log> logList;
    @JoinColumn(name = "id_nivel", referencedColumnName = "id_nivel", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Nivel nivel;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "jugador")
    private List<Usuario> usuarioList;

    public Jugador() {
    }

    public Jugador(JugadorPK jugadorPK) {
        this.jugadorPK = jugadorPK;
    }

    public Jugador(JugadorPK jugadorPK, String nickname, int monedaJugador, int experienciaJugador, int nivelJugador) {
        this.jugadorPK = jugadorPK;
        this.nickname = nickname;
        this.monedaJugador = monedaJugador;
        this.experienciaJugador = experienciaJugador;
        this.nivelJugador = nivelJugador;
    }

    public Jugador(int idJugador, int idNivel) {
        this.jugadorPK = new JugadorPK(idJugador, idNivel);
    }

    public JugadorPK getJugadorPK() {
        return jugadorPK;
    }

    public void setJugadorPK(JugadorPK jugadorPK) {
        this.jugadorPK = jugadorPK;
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

    @XmlTransient
    public List<Personaje> getPersonajeList() {
        return personajeList;
    }

    public void setPersonajeList(List<Personaje> personajeList) {
        this.personajeList = personajeList;
    }

    @XmlTransient
    public List<Log> getLogList() {
        return logList;
    }

    public void setLogList(List<Log> logList) {
        this.logList = logList;
    }

    public Nivel getNivel() {
        return nivel;
    }

    public void setNivel(Nivel nivel) {
        this.nivel = nivel;
    }

    @XmlTransient
    public List<Usuario> getUsuarioList() {
        return usuarioList;
    }

    public void setUsuarioList(List<Usuario> usuarioList) {
        this.usuarioList = usuarioList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (jugadorPK != null ? jugadorPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Jugador)) {
            return false;
        }
        Jugador other = (Jugador) object;
        if ((this.jugadorPK == null && other.jugadorPK != null) || (this.jugadorPK != null && !this.jugadorPK.equals(other.jugadorPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Jugador[ jugadorPK=" + jugadorPK + " ]";
    }
    
}
