package entitities;

import entitities.Categoria;
import entitities.Imagen;
import entitities.PersonajePK;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-04-07T12:09:49")
@StaticMetamodel(Personaje.class)
public class Personaje_ { 

    public static volatile SingularAttribute<Personaje, String> nombrePersonaje;
    public static volatile SingularAttribute<Personaje, Integer> costo;
    public static volatile SingularAttribute<Personaje, Categoria> categoria;
    public static volatile SingularAttribute<Personaje, String> descripcionPersonaje;
    public static volatile SingularAttribute<Personaje, Imagen> imagen;
    public static volatile SingularAttribute<Personaje, PersonajePK> personajePK;
    public static volatile SingularAttribute<Personaje, Integer> nivelDano;

}