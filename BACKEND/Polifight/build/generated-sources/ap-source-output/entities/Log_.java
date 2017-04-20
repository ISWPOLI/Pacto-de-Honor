package entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2017-04-19T20:44:21")
@StaticMetamodel(Log.class)
public class Log_ { 

    public static volatile SingularAttribute<Log, Integer> idJugador;
    public static volatile SingularAttribute<Log, String> tiempo;
    public static volatile SingularAttribute<Log, String> fechaInicio;
    public static volatile SingularAttribute<Log, Integer> idUsuario;
    public static volatile SingularAttribute<Log, String> fechaFinal;

}