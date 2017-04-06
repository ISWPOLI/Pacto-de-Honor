/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.entidades;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author JERR
 */
@Entity
@Table(name = "registrologin")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Registrologin.findAll", query = "SELECT r FROM Registrologin r")
    , @NamedQuery(name = "Registrologin.findById", query = "SELECT r FROM Registrologin r WHERE r.id = :id")
    , @NamedQuery(name = "Registrologin.findByNombre", query = "SELECT r FROM Registrologin r WHERE r.nombre = :nombre")
    , @NamedQuery(name = "Registrologin.findByApellido", query = "SELECT r FROM Registrologin r WHERE r.apellido = :apellido")
    , @NamedQuery(name = "Registrologin.findByEmail", query = "SELECT r FROM Registrologin r WHERE r.email = :email")
    , @NamedQuery(name = "Registrologin.findByPais", query = "SELECT r FROM Registrologin r WHERE r.pais = :pais")
    , @NamedQuery(name = "Registrologin.findByCiudad", query = "SELECT r FROM Registrologin r WHERE r.ciudad = :ciudad")
    , @NamedQuery(name = "Registrologin.findByUsuario", query = "SELECT r FROM Registrologin r WHERE r.usuario = :usuario")
    , @NamedQuery(name = "Registrologin.findByClave", query = "SELECT r FROM Registrologin r WHERE r.clave = :clave")})

public class Registrologin implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 100)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 100)
    @Column(name = "apellido")
    private String apellido;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 100)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 50)
    @Column(name = "pais")
    private String pais;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 50)
    @Column(name = "ciudad")
    private String ciudad;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 50)
    @Column(name = "usuario")
    private String usuario;
    @Basic(optional = false)
    //@NotNull
    @Size(min = 1, max = 100)
    @Column(name = "clave")
    private String clave;

    public Registrologin() {
        //Registrologin.super.equals(emf);
    }

    public Registrologin(Integer id) {
        this.id = id;
    }

    public Registrologin(Integer id, String nombre, String apellido, String email, String pais, String ciudad, String usuario, String clave) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.pais = pais;
        this.ciudad = ciudad;
        this.usuario = usuario;
        this.clave = clave;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Registrologin)) {
            return false;
        }
        Registrologin other = (Registrologin) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    
    @Override
    public String toString() {
        return "Controlador.entidades.Registrologin[ id=" + id + " ]";
    }
    
}
