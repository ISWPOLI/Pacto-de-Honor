/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Will
 */
@Embeddable
public class UsuarioPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_jugador", nullable = false)
    private int idJugador;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_pais", nullable = false)
    private int idPais;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_ciudad", nullable = false)
    private int idCiudad;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_rol_usuario", nullable = false)
    private int idRolUsuario;

    public UsuarioPK() {
    }

    public UsuarioPK(int idJugador, int idPais, int idCiudad, int idRolUsuario) {
        this.idJugador = idJugador;
        this.idPais = idPais;
        this.idCiudad = idCiudad;
        this.idRolUsuario = idRolUsuario;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    public int getIdPais() {
        return idPais;
    }

    public void setIdPais(int idPais) {
        this.idPais = idPais;
    }

    public int getIdCiudad() {
        return idCiudad;
    }

    public void setIdCiudad(int idCiudad) {
        this.idCiudad = idCiudad;
    }

    public int getIdRolUsuario() {
        return idRolUsuario;
    }

    public void setIdRolUsuario(int idRolUsuario) {
        this.idRolUsuario = idRolUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idJugador;
        hash += (int) idPais;
        hash += (int) idCiudad;
        hash += (int) idRolUsuario;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UsuarioPK)) {
            return false;
        }
        UsuarioPK other = (UsuarioPK) object;
        if (this.idJugador != other.idJugador) {
            return false;
        }
        if (this.idPais != other.idPais) {
            return false;
        }
        if (this.idCiudad != other.idCiudad) {
            return false;
        }
        if (this.idRolUsuario != other.idRolUsuario) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.UsuarioPK[ idJugador=" + idJugador + ", idPais=" + idPais + ", idCiudad=" + idCiudad + ", idRolUsuario=" + idRolUsuario + " ]";
    }
    
}
