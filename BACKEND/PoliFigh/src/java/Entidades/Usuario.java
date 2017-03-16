/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Will
 */
@Entity
@Table(name = "usuario", catalog = "p_h01", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.findByIdJugador", query = "SELECT u FROM Usuario u WHERE u.usuarioPK.idJugador = :idJugador"),
    @NamedQuery(name = "Usuario.findByIdPais", query = "SELECT u FROM Usuario u WHERE u.usuarioPK.idPais = :idPais"),
    @NamedQuery(name = "Usuario.findByIdCiudad", query = "SELECT u FROM Usuario u WHERE u.usuarioPK.idCiudad = :idCiudad"),
    @NamedQuery(name = "Usuario.findByIdRolUsuario", query = "SELECT u FROM Usuario u WHERE u.usuarioPK.idRolUsuario = :idRolUsuario"),
    @NamedQuery(name = "Usuario.findByNombreUsuario", query = "SELECT u FROM Usuario u WHERE u.nombreUsuario = :nombreUsuario"),
    @NamedQuery(name = "Usuario.findByApellidoUsuario", query = "SELECT u FROM Usuario u WHERE u.apellidoUsuario = :apellidoUsuario"),
    @NamedQuery(name = "Usuario.findByEmailUsuario", query = "SELECT u FROM Usuario u WHERE u.emailUsuario = :emailUsuario"),
    @NamedQuery(name = "Usuario.findByContrasenaUsuario", query = "SELECT u FROM Usuario u WHERE u.contrasenaUsuario = :contrasenaUsuario"),
    @NamedQuery(name = "Usuario.findByFechaRegistro", query = "SELECT u FROM Usuario u WHERE u.fechaRegistro = :fechaRegistro")})
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected UsuarioPK usuarioPK;
    @Size(max = 100)
    @Column(name = "nombre_usuario", length = 100)
    private String nombreUsuario;
    @Size(max = 100)
    @Column(name = "apellido_usuario", length = 100)
    private String apellidoUsuario;
    @Size(max = 150)
    @Column(name = "email_usuario", length = 150)
    private String emailUsuario;
    @Size(max = 20)
    @Column(name = "contrasena_usuario", length = 20)
    private String contrasenaUsuario;
    @Column(name = "fecha_registro")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaRegistro;
    @JoinColumn(name = "id_ciudad", referencedColumnName = "id_ciudad", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Ciudad ciudad;
    @JoinColumn(name = "id_jugador", referencedColumnName = "id_jugador", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Jugador jugador;
    @JoinColumn(name = "id_pais", referencedColumnName = "id_pais", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Pais pais;
    @JoinColumn(name = "id_rol_usuario", referencedColumnName = "id_rol_usuario", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private RolUsuario rolUsuario;

    public Usuario() {
    }

    public Usuario(UsuarioPK usuarioPK) {
        this.usuarioPK = usuarioPK;
    }

    public Usuario(int idJugador, int idPais, int idCiudad, int idRolUsuario) {
        this.usuarioPK = new UsuarioPK(idJugador, idPais, idCiudad, idRolUsuario);
    }

    public UsuarioPK getUsuarioPK() {
        return usuarioPK;
    }

    public void setUsuarioPK(UsuarioPK usuarioPK) {
        this.usuarioPK = usuarioPK;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getApellidoUsuario() {
        return apellidoUsuario;
    }

    public void setApellidoUsuario(String apellidoUsuario) {
        this.apellidoUsuario = apellidoUsuario;
    }

    public String getEmailUsuario() {
        return emailUsuario;
    }

    public void setEmailUsuario(String emailUsuario) {
        this.emailUsuario = emailUsuario;
    }

    public String getContrasenaUsuario() {
        return contrasenaUsuario;
    }

    public void setContrasenaUsuario(String contrasenaUsuario) {
        this.contrasenaUsuario = contrasenaUsuario;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Ciudad getCiudad() {
        return ciudad;
    }

    public void setCiudad(Ciudad ciudad) {
        this.ciudad = ciudad;
    }

    public Jugador getJugador() {
        return jugador;
    }

    public void setJugador(Jugador jugador) {
        this.jugador = jugador;
    }

    public Pais getPais() {
        return pais;
    }

    public void setPais(Pais pais) {
        this.pais = pais;
    }

    public RolUsuario getRolUsuario() {
        return rolUsuario;
    }

    public void setRolUsuario(RolUsuario rolUsuario) {
        this.rolUsuario = rolUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (usuarioPK != null ? usuarioPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.usuarioPK == null && other.usuarioPK != null) || (this.usuarioPK != null && !this.usuarioPK.equals(other.usuarioPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Usuario[ usuarioPK=" + usuarioPK + " ]";
    }
    
}
