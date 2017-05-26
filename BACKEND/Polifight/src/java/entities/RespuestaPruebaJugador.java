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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author nimartinezma
 */
@Entity
@Table(name = "respuesta_prueba_jugador")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RespuestaPruebaJugador.findAll", query = "SELECT r FROM RespuestaPruebaJugador r"),
    @NamedQuery(name = "RespuestaPruebaJugador.findByIdRespuestaPruebaJugador", query = "SELECT r FROM RespuestaPruebaJugador r WHERE r.idRespuestaPruebaJugador = :idRespuestaPruebaJugador"),
    @NamedQuery(name = "RespuestaPruebaJugador.findByIdRespuesta", query = "SELECT r FROM RespuestaPruebaJugador r WHERE r.idRespuesta = :idRespuesta"),
    @NamedQuery(name = "RespuestaPruebaJugador.findByIdJugador", query = "SELECT r FROM RespuestaPruebaJugador r WHERE r.idJugador = :idJugador")})
public class RespuestaPruebaJugador implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_respuesta_prueba_jugador")
    private Integer idRespuestaPruebaJugador;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_respuesta")
    private int idRespuesta;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_jugador")
    private int idJugador;

    public RespuestaPruebaJugador() {
    }

    public RespuestaPruebaJugador(Integer idRespuestaPruebaJugador) {
        this.idRespuestaPruebaJugador = idRespuestaPruebaJugador;
    }

    public RespuestaPruebaJugador(Integer idRespuestaPruebaJugador, int idRespuesta, int idJugador) {
        this.idRespuestaPruebaJugador = idRespuestaPruebaJugador;
        this.idRespuesta = idRespuesta;
        this.idJugador = idJugador;
    }

    public Integer getIdRespuestaPruebaJugador() {
        return idRespuestaPruebaJugador;
    }

    public void setIdRespuestaPruebaJugador(Integer idRespuestaPruebaJugador) {
        this.idRespuestaPruebaJugador = idRespuestaPruebaJugador;
    }

    public int getIdRespuesta() {
        return idRespuesta;
    }

    public void setIdRespuesta(int idRespuesta) {
        this.idRespuesta = idRespuesta;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRespuestaPruebaJugador != null ? idRespuestaPruebaJugador.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RespuestaPruebaJugador)) {
            return false;
        }
        RespuestaPruebaJugador other = (RespuestaPruebaJugador) object;
        if ((this.idRespuestaPruebaJugador == null && other.idRespuestaPruebaJugador != null) || (this.idRespuestaPruebaJugador != null && !this.idRespuestaPruebaJugador.equals(other.idRespuestaPruebaJugador))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.RespuestaPruebaJugador[ idRespuestaPruebaJugador=" + idRespuestaPruebaJugador + " ]";
    }
    
}