--creacion de la tabla factores prueba psicotecnicas

CREATE TABLE `pactohonor`.`prueba_psicotecnica_Factores` 
( `id_factor` INT NOT NULL AUTO_INCREMENT , `sigla` VARCHAR(5) NOT NULL , `nombre_factor` TEXT NOT NULL ,
 `puntos_totales` INT NOT NULL , PRIMARY KEY (`id_factor`)) ENGINE = InnoDB;
 
 --insercion de factores

INSERT INTO `prueba_psicotecnica_Factores`(`sigla`, `nombre_factor`, `puntos_totales`) VALUES ('PAS','Prácticas Antisociales',13);
INSERT INTO `prueba_psicotecnica_Factores`(`sigla`, `nombre_factor`, `puntos_totales`) VALUES ('RS','Responsabilidad Social',14);

--modificaciones de preguntas

ALTER TABLE `pregunta_prueba_psicotecnica` CHANGE `id_tipo_pregunta_psicotecnica` `id_tipo_pregunta_psicotecnica` INT(11) NULL;
ALTER TABLE `pregunta_prueba_psicotecnica` ADD `numero_pregunta_prueba` INT NOT NULL ;

--inserciones de los tipo de pruebas

INSERT INTO `tipo_prueba` (`id_tipo_prueba`, `tipo_prueba`, `descripcion_tipo_prueba`) VALUES ('1', 'TEST', 'tipo de prueba desarrollada para completar los datos');

-- insercion de prueba

INSERT INTO `prueba_psicotecnica` (`id_prueba_psicotecnica`, `nombre`, `fecha_creacion`, `id_tipo_prueba`) VALUES ('1', 'MMPIA', '2017-04-01 00:00:00', '1');

-- insercion tipo de pregunta

INSERT INTO `tipo_pregunta_psicotecnica` (`id_tipo_pregunta_psicotecnica`, `clase_pregunta`) VALUES ('1', '1');
-- insercion de las preguntas

INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (1,1,'Me gustan leer los artículos sobre crímenes en los periodicos.',1,7);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (2,1,'Por principio, cuando alguien me hace algún mal siento que, de ser posible, deberia pagarle con la misma moneda.',1,27);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (3,1,'En ocasiones siento deseos de maldecir.',1,29);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (4,1,'Creo que la mayoría de la gente metiría para salir adelante.',1,81);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (5,1,'Cuando joven me suspendieron de la escuela una o más veces por mala conducta.',1,84);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (6,1,'Nunca he hecho algo peligroso sólo por el gusto de hacerlo.',1,100);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (7,1,'Disfruto más de una carrera o de un juego cuando apuesto.',1,103);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (8,1,'La mayor parte de la gente es honrada principalmente por temor a ser descubierta.',1,104);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (9,1,'En la escuela algunas veces me llevaron ante el director por mala conducta.',1,105);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (10,1,'Si pudiera entrar a un cine sin pagar y estuviera seguro de no ser descubierto, probablemente lo haría.',1,123);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (11,1,'Me gusta la ciencia.',1,199);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (12,1,'A mendo mis padres se oponían a la clase de gente que frecuentaba.',1,202);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (13,1,'Fui una persona lenta para aprender en la escuela.',1,235);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (14,1,'Nunca he tenido problemas con la ley.',1,266);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (15,1,'Si varias personas se hallan en apuros, lo mejor que pueden hacer es ponerse de acuerdo sobre lo que van a decir y mantenerse firmes en lo que acuerden.',1,269);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (16,1,'La persona que causa tentación dejando propiedades de valor sin protección, es tan culpable del robo como el ladrón.',1,283);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (17,1,'Creo que casi todo el mundo mentiría para evitarse problemas.',1,284);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (18,1,'La mayoría de las personas utilizaría medios, de alguna manera discutibles, para mejorar su situación en la vida.',1,374);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (19,1,'Cuando era chico(a) frecuentemente no iba a la escuela aunque debía haberlo hecho.',1,412);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (20,1,'Es correcto tratar de evitar el cumplimiento de la ley, siempre que ésta no se viole.',1,418);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (21,1,'Hay ciertas personas que me desagradan tanto, que me alegro interiormente cuando están pagando las consecuencias por algo que han hecho.',1,419);
INSERT INTO `pregunta_prueba_psicotecnica`(`id_pregunta_psicotecnica`, `id_prueba_psicotecnica`, `pregunta`, `id_tipo_pregunta_psicotecnica`, `numero_pregunta_prueba`) VALUES (22,1,'En la escuela mis calificaciones en conducta general eran malas.',1,431);

--modificaciones tabla respuesta
ALTER TABLE `respuesta_preguntas_psicotecnicas` ADD `id_factor` INT NOT NULL ;

--insercion respuestas

INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (1,2,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (1,3,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (2,4,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (2,5,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (3,6,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (3,7,'VERDADERO',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (4,8,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (4,9,'VERDADERO',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (5,10,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (5,11,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (6,12,'VERDADERO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (6,13,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (7,14,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (7,15,'VERDADERO',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (8,16,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (8,17,'VERDADERO',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (9,18,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (9,19,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (10,20,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (10,21,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (11,22,'VERDADERO ',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (11,23,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (12,24,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (12,25,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (13,26,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (13,27,'FALSO',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (14,28,'VERDADERO ',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (14,29,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (15,30,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (15,31,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (16,32,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (16,33,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (17,34,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (17,35,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (18,36,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (18,37,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (19,38,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (19,39,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (20,40,'FALSO',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (20,41,'VERDADERO ',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (21,42,'NULL',2);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (21,43,'NULL',1);
INSERT INTO `respuesta_preguntas_psicotecnicas` (`id_pregunta_prueba_psicotecnica`, `id_respuesta_psicotecnica`, `descripcion_prueba_psicotecnica`, `id_factor`) VALUES (22,44,'FALSO',2);

-- Creacion tabla de respuesta x jugador

CREATE TABLE `pactohonor`.`respuesta_prueba_jugador` ( `id_respuesta_prueba_jugador` INT NOT NULL AUTO_INCREMENT , 
`id_respuesta` INT NOT NULL , `id_jugador` INT NOT NULL , PRIMARY KEY (`id_respuesta_prueba_jugador`)) ENGINE = InnoDB;


