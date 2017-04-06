/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.ejb.JBean;
import javax.persistence.EntityManagerFactory;
import Controlador.entidades.Registrologin;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author JERR
 */
@Stateless
public class JavaBeansLogin extends AbstractFacade<Registrologin> {

    @PersistenceContext(unitName = "PruebasPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public JavaBeansLogin() {
        super(Registrologin.class);
    }
    
    @Override
    public void create(Registrologin e){
        em.persist(e);
    }
}
