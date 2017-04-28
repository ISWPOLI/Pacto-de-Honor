 CREATE TABLE `pactohonor`.`categoriaImagen` 
 ( `id_categoriaImagen` INT NOT NULL AUTO_INCREMENT , `descCategoriaImagen` VARCHAR(50) NOT NULL , PRIMARY KEY (`id_categoriaImagen`)) ENGINE = InnoDB;

INSERT INTO `categoriaImagen`( `descCategoriaImagen`) VALUES ('Sprite');
INSERT INTO `categoriaImagen`( `descCategoriaImagen`) VALUES ('BotonPoder');
INSERT INTO `categoriaImagen`( `descCategoriaImagen`) VALUES ('ImpactoPersonalidad');

CREATE TABLE `pactohonor`.`personaje_tiene_imagen` ( `id_personaje_tiene_imagen` INT NOT NULL AUTO_INCREMENT , PRIMARY KEY (`id_personaje_tiene_imagen`)) ENGINE = InnoDB;
ALTER TABLE `personaje_tiene_imagen` ADD `id_Imgen` INT NOT NULL ;
ALTER TABLE `personaje_tiene_imagen` ADD `id_personaje` INT NOT NULL ;
ALTER TABLE `personaje_tiene_imagen` ADD `id_categoriaImagen` INT NOT NULL ;


ALTER TABLE `personaje_tiene_imagen`
ADD CONSTRAINT `FK_id_CategoriaImagen`  
FOREIGN KEY (`id_categoriaImagen`) 
REFERENCES `pactohonor`.`categoriaImagen` (`id_categoriaImagen`)  
ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `personaje_tiene_imagen`
ADD CONSTRAINT `FK_id_Personaje`  
FOREIGN KEY (`id_personaje`) 
REFERENCES `pactohonor`.`personaje` (`id_personaje`)  
ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `personaje_tiene_imagen`
ADD CONSTRAINT `FK_id_Imgen`  
FOREIGN KEY (`id_Imgen`) 
REFERENCES `pactohonor`.`imagen` (`id_imagen`)  
ON DELETE NO ACTION ON UPDATE NO ACTION;
