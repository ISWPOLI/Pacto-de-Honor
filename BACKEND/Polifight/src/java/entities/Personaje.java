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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entidad Personaje
 * @author jrubiaob
 */
@Entity
@Table(name = "personaje")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Personaje.findAll", query = "SELECT p FROM Personaje p"),
    @NamedQuery(name = "Personaje.findRange", query = "SELECT p FROM Personaje p WHERE p.idPersonaje BETWEEN :from AND :to"),
    @NamedQuery(name = "Personaje.findByIdPersonaje", query = "SELECT p FROM Personaje p WHERE p.idPersonaje = :idPersonaje"),
    @NamedQuery(name = "Personaje.findByIdCategoria", query = "SELECT p FROM Personaje p WHERE p.idCategoria = :idCategoria"),
    @NamedQuery(name = "Personaje.findByIdImagen", query = "SELECT p FROM Personaje p WHERE p.idImagen = :idImagen"),
    @NamedQuery(name = "Personaje.findByNombrePersonaje", query = "SELECT p FROM Personaje p WHERE p.nombrePersonaje = :nombrePersonaje"),
    @NamedQuery(name = "Personaje.findByDescripcionPersonaje", query = "SELECT p FROM Personaje p WHERE p.descripcionPersonaje = :descripcionPersonaje"),
    @NamedQuery(name = "Personaje.findByCosto", query = "SELECT p FROM Personaje p WHERE p.costo = :costo"),
    @NamedQuery(name = "Personaje.findByNivelDano", query = "SELECT p FROM Personaje p WHERE p.nivelDano = :nivelDano"),
    @NamedQuery(name = "Personaje.listById", query = "SELECT p.idPersonaje, p.nombrePersonaje FROM Personaje p ")})
public class Personaje implements Serializable {
    
    private static final long serialVersionUID = 1L;  
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_personaje")
    private Integer idPersonaje;
    
    
    @Basic(optional = false)
    @Column(name = "id_categoria")
    @JoinColumn(name = "id_categoria", referencedColumnName = "id_categoria", insertable = false, updatable = false)        
    @ManyToOne(optional = false)
    private int idCategoria;
    
    
    @Basic(optional = false)
    @Column(name = "id_imagen")
    @JoinColumn(name = "id_imagen", referencedColumnName = "id_imagen", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private int idImagen;
    
    @Basic(optional = false)
    @Size(min = 1, max = 20)
    @Column(name = "nombre_personaje")
    private String nombrePersonaje;
    
    @Basic(optional = false)
    @Size(min = 1, max = 255)
    @Column(name = "descripcion_personaje")
    private String descripcionPersonaje;
    
    @Basic(optional = false)
    @Column(name = "costo")
    private int costo;
    
    @Basic(optional = false)
    @Column(name = "nivel_dano")
    private int nivelDano; 
    

    public Personaje() {
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(int idImagen) {
        this.idImagen = idImagen;
    }  

    public String getNombrePersonaje() {
        return nombrePersonaje;
    }

    public void setNombrePersonaje(String nombrePersonaje) {
        this.nombrePersonaje = nombrePersonaje;
    }

    public String getDescripcionPersonaje() {
        return descripcionPersonaje;
    }

    public void setDescripcionPersonaje(String descripcionPersonaje) {
        this.descripcionPersonaje = descripcionPersonaje;
    }

    public int getCosto() {
        return costo;
    }

    public void setCosto(int costo) {
        this.costo = costo;
    }

    public int getNivelDano() {
        return nivelDano;
    }

    public void setNivelDano(int nivelDano) {
        this.nivelDano = nivelDano;
    }
   
    public Integer getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(Integer idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

     
    
}
