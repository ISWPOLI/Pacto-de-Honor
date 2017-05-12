/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Usuario
 */
@Entity
@Table(name = "codigos_alfanumericos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CodigosAlfanumericos.findAll", query = "SELECT c FROM CodigosAlfanumericos c")
    , @NamedQuery(name = "CodigosAlfanumericos.findByIdCodigosAlfanumericos", query = "SELECT c FROM CodigosAlfanumericos c WHERE c.idCodigosAlfanumericos = :idCodigosAlfanumericos")
    , @NamedQuery(name = "CodigosAlfanumericos.findByFechaCreacion", query = "SELECT c FROM CodigosAlfanumericos c WHERE c.fechaCreacion = :fechaCreacion")
    , @NamedQuery(name = "CodigosAlfanumericos.findByVigencia", query = "SELECT c FROM CodigosAlfanumericos c WHERE c.vigencia = :vigencia")
    , @NamedQuery(name = "CodigosAlfanumericos.findByUsado", query = "SELECT c FROM CodigosAlfanumericos c WHERE c.usado = :usado")
    , @NamedQuery(name = "CodigosAlfanumericos.findByCodigo", query = "SELECT c FROM CodigosAlfanumericos c WHERE c.codigo = :codigo")})
public class CodigosAlfanumericos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_codigos_alfanumericos")
    private Integer idCodigosAlfanumericos;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_creacion")
    @Temporal(TemporalType.DATE)
    private Date fechaCreacion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "vigencia")
    private int vigencia;
    @Column(name = "usado")
    private Boolean usado;
    @Column(name="codigo")
    private String codigo;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public CodigosAlfanumericos() {
    }

    public CodigosAlfanumericos(Integer idCodigosAlfanumericos) {
        this.idCodigosAlfanumericos = idCodigosAlfanumericos;
    }

    public CodigosAlfanumericos(Integer idCodigosAlfanumericos, Date fechaCreacion, int vigencia) {
        this.idCodigosAlfanumericos = idCodigosAlfanumericos;
        this.fechaCreacion = fechaCreacion;
        this.vigencia = vigencia;
    }

    public Integer getIdCodigosAlfanumericos() {
        return idCodigosAlfanumericos;
    }

    public void setIdCodigosAlfanumericos(Integer idCodigosAlfanumericos) {
        this.idCodigosAlfanumericos = idCodigosAlfanumericos;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public int getVigencia() {
        return vigencia;
    }

    public void setVigencia(int vigencia) {
        this.vigencia = vigencia;
    }

    public Boolean getUsado() {
        return usado;
    }

    public void setUsado(Boolean usado) {
        this.usado = usado;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCodigosAlfanumericos != null ? idCodigosAlfanumericos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CodigosAlfanumericos)) {
            return false;
        }
        CodigosAlfanumericos other = (CodigosAlfanumericos) object;
        if ((this.idCodigosAlfanumericos == null && other.idCodigosAlfanumericos != null) || (this.idCodigosAlfanumericos != null && !this.idCodigosAlfanumericos.equals(other.idCodigosAlfanumericos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        StringBuilder print= new StringBuilder();
        print.append("Entity Codigos");
        print.append("/n");
        print.append(this.usado);
        
        return print.toString();
    }
    
}
