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
import javax.persistence.Id;
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
@Table(name = "poder")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Poder.findAll", query = "SELECT p FROM Poder p")
    , @NamedQuery(name = "Poder.findByIdpoder", query = "SELECT p FROM Poder p WHERE p.idpoder = :idpoder")
    , @NamedQuery(name = "Poder.findByNombrePoder", query = "SELECT p FROM Poder p WHERE p.nombrePoder = :nombrePoder")
    , @NamedQuery(name = "Poder.findByDescripcionPoder", query = "SELECT p FROM Poder p WHERE p.descripcionPoder = :descripcionPoder")
    , @NamedQuery(name = "Poder.findByTipoPoder", query = "SELECT p FROM Poder p WHERE p.tipoPoder = :tipoPoder")
    , @NamedQuery(name = "Poder.findByFormaPoder", query = "SELECT p FROM Poder p WHERE p.formaPoder = :formaPoder")
    , @NamedQuery(name = "Poder.findByPotencia", query = "SELECT p FROM Poder p WHERE p.potencia = :potencia")})
public class Poder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idpoder")
    private Integer idpoder;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_poder")
    private String nombrePoder;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "descripcion_poder")
    private String descripcionPoder;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 7)
    @Column(name = "tipo_poder")
    private String tipoPoder;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 7)
    @Column(name = "forma_poder")
    private String formaPoder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "potencia")
    private int potencia;
    @ManyToMany(mappedBy = "poderList")
    private List<Personaje> personajeList;

    public Poder() {
    }

    public Poder(Integer idpoder) {
        this.idpoder = idpoder;
    }

    public Poder(Integer idpoder, String nombrePoder, String descripcionPoder, String tipoPoder, String formaPoder, int potencia) {
        this.idpoder = idpoder;
        this.nombrePoder = nombrePoder;
        this.descripcionPoder = descripcionPoder;
        this.tipoPoder = tipoPoder;
        this.formaPoder = formaPoder;
        this.potencia = potencia;
    }

    public Integer getIdpoder() {
        return idpoder;
    }

    public void setIdpoder(Integer idpoder) {
        this.idpoder = idpoder;
    }

    public String getNombrePoder() {
        return nombrePoder;
    }

    public void setNombrePoder(String nombrePoder) {
        this.nombrePoder = nombrePoder;
    }

    public String getDescripcionPoder() {
        return descripcionPoder;
    }

    public void setDescripcionPoder(String descripcionPoder) {
        this.descripcionPoder = descripcionPoder;
    }

    public String getTipoPoder() {
        return tipoPoder;
    }

    public void setTipoPoder(String tipoPoder) {
        this.tipoPoder = tipoPoder;
    }

    public String getFormaPoder() {
        return formaPoder;
    }

    public void setFormaPoder(String formaPoder) {
        this.formaPoder = formaPoder;
    }

    public int getPotencia() {
        return potencia;
    }

    public void setPotencia(int potencia) {
        this.potencia = potencia;
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
        hash += (idpoder != null ? idpoder.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Poder)) {
            return false;
        }
        Poder other = (Poder) object;
        if ((this.idpoder == null && other.idpoder != null) || (this.idpoder != null && !this.idpoder.equals(other.idpoder))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Poder[ idpoder=" + idpoder + " ]";
    }
    
}
