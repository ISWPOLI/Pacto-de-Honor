package entities;

import entities.Imagen;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2017-04-19T20:44:21")
@StaticMetamodel(Mundo.class)
public class Mundo_ { 

    public static volatile SingularAttribute<Mundo, Integer> idMundo;
    public static volatile ListAttribute<Mundo, Imagen> imagenList;
    public static volatile SingularAttribute<Mundo, String> nombreMundo;

}