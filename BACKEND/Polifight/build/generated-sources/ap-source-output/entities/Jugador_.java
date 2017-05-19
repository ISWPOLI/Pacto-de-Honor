package entities;

import entities.Nivel;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-05-10T21:31:15")
@StaticMetamodel(Jugador.class)
public class Jugador_ { 

    public static volatile SingularAttribute<Jugador, Integer> idJugador;
    public static volatile SingularAttribute<Jugador, Integer> monedaJugador;
    public static volatile SingularAttribute<Jugador, Integer> nivelJugador;
    public static volatile SingularAttribute<Jugador, String> nickname;
    public static volatile SingularAttribute<Jugador, Integer> experienciaJugador;
    public static volatile SingularAttribute<Jugador, Nivel> nivel;

}