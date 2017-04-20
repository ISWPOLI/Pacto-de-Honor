package entities;

import entities.PruebaPsicotecnica;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2017-04-19T20:44:21")
@StaticMetamodel(TipoPrueba.class)
public class TipoPrueba_ { 

    public static volatile SingularAttribute<TipoPrueba, String> descripcionTipoPrueba;
    public static volatile SingularAttribute<TipoPrueba, Integer> idTipoPrueba;
    public static volatile SingularAttribute<TipoPrueba, String> tipoPrueba;
    public static volatile CollectionAttribute<TipoPrueba, PruebaPsicotecnica> pruebaPsicotecnicaCollection;

}