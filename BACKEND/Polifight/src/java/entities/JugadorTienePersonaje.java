/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
 *
 * @author 1013608348
 */
@Entity
@Table(name = "jugador_tiene_personaje")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "JugadorTienePersonaje.findAll", query = "SELECT j FROM JugadorTienePersonaje j"),
    @NamedQuery(name = "JugadorTienePersonaje.findByIdJugadortienepersonaje", query = "SELECT j FROM JugadorTienePersonaje j WHERE j.idJugadortienepersonaje = :idJugadortienepersonaje"),
    @NamedQuery(name = "JugadorTienePersonaje.findByIdJugador", query = "SELECT j FROM JugadorTienePersonaje j WHERE j.idJugador = :idJugador")})
public class JugadorTienePersonaje implements Serializable {
    private static final long serialVersionUID = 1L;
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_Jugador_tiene_personaje")
    private Integer idJugadortienepersonaje;
    
    
    @Basic(optional = false)
    @Column(name = "id_jugador")
    @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idJugador;
    
    @Basic(optional = false)
    @Column(name = "id_personaje")
    @JoinColumn(name = "id_personaje", referencedColumnName = "id_personaje", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idPersonaje;

    public JugadorTienePersonaje() {
    }

    public Integer getIdJugadortienepersonaje() {
       return idJugadortienepersonaje;
    }

    public void setIdJugadortienepersonaje(Integer idJugadortienepersonaje) {
        this.idJugadortienepersonaje = idJugadortienepersonaje;
    }
    
    public Integer getIdJugador(){
        return idJugador;
    }
    
    public void setIdJugador(Integer idJugador){
        this.idJugador = idJugador;
    }
    
    public Integer getIdPersonaje(){
        return idPersonaje;
    }
    
    public void setIdPersonaje(Integer idPersonaje){
        this.idPersonaje = idPersonaje;
    }

    @Override
    public String toString() {
        return "entities.JugadorTienePersonaje[ idJugadortienepersonaje=" + idJugadortienepersonaje + " ]";
    }
    
}
