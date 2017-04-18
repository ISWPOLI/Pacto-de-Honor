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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
@Table(name = "mundo", catalog = "pactohonor", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mundo.findAll", query = "SELECT m FROM Mundo m"),
    @NamedQuery(name = "Mundo.findByIdMundo", query = "SELECT m FROM Mundo m WHERE m.idMundo = :idMundo"),
    @NamedQuery(name = "Mundo.findByNombreMundo", query = "SELECT m FROM Mundo m WHERE m.nombreMundo = :nombreMundo")})
public class Mundo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_mundo", nullable = false)
    private Integer idMundo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_mundo", nullable = false, length = 20)
    private String nombreMundo;
    @ManyToMany(mappedBy = "mundoList")
    private List<Imagen> imagenList;

    public Mundo() {
    }

    public Mundo(Integer idMundo) {
        this.idMundo = idMundo;
    }

    public Mundo(Integer idMundo, String nombreMundo) {
        this.idMundo = idMundo;
        this.nombreMundo = nombreMundo;
    }

    public Integer getIdMundo() {
        return idMundo;
    }

    public void setIdMundo(Integer idMundo) {
        this.idMundo = idMundo;
    }

    public String getNombreMundo() {
        return nombreMundo;
    }

    public void setNombreMundo(String nombreMundo) {
        this.nombreMundo = nombreMundo;
    }

    @XmlTransient
    public List<Imagen> getImagenList() {
        return imagenList;
    }

    public void setImagenList(List<Imagen> imagenList) {
        this.imagenList = imagenList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMundo != null ? idMundo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mundo)) {
            return false;
        }
        Mundo other = (Mundo) object;
        if ((this.idMundo == null && other.idMundo != null) || (this.idMundo != null && !this.idMundo.equals(other.idMundo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Mundo[ idMundo=" + idMundo + " ]";
    }
    
}
