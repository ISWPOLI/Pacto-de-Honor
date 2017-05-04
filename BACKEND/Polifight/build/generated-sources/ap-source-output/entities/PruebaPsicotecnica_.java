package entities;

import entities.PruebaPsicotecnicaPK;
import entities.TipoPrueba;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-05-03T21:35:20")
@StaticMetamodel(PruebaPsicotecnica.class)
public class PruebaPsicotecnica_ { 

    public static volatile SingularAttribute<PruebaPsicotecnica, PruebaPsicotecnicaPK> pruebaPsicotecnicaPK;
    public static volatile SingularAttribute<PruebaPsicotecnica, TipoPrueba> tipoPrueba;
    public static volatile SingularAttribute<PruebaPsicotecnica, Date> fechaCreacion;
    public static volatile SingularAttribute<PruebaPsicotecnica, String> nombre;

}