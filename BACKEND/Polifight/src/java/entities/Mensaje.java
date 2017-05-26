package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entidad para la tabla "mensaje"
 * @author jrubiaob
 */
@Entity
@Table(name = "mensaje")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mensaje.findAll", query = "SELECT m FROM Mensaje m"),
    @NamedQuery(name = "Mensaje.findByIdMensaje", query = "SELECT m FROM Mensaje m WHERE m.idMensaje = :idMensaje"),
    @NamedQuery(name = "Mensaje.findByIdJugadorFrom", query = "SELECT m FROM Mensaje m WHERE m.idJugadorFrom = :idJugadorFrom"),
    @NamedQuery(name = "Mensaje.findByIdJugadorTo", query = "SELECT m FROM Mensaje m WHERE m.idJugadorTo = :idJugadorTo"),
    @NamedQuery(name = "Mensaje.findByMensaje", query = "SELECT m FROM Mensaje m WHERE m.mensaje = :mensaje"),
    @NamedQuery(name = "Mensaje.findByIsChat", query = "SELECT m FROM Mensaje m WHERE m.isChat = :isChat")})
public class Mensaje implements Serializable { 
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_mensaje")
    private Integer idMensaje;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_jugador_from")
    private int idJugadorFrom;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_jugador_to")
    private int idJugadorTo;
    
    @Size(max = 5000)
    @Column(name = "mensaje")
    private String mensaje;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "isChat")
    private boolean isChat;

    public Mensaje() {
    }

    public Mensaje(Integer idMensaje) {
        this.idMensaje = idMensaje;
    }

    public Mensaje(Integer idMensaje, int idJugadorFrom, int idJugadorTo, boolean isChat) {
        this.idMensaje = idMensaje;
        this.idJugadorFrom = idJugadorFrom;
        this.idJugadorTo = idJugadorTo;
        this.isChat = isChat;
    }

    public Integer getIdMensaje() {
        return idMensaje;
    }

    public void setIdMensaje(Integer idMensaje) {
        this.idMensaje = idMensaje;
    }

    public int getIdJugadorFrom() {
        return idJugadorFrom;
    }

    public void setIdJugadorFrom(int idJugadorFrom) {
        this.idJugadorFrom = idJugadorFrom;
    }

    public int getIdJugadorTo() {
        return idJugadorTo;
    }

    public void setIdJugadorTo(int idJugadorTo) {
        this.idJugadorTo = idJugadorTo;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public boolean getIsChat() {
        return isChat;
    }

    public void setIsChat(boolean isChat) {
        this.isChat = isChat;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMensaje != null ? idMensaje.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mensaje)) {
            return false;
        }
        Mensaje other = (Mensaje) object;
        if ((this.idMensaje == null && other.idMensaje != null) || (this.idMensaje != null && !this.idMensaje.equals(other.idMensaje))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Mensaje[ idMensaje=" + idMensaje + " ]";
    }
    
}
