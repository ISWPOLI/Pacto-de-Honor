/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
    @NamedQuery(name = "Jugador.findAll", query = "SELECT j FROM Jugador j")
    , @NamedQuery(name = "Jugador.findByIdJugador", query = "SELECT j FROM Jugador j WHERE j.idJugador = :idJugador")
    , @NamedQuery(name = "Jugador.findByNickname", query = "SELECT j FROM Jugador j WHERE j.nickname = :nickname")
    , @NamedQuery(name = "Jugador.findByMonedas", query = "SELECT j FROM Jugador j WHERE j.monedas = :monedas")
    , @NamedQuery(name = "Jugador.findByPuntosexpe", query = "SELECT j FROM Jugador j WHERE j.puntosexpe = :puntosexpe")
    , @NamedQuery(name = "Jugador.findByNivelJugador", query = "SELECT j FROM Jugador j WHERE j.nivelJugador = :nivelJugador")
    , @NamedQuery(name = "Jugador.findByPuntosVida", query = "SELECT j FROM Jugador j WHERE j.puntosVida = :puntosVida")
    , @NamedQuery(name = "Jugador.findByIdNivelActual", query = "SELECT j FROM Jugador j WHERE j.idNivelActual = :idNivelActual")})
public class Jugador implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idJugador")
    private Integer idJugador;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "nickname")
    private String nickname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "monedas")
    private int monedas;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puntosexpe")
    private int puntosexpe;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nivel_jugador")
    private int nivelJugador;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puntos_vida")
    private int puntosVida;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_nivel_actual")
    private int idNivelActual;
    @JoinTable(name = "jugador_has_personaje", joinColumns = {
        @JoinColumn(name = "Jugador_idJugador", referencedColumnName = "idJugador")}, inverseJoinColumns = {
        @JoinColumn(name = "Personaje_idPersonaje", referencedColumnName = "idPersonaje")})
    @ManyToMany
    private List<Personaje> personajeList;

    public Jugador() {
    }

    public Jugador(Integer idJugador) {
        this.idJugador = idJugador;
    }

    public Jugador(Integer idJugador, String nickname, int monedas, int puntosexpe, int nivelJugador, int puntosVida, int idNivelActual) {
        this.idJugador = idJugador;
        this.nickname = nickname;
        this.monedas = monedas;
        this.puntosexpe = puntosexpe;
        this.nivelJugador = nivelJugador;
        this.puntosVida = puntosVida;
        this.idNivelActual = idNivelActual;
    }

    public Integer getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(Integer idJugador) {
        this.idJugador = idJugador;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getMonedas() {
        return monedas;
    }

    public void setMonedas(int monedas) {
        this.monedas = monedas;
    }

    public int getPuntosexpe() {
        return puntosexpe;
    }

    public void setPuntosexpe(int puntosexpe) {
        this.puntosexpe = puntosexpe;
    }

    public int getNivelJugador() {
        return nivelJugador;
    }

    public void setNivelJugador(int nivelJugador) {
        this.nivelJugador = nivelJugador;
    }

    public int getPuntosVida() {
        return puntosVida;
    }

    public void setPuntosVida(int puntosVida) {
        this.puntosVida = puntosVida;
    }

    public int getIdNivelActual() {
        return idNivelActual;
    }

    public void setIdNivelActual(int idNivelActual) {
        this.idNivelActual = idNivelActual;
    }

    @XmlTransient
    public List<Personaje> getPersonajeList() {
        return personajeList;
    }

    public void setPersonajeList(List<Personaje> personajeList) {
        this.personajeList = personajeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idJugador != null ? idJugador.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Jugador)) {
            return false;
        }
        Jugador other = (Jugador) object;
        if ((this.idJugador == null && other.idJugador != null) || (this.idJugador != null && !this.idJugador.equals(other.idJugador))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Jugador[ idJugador=" + idJugador + " ]";
    }
    
}
