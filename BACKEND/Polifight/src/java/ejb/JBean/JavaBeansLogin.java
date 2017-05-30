/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb.JBean;
import entities.Usuario;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author JERR
 */
@Stateless
public class JavaBeansLogin extends AbstractFacade<Usuario> {

    @PersistenceContext(unitName = "PolifightPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public JavaBeansLogin() {
        super(Usuario.class);
    }
    
    @Override
    public void create(Usuario e){
        em.persist(e);
    }
     
    
}
