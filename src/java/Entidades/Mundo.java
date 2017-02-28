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
import javax.persistence.Id;
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
@Table(name = "mundo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mundo.findAll", query = "SELECT m FROM Mundo m")
    , @NamedQuery(name = "Mundo.findByIdMundo", query = "SELECT m FROM Mundo m WHERE m.idMundo = :idMundo")
    , @NamedQuery(name = "Mundo.findByNombremundo", query = "SELECT m FROM Mundo m WHERE m.nombremundo = :nombremundo")
    , @NamedQuery(name = "Mundo.findByIdPersonajeDesbloquear", query = "SELECT m FROM Mundo m WHERE m.idPersonajeDesbloquear = :idPersonajeDesbloquear")})
public class Mundo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idMundo")
    private Integer idMundo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "Nombre_mundo")
    private String nombremundo;
    @Size(max = 45)
    @Column(name = "id_personaje_desbloquear")
    private String idPersonajeDesbloquear;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "mundoidMundo")
    private List<Tablero> tableroList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "mundoidMundo")
    private List<Personaje> personajeList;

    public Mundo() {
    }

    public Mundo(Integer idMundo) {
        this.idMundo = idMundo;
    }

    public Mundo(Integer idMundo, String nombremundo) {
        this.idMundo = idMundo;
        this.nombremundo = nombremundo;
    }

    public Integer getIdMundo() {
        return idMundo;
    }

    public void setIdMundo(Integer idMundo) {
        this.idMundo = idMundo;
    }

    public String getNombremundo() {
        return nombremundo;
    }

    public void setNombremundo(String nombremundo) {
        this.nombremundo = nombremundo;
    }

    public String getIdPersonajeDesbloquear() {
        return idPersonajeDesbloquear;
    }

    public void setIdPersonajeDesbloquear(String idPersonajeDesbloquear) {
        this.idPersonajeDesbloquear = idPersonajeDesbloquear;
    }

    @XmlTransient
    public List<Tablero> getTableroList() {
        return tableroList;
    }

    public void setTableroList(List<Tablero> tableroList) {
        this.tableroList = tableroList;
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
