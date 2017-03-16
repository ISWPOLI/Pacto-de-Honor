/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "rol_usuario", catalog = "p_h01", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RolUsuario.findAll", query = "SELECT r FROM RolUsuario r"),
    @NamedQuery(name = "RolUsuario.findByIdRolUsuario", query = "SELECT r FROM RolUsuario r WHERE r.idRolUsuario = :idRolUsuario"),
    @NamedQuery(name = "RolUsuario.findByTipoUsuario", query = "SELECT r FROM RolUsuario r WHERE r.tipoUsuario = :tipoUsuario")})
public class RolUsuario implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_rol_usuario", nullable = false)
    private Integer idRolUsuario;
    @Column(name = "tipo_usuario")
    private Integer tipoUsuario;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "rolUsuario")
    private List<Usuario> usuarioList;

    public RolUsuario() {
    }

    public RolUsuario(Integer idRolUsuario) {
        this.idRolUsuario = idRolUsuario;
    }

    public Integer getIdRolUsuario() {
        return idRolUsuario;
    }

    public void setIdRolUsuario(Integer idRolUsuario) {
        this.idRolUsuario = idRolUsuario;
    }

    public Integer getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(Integer tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
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
        hash += (idRolUsuario != null ? idRolUsuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RolUsuario)) {
            return false;
        }
        RolUsuario other = (RolUsuario) object;
        if ((this.idRolUsuario == null && other.idRolUsuario != null) || (this.idRolUsuario != null && !this.idRolUsuario.equals(other.idRolUsuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.RolUsuario[ idRolUsuario=" + idRolUsuario + " ]";
    }
    
}
