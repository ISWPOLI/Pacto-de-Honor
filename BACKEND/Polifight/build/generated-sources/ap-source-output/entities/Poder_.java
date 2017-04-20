package entities;

import entities.Imagen;
import entities.PoderPK;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2017-04-19T20:44:21")
@StaticMetamodel(Poder.class)
public class Poder_ { 

    public static volatile SingularAttribute<Poder, Integer> tipoPoder;
    public static volatile SingularAttribute<Poder, String> nombrePoder;
    public static volatile SingularAttribute<Poder, Integer> formaPoder;
    public static volatile SingularAttribute<Poder, PoderPK> poderPK;
    public static volatile SingularAttribute<Poder, Imagen> imagen;
    public static volatile SingularAttribute<Poder, Integer> potenciaPoder;
    public static volatile SingularAttribute<Poder, String> descripcionPoder;

}