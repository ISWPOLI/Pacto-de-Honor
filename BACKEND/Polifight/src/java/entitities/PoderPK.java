/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.poder.Restful.PH;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author ahsierra
 */
@Embeddable
public class PoderPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_poder")
    private int idPoder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_imagen")
    private int idImagen;

    public PoderPK() {
    }

    public PoderPK(int idPoder, int idImagen) {
        this.idPoder = idPoder;
        this.idImagen = idImagen;
    }

    public int getIdPoder() {
        return idPoder;
    }

    public void setIdPoder(int idPoder) {
        this.idPoder = idPoder;
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
        hash += (int) idPoder;
        hash += (int) idImagen;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PoderPK)) {
            return false;
        }
        PoderPK other = (PoderPK) object;
        if (this.idPoder != other.idPoder) {
            return false;
        }
        if (this.idImagen != other.idImagen) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.poder.Restful.PH.PoderPK[ idPoder=" + idPoder + ", idImagen=" + idImagen + " ]";
    }
    
}
