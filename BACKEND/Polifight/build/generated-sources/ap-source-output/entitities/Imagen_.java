package entitities;

import entitities.Personaje;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-04-07T12:09:49")
@StaticMetamodel(Imagen.class)
public class Imagen_ { 

    public static volatile SingularAttribute<Imagen, String> foto;
    public static volatile SingularAttribute<Imagen, Integer> idImagen;
    public static volatile CollectionAttribute<Imagen, Personaje> personajeCollection;

}