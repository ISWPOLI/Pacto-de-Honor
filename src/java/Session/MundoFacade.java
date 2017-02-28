/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import Entidades.Mundo;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Will
 */
@Stateless
public class MundoFacade extends AbstractFacade<Mundo> {

    @PersistenceContext(unitName = "com.P_HdbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MundoFacade() {
        super(Mundo.class);
    }
    
}