/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author nimartinezma
 */
@Entity
@Table(name = "prueba_psicotecnica_Factores")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PruebapsicotecnicaFactores.findAll", query = "SELECT p FROM PruebapsicotecnicaFactores p"),
    @NamedQuery(name = "PruebapsicotecnicaFactores.findByIdFactor", query = "SELECT p FROM PruebapsicotecnicaFactores p WHERE p.idFactor = :idFactor"),
    @NamedQuery(name = "PruebapsicotecnicaFactores.findBySigla", query = "SELECT p FROM PruebapsicotecnicaFactores p WHERE p.sigla = :sigla"),
    @NamedQuery(name = "PruebapsicotecnicaFactores.findByPuntosTotales", query = "SELECT p FROM PruebapsicotecnicaFactores p WHERE p.puntosTotales = :puntosTotales")})
public class PruebapsicotecnicaFactores implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_factor")
    private Integer idFactor;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5)
    @Column(name = "sigla")
    private String sigla;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "nombre_factor")
    private String nombreFactor;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puntos_totales")
    private int puntosTotales;

    public PruebapsicotecnicaFactores() {
    }

    public PruebapsicotecnicaFactores(Integer idFactor) {
        this.idFactor = idFactor;
    }

    public PruebapsicotecnicaFactores(Integer idFactor, String sigla, String nombreFactor, int puntosTotales) {
        this.idFactor = idFactor;
        this.sigla = sigla;
        this.nombreFactor = nombreFactor;
        this.puntosTotales = puntosTotales;
    }

    public Integer getIdFactor() {
        return idFactor;
    }

    public void setIdFactor(Integer idFactor) {
        this.idFactor = idFactor;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public String getNombreFactor() {
        return nombreFactor;
    }

    public void setNombreFactor(String nombreFactor) {
        this.nombreFactor = nombreFactor;
    }

    public int getPuntosTotales() {
        return puntosTotales;
    }

    public void setPuntosTotales(int puntosTotales) {
        this.puntosTotales = puntosTotales;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFactor != null ? idFactor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PruebapsicotecnicaFactores)) {
            return false;
        }
        PruebapsicotecnicaFactores other = (PruebapsicotecnicaFactores) object;
        if ((this.idFactor == null && other.idFactor != null) || (this.idFactor != null && !this.idFactor.equals(other.idFactor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.PruebapsicotecnicaFactores[ idFactor=" + idFactor + " ]";
    }
    
}
