package com.poder.Restful.PH;

import com.poder.Restful.PH.Imagen;
import com.poder.Restful.PH.PoderPK;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2017-04-05T19:27:48")
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