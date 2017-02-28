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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
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
@Table(name = "personaje")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Personaje.findAll", query = "SELECT p FROM Personaje p")
    , @NamedQuery(name = "Personaje.findByIdPersonaje", query = "SELECT p FROM Personaje p WHERE p.idPersonaje = :idPersonaje")
    , @NamedQuery(name = "Personaje.findByNombre", query = "SELECT p FROM Personaje p WHERE p.nombre = :nombre")
    , @NamedQuery(name = "Personaje.findByDescripcionp", query = "SELECT p FROM Personaje p WHERE p.descripcionp = :descripcionp")
    , @NamedQuery(name = "Personaje.findByCosto", query = "SELECT p FROM Personaje p WHERE p.costo = :costo")
    , @NamedQuery(name = "Personaje.findByIdPoder1", query = "SELECT p FROM Personaje p WHERE p.idPoder1 = :idPoder1")
    , @NamedQuery(name = "Personaje.findByIdPoder2", query = "SELECT p FROM Personaje p WHERE p.idPoder2 = :idPoder2")
    , @NamedQuery(name = "Personaje.findByPuntosataquesfisicos", query = "SELECT p FROM Personaje p WHERE p.puntosataquesfisicos = :puntosataquesfisicos")
    , @NamedQuery(name = "Personaje.findByRol", query = "SELECT p FROM Personaje p WHERE p.rol = :rol")})
public class Personaje implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idPersonaje")
    private Integer idPersonaje;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Descripcion_p")
    private String descripcionp;
    @Basic(optional = false)
    @NotNull
    @Column(name = "costo")
    private int costo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_poder1")
    private int idPoder1;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_poder2")
    private int idPoder2;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Puntos_ataques_fisicos")
    private int puntosataquesfisicos;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 7)
    @Column(name = "rol")
    private String rol;
    @ManyToMany(mappedBy = "personajeList")
    private List<Jugador> jugadorList;
    @JoinTable(name = "personaje_has_poder", joinColumns = {
        @JoinColumn(name = "Personaje_idPersonaje", referencedColumnName = "idPersonaje")}, inverseJoinColumns = {
        @JoinColumn(name = "poder_idpoder", referencedColumnName = "idpoder")})
    @ManyToMany
    private List<Poder> poderList;
    @JoinColumn(name = "Mundo_idMundo", referencedColumnName = "idMundo")
    @ManyToOne(optional = false)
    private Mundo mundoidMundo;
    @JoinColumn(name = "tablero_idtalero", referencedColumnName = "idtalero")
    @ManyToOne(optional = false)
    private Tablero tableroIdtalero;

    public Personaje() {
    }

    public Personaje(Integer idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    public Personaje(Integer idPersonaje, String nombre, String descripcionp, int costo, int idPoder1, int idPoder2, int puntosataquesfisicos, String rol) {
        this.idPersonaje = idPersonaje;
        this.nombre = nombre;
        this.descripcionp = descripcionp;
        this.costo = costo;
        this.idPoder1 = idPoder1;
        this.idPoder2 = idPoder2;
        this.puntosataquesfisicos = puntosataquesfisicos;
        this.rol = rol;
    }

    public Integer getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(Integer idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcionp() {
        return descripcionp;
    }

    public void setDescripcionp(String descripcionp) {
        this.descripcionp = descripcionp;
    }

    public int getCosto() {
        return costo;
    }

    public void setCosto(int costo) {
        this.costo = costo;
    }

    public int getIdPoder1() {
        return idPoder1;
    }

    public void setIdPoder1(int idPoder1) {
        this.idPoder1 = idPoder1;
    }

    public int getIdPoder2() {
        return idPoder2;
    }

    public void setIdPoder2(int idPoder2) {
        this.idPoder2 = idPoder2;
    }

    public int getPuntosataquesfisicos() {
        return puntosataquesfisicos;
    }

    public void setPuntosataquesfisicos(int puntosataquesfisicos) {
        this.puntosataquesfisicos = puntosataquesfisicos;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    @XmlTransient
    public List<Jugador> getJugadorList() {
        return jugadorList;
    }

    public void setJugadorList(List<Jugador> jugadorList) {
        this.jugadorList = jugadorList;
    }

    @XmlTransient
    public List<Poder> getPoderList() {
        return poderList;
    }

    public void setPoderList(List<Poder> poderList) {
        this.poderList = poderList;
    }

    public Mundo getMundoidMundo() {
        return mundoidMundo;
    }

    public void setMundoidMundo(Mundo mundoidMundo) {
        this.mundoidMundo = mundoidMundo;
    }

    public Tablero getTableroIdtalero() {
        return tableroIdtalero;
    }

    public void setTableroIdtalero(Tablero tableroIdtalero) {
        this.tableroIdtalero = tableroIdtalero;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPersonaje != null ? idPersonaje.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Personaje)) {
            return false;
        }
        Personaje other = (Personaje) object;
        if ((this.idPersonaje == null && other.idPersonaje != null) || (this.idPersonaje != null && !this.idPersonaje.equals(other.idPersonaje))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.Personaje[ idPersonaje=" + idPersonaje + " ]";
    }
    
}
