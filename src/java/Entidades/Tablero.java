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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "tablero")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tablero.findAll", query = "SELECT t FROM Tablero t")
    , @NamedQuery(name = "Tablero.findByIdtalero", query = "SELECT t FROM Tablero t WHERE t.idtalero = :idtalero")
    , @NamedQuery(name = "Tablero.findByNombreTablero", query = "SELECT t FROM Tablero t WHERE t.nombreTablero = :nombreTablero")
    , @NamedQuery(name = "Tablero.findByIdPersonajeEnemigo", query = "SELECT t FROM Tablero t WHERE t.idPersonajeEnemigo = :idPersonajeEnemigo")})
public class Tablero implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idtalero")
    private Integer idtalero;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_tablero")
    private String nombreTablero;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_personaje_enemigo")
    private int idPersonajeEnemigo;
    @JoinColumn(name = "Mundo_idMundo", referencedColumnName = "idMundo")
    @ManyToOne(optional = false)
    private Mundo mundoidMundo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tableroIdtalero")
    private List<Personaje> personajeList;

    public Tablero() {
    }

    public Tablero(Integer idtalero) {
        this.idtalero = idtalero;
    }

    public Tablero(Integer idtalero, String nombreTablero, int idPersonajeEnemigo) {
        this.idtalero = idtalero;
        this.nombreTablero = nombreTablero;
        this.idPersonajeEnemigo = idPersonajeEnemigo;
    }

    public Integer getIdtalero() {
        return idtalero;
    }

    public void setIdtalero(Integer idtalero) {
        this.idtalero = idtalero;
    }

    public String getNombreTablero() {
        return nombreTablero;
    }

    public void setNombreTablero(String nombreTablero) {
        this.nombreTablero = nombreTablero;
    }

    public int getIdPersonajeEnemigo() {
        return idPersonajeEnemigo;
    }

    public void setIdPersonajeEnemigo(int idPersonajeEnemigo) {
        this.idPersonajeEnemigo = idPersonajeEnemigo;
    }

    public Mundo getMundoidMundo() {
        return mundoidMundo;
    }

    public void setMundoidMundo(Mundo mundoidMundo) {
        this.mundoidMundo = mundoidMundo;
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
        hash += (idtalero != null ? idtalero.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tablero)) {
            return false;
        }
        Tablero other = (Tablero) object;
        if ((this.idtalero == null && other.idtalero != null) || (this.idtalero != null && !this.idtalero.equals(other.idtalero))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Tablero[ idtalero=" + idtalero + " ]";
    }
    
}
