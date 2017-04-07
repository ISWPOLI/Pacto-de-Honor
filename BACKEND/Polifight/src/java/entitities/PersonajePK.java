/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entitities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author jrubiaob
 */
@Embeddable
public class PersonajePK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_personaje")
    private int idPersonaje;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_categoria")
    private int idCategoria;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_imagen")
    private int idImagen;

    public PersonajePK() {
    }

    public PersonajePK(int idPersonaje, int idCategoria, int idImagen) {
        this.idPersonaje = idPersonaje;
        this.idCategoria = idCategoria;
        this.idImagen = idImagen;
    }

    public int getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(int idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(int idImagen) {
        this.idImagen = idImagen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idPersonaje;
        hash += (int) idCategoria;
        hash += (int) idImagen;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PersonajePK)) {
            return false;
        }
        PersonajePK other = (PersonajePK) object;
        if (this.idPersonaje != other.idPersonaje) {
            return false;
        }
        if (this.idCategoria != other.idCategoria) {
            return false;
        }
        if (this.idImagen != other.idImagen) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entitities.PersonajePK[ idPersonaje=" + idPersonaje + ", idCategoria=" + idCategoria + ", idImagen=" + idImagen + " ]";
    }
    
}
