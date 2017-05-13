package entities;

import entities.Categoriaimagen;
import entities.Imagen;
import entities.Personaje;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-05-10T21:31:15")
@StaticMetamodel(PersonajeTieneImagen.class)
public class PersonajeTieneImagen_ { 

    public static volatile SingularAttribute<PersonajeTieneImagen, Categoriaimagen> idCategoriaImagen;
    public static volatile SingularAttribute<PersonajeTieneImagen, Personaje> idPersonaje;
    public static volatile SingularAttribute<PersonajeTieneImagen, Imagen> idImagen;
    public static volatile SingularAttribute<PersonajeTieneImagen, Integer> idPersonajeTieneImagen;

}