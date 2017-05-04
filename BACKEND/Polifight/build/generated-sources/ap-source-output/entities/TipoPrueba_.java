package entities;

import entities.PruebaPsicotecnica;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-05-03T21:35:20")
@StaticMetamodel(TipoPrueba.class)
public class TipoPrueba_ { 

    public static volatile SingularAttribute<TipoPrueba, String> descripcionTipoPrueba;
    public static volatile SingularAttribute<TipoPrueba, Integer> idTipoPrueba;
    public static volatile SingularAttribute<TipoPrueba, String> tipoPrueba;
    public static volatile CollectionAttribute<TipoPrueba, PruebaPsicotecnica> pruebaPsicotecnicaCollection;

}