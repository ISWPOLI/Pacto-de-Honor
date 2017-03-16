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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
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
@Table(name = "imagen", catalog = "p_h01", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Imagen.findAll", query = "SELECT i FROM Imagen i"),
    @NamedQuery(name = "Imagen.findByIdImagen", query = "SELECT i FROM Imagen i WHERE i.idImagen = :idImagen"),
    @NamedQuery(name = "Imagen.findByFoto", query = "SELECT i FROM Imagen i WHERE i.foto = :foto")})
public class Imagen implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_imagen", nullable = false)
    private Integer idImagen;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "foto", nullable = false, length = 255)
    private String foto;
    @JoinTable(name = "mundo_tiene_imagen", joinColumns = {
        @JoinColumn(name = "id_imagen", referencedColumnName = "id_imagen", nullable = false)}, inverseJoinColumns = {
        @JoinColumn(name = "id_mundo", referencedColumnName = "id_mundo", nullable = false)})
    @ManyToMany
    private List<Mundo> mundoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "imagen")
    private List<Poder> poderList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "imagen")
    private List<Personaje> personajeList;

    public Imagen() {
    }

    public Imagen(Integer idImagen) {
        this.idImagen = idImagen;
    }

    public Imagen(Integer idImagen, String foto) {
        this.idImagen = idImagen;
        this.foto = foto;
    }

    public Integer getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(Integer idImagen) {
        this.idImagen = idImagen;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    @XmlTransient
    public List<Mundo> getMundoList() {
        return mundoList;
    }

    public void setMundoList(List<Mundo> mundoList) {
        this.mundoList = mundoList;
    }

    @XmlTransient
    public List<Poder> getPoderList() {
        return poderList;
    }

    public void setPoderList(List<Poder> poderList) {
        this.poderList = poderList;
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
        hash += (idImagen != null ? idImagen.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Imagen)) {
            return false;
        }
        Imagen other = (Imagen) object;
        if ((this.idImagen == null && other.idImagen != null) || (this.idImagen != null && !this.idImagen.equals(other.idImagen))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Imagen[ idImagen=" + idImagen + " ]";
    }
    
}
