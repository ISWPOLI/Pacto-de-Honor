/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import Entidades.Personaje;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Will
 */
@Stateless
public class PersonajeFacade extends AbstractFacade<Personaje> {

    @PersistenceContext(unitName = "com.P_HdbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PersonajeFacade() {
        super(Personaje.class);
    }
    
}
