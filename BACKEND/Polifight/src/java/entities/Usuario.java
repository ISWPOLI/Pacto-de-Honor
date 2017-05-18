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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entidad para la tabla Usuario
 * @author jrubiaob
 */

@Entity
@Table(name = "usuario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.findToken", query = "SELECT u FROM Usuario u WHERE u.token = :token"),
    @NamedQuery(name = "Usuario.findByIdUsuario", query = "SELECT u FROM Usuario u WHERE u.idUsuario = :idUsuario"),
    @NamedQuery(name = "Usuario.findByIdPais", query = "SELECT u FROM Usuario u WHERE u.idPais = :idPais"),
    @NamedQuery(name = "Usuario.findByIdCiudad", query = "SELECT u FROM Usuario u WHERE u.idCiudad = :idCiudad"),
    @NamedQuery(name = "Usuario.findByIdRolUsuario", query = "SELECT u FROM Usuario u WHERE u.idRolUsuario = :idRolUsuario"),
    @NamedQuery(name = "Usuario.findByNombreUsuario", query = "SELECT u FROM Usuario u WHERE u.nombreUsuario = :nombreUsuario"),
    @NamedQuery(name = "Usuario.findByApellidoUsuario", query = "SELECT u FROM Usuario u WHERE u.apellidoUsuario = :apellidoUsuario"),
    @NamedQuery(name = "Usuario.findByEmailUsuario", query = "SELECT u FROM Usuario u WHERE u.emailUsuario = :emailUsuario"),
    @NamedQuery(name = "Usuario.findByContrasenaUsuario", query = "SELECT u FROM Usuario u WHERE u.contrasenaUsuario = :contrasenaUsuario"),
    @NamedQuery(name = "Usuario.findByFechaRegistro", query = "SELECT u FROM Usuario u WHERE u.fechaRegistro = :fechaRegistro")})
public class Usuario implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_usuario")
    protected int idUsuario;
    
    @Basic(optional = false)
    @Column(name = "id_pais")
    @JoinColumn(name = "id_pais", referencedColumnName = "id_pais", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idPais;
    
    @Basic(optional = false)
    @Column(name = "id_ciudad")
    @JoinColumn(name = "id_ciudad", referencedColumnName = "id_ciudad", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idCiudad;
    
    @Basic(optional = false)
    @Column(name = "id_rol_usuario")
    @JoinColumn(name = "id_rol_usuario", referencedColumnName = "id_rol_usuario", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idRolUsuario;
    
    @Size(max = 100)
    @Column(name = "nombre_usuario")
    private String nombreUsuario;
    
    @Size(max = 100)
    @Column(name = "apellido_usuario")
    private String apellidoUsuario;
    
    @Size(max = 150)
    @Column(name = "email_usuario")
    private String emailUsuario;
    
    @Size(max = 20)
    @Column(name = "contrasena_usuario")
    private String contrasenaUsuario;
    
    @Column(name = "fecha_registro")
    private String fechaRegistro;
    
    @Column(name = "token")
    private String token;
    
    @Column(name = "fecha_token")
    private String fechaToken;
    

    public Usuario() {
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

    public String getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(String fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

  
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
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

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getFechaToken() {
        return fechaToken;
    }

    public void setFechaToken(String fechaToken) {
        this.fechaToken = fechaToken;
    }
    
    
}