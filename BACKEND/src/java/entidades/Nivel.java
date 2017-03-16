/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
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
@Table(name = "nivel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Nivel.findAll", query = "SELECT n FROM Nivel n"),
    @NamedQuery(name = "Nivel.findByIdNivel", query = "SELECT n FROM Nivel n WHERE n.nivelPK.idNivel = :idNivel"),
    @NamedQuery(name = "Nivel.findByIdMundo", query = "SELECT n FROM Nivel n WHERE n.nivelPK.idMundo = :idMundo"),
    @NamedQuery(name = "Nivel.findByNombreNivel", query = "SELECT n FROM Nivel n WHERE n.nombreNivel = :nombreNivel")})
public class Nivel implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected NivelPK nivelPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_nivel")
    private String nombreNivel;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "nivel")
    private List<Jugador> jugadorList;
    @JoinColumn(name = "id_mundo", referencedColumnName = "id_mundo", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Mundo mundo;

    public Nivel() {
    }

    public Nivel(NivelPK nivelPK) {
        this.nivelPK = nivelPK;
    }

    public Nivel(NivelPK nivelPK, String nombreNivel) {
        this.nivelPK = nivelPK;
        this.nombreNivel = nombreNivel;
    }

    public Nivel(int idNivel, int idMundo) {
        this.nivelPK = new NivelPK(idNivel, idMundo);
    }

    public NivelPK getNivelPK() {
        return nivelPK;
    }

    public void setNivelPK(NivelPK nivelPK) {
        this.nivelPK = nivelPK;
    }

    public String getNombreNivel() {
        return nombreNivel;
    }

    public void setNombreNivel(String nombreNivel) {
        this.nombreNivel = nombreNivel;
    }

    @XmlTransient
    public List<Jugador> getJugadorList() {
        return jugadorList;
    }

    public void setJugadorList(List<Jugador> jugadorList) {
        this.jugadorList = jugadorList;
    }

    public Mundo getMundo() {
        return mundo;
    }

    public void setMundo(Mundo mundo) {
        this.mundo = mundo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nivelPK != null ? nivelPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Nivel)) {
            return false;
        }
        Nivel other = (Nivel) object;
        if ((this.nivelPK == null && other.nivelPK != null) || (this.nivelPK != null && !this.nivelPK.equals(other.nivelPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Nivel[ nivelPK=" + nivelPK + " ]";
    }
    
}
