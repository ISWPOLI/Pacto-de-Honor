-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-04-2017 a las 18:22:22
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `p_h01`
--
CREATE DATABASE IF NOT EXISTS `p_h01` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `p_h01`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `Nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idJugador` int(11) NOT NULL,
  `nickname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `monedas` int(11) NOT NULL,
  `puntosexpe` int(11) NOT NULL,
  `nivel_jugador` int(11) NOT NULL,
  `puntos_vida` int(11) NOT NULL,
  `Nivel_idnivel` int(11) NOT NULL,
  `Log_idLog` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador_has_personaje`
--

CREATE TABLE `jugador_has_personaje` (
  `Jugador_idJugador` int(11) NOT NULL,
  `Personaje_idPersonaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `idLog` int(11) NOT NULL,
  `idjugador` int(11) NOT NULL,
  `Tiempo` time(4) NOT NULL,
  `fechainicio` datetime(6) NOT NULL,
  `fechafinal` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mundo`
--

CREATE TABLE `mundo` (
  `idMundo` int(11) NOT NULL,
  `Nombre_mundo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `id_personaje_desbloquear` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Nivel_idtalero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `idnivel` int(11) NOT NULL,
  `nombre_nivel` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `id_personaje_enemigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje`
--

CREATE TABLE `personaje` (
  `idPersonaje` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `Descripcion_p` varchar(255) NOT NULL,
  `costo` int(11) NOT NULL,
  `Puntos_ataques_fisicos` int(11) NOT NULL,
  `Categoria_idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5 COMMENT='	';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje_has_poder`
--

CREATE TABLE `personaje_has_poder` (
  `Personaje_idPersonaje` int(11) NOT NULL,
  `poder_idpoder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poder`
--

CREATE TABLE `poder` (
  `idpoder` int(11) NOT NULL,
  `nombre_poder` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion_poder` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tipo_poder` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `forma_poder` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `potencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idJugador`,`Nivel_idnivel`,`Log_idLog`),
  ADD KEY `fk_Jugador_Nivel1_idx` (`Nivel_idnivel`),
  ADD KEY `fk_Jugador_Log1_idx` (`Log_idLog`);

--
-- Indices de la tabla `jugador_has_personaje`
--
ALTER TABLE `jugador_has_personaje`
  ADD PRIMARY KEY (`Jugador_idJugador`,`Personaje_idPersonaje`),
  ADD KEY `fk_Jugador_has_Personaje_Personaje1_idx` (`Personaje_idPersonaje`),
  ADD KEY `fk_Jugador_has_Personaje_Jugador_idx` (`Jugador_idJugador`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`idLog`);

--
-- Indices de la tabla `mundo`
--
ALTER TABLE `mundo`
  ADD PRIMARY KEY (`idMundo`,`Nivel_idtalero`),
  ADD KEY `fk_Mundo_Nivel1_idx` (`Nivel_idtalero`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`idnivel`);

--
-- Indices de la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD PRIMARY KEY (`idPersonaje`,`Categoria_idCategoria`),
  ADD KEY `fk_Personaje_Categoria1_idx` (`Categoria_idCategoria`);

--
-- Indices de la tabla `personaje_has_poder`
--
ALTER TABLE `personaje_has_poder`
  ADD PRIMARY KEY (`Personaje_idPersonaje`,`poder_idpoder`),
  ADD KEY `fk_Personaje_has_poder_poder1_idx` (`poder_idpoder`),
  ADD KEY `fk_Personaje_has_poder_Personaje1_idx` (`Personaje_idPersonaje`);

--
-- Indices de la tabla `poder`
--
ALTER TABLE `poder`
  ADD PRIMARY KEY (`idpoder`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `idJugador` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `idLog` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `personaje`
--
ALTER TABLE `personaje`
  MODIFY `idPersonaje` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `poder`
--
ALTER TABLE `poder`
  MODIFY `idpoder` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `fk_Jugador_Log1` FOREIGN KEY (`Log_idLog`) REFERENCES `log` (`idLog`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jugador_Nivel1` FOREIGN KEY (`Nivel_idnivel`) REFERENCES `nivel` (`idnivel`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `jugador_has_personaje`
--
ALTER TABLE `jugador_has_personaje`
  ADD CONSTRAINT `fk_Jugador_has_Personaje_Jugador` FOREIGN KEY (`Jugador_idJugador`) REFERENCES `jugador` (`idJugador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jugador_has_Personaje_Personaje1` FOREIGN KEY (`Personaje_idPersonaje`) REFERENCES `personaje` (`idPersonaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `mundo`
--
ALTER TABLE `mundo`
  ADD CONSTRAINT `fk_Mundo_Nivel1` FOREIGN KEY (`Nivel_idtalero`) REFERENCES `nivel` (`idnivel`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD CONSTRAINT `fk_Personaje_Categoria1` FOREIGN KEY (`Categoria_idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje_has_poder`
--
ALTER TABLE `personaje_has_poder`
  ADD CONSTRAINT `fk_Personaje_has_poder_Personaje1` FOREIGN KEY (`Personaje_idPersonaje`) REFERENCES `personaje` (`idPersonaje`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Personaje_has_poder_poder1` FOREIGN KEY (`poder_idpoder`) REFERENCES `poder` (`idpoder`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `pactohonor`
--
CREATE DATABASE IF NOT EXISTS `pactohonor` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `pactohonor`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `rol` int(11) NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `rol`, `tipo`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2),
(5, 3, 1),
(6, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoriaimagen`
--

CREATE TABLE `categoriaimagen` (
  `id_categoriaImagen` int(11) NOT NULL,
  `descCategoriaImagen` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoriaimagen`
--

INSERT INTO `categoriaimagen` (`id_categoriaImagen`, `descCategoriaImagen`) VALUES
(1, 'Sprite'),
(2, 'BotonPoder'),
(3, 'ImpactoPersonalidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id_ciudad` int(11) NOT NULL,
  `nombre_ciudad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_ciudad`, `nombre_ciudad`) VALUES
(1, 'Bogota'),
(2, 'Medellin'),
(3, 'Cali'),
(4, 'Barranquilla'),
(5, 'Barrancabermeja'),
(5001, 'MEDELLÍN'),
(5002, 'ABEJORRAL'),
(5004, 'ABRIAQUÍ'),
(5021, 'ALEJANDRÍA'),
(5030, 'AMAGÁ'),
(5031, 'AMALFI'),
(5034, 'ANDES'),
(5036, 'ANGELÓPOLIS'),
(5038, 'ANGOSTURA'),
(5040, 'ANORÍ'),
(5042, 'SANTA FÉ DE ANTIOQUIA'),
(5044, 'ANZÁ'),
(5045, 'APARTADÓ'),
(5051, 'ARBOLETES'),
(5055, 'ARGELIA'),
(5059, 'ARMENIA'),
(5079, 'BARBOSA'),
(5086, 'BELMIRA'),
(5088, 'BELLO'),
(5091, 'BETANIA'),
(5093, 'BETULIA'),
(5101, 'CIUDAD BOLÍVAR'),
(5107, 'BRICEÑO'),
(5113, 'BURITICÁ'),
(5120, 'CÁCERES'),
(5125, 'CAICEDO'),
(5129, 'CALDAS'),
(5134, 'CAMPAMENTO'),
(5138, 'CAÑASGORDAS'),
(5142, 'CARACOLÍ'),
(5145, 'CARAMANTA'),
(5147, 'CAREPA'),
(5148, 'EL CARMEN DE VIBORAL'),
(5150, 'CAROLINA'),
(5154, 'CAUCASIA'),
(5172, 'CHIGORODÓ'),
(5190, 'CISNEROS'),
(5197, 'COCORNÁ'),
(5206, 'CONCEPCIÓN'),
(5209, 'CONCORDIA'),
(5212, 'COPACABANA'),
(5234, 'DABEIBA'),
(5237, 'DONMATÍAS'),
(5240, 'EBÉJICO'),
(5250, 'EL BAGRE'),
(5264, 'ENTRERRÍOS'),
(5266, 'ENVIGADO'),
(5282, 'FREDONIA'),
(5284, 'FRONTINO'),
(5306, 'GIRALDO'),
(5308, 'GIRARDOTA'),
(5310, 'GÓMEZ PLATA'),
(5313, 'GRANADA'),
(5315, 'GUADALUPE'),
(5318, 'GUARNE'),
(5321, 'GUATAPÉ'),
(5347, 'HELICONIA'),
(5353, 'HISPANIA'),
(5360, 'ITAGÜÍ'),
(5361, 'ITUANGO'),
(5364, 'JARDÍN'),
(5368, 'JERICÓ'),
(5376, 'LA CEJA'),
(5380, 'LA ESTRELLA'),
(5390, 'LA PINTADA'),
(5400, 'LA UNIÓN'),
(5411, 'LIBORINA'),
(5425, 'MACEO'),
(5440, 'MARINILLA'),
(5467, 'MONTEBELLO'),
(5475, 'MURINDÓ'),
(5480, 'MUTATÁ'),
(5483, 'NARIÑO'),
(5490, 'NECOCLÍ'),
(5495, 'NECHÍ'),
(5501, 'OLAYA'),
(5541, 'PEÑOL'),
(5543, 'PEQUE'),
(5576, 'PUEBLORRICO'),
(5579, 'PUERTO BERRÍO'),
(5585, 'PUERTO NARE'),
(5591, 'PUERTO TRIUNFO'),
(5604, 'REMEDIOS'),
(5607, 'RETIRO'),
(5615, 'RIONEGRO'),
(5628, 'SABANALARGA'),
(5631, 'SABANETA'),
(5642, 'SALGAR'),
(5647, 'SAN ANDRÉS DE CUERQUÍA'),
(5649, 'SAN CARLOS'),
(5652, 'SAN FRANCISCO'),
(5656, 'SAN JERÓNIMO'),
(5658, 'SAN JOSÉ DE LA MONTAÑA'),
(5659, 'SAN JUAN DE URABÁ'),
(5660, 'SAN LUIS'),
(5664, 'SAN PEDRO DE LOS MILAGROS'),
(5665, 'SAN PEDRO DE URABÁ'),
(5667, 'SAN RAFAEL'),
(5670, 'SAN ROQUE'),
(5674, 'SAN VICENTE FERRER'),
(5679, 'SANTA BÁRBARA'),
(5686, 'SANTA ROSA DE OSOS'),
(5690, 'SANTO DOMINGO'),
(5697, 'EL SANTUARIO'),
(5736, 'SEGOVIA'),
(5756, 'SONSÓN'),
(5761, 'SOPETRÁN'),
(5789, 'TÁMESIS'),
(5790, 'TARAZÁ'),
(5792, 'TARSO'),
(5809, 'TITIRIBÍ'),
(5819, 'TOLEDO'),
(5837, 'TURBO'),
(5842, 'URAMITA'),
(5847, 'URRAO'),
(5854, 'VALDIVIA'),
(5856, 'VALPARAÍSO'),
(5858, 'VEGACHÍ'),
(5861, 'VENECIA'),
(5873, 'VIGÍA DEL FUERTE'),
(5885, 'YALÍ'),
(5887, 'YARUMAL'),
(5890, 'YOLOMBÓ'),
(5893, 'YONDÓ'),
(5895, 'ZARAGOZA'),
(8001, 'BARRANQUILLA'),
(8078, 'BARANOA'),
(8137, 'CAMPO DE LA CRUZ'),
(8141, 'CANDELARIA'),
(8296, 'GALAPA'),
(8372, 'JUAN DE ACOSTA'),
(8421, 'LURUACO'),
(8433, 'MALAMBO'),
(8436, 'MANATÍ'),
(8520, 'PALMAR DE VARELA'),
(8549, 'PIOJÓ'),
(8558, 'POLONUEVO'),
(8560, 'PONEDERA'),
(8573, 'PUERTO COLOMBIA'),
(8606, 'REPELÓN'),
(8634, 'SABANAGRANDE'),
(8638, 'SABANALARGA'),
(8675, 'SANTA LUCÍA'),
(8685, 'SANTO TOMÁS'),
(8758, 'SOLEDAD'),
(8770, 'SUAN'),
(8832, 'TUBARÁ'),
(8849, 'USIACURÍ'),
(11001, 'BOGOTÁ, D.C.'),
(13001, 'CARTAGENA DE INDIAS'),
(13006, 'ACHÍ'),
(13030, 'ALTOS DEL ROSARIO'),
(13042, 'ARENAL'),
(13052, 'ARJONA'),
(13062, 'ARROYOHONDO'),
(13074, 'BARRANCO DE LOBA'),
(13140, 'CALAMAR'),
(13160, 'CANTAGALLO'),
(13188, 'CICUCO'),
(13212, 'CÓRDOBA'),
(13222, 'CLEMENCIA'),
(13244, 'EL CARMEN DE BOLÍVAR'),
(13248, 'EL GUAMO'),
(13268, 'EL PEÑÓN'),
(13300, 'HATILLO DE LOBA'),
(13430, 'MAGANGUÉ'),
(13433, 'MAHATES'),
(13440, 'MARGARITA'),
(13442, 'MARÍA LA BAJA'),
(13458, 'MONTECRISTO'),
(13468, 'MOMPÓS'),
(13473, 'MORALES'),
(13490, 'NOROSÍ'),
(13549, 'PINILLOS'),
(13580, 'REGIDOR'),
(13600, 'RÍO VIEJO'),
(13620, 'SAN CRISTÓBAL'),
(13647, 'SAN ESTANISLAO'),
(13650, 'SAN FERNANDO'),
(13654, 'SAN JACINTO'),
(13655, 'SAN JACINTO DEL CAUCA'),
(13657, 'SAN JUAN NEPOMUCENO'),
(13667, 'SAN MARTÍN DE LOBA'),
(13670, 'SAN PABLO'),
(13673, 'SANTA CATALINA'),
(13683, 'SANTA ROSA'),
(13688, 'SANTA ROSA DEL SUR'),
(13744, 'SIMITÍ'),
(13760, 'SOPLAVIENTO'),
(13780, 'TALAIGUA NUEVO'),
(13810, 'TIQUISIO'),
(13836, 'TURBACO'),
(13838, 'TURBANÁ'),
(13873, 'VILLANUEVA'),
(13894, 'ZAMBRANO'),
(15001, 'TUNJA'),
(15022, 'ALMEIDA'),
(15047, 'AQUITANIA'),
(15051, 'ARCABUCO'),
(15087, 'BELÉN'),
(15090, 'BERBEO'),
(15092, 'BETÉITIVA'),
(15097, 'BOAVITA'),
(15104, 'BOYACÁ'),
(15106, 'BRICEÑO'),
(15109, 'BUENAVISTA'),
(15114, 'BUSBANZÁ'),
(15131, 'CALDAS'),
(15135, 'CAMPOHERMOSO'),
(15162, 'CERINZA'),
(15172, 'CHINAVITA'),
(15176, 'CHIQUINQUIRÁ'),
(15180, 'CHISCAS'),
(15183, 'CHITA'),
(15185, 'CHITARAQUE'),
(15187, 'CHIVATÁ'),
(15189, 'CIÉNEGA'),
(15204, 'CÓMBITA'),
(15212, 'COPER'),
(15215, 'CORRALES'),
(15218, 'COVARACHÍA'),
(15223, 'CUBARÁ'),
(15224, 'CUCAITA'),
(15226, 'CUÍTIVA'),
(15232, 'CHÍQUIZA'),
(15236, 'CHIVOR'),
(15238, 'DUITAMA'),
(15244, 'EL COCUY'),
(15248, 'EL ESPINO'),
(15272, 'FIRAVITOBA'),
(15276, 'FLORESTA'),
(15293, 'GACHANTIVÁ'),
(15296, 'GÁMEZA'),
(15299, 'GARAGOA'),
(15317, 'GUACAMAYAS'),
(15322, 'GUATEQUE'),
(15325, 'GUAYATÁ'),
(15332, 'GÜICÁN'),
(15362, 'IZA'),
(15367, 'JENESANO'),
(15368, 'JERICÓ'),
(15377, 'LABRANZAGRANDE'),
(15380, 'LA CAPILLA'),
(15401, 'LA VICTORIA'),
(15403, 'LA UVITA'),
(15407, 'VILLA DE LEYVA'),
(15425, 'MACANAL'),
(15442, 'MARIPÍ'),
(15455, 'MIRAFLORES'),
(15464, 'MONGUA'),
(15466, 'MONGUÍ'),
(15469, 'MONIQUIRÁ'),
(15476, 'MOTAVITA'),
(15480, 'MUZO'),
(15491, 'NOBSA'),
(15494, 'NUEVO COLÓN'),
(15500, 'OICATÁ'),
(15507, 'OTANCHE'),
(15511, 'PACHAVITA'),
(15514, 'PÁEZ'),
(15516, 'PAIPA'),
(15518, 'PAJARITO'),
(15522, 'PANQUEBA'),
(15531, 'PAUNA'),
(15533, 'PAYA'),
(15537, 'PAZ DE RÍO'),
(15542, 'PESCA'),
(15550, 'PISBA'),
(15572, 'PUERTO BOYACÁ'),
(15580, 'QUÍPAMA'),
(15599, 'RAMIRIQUÍ'),
(15600, 'RÁQUIRA'),
(15621, 'RONDÓN'),
(15632, 'SABOYÁ'),
(15638, 'SÁCHICA'),
(15646, 'SAMACÁ'),
(15660, 'SAN EDUARDO'),
(15664, 'SAN JOSÉ DE PARE'),
(15667, 'SAN LUIS DE GACENO'),
(15673, 'SAN MATEO'),
(15676, 'SAN MIGUEL DE SEMA'),
(15681, 'SAN PABLO DE BORBUR'),
(15686, 'SANTANA'),
(15690, 'SANTA MARÍA'),
(15693, 'SANTA ROSA DE VITERBO'),
(15696, 'SANTA SOFÍA'),
(15720, 'SATIVANORTE'),
(15723, 'SATIVASUR'),
(15740, 'SIACHOQUE'),
(15753, 'SOATÁ'),
(15755, 'SOCOTÁ'),
(15757, 'SOCHA'),
(15759, 'SOGAMOSO'),
(15761, 'SOMONDOCO'),
(15762, 'SORA'),
(15763, 'SOTAQUIRÁ'),
(15764, 'SORACÁ'),
(15774, 'SUSACÓN'),
(15776, 'SUTAMARCHÁN'),
(15778, 'SUTATENZA'),
(15790, 'TASCO'),
(15798, 'TENZA'),
(15804, 'TIBANÁ'),
(15806, 'TIBASOSA'),
(15808, 'TINJACÁ'),
(15810, 'TIPACOQUE'),
(15814, 'TOCA'),
(15816, 'TOGÜÍ'),
(15820, 'TÓPAGA'),
(15822, 'TOTA'),
(15832, 'TUNUNGUÁ'),
(15835, 'TURMEQUÉ'),
(15837, 'TUTA'),
(15839, 'TUTAZÁ'),
(15842, 'ÚMBITA'),
(15861, 'VENTAQUEMADA'),
(15879, 'VIRACACHÁ'),
(15897, 'ZETAQUIRA'),
(17001, 'MANIZALES'),
(17013, 'AGUADAS'),
(17042, 'ANSERMA'),
(17050, 'ARANZAZU'),
(17088, 'BELALCÁZAR'),
(17174, 'CHINCHINÁ'),
(17272, 'FILADELFIA'),
(17380, 'LA DORADA'),
(17388, 'LA MERCED'),
(17433, 'MANZANARES'),
(17442, 'MARMATO'),
(17444, 'MARQUETALIA'),
(17446, 'MARULANDA'),
(17486, 'NEIRA'),
(17495, 'NORCASIA'),
(17513, 'PÁCORA'),
(17524, 'PALESTINA'),
(17541, 'PENSILVANIA'),
(17614, 'RIOSUCIO'),
(17616, 'RISARALDA'),
(17653, 'SALAMINA'),
(17662, 'SAMANÁ'),
(17665, 'SAN JOSÉ'),
(17777, 'SUPÍA'),
(17867, 'VICTORIA'),
(17873, 'VILLAMARÍA'),
(17877, 'VITERBO'),
(18001, 'FLORENCIA'),
(18029, 'ALBANIA'),
(18094, 'BELÉN DE LOS ANDAQUÍES'),
(18150, 'CARTAGENA DEL CHAIRÁ'),
(18205, 'CURILLO'),
(18247, 'EL DONCELLO'),
(18256, 'EL PAUJÍL'),
(18410, 'LA MONTAÑITA'),
(18460, 'MILÁN'),
(18479, 'MORELIA'),
(18592, 'PUERTO RICO'),
(18610, 'SAN JOSÉ DEL FRAGUA'),
(18753, 'SAN VICENTE DEL CAGUÁN'),
(18756, 'SOLANO'),
(18785, 'SOLITA'),
(18860, 'VALPARAÍSO'),
(19001, 'POPAYÁN'),
(19022, 'ALMAGUER'),
(19050, 'ARGELIA'),
(19075, 'BALBOA'),
(19100, 'BOLÍVAR'),
(19110, 'BUENOS AIRES'),
(19130, 'CAJIBÍO'),
(19137, 'CALDONO'),
(19142, 'CALOTO'),
(19212, 'CORINTO'),
(19256, 'EL TAMBO'),
(19290, 'FLORENCIA'),
(19300, 'GUACHENÉ'),
(19318, 'GUAPÍ'),
(19355, 'INZÁ'),
(19364, 'JAMBALÓ'),
(19392, 'LA SIERRA'),
(19397, 'LA VEGA'),
(19418, 'LÓPEZ DE MICAY'),
(19450, 'MERCADERES'),
(19455, 'MIRANDA'),
(19473, 'MORALES'),
(19513, 'PADILLA'),
(19517, 'PÁEZ'),
(19532, 'PATÍA'),
(19533, 'PIAMONTE'),
(19548, 'PIENDAMÓ'),
(19573, 'PUERTO TEJADA'),
(19585, 'PURACÉ'),
(19622, 'ROSAS'),
(19693, 'SAN SEBASTIÁN'),
(19698, 'SANTANDER DE QUILICHAO'),
(19701, 'SANTA ROSA'),
(19743, 'SILVIA'),
(19760, 'SOTARA'),
(19780, 'SUÁREZ'),
(19785, 'SUCRE'),
(19807, 'TIMBÍO'),
(19809, 'TIMBIQUÍ'),
(19821, 'TORIBÍO'),
(19824, 'TOTORÓ'),
(19845, 'VILLA RICA'),
(20001, 'VALLEDUPAR'),
(20011, 'AGUACHICA'),
(20013, 'AGUSTÍN CODAZZI'),
(20032, 'ASTREA'),
(20045, 'BECERRIL'),
(20060, 'BOSCONIA'),
(20175, 'CHIMICHAGUA'),
(20178, 'CHIRIGUANÁ'),
(20228, 'CURUMANÍ'),
(20238, 'EL COPEY'),
(20250, 'EL PASO'),
(20295, 'GAMARRA'),
(20310, 'GONZÁLEZ'),
(20383, 'LA GLORIA'),
(20400, 'LA JAGUA DE IBIRICO'),
(20443, 'MANAURE BALCÓN DEL CESAR'),
(20517, 'PAILITAS'),
(20550, 'PELAYA'),
(20570, 'PUEBLO BELLO'),
(20614, 'RÍO DE ORO'),
(20621, 'LA PAZ'),
(20710, 'SAN ALBERTO'),
(20750, 'SAN DIEGO'),
(20770, 'SAN MARTÍN'),
(20787, 'TAMALAMEQUE'),
(23001, 'MONTERÍA'),
(23068, 'AYAPEL'),
(23079, 'BUENAVISTA'),
(23090, 'CANALETE'),
(23162, 'CERETÉ'),
(23168, 'CHIMÁ'),
(23182, 'CHINÚ'),
(23189, 'CIÉNAGA DE ORO'),
(23300, 'COTORRA'),
(23350, 'LA APARTADA'),
(23417, 'LORICA'),
(23419, 'LOS CÓRDOBAS'),
(23464, 'MOMIL'),
(23466, 'MONTELÍBANO'),
(23500, 'MOÑITOS'),
(23555, 'PLANETA RICA'),
(23570, 'PUEBLO NUEVO'),
(23574, 'PUERTO ESCONDIDO'),
(23580, 'PUERTO LIBERTADOR'),
(23586, 'PURÍSIMA DE LA CONCEPCIÓN'),
(23660, 'SAHAGÚN'),
(23670, 'SAN ANDRÉS DE SOTAVENTO'),
(23672, 'SAN ANTERO'),
(23675, 'SAN BERNARDO DEL VIENTO'),
(23678, 'SAN CARLOS'),
(23682, 'SAN JOSÉ DE URÉ'),
(23686, 'SAN PELAYO'),
(23807, 'TIERRALTA'),
(23815, 'TUCHÍN'),
(23855, 'VALENCIA'),
(25001, 'AGUA DE DIOS'),
(25019, 'ALBÁN'),
(25035, 'ANAPOIMA'),
(25040, 'ANOLAIMA'),
(25053, 'ARBELÁEZ'),
(25086, 'BELTRÁN'),
(25095, 'BITUIMA'),
(25099, 'BOJACÁ'),
(25120, 'CABRERA'),
(25123, 'CACHIPAY'),
(25126, 'CAJICÁ'),
(25148, 'CAPARRAPÍ'),
(25151, 'CÁQUEZA'),
(25154, 'CARMEN DE CARUPA'),
(25168, 'CHAGUANÍ'),
(25175, 'CHÍA'),
(25178, 'CHIPAQUE'),
(25181, 'CHOACHÍ'),
(25183, 'CHOCONTÁ'),
(25200, 'COGUA'),
(25214, 'COTA'),
(25224, 'CUCUNUBÁ'),
(25245, 'EL COLEGIO'),
(25258, 'EL PEÑÓN'),
(25260, 'EL ROSAL'),
(25269, 'FACATATIVÁ'),
(25279, 'FÓMEQUE'),
(25281, 'FOSCA'),
(25286, 'FUNZA'),
(25288, 'FÚQUENE'),
(25290, 'FUSAGASUGÁ'),
(25293, 'GACHALÁ'),
(25295, 'GACHANCIPÁ'),
(25297, 'GACHETÁ'),
(25299, 'GAMA'),
(25307, 'GIRARDOT'),
(25312, 'GRANADA'),
(25317, 'GUACHETÁ'),
(25320, 'GUADUAS'),
(25322, 'GUASCA'),
(25324, 'GUATAQUÍ'),
(25326, 'GUATAVITA'),
(25328, 'GUAYABAL DE SÍQUIMA'),
(25335, 'GUAYABETAL'),
(25339, 'GUTIÉRREZ'),
(25368, 'JERUSALÉN'),
(25372, 'JUNÍN'),
(25377, 'LA CALERA'),
(25386, 'LA MESA'),
(25394, 'LA PALMA'),
(25398, 'LA PEÑA'),
(25402, 'LA VEGA'),
(25407, 'LENGUAZAQUE'),
(25426, 'MACHETÁ'),
(25430, 'MADRID'),
(25436, 'MANTA'),
(25438, 'MEDINA'),
(25473, 'MOSQUERA'),
(25483, 'NARIÑO'),
(25486, 'NEMOCÓN'),
(25488, 'NILO'),
(25489, 'NIMAIMA'),
(25491, 'NOCAIMA'),
(25506, 'VENECIA'),
(25513, 'PACHO'),
(25518, 'PAIME'),
(25524, 'PANDI'),
(25530, 'PARATEBUENO'),
(25535, 'PASCA'),
(25572, 'PUERTO SALGAR'),
(25580, 'PULÍ'),
(25592, 'QUEBRADANEGRA'),
(25594, 'QUETAME'),
(25596, 'QUIPILE'),
(25599, 'APULO'),
(25612, 'RICAURTE'),
(25645, 'SAN ANTONIO DEL TEQUENDAMA'),
(25649, 'SAN BERNARDO'),
(25653, 'SAN CAYETANO'),
(25658, 'SAN FRANCISCO'),
(25662, 'SAN JUAN DE RIOSECO'),
(25718, 'SASAIMA'),
(25736, 'SESQUILÉ'),
(25740, 'SIBATÉ'),
(25743, 'SILVANIA'),
(25745, 'SIMIJACA'),
(25754, 'SOACHA'),
(25758, 'SOPÓ'),
(25769, 'SUBACHOQUE'),
(25772, 'SUESCA'),
(25777, 'SUPATÁ'),
(25779, 'SUSA'),
(25781, 'SUTATAUSA'),
(25785, 'TABIO'),
(25793, 'TAUSA'),
(25797, 'TENA'),
(25799, 'TENJO'),
(25805, 'TIBACUY'),
(25807, 'TIBIRITA'),
(25815, 'TOCAIMA'),
(25817, 'TOCANCIPÁ'),
(25823, 'TOPAIPÍ'),
(25839, 'UBALÁ'),
(25841, 'UBAQUE'),
(25843, 'VILLA DE SAN DIEGO DE UBATÉ'),
(25845, 'UNE'),
(25851, 'ÚTICA'),
(25862, 'VERGARA'),
(25867, 'VIANÍ'),
(25871, 'VILLAGÓMEZ'),
(25873, 'VILLAPINZÓN'),
(25875, 'VILLETA'),
(25878, 'VIOTÁ'),
(25885, 'YACOPÍ'),
(25898, 'ZIPACÓN'),
(25899, 'ZIPAQUIRÁ'),
(27001, 'QUIBDÓ'),
(27006, 'ACANDÍ'),
(27025, 'ALTO BAUDÓ'),
(27050, 'ATRATO'),
(27073, 'BAGADÓ'),
(27075, 'BAHÍA SOLANO'),
(27077, 'BAJO BAUDÓ'),
(27099, 'BOJAYÁ'),
(27135, 'EL CANTÓN DEL SAN PABLO'),
(27150, 'CARMEN DEL DARIÉN'),
(27160, 'CÉRTEGUI'),
(27205, 'CONDOTO'),
(27245, 'EL CARMEN DE ATRATO'),
(27250, 'EL LITORAL DEL SAN JUAN'),
(27361, 'ISTMINA'),
(27372, 'JURADÓ'),
(27413, 'LLORÓ'),
(27425, 'MEDIO ATRATO'),
(27430, 'MEDIO BAUDÓ'),
(27450, 'MEDIO SAN JUAN'),
(27491, 'NÓVITA'),
(27495, 'NUQUÍ'),
(27580, 'RÍO IRÓ'),
(27600, 'RÍO QUITO'),
(27615, 'RIOSUCIO'),
(27660, 'SAN JOSÉ DEL PALMAR'),
(27745, 'SIPÍ'),
(27787, 'TADÓ'),
(27800, 'UNGUÍA'),
(27810, 'UNIÓN PANAMERICANA'),
(41001, 'NEIVA'),
(41006, 'ACEVEDO'),
(41013, 'AGRADO'),
(41016, 'AIPE'),
(41020, 'ALGECIRAS'),
(41026, 'ALTAMIRA'),
(41078, 'BARAYA'),
(41132, 'CAMPOALEGRE'),
(41206, 'COLOMBIA'),
(41244, 'ELÍAS'),
(41298, 'GARZÓN'),
(41306, 'GIGANTE'),
(41319, 'GUADALUPE'),
(41349, 'HOBO'),
(41357, 'ÍQUIRA'),
(41359, 'ISNOS'),
(41378, 'LA ARGENTINA'),
(41396, 'LA PLATA'),
(41483, 'NÁTAGA'),
(41503, 'OPORAPA'),
(41518, 'PAICOL'),
(41524, 'PALERMO'),
(41530, 'PALESTINA'),
(41548, 'PITAL'),
(41551, 'PITALITO'),
(41615, 'RIVERA'),
(41660, 'SALADOBLANCO'),
(41668, 'SAN AGUSTÍN'),
(41676, 'SANTA MARÍA'),
(41770, 'SUAZA'),
(41791, 'TARQUI'),
(41797, 'TESALIA'),
(41799, 'TELLO'),
(41801, 'TERUEL'),
(41807, 'TIMANÁ'),
(41872, 'VILLAVIEJA'),
(41885, 'YAGUARÁ'),
(44001, 'RIOHACHA'),
(44035, 'ALBANIA'),
(44078, 'BARRANCAS'),
(44090, 'DIBULLA'),
(44098, 'DISTRACCIÓN'),
(44110, 'EL MOLINO'),
(44279, 'FONSECA'),
(44378, 'HATONUEVO'),
(44420, 'LA JAGUA DEL PILAR'),
(44430, 'MAICAO'),
(44560, 'MANAURE'),
(44650, 'SAN JUAN DEL CESAR'),
(44847, 'URIBIA'),
(44855, 'URUMITA'),
(44874, 'VILLANUEVA'),
(47001, 'SANTA MARTA'),
(47030, 'ALGARROBO'),
(47053, 'ARACATACA'),
(47058, 'ARIGUANÍ'),
(47161, 'CERRO DE SAN ANTONIO'),
(47170, 'CHIVOLO'),
(47189, 'CIÉNAGA'),
(47205, 'CONCORDIA'),
(47245, 'EL BANCO'),
(47258, 'EL PIÑÓN'),
(47268, 'EL RETÉN'),
(47288, 'FUNDACIÓN'),
(47318, 'GUAMAL'),
(47460, 'NUEVA GRANADA'),
(47541, 'PEDRAZA'),
(47545, 'PIJIÑO DEL CARMEN'),
(47551, 'PIVIJAY'),
(47555, 'PLATO'),
(47570, 'PUEBLOVIEJO'),
(47605, 'REMOLINO'),
(47660, 'SABANAS DE SAN ÁNGEL'),
(47675, 'SALAMINA'),
(47692, 'SAN SEBASTIÁN DE BUENAVISTA'),
(47703, 'SAN ZENÓN'),
(47707, 'SANTA ANA'),
(47720, 'SANTA BÁRBARA DE PINTO'),
(47745, 'SITIONUEVO'),
(47798, 'TENERIFE'),
(47960, 'ZAPAYÁN'),
(47980, 'ZONA BANANERA'),
(50001, 'VILLAVICENCIO'),
(50006, 'ACACÍAS'),
(50110, 'BARRANCA DE UPÍA'),
(50124, 'CABUYARO'),
(50150, 'CASTILLA LA NUEVA'),
(50223, 'SAN LUIS DE CUBARRAL'),
(50226, 'CUMARAL'),
(50245, 'EL CALVARIO'),
(50251, 'EL CASTILLO'),
(50270, 'EL DORADO'),
(50287, 'FUENTE DE ORO'),
(50313, 'GRANADA'),
(50318, 'GUAMAL'),
(50325, 'MAPIRIPÁN'),
(50330, 'MESETAS'),
(50350, 'LA MACARENA'),
(50370, 'URIBE'),
(50400, 'LEJANÍAS'),
(50450, 'PUERTO CONCORDIA'),
(50568, 'PUERTO GAITÁN'),
(50573, 'PUERTO LÓPEZ'),
(50577, 'PUERTO LLERAS'),
(50590, 'PUERTO RICO'),
(50606, 'RESTREPO'),
(50680, 'SAN CARLOS DE GUAROA'),
(50683, 'SAN JUAN DE ARAMA'),
(50686, 'SAN JUANITO'),
(50689, 'SAN MARTÍN'),
(50711, 'VISTAHERMOSA'),
(52001, 'PASTO'),
(52019, 'ALBÁN'),
(52022, 'ALDANA'),
(52036, 'ANCUYÁ'),
(52051, 'ARBOLEDA'),
(52079, 'BARBACOAS'),
(52083, 'BELÉN'),
(52110, 'BUESACO'),
(52203, 'COLÓN'),
(52207, 'CONSACÁ'),
(52210, 'CONTADERO'),
(52215, 'CÓRDOBA'),
(52224, 'CUASPÚD'),
(52227, 'CUMBAL'),
(52233, 'CUMBITARA'),
(52240, 'CHACHAGÜÍ'),
(52250, 'EL CHARCO'),
(52254, 'EL PEÑOL'),
(52256, 'EL ROSARIO'),
(52258, 'EL TABLÓN DE GÓMEZ'),
(52260, 'EL TAMBO'),
(52287, 'FUNES'),
(52317, 'GUACHUCAL'),
(52320, 'GUAITARILLA'),
(52323, 'GUALMATÁN'),
(52352, 'ILES'),
(52354, 'IMUÉS'),
(52356, 'IPIALES'),
(52378, 'LA CRUZ'),
(52381, 'LA FLORIDA'),
(52385, 'LA LLANADA'),
(52390, 'LA TOLA'),
(52399, 'LA UNIÓN'),
(52405, 'LEIVA'),
(52411, 'LINARES'),
(52418, 'LOS ANDES'),
(52427, 'MAGÜÍ'),
(52435, 'MALLAMA'),
(52473, 'MOSQUERA'),
(52480, 'NARIÑO'),
(52490, 'OLAYA HERRERA'),
(52506, 'OSPINA'),
(52520, 'FRANCISCO PIZARRO'),
(52540, 'POLICARPA'),
(52560, 'POTOSÍ'),
(52565, 'PROVIDENCIA'),
(52573, 'PUERRES'),
(52585, 'PUPIALES'),
(52612, 'RICAURTE'),
(52621, 'ROBERTO PAYÁN'),
(52678, 'SAMANIEGO'),
(52683, 'SANDONÁ'),
(52685, 'SAN BERNARDO'),
(52687, 'SAN LORENZO'),
(52693, 'SAN PABLO'),
(52694, 'SAN PEDRO DE CARTAGO'),
(52696, 'SANTA BÁRBARA'),
(52699, 'SANTACRUZ'),
(52720, 'SAPUYES'),
(52786, 'TAMINANGO'),
(52788, 'TANGUA'),
(52835, 'SAN ANDRÉS DE TUMACO'),
(52838, 'TÚQUERRES'),
(52885, 'YACUANQUER'),
(54001, 'CÚCUTA'),
(54003, 'ÁBREGO'),
(54051, 'ARBOLEDAS'),
(54099, 'BOCHALEMA'),
(54109, 'BUCARASICA'),
(54125, 'CÁCOTA'),
(54128, 'CÁCHIRA'),
(54172, 'CHINÁCOTA'),
(54174, 'CHITAGÁ'),
(54206, 'CONVENCIÓN'),
(54223, 'CUCUTILLA'),
(54239, 'DURANIA'),
(54245, 'EL CARMEN'),
(54250, 'EL TARRA'),
(54261, 'EL ZULIA'),
(54313, 'GRAMALOTE'),
(54344, 'HACARÍ'),
(54347, 'HERRÁN'),
(54377, 'LABATECA'),
(54385, 'LA ESPERANZA'),
(54398, 'LA PLAYA'),
(54405, 'LOS PATIOS'),
(54418, 'LOURDES'),
(54480, 'MUTISCUA'),
(54498, 'OCAÑA'),
(54518, 'PAMPLONA'),
(54520, 'PAMPLONITA'),
(54553, 'PUERTO SANTANDER'),
(54599, 'RAGONVALIA'),
(54660, 'SALAZAR'),
(54670, 'SAN CALIXTO'),
(54673, 'SAN CAYETANO'),
(54680, 'SANTIAGO'),
(54720, 'SARDINATA'),
(54743, 'SILOS'),
(54800, 'TEORAMA'),
(54810, 'TIBÚ'),
(54820, 'TOLEDO'),
(54871, 'VILLA CARO'),
(54874, 'VILLA DEL ROSARIO'),
(63001, 'ARMENIA'),
(63111, 'BUENAVISTA'),
(63130, 'CALARCÁ'),
(63190, 'CIRCASIA'),
(63212, 'CÓRDOBA'),
(63272, 'FILANDIA'),
(63302, 'GÉNOVA'),
(63401, 'LA TEBAIDA'),
(63470, 'MONTENEGRO'),
(63548, 'PIJAO'),
(63594, 'QUIMBAYA'),
(63690, 'SALENTO'),
(66001, 'PEREIRA'),
(66045, 'APÍA'),
(66075, 'BALBOA'),
(66088, 'BELÉN DE UMBRÍA'),
(66170, 'DOSQUEBRADAS'),
(66318, 'GUÁTICA'),
(66383, 'LA CELIA'),
(66400, 'LA VIRGINIA'),
(66440, 'MARSELLA'),
(66456, 'MISTRATÓ'),
(66572, 'PUEBLO RICO'),
(66594, 'QUINCHÍA'),
(66682, 'SANTA ROSA DE CABAL'),
(66687, 'SANTUARIO'),
(68001, 'BUCARAMANGA'),
(68013, 'AGUADA'),
(68020, 'ALBANIA'),
(68051, 'ARATOCA'),
(68077, 'BARBOSA'),
(68079, 'BARICHARA'),
(68081, 'BARRANCABERMEJA'),
(68092, 'BETULIA'),
(68101, 'BOLÍVAR'),
(68121, 'CABRERA'),
(68132, 'CALIFORNIA'),
(68147, 'CAPITANEJO'),
(68152, 'CARCASÍ'),
(68160, 'CEPITÁ'),
(68162, 'CERRITO'),
(68167, 'CHARALÁ'),
(68169, 'CHARTA'),
(68176, 'CHIMA'),
(68179, 'CHIPATÁ'),
(68190, 'CIMITARRA'),
(68207, 'CONCEPCIÓN'),
(68209, 'CONFINES'),
(68211, 'CONTRATACIÓN'),
(68217, 'COROMORO'),
(68229, 'CURITÍ'),
(68235, 'EL CARMEN DE CHUCURÍ'),
(68245, 'EL GUACAMAYO'),
(68250, 'EL PEÑÓN'),
(68255, 'EL PLAYÓN'),
(68264, 'ENCINO'),
(68266, 'ENCISO'),
(68271, 'FLORIÁN'),
(68276, 'FLORIDABLANCA'),
(68296, 'GALÁN'),
(68298, 'GÁMBITA'),
(68307, 'GIRÓN'),
(68318, 'GUACA'),
(68320, 'GUADALUPE'),
(68322, 'GUAPOTÁ'),
(68324, 'GUAVATÁ'),
(68327, 'GÜEPSA'),
(68344, 'HATO'),
(68368, 'JESÚS MARÍA'),
(68370, 'JORDÁN'),
(68377, 'LA BELLEZA'),
(68385, 'LANDÁZURI'),
(68397, 'LA PAZ'),
(68406, 'LEBRIJA'),
(68418, 'LOS SANTOS'),
(68425, 'MACARAVITA'),
(68432, 'MÁLAGA'),
(68444, 'MATANZA'),
(68464, 'MOGOTES'),
(68468, 'MOLAGAVITA'),
(68498, 'OCAMONTE'),
(68500, 'OIBA'),
(68502, 'ONZAGA'),
(68522, 'PALMAR'),
(68524, 'PALMAS DEL SOCORRO'),
(68533, 'PÁRAMO'),
(68547, 'PIEDECUESTA'),
(68549, 'PINCHOTE'),
(68572, 'PUENTE NACIONAL'),
(68573, 'PUERTO PARRA'),
(68575, 'PUERTO WILCHES'),
(68615, 'RIONEGRO'),
(68655, 'SABANA DE TORRES'),
(68669, 'SAN ANDRÉS'),
(68673, 'SAN BENITO'),
(68679, 'SAN GIL'),
(68682, 'SAN JOAQUÍN'),
(68684, 'SAN JOSÉ DE MIRANDA'),
(68686, 'SAN MIGUEL'),
(68689, 'SAN VICENTE DE CHUCURÍ'),
(68705, 'SANTA BÁRBARA'),
(68720, 'SANTA HELENA DEL OPÓN'),
(68745, 'SIMACOTA'),
(68755, 'SOCORRO'),
(68770, 'SUAITA'),
(68773, 'SUCRE'),
(68780, 'SURATÁ'),
(68820, 'TONA'),
(68855, 'VALLE DE SAN JOSÉ'),
(68861, 'VÉLEZ'),
(68867, 'VETAS'),
(68872, 'VILLANUEVA'),
(68895, 'ZAPATOCA'),
(70001, 'SINCELEJO'),
(70110, 'BUENAVISTA'),
(70124, 'CAIMITO'),
(70204, 'COLOSO'),
(70215, 'COROZAL'),
(70221, 'COVEÑAS'),
(70230, 'CHALÁN'),
(70233, 'EL ROBLE'),
(70235, 'GALERAS'),
(70265, 'GUARANDA'),
(70400, 'LA UNIÓN'),
(70418, 'LOS PALMITOS'),
(70429, 'MAJAGUAL'),
(70473, 'MORROA'),
(70508, 'OVEJAS'),
(70523, 'PALMITO'),
(70670, 'SAMPUÉS'),
(70678, 'SAN BENITO ABAD'),
(70702, 'SAN JUAN DE BETULIA'),
(70708, 'SAN MARCOS'),
(70713, 'SAN ONOFRE'),
(70717, 'SAN PEDRO'),
(70742, 'SAN LUIS DE SINCÉ'),
(70771, 'SUCRE'),
(70820, 'SANTIAGO DE TOLÚ'),
(70823, 'TOLÚ VIEJO'),
(73001, 'IBAGUÉ'),
(73024, 'ALPUJARRA'),
(73026, 'ALVARADO'),
(73030, 'AMBALEMA'),
(73043, 'ANZOÁTEGUI'),
(73055, 'ARMERO GUAYABAL'),
(73067, 'ATACO'),
(73124, 'CAJAMARCA'),
(73148, 'CARMEN DE APICALÁ'),
(73152, 'CASABIANCA'),
(73168, 'CHAPARRAL'),
(73200, 'COELLO'),
(73217, 'COYAIMA'),
(73226, 'CUNDAY'),
(73236, 'DOLORES'),
(73268, 'ESPINAL'),
(73270, 'FALAN'),
(73275, 'FLANDES'),
(73283, 'FRESNO'),
(73319, 'GUAMO'),
(73347, 'HERVEO'),
(73349, 'HONDA'),
(73352, 'ICONONZO'),
(73408, 'LÉRIDA'),
(73411, 'LÍBANO'),
(73443, 'SAN SEBASTIÁN DE MARIQUITA'),
(73449, 'MELGAR'),
(73461, 'MURILLO'),
(73483, 'NATAGAIMA'),
(73504, 'ORTEGA'),
(73520, 'PALOCABILDO'),
(73547, 'PIEDRAS'),
(73555, 'PLANADAS'),
(73563, 'PRADO'),
(73585, 'PURIFICACIÓN'),
(73616, 'RIOBLANCO'),
(73622, 'RONCESVALLES'),
(73624, 'ROVIRA'),
(73671, 'SALDAÑA'),
(73675, 'SAN ANTONIO'),
(73678, 'SAN LUIS'),
(73686, 'SANTA ISABEL'),
(73770, 'SUÁREZ'),
(73854, 'VALLE DE SAN JUAN'),
(73861, 'VENADILLO'),
(73870, 'VILLAHERMOSA'),
(73873, 'VILLARRICA'),
(76001, 'CALI'),
(76020, 'ALCALÁ'),
(76036, 'ANDALUCÍA'),
(76041, 'ANSERMANUEVO'),
(76054, 'ARGELIA'),
(76100, 'BOLÍVAR'),
(76109, 'BUENAVENTURA'),
(76111, 'GUADALAJARA DE BUGA'),
(76113, 'BUGALAGRANDE'),
(76122, 'CAICEDONIA'),
(76126, 'CALIMA'),
(76130, 'CANDELARIA'),
(76147, 'CARTAGO'),
(76233, 'DAGUA'),
(76243, 'EL ÁGUILA'),
(76246, 'EL CAIRO'),
(76248, 'EL CERRITO'),
(76250, 'EL DOVIO'),
(76275, 'FLORIDA'),
(76306, 'GINEBRA'),
(76318, 'GUACARÍ'),
(76364, 'JAMUNDÍ'),
(76377, 'LA CUMBRE'),
(76400, 'LA UNIÓN'),
(76403, 'LA VICTORIA'),
(76497, 'OBANDO'),
(76520, 'PALMIRA'),
(76563, 'PRADERA'),
(76606, 'RESTREPO'),
(76616, 'RIOFRÍO'),
(76622, 'ROLDANILLO'),
(76670, 'SAN PEDRO'),
(76736, 'SEVILLA'),
(76823, 'TORO'),
(76828, 'TRUJILLO'),
(76834, 'TULUÁ'),
(76845, 'ULLOA'),
(76863, 'VERSALLES'),
(76869, 'VIJES'),
(76890, 'YOTOCO'),
(76892, 'YUMBO'),
(76895, 'ZARZAL'),
(81001, 'ARAUCA'),
(81065, 'ARAUQUITA'),
(81220, 'CRAVO NORTE'),
(81300, 'FORTUL'),
(81591, 'PUERTO RONDÓN'),
(81736, 'SARAVENA'),
(81794, 'TAME'),
(85001, 'YOPAL'),
(85010, 'AGUAZUL'),
(85015, 'CHÁMEZA'),
(85125, 'HATO COROZAL'),
(85136, 'LA SALINA'),
(85139, 'MANÍ'),
(85162, 'MONTERREY'),
(85225, 'NUNCHÍA'),
(85230, 'OROCUÉ'),
(85250, 'PAZ DE ARIPORO'),
(85263, 'PORE'),
(85279, 'RECETOR'),
(85300, 'SABANALARGA'),
(85315, 'SÁCAMA'),
(85325, 'SAN LUIS DE PALENQUE'),
(85400, 'TÁMARA'),
(85410, 'TAURAMENA'),
(85430, 'TRINIDAD'),
(85440, 'VILLANUEVA'),
(86001, 'MOCOA'),
(86219, 'COLÓN'),
(86320, 'ORITO'),
(86568, 'PUERTO ASÍS'),
(86569, 'PUERTO CAICEDO'),
(86571, 'PUERTO GUZMÁN'),
(86573, 'PUERTO LEGUÍZAMO'),
(86749, 'SIBUNDOY'),
(86755, 'SAN FRANCISCO'),
(86757, 'SAN MIGUEL'),
(86760, 'SANTIAGO'),
(86865, 'VALLE DEL GUAMUEZ'),
(86885, 'VILLAGARZÓN'),
(88001, 'SAN ANDRÉS'),
(88564, 'PROVIDENCIA'),
(91001, 'LETICIA'),
(91263, 'EL ENCANTO'),
(91405, 'LA CHORRERA'),
(91407, 'LA PEDRERA'),
(91430, 'LA VICTORIA'),
(91460, 'MIRITÍ - PARANÁ'),
(91530, 'PUERTO ALEGRÍA'),
(91536, 'PUERTO ARICA'),
(91540, 'PUERTO NARIÑO'),
(91669, 'PUERTO SANTANDER'),
(91798, 'TARAPACÁ'),
(94001, 'INÍRIDA'),
(94343, 'BARRANCO MINAS'),
(94663, 'MAPIRIPANA'),
(94883, 'SAN FELIPE'),
(94884, 'PUERTO COLOMBIA'),
(94885, 'LA GUADALUPE'),
(94886, 'CACAHUAL'),
(94887, 'PANA PANA'),
(94888, 'MORICHAL'),
(95001, 'SAN JOSÉ DEL GUAVIARE'),
(95015, 'CALAMAR'),
(95025, 'EL RETORNO'),
(95200, 'MIRAFLORES'),
(97001, 'MITÚ'),
(97161, 'CARURÚ'),
(97511, 'PACOA'),
(97666, 'TARAIRA'),
(97777, 'PAPUNAUA'),
(97889, 'YAVARATÉ'),
(99001, 'PUERTO CARREÑO'),
(99524, 'LA PRIMAVERA'),
(99624, 'SANTA ROSALÍA'),
(99773, 'CUMARIBO'),
(99774, 'EXTERIOR DEL PAIS'),
(99775, 'Pasto2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `frase`
--

CREATE TABLE `frase` (
  `id_frase` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `frase`
--

INSERT INTO `frase` (`id_frase`, `descripcion`) VALUES
(1, 'Frase asociada a personaje 01'),
(2, 'Frase asociada a personaje 02'),
(3, 'Entrena más fuera de clases ¡Yeah ¡'),
(4, 'Ahoooooooo'),
(5, 'Tendrás tu revancha'),
(6, 'Acabare contigo después'),
(7, 'Demuestra lo que sabes!'),
(8, 'Eso es todo…..'),
(9, '¡Adelante!'),
(10, 'Como siempre “Ganador”'),
(11, 'Que fracaso….'),
(12, 'Siempre imponente'),
(13, 'No esperaba menos!'),
(14, 'Infame!'),
(15, 'Esto es inaceptable'),
(16, 'Quedate ahí, No llegaras más lejos!'),
(17, 'Perdedor'),
(18, 'Ja Ja Ja Ingenuo(a)'),
(19, 'El vivo, vive del bobo ¡Perdedor!'),
(20, '¡Ganador!'),
(21, 'Pura suerte mi amigo(a)!'),
(22, 'Mala selección….'),
(23, 'Te cazare en otra oportunidad!'),
(24, '¿Crees ver mejor que yo?'),
(25, 'Que pésimo oponente Ja JaJa'),
(26, 'De eso presumes?'),
(27, '¡Gran poder, Gran resultado!'),
(28, 'Una victoria más para la bolsa'),
(29, 'Top 1 - Winner'),
(30, 'Gran golpe…'),
(31, '¡Ceeeeee!'),
(32, 'Como te atreves!'),
(33, 'Sentirás el instinto de lucha verdadero.'),
(34, 'Porque tan nervioso?'),
(35, 'Ja Ja Ja'),
(36, 'Por suerte, SOY EL MEJOR'),
(37, '¡Un salto a la victoria!'),
(38, 'Dedicado a mis seguidores!'),
(39, '¿Que hice mal?'),
(40, 'Nos volveremos a encontrar!'),
(41, 'Porque pierdo así?'),
(42, '¿Crees que eres rival para mí?'),
(43, 'Imponente y fracasado.'),
(44, '¡Raro sería si no ganara!, Ganeeeeee Ja Ja Ja)'),
(45, 'No fue suficiente para lograrlo!'),
(46, 'No se volverá a repetir!'),
(47, '¿Es lo único que haces?'),
(48, 'Es toda tu habilidad?'),
(49, '¡Ven, Ven!'),
(50, 'No eres un guerrero, eres un principiante!'),
(51, '¡Desista!, no te puedes comparar a mí'),
(52, 'Vete a casa! Perdedor…'),
(53, 'Comooooo?....'),
(54, 'Jua Jua Jua'),
(55, '¡Que poder tan insignificante!'),
(56, 'Adelante o vete a casa!'),
(57, 'Aplastare tus valores!'),
(58, 'Era evidente tu fracaso'),
(59, 'Te creías capaz de vencerme! Ja Ja Ja'),
(60, 'La fuerza todo lo supera ¡Perdedor(a)!'),
(61, 'Nos volveremos a ver!'),
(62, 'Imposible, como pude ser derrotado!'),
(63, 'Atrévete a golpearme si puedes!, Estoy en magníficas condiciones…'),
(64, '¡Sin el más mínimo esfuerzo!'),
(65, 'La astucia borra la sabiduría! Perdedor…'),
(66, 'Jijau… Jijau'),
(67, 'Esto es terrible…'),
(68, 'No puedo continuar!'),
(69, 'Mi victoria se pospondrá por poco tiempo… Prepárate!'),
(70, '¿Podrás tocarme? No lo creo'),
(71, '¡Perderás ante el mejor!'),
(72, 'Tu esfuerzo es inútil ante mí'),
(73, '¡Y pensar que fue así de fácil!'),
(74, 'Siiiii ¡Imponente como siempre!'),
(75, 'Perder es ganar un poco. Ja Ja Ja'),
(76, '¡Te estaré vigilando desde la oscuridad!'),
(77, 'No tendré piedad en una nueva ocasión…'),
(78, '¿Ese es tu máximo poder? Ja Ja Ja'),
(79, 'Me das risa “Iluso”'),
(80, 'Pensar que eras un buen oponente…. ¡Absurdo!'),
(81, '¡Yeah!, Ganador…'),
(82, '¡Esta victoria me complace!'),
(83, '¡¡Gana siempre el estudioso!!'),
(84, '¡Que pensaran mis amigos! Ohhh Noooo'),
(85, 'Gran oponente'),
(86, 'Te venceré en otra oportunidad'),
(87, 'Intentare estar un paso adelante.'),
(88, 'Demuéstrame tus habilidades'),
(89, '¡Somos el dúo maravilla!'),
(90, 'Victoria –“Súper Fashion”'),
(91, 'El resultado lo sabíamos desde el principio.'),
(92, '¿Como pudimos perder?'),
(93, '¡Qué falta de Glamour!'),
(94, '¡Mejoraremos! Y morderás el suelo'),
(95, 'No ganaras ¡NUNCA!'),
(96, 'No sabes quienes somos nosotras?'),
(97, '¡Los valores hacen de una persona imparable!'),
(98, 'Reacciona y corrige lo malo, para ser un buen oponente.'),
(99, '¡El bien tarde o temprano ganara!'),
(100, '¡Perder es ganar un poco!'),
(101, 'Cuídate porque en la próxima ¡no perderé!'),
(102, '¿Qué esperas?, acércate'),
(103, 'Crees que podrás ganarme?'),
(104, 'El resultado será el mismo! Te irás a casa'),
(105, '¡Gran combate!'),
(106, 'Ganaras cuando actúes correctamente'),
(107, 'Construiré nuevos valores en mí, para derrotarte como se debe'),
(108, 'Soy inferior a ti por ser derrotada?, Que iluso(a)'),
(109, 'Te mostrare mi gran fuerza'),
(110, 'Se ve que te falta mucho para cambiar tu estilo de vivir'),
(111, '¡Qué gran combate, pero así es el destino!'),
(112, '¡Ganador! Kikiriki'),
(113, 'Era de esperar el resultado de nuestro encuentro'),
(114, 'Acepto mi derrota, pero será la última'),
(115, 'Con más dedicación lograre mis objetivos y nos volveremos a ver'),
(116, 'Dame tiempo y prepárate para lo que viene'),
(117, 'Qué pasa con tus ánimos, golpea…'),
(118, 'Crees ganarme?, así de equivocado estas'),
(119, '¡Me preparare más, no esperaba algo diferente!'),
(120, 'Te falta mucho para poder derrotarme'),
(121, 'Cuando quieras te puedo dar algunos consejos'),
(122, 'Esto no es una derrota, me esforzare más la próxima vez'),
(123, 'Me desconcentre, pero no volverá a suceder'),
(124, 'No debí confiarme, pero no pasara de nuevo'),
(125, 'Si quieres mi ayuda es mejor que la sepas pedir'),
(126, '¡No me hagas perder el tiempo!'),
(127, 'No quería hacerte daño, pero necesitabas ayuda'),
(128, 'Los que actuamos correctamente nunca perderemos'),
(129, 'Si necesitas ayuda házmelo saber'),
(130, 'Esto no es una derrota, me esforzaré más la próxima vez'),
(131, 'Esta derrota me enseña más, no volveré a perder'),
(132, 'Me falto preparación, hagámoslo otra vez'),
(133, 'Si te la pasas en el bar, no debo preocuparme'),
(134, 'Sé cómo estudias, y no me vas a ganar'),
(135, 'Como no te preparaste, no tenías ninguna posibilidad'),
(136, 'Ja Ja esto se veía venir'),
(137, 'Me prepare mucho, no es raro que ganara tan fácil'),
(138, 'Aprenderé, volveré y te derrotare'),
(139, 'Me distraje y acepto mi derrota'),
(140, 'No debí dejar de estudiar'),
(141, 'Sé que no estudiaste, esto va a ser fácil'),
(142, 'No eres rival para mí'),
(143, 'Mejor sigue perdiendo el tiempo'),
(144, '¡Ohhh! Las metas llegarán después de un gran sacrificio'),
(145, 'Mmm ¡La próxima vez será la vencida!'),
(146, '¡Solo el bien! prevalecerá siempre sobre el mal Jo Jo'),
(147, '¡Dos piensan mejor que uno!'),
(148, '¡Mmm, no siempre se gana, pero siempre se aprende!'),
(149, '¡Los últimos no siempre serán los últimos!');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `id_imagen` int(11) NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `imagen`
--

INSERT INTO `imagen` (`id_imagen`, `foto`) VALUES
(1, '/personaje1/foto1'),
(2, '/personaje2/foto1'),
(3, '/personaje2/foto2'),
(4, '/personaje1/foto2'),
(5, '/mundos/mundo1'),
(6, '/mundos/mundo2'),
(7, '/poderes/poder1'),
(8, '/poderes/poder2'),
(9, '/mundos/newMundo2.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `id_jugador` int(11) NOT NULL,
  `id_nivel` int(11) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `moneda_jugador` int(11) NOT NULL,
  `experiencia_jugador` int(11) NOT NULL,
  `nivel_jugador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`id_jugador`, `id_nivel`, `nickname`, `moneda_jugador`, `experiencia_jugador`, `nivel_jugador`) VALUES
(1, 1, 'nick01', 100, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador_tiene_personaje`
--

CREATE TABLE `jugador_tiene_personaje` (
  `id_jugador` int(11) NOT NULL,
  `id_personaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `jugador_tiene_personaje`
--

INSERT INTO `jugador_tiene_personaje` (`id_jugador`, `id_personaje`) VALUES
(1, 14),
(1, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `id_log` int(11) NOT NULL,
  `id_jugador` int(11) NOT NULL,
  `tiempo_log` time NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_final` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `log`
--

INSERT INTO `log` (`id_log`, `id_jugador`, `tiempo_log`, `fecha_inicio`, `fecha_final`) VALUES
(1, 1, '16:14:23', '2017-03-02 16:14:25', '2017-03-04 16:14:31'),
(2, 1, '16:14:42', '2017-03-03 16:14:45', '2017-03-04 16:14:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logros`
--

CREATE TABLE `logros` (
  `id_logro` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `esModenas` tinyint(1) NOT NULL,
  `esRanking` tinyint(1) NOT NULL,
  `esTiempo` tinyint(1) NOT NULL,
  `monedas` int(11) NOT NULL,
  `ranking` int(11) NOT NULL,
  `tiempoJugado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mundo`
--

CREATE TABLE `mundo` (
  `id_mundo` int(11) NOT NULL,
  `nombre_mundo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mundo`
--

INSERT INTO `mundo` (`id_mundo`, `nombre_mundo`) VALUES
(1, 'Mundo 1'),
(2, 'Mundo 2'),
(3, 'Mundo 3'),
(4, 'Mundo 4'),
(5, 'Mundo 5'),
(6, 'Mundo 6'),
(7, 'Mundo 7'),
(8, 'Mundo 8'),
(9, 'Mundo 9'),
(10, 'Mundo 10'),
(11, 'Mundo 11'),
(12, 'Mundo 12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mundo_tiene_imagen`
--

CREATE TABLE `mundo_tiene_imagen` (
  `id_mundo` int(11) NOT NULL,
  `id_imagen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mundo_tiene_imagen`
--

INSERT INTO `mundo_tiene_imagen` (`id_mundo`, `id_imagen`) VALUES
(1, 5),
(2, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `id_nivel` int(11) NOT NULL,
  `id_mundo` int(11) NOT NULL,
  `nombre_nivel` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`id_nivel`, `id_mundo`, `nombre_nivel`) VALUES
(1, 1, 'Nivel 1'),
(2, 1, 'nivel 2'),
(3, 1, 'nivel 3'),
(4, 1, 'nivel 4'),
(5, 1, 'Nivel 5 '),
(6, 2, 'Nivel 6'),
(7, 2, 'Nivel 7'),
(8, 2, 'Nivel 8'),
(9, 2, 'Nivel 9'),
(10, 2, 'Nivel 10'),
(11, 3, 'Nivel 11'),
(12, 3, 'Nivel 12'),
(13, 3, 'Nivel 13'),
(14, 3, 'Nivel 14'),
(15, 3, 'Nivel 15'),
(16, 4, 'Nivel 16'),
(17, 4, 'Nivel 17'),
(18, 4, 'Nivel 18'),
(19, 4, 'Nivel 19'),
(20, 4, 'Nivel 20'),
(21, 5, 'Nivel 21'),
(22, 5, 'Nivel 22'),
(23, 5, 'Nivel 23'),
(24, 5, 'Nivel 24'),
(25, 5, 'Nivel 25'),
(26, 6, 'Nivel 26'),
(27, 6, 'Nivel 27'),
(28, 6, 'Nivel 28'),
(29, 6, 'Nivel 29'),
(30, 6, 'Nivel 30'),
(31, 7, 'Nivel 31'),
(32, 7, 'Nivel 32'),
(33, 7, 'Nivel 33'),
(34, 7, 'Nivel 34'),
(35, 7, 'Nivel 35'),
(36, 8, 'Nivel 36'),
(37, 8, 'Nivel 37'),
(38, 8, 'Nivel 38'),
(39, 8, 'Nivel 39'),
(40, 8, 'Nivel 40'),
(41, 9, 'Nivel 41'),
(42, 9, 'Nivel 42'),
(43, 9, 'Nivel 43'),
(44, 9, 'Nivel 44'),
(45, 9, 'Nivel 45'),
(46, 10, 'Nivel 46'),
(47, 10, 'Nivel 47'),
(48, 10, 'Nivel 48'),
(49, 10, 'Nivel 49'),
(50, 10, 'Nivel 50'),
(51, 11, 'Nivel 51'),
(52, 11, 'Nivel 52'),
(53, 11, 'Nivel 53'),
(54, 11, 'Nivel 54'),
(55, 11, 'Nivel 55'),
(56, 12, 'Nivel 56'),
(57, 12, 'Nivel 57'),
(58, 12, 'Nivel 58'),
(59, 12, 'Nivel 59'),
(60, 12, 'Nivel 60'),
(61, 12, 'Nivel 61');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `id_pais` int(11) NOT NULL,
  `nombre_pais` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id_pais`, `nombre_pais`) VALUES
(1, 'Colombia'),
(2, 'Brasil');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje`
--

CREATE TABLE `personaje` (
  `id_personaje` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_imagen` int(11) NOT NULL,
  `nombre_personaje` varchar(20) NOT NULL,
  `descripcion_personaje` varchar(255) NOT NULL,
  `costo` int(11) NOT NULL,
  `nivel_dano` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `personaje`
--

INSERT INTO `personaje` (`id_personaje`, `id_categoria`, `id_imagen`, `nombre_personaje`, `descripcion_personaje`, `costo`, `nivel_dano`) VALUES
(1, 1, 1, 'juan rata', 'personaje 01 cargue ejemplo', 500, 50),
(1, 3, 1, 'Camilo Perezoso', 'Casual, al mantener una de sus manos en el bolsillo,sus ojos bien abiertos, pero con mente distraída y síntomas de cansancio por falta de sueño, debido a sus frecuentes salidas nocturnas.', 500, 50),
(2, 2, 2, 'pepe grillo', 'personaje 02 cargue ejemplo', 1000, 100),
(2, 3, 2, 'Felipe Oso', 'Es una persona que viste muy formal, pero no debes confiar en su apariencia. Es conocido por no sonreír, por su indisposición ante las situaciones y especialista en copiar movimientos, poderes y gestos.', 1000, 100),
(3, 4, 1, 'Carlos Buitre', 'Es una persona perspicaz, aparenta una vida correcta y realizada, pero en el fondo existe una persona engañosa y estafadora. Su habilidad principal es falsificar documentos para escabullirse de cualquier evento que pueda afectar su imagen y sobre todo sus', 1500, 150),
(4, 3, 2, 'Luis Víbora', 'Es una persona reservada, tranquila y veloz. Su agilidad le ha permitido incluirse en el top 10 de las personas más recurrentes en fraudes de Copyright informático.', 2000, 200),
(5, 3, 1, 'Andrés Zorro', 'Es una persona joven, compañerita y de muy buen ambiente. Sin embargo, se ha visto preocupado e inestable emocionalmente por la serie de evidencias que lo involucran en colarse en sistemas de transporte universitario', 2500, 250),
(6, 3, 2, 'Nicolás Lagarto', 'Es una persona alegre, perezoso, y deportista. Bastante competitivo y cuenta con unas orejas pequeñas que permiten escuchar a más distancia de lo habitual.', 3000, 300),
(7, 1, 1, 'Pedro Conejo', 'Descripción del nuevo personaje', 100, 3),
(7, 3, 1, 'Víctor Hiena', 'Es una persona tranquila, fría, viste muy bien, sin preocupaciones, pero NO es totalmente feliz ya que habla mal de las demás personas.', 3500, 350),
(8, 1, 1, 'Pedro Pez', 'Descripción del nuevo personaje', 100, 3),
(8, 3, 2, 'Fabián Babuino', 'Es una persona temperamental, de malgenio, sociable únicamente con su grupo de amigos, conflictiva para ganar territorio y reconocimiento', 4000, 400),
(9, 1, 1, 'Lola vaca', 'Descripción de la vaca', 230, 20),
(9, 3, 1, 'Julián Burro', 'Una persona de estrato medio, que intenta obtener logros para su beneficio a costa de los demás. Es conocido por contratar terceros para hacer sus trabajos y parciales estudiantiles, avances laborales y proyectos', 4500, 450),
(10, 3, 2, 'Juan Rata', 'Es una persona que vive en un mundo fraudulento. Se provee de artículos importantes realizar distribuciones a cambio de dinero.', 5000, 500),
(11, 3, 1, 'Juan Camaleón', 'Es una persona inteligente, cumplida al momento de entregar los temas pendientes a su cargo, buen compañero, poco sociable, pero en busca de ser aceptado por las personas.', 5500, 550),
(12, 4, 2, 'Ana y Sara abeja', 'Son realmente hermosas, les encanta salir a reunirse con sus amigos a compartir, participan poco a clase y sus prioridades siempre son las fiestas y sus amigos que el estudio', 6000, 600),
(13, 2, 1, 'Iván Ruiseñor', 'Es una persona amigable, bastante elegante a la hora de vestir, valores definidos, respetuoso y competitivo.\n', 6500, 650),
(14, 1, 2, 'Tati Hormiga', 'Es una persona carismática, dispuesta a ayudar, le agrada socializarse con las personas y para ello construye o se integra a grupos de trabajo. Se desempeña como comunicadora social y lidera varios proyectos académicos y laborales', 7000, 700),
(15, 1, 1, 'Andrés Gallo', 'Es una persona muy puntual, le encanta socializar con las personas. El reconoce el trabajo duro de las personas y a su vez hace parte importante en el apoyo de sus compañeros con asesorías de extra clase.', 7500, 750),
(16, 2, 2, 'Fabián Canario', 'Es un pequeñín sin igual, sus buenos modales no son cuestión del azar. Una excelente educación en la universidad y en el hogar, crearon reglas básicas que lo hacen resaltar: Un saludo, un por favor y dar las gracias nunca están de más.', 8000, 800),
(17, 1, 1, 'Cata Cierva', 'Siempre una cara tierna y una sonrisa despierta, para Cata la amabilidad es su mejor receta, por eso saludar y dar las gracias, son pasos básicos, que, para ella, ayudan a tratar bien a la gente.', 8500, 850),
(18, 1, 2, 'Ana Pantera', 'Ana tiene buenos amigos y un gran grupo social, los sigue a todos lados y los apoya sin dudar. Pero si algo no le parece o ve que la puede afectar, no se toma ni un segundo para pensar, sus buenos principios los defiende y no los va a negociar.', 9000, 900),
(19, 1, 1, 'Lola Abeja', 'Caracterizada por ser un personaje talentoso e inteligente. Su estatura está representada en su capacidad de movimiento y agilidad física.', 9500, 950),
(20, 1, 2, 'Daniel León', 'Personajes con grandes cualidades de responsabilidad y compromiso académico. Evitan de manera incondicional cualquier tipo de trabajos de información imprecisa y ausente de fuentes de propiedad intelectual.', 10000, 1000),
(21, 1, 1, 'Pedro Ratón', 'Pedro se destaca por su apariencia pequeña, pero con una gran intuición y agilidad mental frente a los combates.', 10500, 1050),
(27, 1, 1, 'Miguel Vaca', 'Descripción de la vaca', 230, 20),
(28, 1, 1, 'Pedro Pez', 'Descripción del nuevo personaje', 100, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje_tiene_frase`
--

CREATE TABLE `personaje_tiene_frase` (
  `id_personaje` int(11) NOT NULL,
  `id_frase` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `personaje_tiene_frase`
--

INSERT INTO `personaje_tiene_frase` (`id_personaje`, `id_frase`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje_tiene_imagen`
--

CREATE TABLE `personaje_tiene_imagen` (
  `id_personaje_tiene_imagen` int(11) NOT NULL,
  `id_Imgen` int(11) NOT NULL,
  `id_personaje` int(11) NOT NULL,
  `id_categoriaImagen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje_tiene_poder`
--

CREATE TABLE `personaje_tiene_poder` (
  `id_personaje` int(11) NOT NULL,
  `id_poder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `personaje_tiene_poder`
--

INSERT INTO `personaje_tiene_poder` (`id_personaje`, `id_poder`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poder`
--

CREATE TABLE `poder` (
  `id_poder` int(11) NOT NULL,
  `id_imagen` int(11) NOT NULL,
  `nombre_poder` varchar(20) NOT NULL,
  `descripcion_poder` varchar(255) NOT NULL,
  `tipo_poder` int(11) NOT NULL,
  `forma_poder` int(11) NOT NULL,
  `potencia_poder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `poder`
--

INSERT INTO `poder` (`id_poder`, `id_imagen`, `nombre_poder`, `descripcion_poder`, `tipo_poder`, `forma_poder`, `potencia_poder`) VALUES
(1, 7, 'Perezoso', 'Lanza lapices hacia su oponente', 1, 1, 10),
(2, 8, 'Copia', 'Lanza cuadernos hacia su oponente', 1, 1, 10),
(3, 7, 'Incapacidad Medica', 'Habilita la caída de elementos como Jeringas, Hojas, Curas y vendajes del cielo sobre su oponente', 1, 2, 10),
(4, 8, 'Copia Internet', 'Habilita la caída de pantallas de computadores del cielo sobre su oponente', 1, 2, 10),
(5, 7, 'Aprisa', 'Habilita la caída de palabras como “¿Colémonos”, “¿Tengo Afán”, “¿No existen filas”, “Usted no sabe quién soy yo?” del cielo sobre su oponente', 1, 2, 10),
(6, 8, 'El negocio', 'Lanza Chocolatinas o balones hacia su oponente', 1, 1, 10),
(7, 7, 'Groserias', 'Habilita la caída de caritas groseras desde el cielo', 1, 2, 10),
(8, 8, 'Conflicto', 'Habilita la caída de guantes de boxeo del cielo sobre su oponente', 1, 2, 10),
(9, 7, 'El poder del dinero', 'Habilita la caída de elementos como dinero, hojas y lápices del cielo sobre su oponente', 1, 2, 10),
(10, 8, 'El Vendedor', 'Lanza el símbolo de $ hacia su oponente', 1, 1, 10),
(11, 7, 'Suplantación', 'Habilita la caída de camaleones de colores del cielo sobre su oponente', 1, 2, 10),
(12, 8, 'Super copia', 'Habilita la caída de palabras como “Copiar Examen”, “Usa celular”, “Toma fotos al examen”, “Miremos al compañero” del cielo sobre su oponente', 1, 2, 10),
(13, 7, 'Respeto', 'Lanza notas musicales hacia su oponente', 1, 1, 10),
(14, 8, 'Colaboracion', 'Lanza el símbolo de cooperación hacia su oponente', 1, 1, 10),
(15, 7, 'Puntualidad', 'Habilita la caída de relojes del cielo sobre su oponente', 1, 2, 10),
(16, 8, 'Valores', 'Habilita la caída de palabras como “Respeto”, “Voluntad”, “Valentía”, “Orden”, “Honestidad” cielo sobre su oponente', 1, 2, 10),
(17, 7, 'Alegria', 'Habilita la caída de caritas alegres desde el cielo', 1, 2, 10),
(18, 8, 'Amistad', 'Lanza el símbolo de amistad hacia su oponente', 1, 1, 10),
(19, 7, 'Metas', 'Habilita la caída de alas desde el cielo', 1, 2, 10),
(20, 8, 'Compañerismo', 'Lanza cuadernos, Lápices, Hojas, relojes hacia su oponente', 1, 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta_prueba_psicotecnica`
--

CREATE TABLE `pregunta_prueba_psicotecnica` (
  `id_pregunta_psicotecnica` int(11) UNSIGNED ZEROFILL NOT NULL,
  `id_prueba_psicotecnica` int(11) NOT NULL,
  `pregunta` varchar(255) NOT NULL,
  `id_tipo_pregunta_psicotecnica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba_psicotecnica`
--

CREATE TABLE `prueba_psicotecnica` (
  `id_prueba_psicotecnica` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `id_tipo_prueba` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuesta_preguntas_psicotecnicas`
--

CREATE TABLE `respuesta_preguntas_psicotecnicas` (
  `id_pregunta_prueba_psicotecnica` int(11) NOT NULL,
  `id_respuesta_psicotecnica` int(11) NOT NULL,
  `descripcion_prueba_psicotecnica` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario`
--

CREATE TABLE `rol_usuario` (
  `id_rol_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id_rol_usuario`, `tipo_usuario`) VALUES
(1, 'Estudiante'),
(2, 'Administrador'),
(3, 'Reportes'),
(4, 'Psicologia'),
(5, 'Interno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pregunta_psicotecnica`
--

CREATE TABLE `tipo_pregunta_psicotecnica` (
  `id_tipo_pregunta_psicotecnica` int(11) NOT NULL,
  `clase_pregunta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_prueba`
--

CREATE TABLE `tipo_prueba` (
  `id_tipo_prueba` int(11) NOT NULL,
  `tipo_prueba` varchar(100) NOT NULL,
  `descripcion_tipo_prueba` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  `id_rol_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) DEFAULT NULL,
  `apellido_usuario` varchar(100) DEFAULT NULL,
  `email_usuario` varchar(150) DEFAULT NULL,
  `contrasena_usuario` varchar(20) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `fecha_token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `id_pais`, `id_ciudad`, `id_rol_usuario`, `nombre_usuario`, `apellido_usuario`, `email_usuario`, `contrasena_usuario`, `fecha_registro`, `token`, `fecha_token`) VALUES
(1, 1, 1, 1, 'Estudiante', 'Demo', 'usuario@poligran.edu.co', 'demo123', '2017-03-04 15:20:16', '0FDA6485B204459B82BAF049A37A16D4190417194507', '2017-04-19 19:45:07 '),
(2, 1, 52838, 1, 'jnrubiano', 'Rubiano', 'jnrubiano@poligran.edu.co', '1234567890', '2017-04-15 23:28:47', '962C7B2EBEB246ACB132C4BAA90E52E6170417155119', '2017-04-17 15:51:19 ');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `categoriaimagen`
--
ALTER TABLE `categoriaimagen`
  ADD PRIMARY KEY (`id_categoriaImagen`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`);

--
-- Indices de la tabla `frase`
--
ALTER TABLE `frase`
  ADD PRIMARY KEY (`id_frase`);

--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`id_imagen`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id_jugador`,`id_nivel`),
  ADD KEY `fk_jugador_nivel1_idx` (`id_nivel`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `jugador_tiene_personaje`
--
ALTER TABLE `jugador_tiene_personaje`
  ADD PRIMARY KEY (`id_jugador`,`id_personaje`),
  ADD KEY `fk_Jugador_has_Personaje_Personaje1_idx` (`id_personaje`),
  ADD KEY `fk_Jugador_has_Personaje_Jugador_idx` (`id_jugador`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id_log`,`id_jugador`),
  ADD KEY `fk_log_jugador1_idx` (`id_jugador`);

--
-- Indices de la tabla `mundo`
--
ALTER TABLE `mundo`
  ADD PRIMARY KEY (`id_mundo`);

--
-- Indices de la tabla `mundo_tiene_imagen`
--
ALTER TABLE `mundo_tiene_imagen`
  ADD PRIMARY KEY (`id_mundo`,`id_imagen`),
  ADD KEY `fk_mundo_tiene_imagen_imagen1_idx` (`id_imagen`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`id_nivel`,`id_mundo`),
  ADD KEY `fk_nivel_mundo1_idx` (`id_mundo`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indices de la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD PRIMARY KEY (`id_personaje`,`id_categoria`,`id_imagen`),
  ADD KEY `fk_personaje_rol_tipo1_idx` (`id_categoria`),
  ADD KEY `fk_personaje_imagen1_idx` (`id_imagen`);

--
-- Indices de la tabla `personaje_tiene_frase`
--
ALTER TABLE `personaje_tiene_frase`
  ADD PRIMARY KEY (`id_personaje`,`id_frase`),
  ADD KEY `fk_personaje_tiene_frase_personaje1_idx` (`id_personaje`),
  ADD KEY `fk_personaje_tiene_frase_frase1_idx` (`id_frase`);

--
-- Indices de la tabla `personaje_tiene_imagen`
--
ALTER TABLE `personaje_tiene_imagen`
  ADD PRIMARY KEY (`id_personaje_tiene_imagen`),
  ADD KEY `FK_id_CategoriaImagen` (`id_categoriaImagen`),
  ADD KEY `FK_id_Personaje` (`id_personaje`),
  ADD KEY `FK_id_Imgen` (`id_Imgen`);

--
-- Indices de la tabla `personaje_tiene_poder`
--
ALTER TABLE `personaje_tiene_poder`
  ADD PRIMARY KEY (`id_personaje`,`id_poder`),
  ADD KEY `fk_Personaje_has_poder_poder1_idx` (`id_poder`),
  ADD KEY `fk_Personaje_has_poder_Personaje1_idx` (`id_personaje`);

--
-- Indices de la tabla `poder`
--
ALTER TABLE `poder`
  ADD PRIMARY KEY (`id_poder`,`id_imagen`),
  ADD KEY `fk_poder_imagen1_idx` (`id_imagen`);

--
-- Indices de la tabla `pregunta_prueba_psicotecnica`
--
ALTER TABLE `pregunta_prueba_psicotecnica`
  ADD PRIMARY KEY (`id_prueba_psicotecnica`,`id_pregunta_psicotecnica`,`id_tipo_pregunta_psicotecnica`),
  ADD KEY `fk_pregunta_psicotecnica_respuesta_psicotecnica1_idx` (`pregunta`),
  ADD KEY `fk_pregunta_psicotecnica_tipo_pregunta_psicotecnica1_idx` (`id_tipo_pregunta_psicotecnica`),
  ADD KEY `id_pregunta_psicotecnica` (`id_pregunta_psicotecnica`);

--
-- Indices de la tabla `prueba_psicotecnica`
--
ALTER TABLE `prueba_psicotecnica`
  ADD PRIMARY KEY (`id_prueba_psicotecnica`,`id_tipo_prueba`),
  ADD KEY `fk_tipo_prueba1_idx` (`id_tipo_prueba`),
  ADD KEY `id_prueba_psicotecnica` (`id_prueba_psicotecnica`);

--
-- Indices de la tabla `respuesta_preguntas_psicotecnicas`
--
ALTER TABLE `respuesta_preguntas_psicotecnicas`
  ADD PRIMARY KEY (`id_respuesta_psicotecnica`,`id_pregunta_prueba_psicotecnica`);

--
-- Indices de la tabla `rol_usuario`
--
ALTER TABLE `rol_usuario`
  ADD PRIMARY KEY (`id_rol_usuario`);

--
-- Indices de la tabla `tipo_pregunta_psicotecnica`
--
ALTER TABLE `tipo_pregunta_psicotecnica`
  ADD PRIMARY KEY (`id_tipo_pregunta_psicotecnica`);

--
-- Indices de la tabla `tipo_prueba`
--
ALTER TABLE `tipo_prueba`
  ADD PRIMARY KEY (`id_tipo_prueba`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`,`id_pais`,`id_ciudad`,`id_rol_usuario`),
  ADD KEY `fk_usuario_jugador1_idx` (`id_usuario`),
  ADD KEY `fk_usuario_pais1_idx` (`id_pais`),
  ADD KEY `fk_usuario_ciudad1_idx` (`id_ciudad`),
  ADD KEY `fk_usuario_rol_usuario1_idx` (`id_rol_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `categoriaimagen`
--
ALTER TABLE `categoriaimagen`
  MODIFY `id_categoriaImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99776;
--
-- AUTO_INCREMENT de la tabla `frase`
--
ALTER TABLE `frase`
  MODIFY `id_frase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;
--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id_jugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `mundo`
--
ALTER TABLE `mundo`
  MODIFY `id_mundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `id_nivel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `id_pais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `personaje`
--
ALTER TABLE `personaje`
  MODIFY `id_personaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT de la tabla `personaje_tiene_imagen`
--
ALTER TABLE `personaje_tiene_imagen`
  MODIFY `id_personaje_tiene_imagen` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `poder`
--
ALTER TABLE `poder`
  MODIFY `id_poder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `pregunta_prueba_psicotecnica`
--
ALTER TABLE `pregunta_prueba_psicotecnica`
  MODIFY `id_pregunta_psicotecnica` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `prueba_psicotecnica`
--
ALTER TABLE `prueba_psicotecnica`
  MODIFY `id_prueba_psicotecnica` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `respuesta_preguntas_psicotecnicas`
--
ALTER TABLE `respuesta_preguntas_psicotecnicas`
  MODIFY `id_respuesta_psicotecnica` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `rol_usuario`
--
ALTER TABLE `rol_usuario`
  MODIFY `id_rol_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tipo_pregunta_psicotecnica`
--
ALTER TABLE `tipo_pregunta_psicotecnica`
  MODIFY `id_tipo_pregunta_psicotecnica` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tipo_prueba`
--
ALTER TABLE `tipo_prueba`
  MODIFY `id_tipo_prueba` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `fk_jugador_nivel1` FOREIGN KEY (`id_nivel`) REFERENCES `nivel` (`id_nivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_jugador_usuario1` FOREIGN KEY (`id_jugador`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `jugador_tiene_personaje`
--
ALTER TABLE `jugador_tiene_personaje`
  ADD CONSTRAINT `fk_Jugador_has_Personaje_Jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jugador_has_Personaje_Personaje1` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `fk_log_jugador1` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `mundo_tiene_imagen`
--
ALTER TABLE `mundo_tiene_imagen`
  ADD CONSTRAINT `fk_mundo_tiene_imagen_imagen1` FOREIGN KEY (`id_imagen`) REFERENCES `imagen` (`id_imagen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mundo_tiene_imagen_mundo1` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD CONSTRAINT `Fk_nivel_mundo1` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD CONSTRAINT `fk_personaje_imagen1` FOREIGN KEY (`id_imagen`) REFERENCES `imagen` (`id_imagen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_personaje_rol_tipo1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje_tiene_frase`
--
ALTER TABLE `personaje_tiene_frase`
  ADD CONSTRAINT `fk_personaje_tiene_frase_frase1` FOREIGN KEY (`id_frase`) REFERENCES `frase` (`id_frase`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_personaje_tiene_frase_personaje1` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje_tiene_imagen`
--
ALTER TABLE `personaje_tiene_imagen`
  ADD CONSTRAINT `FK_id_CategoriaImagen` FOREIGN KEY (`id_categoriaImagen`) REFERENCES `categoriaimagen` (`id_categoriaImagen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_id_Imgen` FOREIGN KEY (`id_Imgen`) REFERENCES `imagen` (`id_imagen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_id_Personaje` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje_tiene_poder`
--
ALTER TABLE `personaje_tiene_poder`
  ADD CONSTRAINT `fk_Personaje_has_poder_Personaje1` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Personaje_has_poder_poder1` FOREIGN KEY (`id_poder`) REFERENCES `poder` (`id_poder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `poder`
--
ALTER TABLE `poder`
  ADD CONSTRAINT `fk_poder_imagen1` FOREIGN KEY (`id_imagen`) REFERENCES `imagen` (`id_imagen`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pregunta_prueba_psicotecnica`
--
ALTER TABLE `pregunta_prueba_psicotecnica`
  ADD CONSTRAINT `fk_prueba_psicotecnica1_idx` FOREIGN KEY (`id_prueba_psicotecnica`) REFERENCES `prueba_psicotecnica` (`id_prueba_psicotecnica`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_pregunta_psicotecnica1_idx` FOREIGN KEY (`id_tipo_pregunta_psicotecnica`) REFERENCES `tipo_pregunta_psicotecnica` (`id_tipo_pregunta_psicotecnica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `prueba_psicotecnica`
--
ALTER TABLE `prueba_psicotecnica`
  ADD CONSTRAINT `fk_tipo_prueba1_idx` FOREIGN KEY (`id_tipo_prueba`) REFERENCES `tipo_prueba` (`id_tipo_prueba`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_ciudad1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_pais1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_rol_usuario1` FOREIGN KEY (`id_rol_usuario`) REFERENCES `rol_usuario` (`id_rol_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{"angular_direct":"direct","relation_lines":"true","snap_to_grid":"off"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{"db":"pactohonor","table":"categoriaimagen"},{"db":"pactohonor","table":"usuario"},{"db":"pactohonor","table":"personaje"},{"db":"pactohonor","table":"categoria"},{"db":"pactohonor","table":"ciudad"},{"db":"pactohonor","table":"jugador"},{"db":"pactohonor","table":"frase"},{"db":"pactohonor","table":"mundo_tiene_imagen"},{"db":"wordpress","table":"wp_users"},{"db":"information_schema","table":"schemata"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2016-11-04 15:30:00', '{"lang":"es","collation_connection":"utf8mb4_unicode_ci"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;--
-- Base de datos: `qanticamarket`
--
CREATE DATABASE IF NOT EXISTS `qanticamarket` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `qanticamarket`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `rol_id` int(11) NOT NULL,
  `icono` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `estado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `descripcion`, `rol_id`, `icono`, `estado`) VALUES
(1, 'Aplicaciones', 'Aplicaciones que provee Q-antica', 1, 'apps.png', 1),
(2, 'Documentos', 'Documentos ofrecidos por Q-antica', 1, 'documentos.png', 1),
(5, 'Videos', 'Videos ofrecidos por Q-antica', 1, 'videos.png', 1),
(6, 'Alta Gracia', 'Alta Gracia', 4, 'logo.png', 1),
(7, 'Alta Gracia', 'Alta Gracia', 4, 'logo.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `contenido_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`id`, `descripcion`, `fecha`, `nombre`, `rating`, `contenido_id`, `usuario_id`) VALUES
(1, 'Comentario desde localhost para ver que imprime en el sErvlet', '2016-11-22 13:39:00', 'Juan Rubiano', 3, 1, 1),
(2, 'Comentario 2 que se ingresa desde el localhost', '2016-11-22 14:40:23', 'Juan Rubiano', 5, 1, 1),
(3, 'Comentario que se ingresa desde el localhost con el usuario Jacinto', '2016-11-22 14:41:05', 'Jacinto Lopera', 5, 1, 3),
(4, 'Comentario 1 para el contenido 2 ', '2016-11-22 14:42:35', 'Juan Rubiano', 5, 4, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id` int(11) NOT NULL,
  `captura_1` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `captura_2` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descargas` int(11) DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `icono` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `publicacion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `ruta` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id`, `captura_1`, `captura_2`, `descargas`, `descripcion`, `estado`, `icono`, `nombre`, `publicacion`, `rating`, `ruta`, `version`, `categoria_id`, `subcategoria_id`) VALUES
(1, '1.png', 'concentrate.jpg', 8, 'Juego concéntrate para Samsung', 1, 'ic_launcher_concentrate.png', 'Concéntrate con Samsung', '2016-04-28 22:00:00', 0, 'ConcentrateFinal.apk', '1.2', 1, 1),
(4, '', '', 0, 'Contenido cargado desde la web', 1, 'ic_launcher.png', 'Contenido Web', '2016-11-13 14:27:00', 0, 'putty.exe', '1.2', 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descarga`
--

CREATE TABLE `descarga` (
  `id` int(11) NOT NULL,
  `fecha` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contenido_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `descarga`
--

INSERT INTO `descarga` (`id`, `fecha`, `contenido_id`, `usuario_id`) VALUES
(1, '2016-11-09', 1, 1),
(2, '2016-11-09', 1, 1),
(3, '2016-11-09', 1, 1),
(4, '2016-11-09', 1, 1),
(5, '2016-11-09', 1, 1),
(6, '2016-11-09', 1, 1),
(7, '2016-11-09', 1, 1),
(8, '2016-11-09', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `id` int(11) NOT NULL,
  `fecha` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`id`, `fecha`, `usuario_id`) VALUES
(1, '24/11/2016 20:00:34 ', 1),
(2, '24/11/2016 20:41:21 ', 1),
(3, '24/11/2016 20:41:28 ', 1),
(4, '24/11/2016 20:42:13 ', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticia`
--

CREATE TABLE `noticia` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fuente` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rol_id` int(11) NOT NULL,
  `titulo` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `noticia`
--

INSERT INTO `noticia` (`id`, `descripcion`, `fecha`, `fuente`, `imagen`, `rol_id`, `titulo`) VALUES
(2, 'Esta es una noticia que se está enviando desde el SErvlet', '2016-08-18 09:23:00', 'Q-antica', '', 1, 'Noticia de prueba'),
(3, 'Esta es una noticia que se está enviando desde el Servlet 2', '2016-08-18 09:23:00', 'Q-antica', '', 1, 'Noticia de prueba 2'),
(4, 'Noticia para Camilo', '24/08/2016', 'Q-antica', '123.png', 3, 'Camilo Mendieta'),
(6, 'Noticia de prueba web', '10/11/2016', 'Web', NULL, 4, 'Noticia de prueba web'),
(7, 'Prueba por la modificación del objeto', '13/11/2016 23:18:06 ', 'Fedecafe', NULL, 1, 'Modificación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `estado`) VALUES
(1, 'Administrador', 1),
(2, 'Prueba actualización', 1),
(3, 'Product Manager', 1),
(4, 'Prueba', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `subcategoria_id` int(11) DEFAULT NULL,
  `icono` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `estado` tinyint(4) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`id`, `nombre`, `subcategoria_id`, `icono`, `estado`, `categoria_id`) VALUES
(1, 'Samsung', NULL, 'ic_launcher_concentrate', 1, 1),
(2, 'Prueba desde la web', NULL, '', 0, 1),
(3, 'Juegos', NULL, 'ico_cont_03.png', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombreUsuario` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `contrasena` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `identificacion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombreUsuario`, `contrasena`, `identificacion`, `nombre`, `apellido`, `rol_id`) VALUES
(1, 'jnrubiano', '123', '1032438571', 'Nicolás', 'Rubiano', 1),
(2, 'cmendieta', '123456', '1234567890', 'Camilo', 'Mendieta', 3),
(3, 'jlopez', '', '1032438571', 'Jacinto', 'Lopera', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK9E0DE7E1B31820B3` (`usuario_id`),
  ADD KEY `FK9E0DE7E11BC76E93` (`contenido_id`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKE7BBDD79D5ECEA1` (`subcategoria_id`),
  ADD KEY `FKE7BBDD798AD91C53` (`categoria_id`);

--
-- Indices de la tabla `descarga`
--
ALTER TABLE `descarga`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK3CA91EDCB31820B3` (`usuario_id`),
  ADD KEY `FK3CA91EDC1BC76E93` (`contenido_id`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK740432B1B31820B3` (`usuario_id`);

--
-- Indices de la tabla `noticia`
--
ALTER TABLE `noticia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ROL_NOTICIA` (`rol_id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_CATEGORIA_SUBCATEGORIA` (`categoria_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKF814F32E13055593` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `descarga`
--
ALTER TABLE `descarga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `noticia`
--
ALTER TABLE `noticia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `FK_CATEGORIA_SUBCATEGORIA` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Base de datos: `wordpress`
--
CREATE DATABASE IF NOT EXISTS `wordpress` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `wordpress`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_commentmeta`
--

CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_comments`
--

CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 1, 'Un comentarista de WordPress', 'wapuu@wordpress.example', 'https://wordpress.org/', '', '2016-11-08 14:13:45', '2016-11-08 14:13:45', 'Hola, esto es un comentario.\nPara empezar a moderar, editar y borrar comentarios, por favor, visita la pantalla de comentarios en el escritorio.\nLos avatares de los comentaristas provienen de <a href="https://gravatar.com">Gravatar</a>.', 0, 'post-trashed', '', '', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_duplicator_packages`
--

CREATE TABLE `wp_duplicator_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `hash` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `status` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `owner` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `package` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `wp_duplicator_packages`
--

INSERT INTO `wp_duplicator_packages` (`id`, `name`, `hash`, `status`, `created`, `owner`, `package`) VALUES
(1, '20170306_bida', '58bcddd377b697370170306035603', 100, '2017-03-06 03:56:24', 'jnrubiano', 0x4f3a31313a224455505f5061636b616765223a32333a7b733a373a2243726561746564223b733a31393a22323031372d30332d30362030333a35363a3033223b733a373a2256657273696f6e223b733a363a22312e312e3334223b733a393a2256657273696f6e5750223b733a353a22342e362e31223b733a393a2256657273696f6e4442223b733a373a2231302e312e3136223b733a31303a2256657273696f6e504850223b733a353a22372e302e39223b733a393a2256657273696f6e4f53223b733a353a2257494e4e54223b733a323a224944223b693a313b733a343a224e616d65223b733a31333a2232303137303330365f62696461223b733a343a2248617368223b733a32393a223538626364646433373762363937333730313730333036303335363033223b733a383a224e616d6548617368223b733a34333a2232303137303330365f626964615f3538626364646433373762363937333730313730333036303335363033223b733a343a2254797065223b693a303b733a353a224e6f746573223b733a303a22223b733a393a2253746f726550617468223b733a34323a22433a2f78616d70702f6874646f63732f776f726470726573732f77702d736e617073686f74732f746d70223b733a383a2253746f726555524c223b733a34303a22687474703a2f2f6c6f63616c686f73742f776f726470726573732f77702d736e617073686f74732f223b733a383a225363616e46696c65223b733a35333a2232303137303330365f626964615f35386263646464333737623639373337303137303330363033353630335f7363616e2e6a736f6e223b733a373a2252756e74696d65223b733a31303a2231392e3434207365632e223b733a373a2245786553697a65223b733a383a223339342e36374b42223b733a373a225a697053697a65223b733a373a2232322e39374d42223b733a363a22537461747573223b4e3b733a363a22575055736572223b733a393a226a6e72756269616e6f223b733a373a2241726368697665223b4f3a31313a224455505f41726368697665223a31333a7b733a31303a2246696c74657244697273223b733a303a22223b733a31303a2246696c74657245787473223b733a303a22223b733a31333a2246696c74657244697273416c6c223b613a303a7b7d733a31333a2246696c74657245787473416c6c223b613a303a7b7d733a383a2246696c7465724f6e223b693a303b733a343a2246696c65223b733a35353a2232303137303330365f626964615f35386263646464333737623639373337303137303330363033353630335f617263686976652e7a6970223b733a363a22466f726d6174223b733a333a225a4950223b733a373a225061636b446972223b733a32353a22433a2f78616d70702f6874646f63732f776f72647072657373223b733a343a2253697a65223b693a32343038313834393b733a343a2244697273223b613a303a7b7d733a353a2246696c6573223b613a303a7b7d733a31303a2246696c746572496e666f223b4f3a32333a224455505f417263686976655f46696c7465725f496e666f223a363a7b733a343a2244697273223b4f3a33343a224455505f417263686976655f46696c7465725f53636f70655f4469726563746f7279223a343a7b733a373a225761726e696e67223b613a303a7b7d733a31303a22556e7265616461626c65223b613a303a7b7d733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a353a2246696c6573223b4f3a32393a224455505f417263686976655f46696c7465725f53636f70655f46696c65223a353a7b733a343a2253697a65223b613a303a7b7d733a373a225761726e696e67223b613a303a7b7d733a31303a22556e7265616461626c65223b613a303a7b7d733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a343a2245787473223b4f3a32393a224455505f417263686976655f46696c7465725f53636f70655f42617365223a323a7b733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a393a2255446972436f756e74223b693a303b733a31303a225546696c65436f756e74223b693a303b733a393a2255457874436f756e74223b693a303b7d733a31303a22002a005061636b616765223b723a313b7d733a393a22496e7374616c6c6572223b4f3a31333a224455505f496e7374616c6c6572223a31323a7b733a343a2246696c65223b733a35373a2232303137303330365f626964615f35386263646464333737623639373337303137303330363033353630335f696e7374616c6c65722e706870223b733a343a2253697a65223b693a3430343134353b733a31303a224f7074734442486f7374223b733a303a22223b733a31303a224f7074734442506f7274223b733a303a22223b733a31303a224f70747344424e616d65223b733a303a22223b733a31303a224f707473444255736572223b733a303a22223b733a31323a224f70747353534c41646d696e223b693a303b733a31323a224f70747353534c4c6f67696e223b693a303b733a31313a224f70747343616368655750223b693a303b733a31333a224f707473436163686550617468223b693a303b733a31303a224f70747355524c4e6577223b733a303a22223b733a31303a22002a005061636b616765223b723a313b7d733a383a224461746162617365223b4f3a31323a224455505f4461746162617365223a31333a7b733a343a2254797065223b733a353a224d7953514c223b733a343a2253697a65223b693a3732383030373b733a343a2246696c65223b733a35363a2232303137303330365f626964615f35386263646464333737623639373337303137303330363033353630335f64617461626173652e73716c223b733a343a2250617468223b4e3b733a31323a2246696c7465725461626c6573223b733a303a22223b733a383a2246696c7465724f6e223b693a303b733a343a224e616d65223b4e3b733a31303a22436f6d70617469626c65223b733a303a22223b733a383a22436f6d6d656e7473223b733a33313a226d6172696164622e6f72672062696e61727920646973747269627574696f6e223b733a31303a22002a005061636b616765223b723a313b733a32353a22004455505f446174616261736500646253746f726550617468223b733a39393a22433a2f78616d70702f6874646f63732f776f726470726573732f77702d736e617073686f74732f746d702f32303137303330365f626964615f35386263646464333737623639373337303137303330363033353630335f64617461626173652e73716c223b733a32333a22004455505f446174616261736500454f464d61726b6572223b733a303a22223b733a32363a22004455505f4461746162617365006e6574776f726b466c757368223b623a303b7d7d),
(2, '20170306_bida', '58bcde1b07eb53023170306035715', 100, '2017-03-06 03:57:28', 'jnrubiano', 0x4f3a31313a224455505f5061636b616765223a32333a7b733a373a2243726561746564223b733a31393a22323031372d30332d30362030333a35373a3135223b733a373a2256657273696f6e223b733a363a22312e312e3334223b733a393a2256657273696f6e5750223b733a353a22342e362e31223b733a393a2256657273696f6e4442223b733a373a2231302e312e3136223b733a31303a2256657273696f6e504850223b733a353a22372e302e39223b733a393a2256657273696f6e4f53223b733a353a2257494e4e54223b733a323a224944223b693a323b733a343a224e616d65223b733a31333a2232303137303330365f62696461223b733a343a2248617368223b733a32393a223538626364653162303765623533303233313730333036303335373135223b733a383a224e616d6548617368223b733a34333a2232303137303330365f626964615f3538626364653162303765623533303233313730333036303335373135223b733a343a2254797065223b693a303b733a353a224e6f746573223b733a303a22223b733a393a2253746f726550617468223b733a34323a22433a2f78616d70702f6874646f63732f776f726470726573732f77702d736e617073686f74732f746d70223b733a383a2253746f726555524c223b733a34303a22687474703a2f2f6c6f63616c686f73742f776f726470726573732f77702d736e617073686f74732f223b733a383a225363616e46696c65223b733a35333a2232303137303330365f626964615f35386263646531623037656235333032333137303330363033353731355f7363616e2e6a736f6e223b733a373a2252756e74696d65223b733a393a22372e3231207365632e223b733a373a2245786553697a65223b733a383a223339342e36374b42223b733a373a225a697053697a65223b733a373a2232322e39374d42223b733a363a22537461747573223b4e3b733a363a22575055736572223b733a393a226a6e72756269616e6f223b733a373a2241726368697665223b4f3a31313a224455505f41726368697665223a31333a7b733a31303a2246696c74657244697273223b733a303a22223b733a31303a2246696c74657245787473223b733a303a22223b733a31333a2246696c74657244697273416c6c223b613a303a7b7d733a31333a2246696c74657245787473416c6c223b613a303a7b7d733a383a2246696c7465724f6e223b693a303b733a343a2246696c65223b733a35353a2232303137303330365f626964615f35386263646531623037656235333032333137303330363033353731355f617263686976652e7a6970223b733a363a22466f726d6174223b733a333a225a4950223b733a373a225061636b446972223b733a32353a22433a2f78616d70702f6874646f63732f776f72647072657373223b733a343a2253697a65223b693a32343038323034343b733a343a2244697273223b613a303a7b7d733a353a2246696c6573223b613a303a7b7d733a31303a2246696c746572496e666f223b4f3a32333a224455505f417263686976655f46696c7465725f496e666f223a363a7b733a343a2244697273223b4f3a33343a224455505f417263686976655f46696c7465725f53636f70655f4469726563746f7279223a343a7b733a373a225761726e696e67223b613a303a7b7d733a31303a22556e7265616461626c65223b613a303a7b7d733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a353a2246696c6573223b4f3a32393a224455505f417263686976655f46696c7465725f53636f70655f46696c65223a353a7b733a343a2253697a65223b613a303a7b7d733a373a225761726e696e67223b613a303a7b7d733a31303a22556e7265616461626c65223b613a303a7b7d733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a343a2245787473223b4f3a32393a224455505f417263686976655f46696c7465725f53636f70655f42617365223a323a7b733a343a22436f7265223b613a303a7b7d733a383a22496e7374616e6365223b613a303a7b7d7d733a393a2255446972436f756e74223b693a303b733a31303a225546696c65436f756e74223b693a303b733a393a2255457874436f756e74223b693a303b7d733a31303a22002a005061636b616765223b723a313b7d733a393a22496e7374616c6c6572223b4f3a31333a224455505f496e7374616c6c6572223a31323a7b733a343a2246696c65223b733a35373a2232303137303330365f626964615f35386263646531623037656235333032333137303330363033353731355f696e7374616c6c65722e706870223b733a343a2253697a65223b693a3430343134353b733a31303a224f7074734442486f7374223b733a303a22223b733a31303a224f7074734442506f7274223b733a303a22223b733a31303a224f70747344424e616d65223b733a303a22223b733a31303a224f707473444255736572223b733a303a22223b733a31323a224f70747353534c41646d696e223b693a303b733a31323a224f70747353534c4c6f67696e223b693a303b733a31313a224f70747343616368655750223b693a303b733a31333a224f707473436163686550617468223b693a303b733a31303a224f70747355524c4e6577223b733a303a22223b733a31303a22002a005061636b616765223b723a313b7d733a383a224461746162617365223b4f3a31323a224455505f4461746162617365223a31333a7b733a343a2254797065223b733a353a224d7953514c223b733a343a2253697a65223b693a3733303935353b733a343a2246696c65223b733a35363a2232303137303330365f626964615f35386263646531623037656235333032333137303330363033353731355f64617461626173652e73716c223b733a343a2250617468223b4e3b733a31323a2246696c7465725461626c6573223b733a303a22223b733a383a2246696c7465724f6e223b693a303b733a343a224e616d65223b4e3b733a31303a22436f6d70617469626c65223b733a303a22223b733a383a22436f6d6d656e7473223b733a33313a226d6172696164622e6f72672062696e61727920646973747269627574696f6e223b733a31303a22002a005061636b616765223b723a313b733a32353a22004455505f446174616261736500646253746f726550617468223b733a39393a22433a2f78616d70702f6874646f63732f776f726470726573732f77702d736e617073686f74732f746d702f32303137303330365f626964615f35386263646531623037656235333032333137303330363033353731355f64617461626173652e73716c223b733a32333a22004455505f446174616261736500454f464d61726b6572223b733a303a22223b733a32363a22004455505f4461746162617365006e6574776f726b466c757368223b623a303b7d7d);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_links`
--

CREATE TABLE `wp_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_options`
--

CREATE TABLE `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://localhost/wordpress', 'yes'),
(2, 'home', 'http://localhost/wordpress', 'yes'),
(3, 'blogname', 'BIDA', 'yes'),
(4, 'blogdescription', 'Big Data Antara', 'yes'),
(5, 'users_can_register', '0', 'yes'),
(6, 'admin_email', 'jnrubiano@gmail.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '0', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '1', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'j F, Y', 'yes'),
(24, 'time_format', 'g:i a', 'yes'),
(25, 'links_updated_date_format', 'j F, Y g:i a', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:194:{s:24:"^wc-auth/v([1]{1})/(.*)?";s:63:"index.php?wc-auth-version=$matches[1]&wc-auth-route=$matches[2]";s:22:"^wc-api/v([1-3]{1})/?$";s:51:"index.php?wc-api-version=$matches[1]&wc-api-route=/";s:24:"^wc-api/v([1-3]{1})(.*)?";s:61:"index.php?wc-api-version=$matches[1]&wc-api-route=$matches[2]";s:9:"tienda/?$";s:27:"index.php?post_type=product";s:39:"tienda/feed/(feed|rdf|rss|rss2|atom)/?$";s:44:"index.php?post_type=product&feed=$matches[1]";s:34:"tienda/(feed|rdf|rss|rss2|atom)/?$";s:44:"index.php?post_type=product&feed=$matches[1]";s:26:"tienda/page/([0-9]{1,})/?$";s:45:"index.php?post_type=product&paged=$matches[1]";s:11:"^wp-json/?$";s:22:"index.php?rest_route=/";s:14:"^wp-json/(.*)?";s:33:"index.php?rest_route=/$matches[1]";s:47:"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:42:"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:23:"category/(.+?)/embed/?$";s:46:"index.php?category_name=$matches[1]&embed=true";s:35:"category/(.+?)/page/?([0-9]{1,})/?$";s:53:"index.php?category_name=$matches[1]&paged=$matches[2]";s:32:"category/(.+?)/wc-api(/(.*))?/?$";s:54:"index.php?category_name=$matches[1]&wc-api=$matches[3]";s:17:"category/(.+?)/?$";s:35:"index.php?category_name=$matches[1]";s:44:"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:39:"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:20:"tag/([^/]+)/embed/?$";s:36:"index.php?tag=$matches[1]&embed=true";s:32:"tag/([^/]+)/page/?([0-9]{1,})/?$";s:43:"index.php?tag=$matches[1]&paged=$matches[2]";s:29:"tag/([^/]+)/wc-api(/(.*))?/?$";s:44:"index.php?tag=$matches[1]&wc-api=$matches[3]";s:14:"tag/([^/]+)/?$";s:25:"index.php?tag=$matches[1]";s:45:"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:40:"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:21:"type/([^/]+)/embed/?$";s:44:"index.php?post_format=$matches[1]&embed=true";s:33:"type/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?post_format=$matches[1]&paged=$matches[2]";s:15:"type/([^/]+)/?$";s:33:"index.php?post_format=$matches[1]";s:57:"categoria-producto/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?product_cat=$matches[1]&feed=$matches[2]";s:52:"categoria-producto/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?product_cat=$matches[1]&feed=$matches[2]";s:33:"categoria-producto/(.+?)/embed/?$";s:44:"index.php?product_cat=$matches[1]&embed=true";s:45:"categoria-producto/(.+?)/page/?([0-9]{1,})/?$";s:51:"index.php?product_cat=$matches[1]&paged=$matches[2]";s:27:"categoria-producto/(.+?)/?$";s:33:"index.php?product_cat=$matches[1]";s:58:"etiqueta-producto/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?product_tag=$matches[1]&feed=$matches[2]";s:53:"etiqueta-producto/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?product_tag=$matches[1]&feed=$matches[2]";s:34:"etiqueta-producto/([^/]+)/embed/?$";s:44:"index.php?product_tag=$matches[1]&embed=true";s:46:"etiqueta-producto/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?product_tag=$matches[1]&paged=$matches[2]";s:28:"etiqueta-producto/([^/]+)/?$";s:33:"index.php?product_tag=$matches[1]";s:36:"producto/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:46:"producto/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:66:"producto/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:61:"producto/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:61:"producto/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:42:"producto/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:25:"producto/([^/]+)/embed/?$";s:40:"index.php?product=$matches[1]&embed=true";s:29:"producto/([^/]+)/trackback/?$";s:34:"index.php?product=$matches[1]&tb=1";s:49:"producto/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:46:"index.php?product=$matches[1]&feed=$matches[2]";s:44:"producto/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:46:"index.php?product=$matches[1]&feed=$matches[2]";s:37:"producto/([^/]+)/page/?([0-9]{1,})/?$";s:47:"index.php?product=$matches[1]&paged=$matches[2]";s:44:"producto/([^/]+)/comment-page-([0-9]{1,})/?$";s:47:"index.php?product=$matches[1]&cpage=$matches[2]";s:34:"producto/([^/]+)/wc-api(/(.*))?/?$";s:48:"index.php?product=$matches[1]&wc-api=$matches[3]";s:40:"producto/[^/]+/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:51:"producto/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:33:"producto/([^/]+)(?:/([0-9]+))?/?$";s:46:"index.php?product=$matches[1]&page=$matches[2]";s:25:"producto/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:35:"producto/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:55:"producto/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:50:"producto/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:50:"producto/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:31:"producto/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:45:"product_variation/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:55:"product_variation/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:75:"product_variation/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:70:"product_variation/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:70:"product_variation/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:51:"product_variation/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:34:"product_variation/([^/]+)/embed/?$";s:50:"index.php?product_variation=$matches[1]&embed=true";s:38:"product_variation/([^/]+)/trackback/?$";s:44:"index.php?product_variation=$matches[1]&tb=1";s:46:"product_variation/([^/]+)/page/?([0-9]{1,})/?$";s:57:"index.php?product_variation=$matches[1]&paged=$matches[2]";s:53:"product_variation/([^/]+)/comment-page-([0-9]{1,})/?$";s:57:"index.php?product_variation=$matches[1]&cpage=$matches[2]";s:43:"product_variation/([^/]+)/wc-api(/(.*))?/?$";s:58:"index.php?product_variation=$matches[1]&wc-api=$matches[3]";s:49:"product_variation/[^/]+/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:60:"product_variation/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:42:"product_variation/([^/]+)(?:/([0-9]+))?/?$";s:56:"index.php?product_variation=$matches[1]&page=$matches[2]";s:34:"product_variation/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:44:"product_variation/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:64:"product_variation/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"product_variation/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"product_variation/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:40:"product_variation/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:45:"shop_order_refund/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:55:"shop_order_refund/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:75:"shop_order_refund/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:70:"shop_order_refund/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:70:"shop_order_refund/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:51:"shop_order_refund/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:34:"shop_order_refund/([^/]+)/embed/?$";s:50:"index.php?shop_order_refund=$matches[1]&embed=true";s:38:"shop_order_refund/([^/]+)/trackback/?$";s:44:"index.php?shop_order_refund=$matches[1]&tb=1";s:46:"shop_order_refund/([^/]+)/page/?([0-9]{1,})/?$";s:57:"index.php?shop_order_refund=$matches[1]&paged=$matches[2]";s:53:"shop_order_refund/([^/]+)/comment-page-([0-9]{1,})/?$";s:57:"index.php?shop_order_refund=$matches[1]&cpage=$matches[2]";s:43:"shop_order_refund/([^/]+)/wc-api(/(.*))?/?$";s:58:"index.php?shop_order_refund=$matches[1]&wc-api=$matches[3]";s:49:"shop_order_refund/[^/]+/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:60:"shop_order_refund/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:42:"shop_order_refund/([^/]+)(?:/([0-9]+))?/?$";s:56:"index.php?shop_order_refund=$matches[1]&page=$matches[2]";s:34:"shop_order_refund/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:44:"shop_order_refund/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:64:"shop_order_refund/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"shop_order_refund/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"shop_order_refund/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:40:"shop_order_refund/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:48:".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$";s:18:"index.php?feed=old";s:20:".*wp-app\\.php(/.*)?$";s:19:"index.php?error=403";s:18:".*wp-register.php$";s:23:"index.php?register=true";s:32:"feed/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:27:"(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:8:"embed/?$";s:21:"index.php?&embed=true";s:20:"page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:17:"wc-api(/(.*))?/?$";s:29:"index.php?&wc-api=$matches[2]";s:41:"comments/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:36:"comments/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:17:"comments/embed/?$";s:21:"index.php?&embed=true";s:26:"comments/wc-api(/(.*))?/?$";s:29:"index.php?&wc-api=$matches[2]";s:44:"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:39:"search/(.+)/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:20:"search/(.+)/embed/?$";s:34:"index.php?s=$matches[1]&embed=true";s:32:"search/(.+)/page/?([0-9]{1,})/?$";s:41:"index.php?s=$matches[1]&paged=$matches[2]";s:29:"search/(.+)/wc-api(/(.*))?/?$";s:42:"index.php?s=$matches[1]&wc-api=$matches[3]";s:14:"search/(.+)/?$";s:23:"index.php?s=$matches[1]";s:47:"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:42:"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:23:"author/([^/]+)/embed/?$";s:44:"index.php?author_name=$matches[1]&embed=true";s:35:"author/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?author_name=$matches[1]&paged=$matches[2]";s:32:"author/([^/]+)/wc-api(/(.*))?/?$";s:52:"index.php?author_name=$matches[1]&wc-api=$matches[3]";s:17:"author/([^/]+)/?$";s:33:"index.php?author_name=$matches[1]";s:69:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:45:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$";s:74:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]";s:54:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/wc-api(/(.*))?/?$";s:82:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&wc-api=$matches[5]";s:39:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$";s:63:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]";s:56:"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:51:"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:32:"([0-9]{4})/([0-9]{1,2})/embed/?$";s:58:"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true";s:44:"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]";s:41:"([0-9]{4})/([0-9]{1,2})/wc-api(/(.*))?/?$";s:66:"index.php?year=$matches[1]&monthnum=$matches[2]&wc-api=$matches[4]";s:26:"([0-9]{4})/([0-9]{1,2})/?$";s:47:"index.php?year=$matches[1]&monthnum=$matches[2]";s:43:"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:38:"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:19:"([0-9]{4})/embed/?$";s:37:"index.php?year=$matches[1]&embed=true";s:31:"([0-9]{4})/page/?([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&paged=$matches[2]";s:28:"([0-9]{4})/wc-api(/(.*))?/?$";s:45:"index.php?year=$matches[1]&wc-api=$matches[3]";s:13:"([0-9]{4})/?$";s:26:"index.php?year=$matches[1]";s:58:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:68:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:88:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:83:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:83:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:64:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:53:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$";s:91:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$";s:85:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1";s:77:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:72:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:65:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]";s:72:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]";s:62:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/wc-api(/(.*))?/?$";s:99:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&wc-api=$matches[6]";s:62:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:73:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:61:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]";s:47:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:57:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:77:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:72:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:72:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:53:"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]";s:51:"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]";s:38:"([0-9]{4})/comment-page-([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&cpage=$matches[2]";s:27:".?.+?/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:".?.+?/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:33:".?.+?/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:16:"(.?.+?)/embed/?$";s:41:"index.php?pagename=$matches[1]&embed=true";s:20:"(.?.+?)/trackback/?$";s:35:"index.php?pagename=$matches[1]&tb=1";s:40:"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:35:"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:28:"(.?.+?)/page/?([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&paged=$matches[2]";s:35:"(.?.+?)/comment-page-([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&cpage=$matches[2]";s:25:"(.?.+?)/wc-api(/(.*))?/?$";s:49:"index.php?pagename=$matches[1]&wc-api=$matches[3]";s:28:"(.?.+?)/order-pay(/(.*))?/?$";s:52:"index.php?pagename=$matches[1]&order-pay=$matches[3]";s:33:"(.?.+?)/order-received(/(.*))?/?$";s:57:"index.php?pagename=$matches[1]&order-received=$matches[3]";s:25:"(.?.+?)/orders(/(.*))?/?$";s:49:"index.php?pagename=$matches[1]&orders=$matches[3]";s:29:"(.?.+?)/view-order(/(.*))?/?$";s:53:"index.php?pagename=$matches[1]&view-order=$matches[3]";s:28:"(.?.+?)/downloads(/(.*))?/?$";s:52:"index.php?pagename=$matches[1]&downloads=$matches[3]";s:31:"(.?.+?)/edit-account(/(.*))?/?$";s:55:"index.php?pagename=$matches[1]&edit-account=$matches[3]";s:31:"(.?.+?)/edit-address(/(.*))?/?$";s:55:"index.php?pagename=$matches[1]&edit-address=$matches[3]";s:34:"(.?.+?)/payment-methods(/(.*))?/?$";s:58:"index.php?pagename=$matches[1]&payment-methods=$matches[3]";s:32:"(.?.+?)/lost-password(/(.*))?/?$";s:56:"index.php?pagename=$matches[1]&lost-password=$matches[3]";s:34:"(.?.+?)/customer-logout(/(.*))?/?$";s:58:"index.php?pagename=$matches[1]&customer-logout=$matches[3]";s:37:"(.?.+?)/add-payment-method(/(.*))?/?$";s:61:"index.php?pagename=$matches[1]&add-payment-method=$matches[3]";s:40:"(.?.+?)/delete-payment-method(/(.*))?/?$";s:64:"index.php?pagename=$matches[1]&delete-payment-method=$matches[3]";s:45:"(.?.+?)/set-default-payment-method(/(.*))?/?$";s:69:"index.php?pagename=$matches[1]&set-default-payment-method=$matches[3]";s:31:".?.+?/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:42:".?.+?/attachment/([^/]+)/wc-api(/(.*))?/?$";s:51:"index.php?attachment=$matches[1]&wc-api=$matches[3]";s:24:"(.?.+?)(?:/([0-9]+))?/?$";s:47:"index.php?pagename=$matches[1]&page=$matches[2]";}', 'yes'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:3:{i:0;s:25:"duplicator/duplicator.php";i:1;s:91:"woocommerce-gateway-paypal-express-checkout/woocommerce-gateway-paypal-express-checkout.php";i:2;s:27:"woocommerce/woocommerce.php";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', '', 'no'),
(40, 'template', 'responsive', 'yes'),
(41, 'stylesheet', 'responsive', 'yes'),
(42, 'comment_whitelist', '1', 'yes'),
(43, 'blacklist_keys', '', 'no'),
(44, 'comment_registration', '0', 'yes'),
(45, 'html_type', 'text/html', 'yes'),
(46, 'use_trackback', '0', 'yes'),
(47, 'default_role', 'subscriber', 'yes'),
(48, 'db_version', '37965', 'yes'),
(49, 'uploads_use_yearmonth_folders', '1', 'yes'),
(50, 'upload_path', '', 'yes'),
(51, 'blog_public', '1', 'yes'),
(52, 'default_link_category', '2', 'yes'),
(53, 'show_on_front', 'posts', 'yes'),
(54, 'tag_base', '', 'yes'),
(55, 'show_avatars', '1', 'yes'),
(56, 'avatar_rating', 'G', 'yes'),
(57, 'upload_url_path', '', 'yes'),
(58, 'thumbnail_size_w', '150', 'yes'),
(59, 'thumbnail_size_h', '150', 'yes'),
(60, 'thumbnail_crop', '1', 'yes'),
(61, 'medium_size_w', '300', 'yes'),
(62, 'medium_size_h', '300', 'yes'),
(63, 'avatar_default', 'mystery', 'yes'),
(64, 'large_size_w', '1024', 'yes'),
(65, 'large_size_h', '1024', 'yes'),
(66, 'image_default_link_type', 'none', 'yes'),
(67, 'image_default_size', '', 'yes'),
(68, 'image_default_align', '', 'yes'),
(69, 'close_comments_for_old_posts', '0', 'yes'),
(70, 'close_comments_days_old', '14', 'yes'),
(71, 'thread_comments', '1', 'yes'),
(72, 'thread_comments_depth', '5', 'yes'),
(73, 'page_comments', '0', 'yes'),
(74, 'comments_per_page', '50', 'yes'),
(75, 'default_comments_page', 'newest', 'yes'),
(76, 'comment_order', 'asc', 'yes'),
(77, 'sticky_posts', 'a:0:{}', 'yes'),
(78, 'widget_categories', 'a:2:{i:2;a:4:{s:5:"title";s:0:"";s:5:"count";i:0;s:12:"hierarchical";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(79, 'widget_text', 'a:2:{i:1;a:0:{}s:12:"_multiwidget";i:1;}', 'yes'),
(80, 'widget_rss', 'a:2:{i:1;a:0:{}s:12:"_multiwidget";i:1;}', 'yes'),
(81, 'uninstall_plugins', 'a:0:{}', 'no'),
(82, 'timezone_string', 'America/Bogota', 'yes'),
(83, 'page_for_posts', '0', 'yes'),
(84, 'page_on_front', '0', 'yes'),
(85, 'default_post_format', '0', 'yes'),
(86, 'link_manager_enabled', '0', 'yes'),
(87, 'finished_splitting_shared_terms', '1', 'yes'),
(89, 'medium_large_size_w', '768', 'yes'),
(90, 'medium_large_size_h', '0', 'yes'),
(91, 'initial_db_version', '37965', 'yes'),
(92, 'wp_user_roles', 'a:7:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:131:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;s:18:"manage_woocommerce";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;s:17:"edit_shop_webhook";b:1;s:17:"read_shop_webhook";b:1;s:19:"delete_shop_webhook";b:1;s:18:"edit_shop_webhooks";b:1;s:25:"edit_others_shop_webhooks";b:1;s:21:"publish_shop_webhooks";b:1;s:26:"read_private_shop_webhooks";b:1;s:20:"delete_shop_webhooks";b:1;s:28:"delete_private_shop_webhooks";b:1;s:30:"delete_published_shop_webhooks";b:1;s:27:"delete_others_shop_webhooks";b:1;s:26:"edit_private_shop_webhooks";b:1;s:28:"edit_published_shop_webhooks";b:1;s:25:"manage_shop_webhook_terms";b:1;s:23:"edit_shop_webhook_terms";b:1;s:25:"delete_shop_webhook_terms";b:1;s:25:"assign_shop_webhook_terms";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:34:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:10:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:5:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:2:{s:4:"read";b:1;s:7:"level_0";b:1;}}s:8:"customer";a:2:{s:4:"name";s:7:"Cliente";s:12:"capabilities";a:1:{s:4:"read";b:1;}}s:12:"shop_manager";a:2:{s:4:"name";s:19:"Gestor de la tienda";s:12:"capabilities";a:110:{s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:4:"read";b:1;s:18:"read_private_pages";b:1;s:18:"read_private_posts";b:1;s:10:"edit_users";b:1;s:10:"edit_posts";b:1;s:10:"edit_pages";b:1;s:20:"edit_published_posts";b:1;s:20:"edit_published_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"edit_private_posts";b:1;s:17:"edit_others_posts";b:1;s:17:"edit_others_pages";b:1;s:13:"publish_posts";b:1;s:13:"publish_pages";b:1;s:12:"delete_posts";b:1;s:12:"delete_pages";b:1;s:20:"delete_private_pages";b:1;s:20:"delete_private_posts";b:1;s:22:"delete_published_pages";b:1;s:22:"delete_published_posts";b:1;s:19:"delete_others_posts";b:1;s:19:"delete_others_pages";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:17:"moderate_comments";b:1;s:15:"unfiltered_html";b:1;s:12:"upload_files";b:1;s:6:"export";b:1;s:6:"import";b:1;s:10:"list_users";b:1;s:18:"manage_woocommerce";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;s:17:"edit_shop_webhook";b:1;s:17:"read_shop_webhook";b:1;s:19:"delete_shop_webhook";b:1;s:18:"edit_shop_webhooks";b:1;s:25:"edit_others_shop_webhooks";b:1;s:21:"publish_shop_webhooks";b:1;s:26:"read_private_shop_webhooks";b:1;s:20:"delete_shop_webhooks";b:1;s:28:"delete_private_shop_webhooks";b:1;s:30:"delete_published_shop_webhooks";b:1;s:27:"delete_others_shop_webhooks";b:1;s:26:"edit_private_shop_webhooks";b:1;s:28:"edit_published_shop_webhooks";b:1;s:25:"manage_shop_webhook_terms";b:1;s:23:"edit_shop_webhook_terms";b:1;s:25:"delete_shop_webhook_terms";b:1;s:25:"assign_shop_webhook_terms";b:1;}}}', 'yes'),
(93, 'WPLANG', 'es_ES', 'yes'),
(94, 'widget_search', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(95, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(96, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(97, 'widget_archives', 'a:2:{i:2;a:3:{s:5:"title";s:0:"";s:5:"count";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(98, 'widget_meta', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(99, 'sidebars_widgets', 'a:14:{s:19:"wp_inactive_widgets";a:0:{}s:12:"main-sidebar";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:13:"right-sidebar";N;s:12:"left-sidebar";N;s:17:"left-sidebar-half";N;s:18:"right-sidebar-half";N;s:13:"home-widget-1";N;s:13:"home-widget-2";N;s:13:"home-widget-3";N;s:14:"gallery-widget";N;s:15:"colophon-widget";N;s:10:"top-widget";N;s:13:"footer-widget";N;s:13:"array_version";i:3;}', 'yes'),
(100, 'widget_pages', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(101, 'widget_calendar', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(102, 'widget_tag_cloud', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(103, 'widget_nav_menu', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(104, 'cron', 'a:9:{i:1490053758;a:1:{s:32:"woocommerce_cancel_unpaid_orders";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:2:{s:8:"schedule";b:0;s:4:"args";a:0:{}}}}i:1490054400;a:1:{s:27:"woocommerce_scheduled_sales";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1490062425;a:3:{s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1490062677;a:1:{s:28:"woocommerce_cleanup_sessions";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1490105655;a:1:{s:19:"wp_scheduled_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1490105877;a:1:{s:30:"woocommerce_tracker_send_event";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1490106002;a:1:{s:30:"wp_scheduled_auto_draft_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1491523200;a:1:{s:25:"woocommerce_geoip_updater";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:7:"monthly";s:4:"args";a:0:{}s:8:"interval";i:2635200;}}}s:7:"version";i:2;}', 'yes'),
(114, '_site_transient_timeout_browser_68948a6d14dc2998ac6d5fc6a7204e73', '1479219255', 'no'),
(115, '_site_transient_browser_68948a6d14dc2998ac6d5fc6a7204e73', 'a:9:{s:8:"platform";s:7:"Windows";s:4:"name";s:6:"Chrome";s:7:"version";s:12:"54.0.2840.71";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'no'),
(117, 'can_compress_scripts', '1', 'no'),
(136, 'recently_activated', 'a:0:{}', 'yes'),
(144, 'woocommerce_default_country', 'CO', 'yes'),
(145, 'woocommerce_allowed_countries', 'all', 'yes'),
(146, 'woocommerce_all_except_countries', '', 'yes'),
(147, 'woocommerce_specific_allowed_countries', '', 'yes'),
(148, 'woocommerce_ship_to_countries', '', 'yes'),
(149, 'woocommerce_specific_ship_to_countries', '', 'yes'),
(150, 'woocommerce_default_customer_address', 'geolocation', 'yes'),
(151, 'woocommerce_calc_taxes', 'yes', 'yes'),
(152, 'woocommerce_demo_store', 'no', 'yes'),
(153, 'woocommerce_demo_store_notice', 'Esta es una tienda de demostración para propósitos de prueba &mdash; no se deberá cumplir ningún pedido.', 'no'),
(154, 'woocommerce_currency', 'COP', 'yes'),
(155, 'woocommerce_currency_pos', 'right', 'yes'),
(156, 'woocommerce_price_thousand_sep', '.', 'yes'),
(157, 'woocommerce_price_decimal_sep', ',', 'yes'),
(158, 'woocommerce_price_num_decimals', '2', 'yes'),
(159, 'woocommerce_weight_unit', 'kg', 'yes'),
(160, 'woocommerce_dimension_unit', 'cm', 'yes'),
(161, 'woocommerce_enable_review_rating', 'yes', 'yes'),
(162, 'woocommerce_review_rating_required', 'yes', 'no'),
(163, 'woocommerce_review_rating_verification_label', 'yes', 'no'),
(164, 'woocommerce_review_rating_verification_required', 'no', 'no'),
(165, 'woocommerce_shop_page_id', '4', 'yes'),
(166, 'woocommerce_shop_page_display', '', 'yes'),
(167, 'woocommerce_category_archive_display', '', 'yes'),
(168, 'woocommerce_default_catalog_orderby', 'menu_order', 'yes'),
(169, 'woocommerce_cart_redirect_after_add', 'no', 'yes'),
(170, 'woocommerce_enable_ajax_add_to_cart', 'yes', 'yes'),
(171, 'shop_catalog_image_size', 'a:3:{s:5:"width";s:3:"300";s:6:"height";s:3:"300";s:4:"crop";i:1;}', 'yes'),
(172, 'shop_single_image_size', 'a:3:{s:5:"width";s:3:"600";s:6:"height";s:3:"600";s:4:"crop";i:1;}', 'yes'),
(173, 'shop_thumbnail_image_size', 'a:3:{s:5:"width";s:3:"180";s:6:"height";s:3:"180";s:4:"crop";i:1;}', 'yes'),
(174, 'woocommerce_enable_lightbox', 'yes', 'yes'),
(175, 'woocommerce_manage_stock', 'yes', 'yes'),
(176, 'woocommerce_hold_stock_minutes', '60', 'no'),
(177, 'woocommerce_notify_low_stock', 'yes', 'no'),
(178, 'woocommerce_notify_no_stock', 'yes', 'no'),
(179, 'woocommerce_stock_email_recipient', 'jnrubiano@gmail.com', 'no'),
(180, 'woocommerce_notify_low_stock_amount', '2', 'no'),
(181, 'woocommerce_notify_no_stock_amount', '0', 'yes'),
(182, 'woocommerce_hide_out_of_stock_items', 'no', 'yes'),
(183, 'woocommerce_stock_format', '', 'yes'),
(184, 'woocommerce_file_download_method', 'force', 'no'),
(185, 'woocommerce_downloads_require_login', 'no', 'no'),
(186, 'woocommerce_downloads_grant_access_after_payment', 'yes', 'no'),
(187, 'woocommerce_prices_include_tax', 'yes', 'yes'),
(188, 'woocommerce_tax_based_on', 'shipping', 'yes'),
(189, 'woocommerce_shipping_tax_class', '', 'yes'),
(190, 'woocommerce_tax_round_at_subtotal', 'no', 'yes'),
(191, 'woocommerce_tax_classes', 'Tasa reducida\r\nZERO Rate', 'yes'),
(192, 'woocommerce_tax_display_shop', 'excl', 'yes'),
(193, 'woocommerce_tax_display_cart', 'excl', 'no'),
(194, 'woocommerce_price_display_suffix', '', 'yes'),
(195, 'woocommerce_tax_total_display', 'itemized', 'no'),
(196, 'woocommerce_enable_shipping_calc', 'yes', 'no'),
(197, 'woocommerce_shipping_cost_requires_address', 'no', 'no'),
(198, 'woocommerce_ship_to_destination', 'billing', 'no'),
(199, 'woocommerce_enable_coupons', 'yes', 'yes'),
(200, 'woocommerce_calc_discounts_sequentially', 'no', 'no'),
(201, 'woocommerce_enable_guest_checkout', 'yes', 'no'),
(202, 'woocommerce_force_ssl_checkout', 'no', 'yes'),
(203, 'woocommerce_unforce_ssl_checkout', 'no', 'yes'),
(204, 'woocommerce_cart_page_id', '5', 'yes'),
(205, 'woocommerce_checkout_page_id', '6', 'yes'),
(206, 'woocommerce_terms_page_id', '', 'no'),
(207, 'woocommerce_checkout_pay_endpoint', 'order-pay', 'yes'),
(208, 'woocommerce_checkout_order_received_endpoint', 'order-received', 'yes'),
(209, 'woocommerce_myaccount_add_payment_method_endpoint', 'add-payment-method', 'yes'),
(210, 'woocommerce_myaccount_delete_payment_method_endpoint', 'delete-payment-method', 'yes'),
(211, 'woocommerce_myaccount_set_default_payment_method_endpoint', 'set-default-payment-method', 'yes'),
(212, 'woocommerce_myaccount_page_id', '7', 'yes'),
(213, 'woocommerce_enable_signup_and_login_from_checkout', 'yes', 'no'),
(214, 'woocommerce_enable_myaccount_registration', 'no', 'no'),
(215, 'woocommerce_enable_checkout_login_reminder', 'yes', 'no'),
(216, 'woocommerce_registration_generate_username', 'yes', 'no'),
(217, 'woocommerce_registration_generate_password', 'no', 'no'),
(218, 'woocommerce_myaccount_orders_endpoint', 'orders', 'yes'),
(219, 'woocommerce_myaccount_view_order_endpoint', 'view-order', 'yes'),
(220, 'woocommerce_myaccount_downloads_endpoint', 'downloads', 'yes'),
(221, 'woocommerce_myaccount_edit_account_endpoint', 'edit-account', 'yes'),
(222, 'woocommerce_myaccount_edit_address_endpoint', 'edit-address', 'yes'),
(223, 'woocommerce_myaccount_payment_methods_endpoint', 'payment-methods', 'yes'),
(224, 'woocommerce_myaccount_lost_password_endpoint', 'lost-password', 'yes'),
(225, 'woocommerce_logout_endpoint', 'customer-logout', 'yes'),
(226, 'woocommerce_email_from_name', 'alta-vista.com', 'no'),
(227, 'woocommerce_email_from_address', 'jnrubiano@gmail.com', 'no'),
(228, 'woocommerce_email_header_image', '', 'no'),
(229, 'woocommerce_email_footer_text', 'alta-vista.com - Desarrollado por WooCommerce', 'no'),
(230, 'woocommerce_email_base_color', '#557da1', 'no'),
(231, 'woocommerce_email_background_color', '#f5f5f5', 'no'),
(232, 'woocommerce_email_body_background_color', '#fdfdfd', 'no'),
(233, 'woocommerce_email_text_color', '#505050', 'no'),
(234, 'woocommerce_api_enabled', 'yes', 'yes'),
(238, 'woocommerce_db_version', '2.6.7', 'yes'),
(239, 'woocommerce_version', '2.6.7', 'yes'),
(240, 'woocommerce_admin_notices', 'a:0:{}', 'yes'),
(242, '_transient_woocommerce_webhook_ids', 'a:0:{}', 'yes'),
(243, 'widget_woocommerce_widget_cart', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(244, 'widget_woocommerce_layered_nav_filters', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(245, 'widget_woocommerce_layered_nav', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(246, 'widget_woocommerce_price_filter', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(247, 'widget_woocommerce_product_categories', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(248, 'widget_woocommerce_product_search', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(249, 'widget_woocommerce_product_tag_cloud', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(250, 'widget_woocommerce_products', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(251, 'widget_woocommerce_rating_filter', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(252, 'widget_woocommerce_recent_reviews', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(253, 'widget_woocommerce_recently_viewed_products', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(254, 'widget_woocommerce_top_rated_products', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(255, '_transient_wc_attribute_taxonomies', 'a:0:{}', 'yes'),
(257, '_transient_wc_count_comments', 'O:8:"stdClass":7:{s:8:"approved";s:1:"1";s:14:"total_comments";i:1;s:3:"all";i:1;s:9:"moderated";i:0;s:4:"spam";i:0;s:5:"trash";i:0;s:12:"post-trashed";i:0;}', 'yes'),
(258, 'woocommerce_meta_box_errors', 'a:0:{}', 'yes'),
(259, '_transient_woocommerce_cache_excluded_uris', 'a:6:{i:0;s:3:"p=5";i:1;s:9:"/carrito/";i:2;s:3:"p=6";i:3;s:19:"/finalizar-comprar/";i:4;s:3:"p=7";i:5;s:11:"/mi-cuenta/";}', 'yes'),
(260, '_transient_timeout_geoip_::1', '1479219498', 'no'),
(261, '_transient_geoip_::1', '', 'no'),
(264, '_transient_timeout_geoip_200.21.240.135', '1479219499', 'no'),
(265, '_transient_geoip_200.21.240.135', 'CO', 'no'),
(266, 'woocommerce_paypal-ec_settings', 'a:1:{s:7:"enabled";s:3:"yes";}', 'yes'),
(267, 'woocommerce_stripe_settings', 'a:1:{s:7:"enabled";s:2:"no";}', 'yes'),
(268, 'woocommerce_paypal_settings', 'a:2:{s:7:"enabled";s:3:"yes";s:5:"email";s:19:"jnrubiano@gmail.com";}', 'yes'),
(269, 'woocommerce_cheque_settings', 'a:1:{s:7:"enabled";s:2:"no";}', 'yes'),
(270, 'woocommerce_bacs_settings', 'a:1:{s:7:"enabled";s:2:"no";}', 'yes'),
(271, 'woocommerce_cod_settings', 'a:1:{s:7:"enabled";s:2:"no";}', 'yes'),
(273, 'woocommerce_allow_tracking', 'no', 'yes'),
(274, 'wc_ppec_version', '1.1.2', 'yes'),
(276, '_transient_shipping-transient-version', '1478614802', 'yes'),
(277, '_transient_timeout_wc_shipping_method_count_0_1478614802', '1481206802', 'no'),
(278, '_transient_wc_shipping_method_count_0_1478614802', '0', 'no'),
(280, '_transient_product_query-transient-version', '1478615071', 'yes'),
(281, '_transient_product-transient-version', '1478615071', 'yes'),
(283, '_transient_twentysixteen_categories', '1', 'yes'),
(291, 'theme_mods_twentysixteen', 'a:1:{s:16:"sidebars_widgets";a:2:{s:4:"time";i:1478615310;s:4:"data";a:2:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}}}}', 'yes'),
(292, 'current_theme', 'Responsive', 'yes'),
(293, 'theme_mods_responsive', 'a:3:{i:0;b:0;s:16:"background_color";s:6:"ffffff";s:12:"header_image";s:13:"remove-header";}', 'yes'),
(294, 'theme_switched', '', 'yes'),
(295, 'responsive_theme_options', 'a:36:{s:10:"breadcrumb";i:0;s:10:"cta_button";i:1;s:12:"minified_css";b:0;s:10:"front_page";i:1;s:13:"home_headline";s:15:"Big Data Antara";s:16:"home_subheadline";N;s:17:"home_content_area";s:154:"Conoce más sobre el proyecto que cambiará la forma en manejar la información en una de las entidades financieras más importantes a nivel global, BIDA.";s:8:"cta_text";s:15:"¿Qué es BIDA?";s:7:"cta_url";s:42:"https://bida1.000webhostapp.com/?page_id=6";s:16:"featured_content";N;s:24:"google_site_verification";s:0:"";s:22:"bing_site_verification";s:0:"";s:23:"yahoo_site_verification";s:0:"";s:23:"site_statistics_tracker";s:0:"";s:11:"twitter_uid";s:0:"";s:12:"facebook_uid";s:0:"";s:12:"linkedin_uid";s:0:"";s:11:"youtube_uid";s:0:"";s:11:"stumble_uid";s:0:"";s:7:"rss_uid";s:0:"";s:15:"google_plus_uid";s:0:"";s:13:"instagram_uid";s:0:"";s:13:"pinterest_uid";s:0:"";s:8:"yelp_uid";s:0:"";s:9:"vimeo_uid";s:0:"";s:14:"foursquare_uid";s:0:"";s:21:"responsive_inline_css";s:0:"";s:25:"responsive_inline_js_head";s:0:"";s:27:"responsive_inline_js_footer";s:0:"";s:31:"responsive_inline_css_js_footer";s:0:"";s:26:"static_page_layout_default";s:7:"default";s:26:"single_post_layout_default";s:7:"default";s:31:"blog_posts_index_layout_default";s:7:"default";s:14:"googleplus_uid";s:0:"";s:15:"stumbleupon_uid";s:0:"";s:17:"copyright_textbox";s:36:"Todos los derechos reservados, BIDA.";}', 'yes'),
(298, 'widget_widget_twentyfourteen_ephemera', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(300, '_transient_twentyfourteen_category_count', '1', 'yes'),
(301, '_transient_timeout_wc_shipping_method_count_1_1478614802', '1481207429', 'no'),
(302, '_transient_wc_shipping_method_count_1_1478614802', '0', 'no'),
(327, '_transient_timeout_wc_low_stock_count', '1491358590', 'no'),
(328, '_transient_wc_low_stock_count', '0', 'no'),
(329, '_transient_timeout_wc_outofstock_count', '1491358590', 'no'),
(330, '_transient_wc_outofstock_count', '0', 'no'),
(348, '_site_transient_timeout_available_translations', '1488777554', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(349, '_site_transient_available_translations', 'a:88:{s:2:"af";a:8:{s:8:"language";s:2:"af";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-06 11:26:31";s:12:"english_name";s:9:"Afrikaans";s:11:"native_name";s:9:"Afrikaans";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/af.zip";s:3:"iso";a:2:{i:1;s:2:"af";i:2;s:3:"afr";}s:7:"strings";a:1:{s:8:"continue";s:10:"Gaan voort";}}s:2:"ar";a:8:{s:8:"language";s:2:"ar";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-16 18:36:09";s:12:"english_name";s:6:"Arabic";s:11:"native_name";s:14:"العربية";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/ar.zip";s:3:"iso";a:2:{i:1;s:2:"ar";i:2;s:3:"ara";}s:7:"strings";a:1:{s:8:"continue";s:16:"المتابعة";}}s:3:"ary";a:8:{s:8:"language";s:3:"ary";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-21 10:19:10";s:12:"english_name";s:15:"Moroccan Arabic";s:11:"native_name";s:31:"العربية المغربية";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.6.1/ary.zip";s:3:"iso";a:2:{i:1;s:2:"ar";i:3;s:3:"ary";}s:7:"strings";a:1:{s:8:"continue";s:16:"المتابعة";}}s:2:"az";a:8:{s:8:"language";s:2:"az";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-29 08:38:56";s:12:"english_name";s:11:"Azerbaijani";s:11:"native_name";s:16:"Azərbaycan dili";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/az.zip";s:3:"iso";a:2:{i:1;s:2:"az";i:2;s:3:"aze";}s:7:"strings";a:1:{s:8:"continue";s:5:"Davam";}}s:3:"azb";a:8:{s:8:"language";s:3:"azb";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2015-12-11 22:42:10";s:12:"english_name";s:17:"South Azerbaijani";s:11:"native_name";s:29:"گؤنئی آذربایجان";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.4.2/azb.zip";s:3:"iso";a:2:{i:1;s:2:"az";i:3;s:3:"azb";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:5:"bg_BG";a:8:{s:8:"language";s:5:"bg_BG";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-24 13:13:07";s:12:"english_name";s:9:"Bulgarian";s:11:"native_name";s:18:"Български";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/bg_BG.zip";s:3:"iso";a:2:{i:1;s:2:"bg";i:2;s:3:"bul";}s:7:"strings";a:1:{s:8:"continue";s:12:"Напред";}}s:5:"bn_BD";a:8:{s:8:"language";s:5:"bn_BD";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-20 16:53:20";s:12:"english_name";s:7:"Bengali";s:11:"native_name";s:15:"বাংলা";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/bn_BD.zip";s:3:"iso";a:1:{i:1;s:2:"bn";}s:7:"strings";a:1:{s:8:"continue";s:23:"এগিয়ে চল.";}}s:2:"bo";a:8:{s:8:"language";s:2:"bo";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-05 09:44:12";s:12:"english_name";s:7:"Tibetan";s:11:"native_name";s:21:"བོད་ཡིག";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/bo.zip";s:3:"iso";a:2:{i:1;s:2:"bo";i:2;s:3:"tib";}s:7:"strings";a:1:{s:8:"continue";s:24:"མུ་མཐུད།";}}s:5:"bs_BA";a:8:{s:8:"language";s:5:"bs_BA";s:7:"version";s:5:"4.5.6";s:7:"updated";s:19:"2016-04-19 23:16:37";s:12:"english_name";s:7:"Bosnian";s:11:"native_name";s:8:"Bosanski";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.5.6/bs_BA.zip";s:3:"iso";a:2:{i:1;s:2:"bs";i:2;s:3:"bos";}s:7:"strings";a:1:{s:8:"continue";s:7:"Nastavi";}}s:2:"ca";a:8:{s:8:"language";s:2:"ca";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2017-01-05 11:04:12";s:12:"english_name";s:7:"Catalan";s:11:"native_name";s:7:"Català";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/ca.zip";s:3:"iso";a:2:{i:1;s:2:"ca";i:2;s:3:"cat";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continua";}}s:3:"ceb";a:8:{s:8:"language";s:3:"ceb";s:7:"version";s:5:"4.4.7";s:7:"updated";s:19:"2016-02-16 15:34:57";s:12:"english_name";s:7:"Cebuano";s:11:"native_name";s:7:"Cebuano";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.4.7/ceb.zip";s:3:"iso";a:2:{i:2;s:3:"ceb";i:3;s:3:"ceb";}s:7:"strings";a:1:{s:8:"continue";s:7:"Padayun";}}s:5:"cs_CZ";a:8:{s:8:"language";s:5:"cs_CZ";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2016-02-11 18:32:36";s:12:"english_name";s:5:"Czech";s:11:"native_name";s:12:"Čeština‎";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.4.2/cs_CZ.zip";s:3:"iso";a:2:{i:1;s:2:"cs";i:2;s:3:"ces";}s:7:"strings";a:1:{s:8:"continue";s:11:"Pokračovat";}}s:2:"cy";a:8:{s:8:"language";s:2:"cy";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-01 16:18:09";s:12:"english_name";s:5:"Welsh";s:11:"native_name";s:7:"Cymraeg";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/cy.zip";s:3:"iso";a:2:{i:1;s:2:"cy";i:2;s:3:"cym";}s:7:"strings";a:1:{s:8:"continue";s:6:"Parhau";}}s:5:"da_DK";a:8:{s:8:"language";s:5:"da_DK";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-29 14:03:59";s:12:"english_name";s:6:"Danish";s:11:"native_name";s:5:"Dansk";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/da_DK.zip";s:3:"iso";a:2:{i:1;s:2:"da";i:2;s:3:"dan";}s:7:"strings";a:1:{s:8:"continue";s:12:"Forts&#230;t";}}s:14:"de_CH_informal";a:8:{s:8:"language";s:14:"de_CH_informal";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-15 12:59:43";s:12:"english_name";s:30:"German (Switzerland, Informal)";s:11:"native_name";s:21:"Deutsch (Schweiz, Du)";s:7:"package";s:73:"https://downloads.wordpress.org/translation/core/4.6.1/de_CH_informal.zip";s:3:"iso";a:1:{i:1;s:2:"de";}s:7:"strings";a:1:{s:8:"continue";s:6:"Weiter";}}s:5:"de_DE";a:8:{s:8:"language";s:5:"de_DE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-21 21:20:26";s:12:"english_name";s:6:"German";s:11:"native_name";s:7:"Deutsch";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/de_DE.zip";s:3:"iso";a:1:{i:1;s:2:"de";}s:7:"strings";a:1:{s:8:"continue";s:6:"Weiter";}}s:12:"de_DE_formal";a:8:{s:8:"language";s:12:"de_DE_formal";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-21 21:21:17";s:12:"english_name";s:15:"German (Formal)";s:11:"native_name";s:13:"Deutsch (Sie)";s:7:"package";s:71:"https://downloads.wordpress.org/translation/core/4.6.1/de_DE_formal.zip";s:3:"iso";a:1:{i:1;s:2:"de";}s:7:"strings";a:1:{s:8:"continue";s:6:"Weiter";}}s:5:"de_CH";a:8:{s:8:"language";s:5:"de_CH";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-15 12:56:13";s:12:"english_name";s:20:"German (Switzerland)";s:11:"native_name";s:17:"Deutsch (Schweiz)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/de_CH.zip";s:3:"iso";a:1:{i:1;s:2:"de";}s:7:"strings";a:1:{s:8:"continue";s:6:"Weiter";}}s:2:"el";a:8:{s:8:"language";s:2:"el";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-09 20:42:31";s:12:"english_name";s:5:"Greek";s:11:"native_name";s:16:"Ελληνικά";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/el.zip";s:3:"iso";a:2:{i:1;s:2:"el";i:2;s:3:"ell";}s:7:"strings";a:1:{s:8:"continue";s:16:"Συνέχεια";}}s:5:"en_ZA";a:8:{s:8:"language";s:5:"en_ZA";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-16 11:54:12";s:12:"english_name";s:22:"English (South Africa)";s:11:"native_name";s:22:"English (South Africa)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/en_ZA.zip";s:3:"iso";a:3:{i:1;s:2:"en";i:2;s:3:"eng";i:3;s:3:"eng";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:5:"en_NZ";a:8:{s:8:"language";s:5:"en_NZ";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-20 07:14:07";s:12:"english_name";s:21:"English (New Zealand)";s:11:"native_name";s:21:"English (New Zealand)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/en_NZ.zip";s:3:"iso";a:3:{i:1;s:2:"en";i:2;s:3:"eng";i:3;s:3:"eng";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:5:"en_AU";a:8:{s:8:"language";s:5:"en_AU";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-12 02:18:44";s:12:"english_name";s:19:"English (Australia)";s:11:"native_name";s:19:"English (Australia)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/en_AU.zip";s:3:"iso";a:3:{i:1;s:2:"en";i:2;s:3:"eng";i:3;s:3:"eng";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:5:"en_GB";a:8:{s:8:"language";s:5:"en_GB";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-11 22:36:25";s:12:"english_name";s:12:"English (UK)";s:11:"native_name";s:12:"English (UK)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/en_GB.zip";s:3:"iso";a:3:{i:1;s:2:"en";i:2;s:3:"eng";i:3;s:3:"eng";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:5:"en_CA";a:8:{s:8:"language";s:5:"en_CA";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-11 23:19:29";s:12:"english_name";s:16:"English (Canada)";s:11:"native_name";s:16:"English (Canada)";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/en_CA.zip";s:3:"iso";a:3:{i:1;s:2:"en";i:2;s:3:"eng";i:3;s:3:"eng";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continue";}}s:2:"eo";a:8:{s:8:"language";s:2:"eo";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-04 22:04:52";s:12:"english_name";s:9:"Esperanto";s:11:"native_name";s:9:"Esperanto";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/eo.zip";s:3:"iso";a:2:{i:1;s:2:"eo";i:2;s:3:"epo";}s:7:"strings";a:1:{s:8:"continue";s:8:"Daŭrigi";}}s:5:"es_PE";a:8:{s:8:"language";s:5:"es_PE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-09 09:36:22";s:12:"english_name";s:14:"Spanish (Peru)";s:11:"native_name";s:17:"Español de Perú";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_PE.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_MX";a:8:{s:8:"language";s:5:"es_MX";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-29 15:07:52";s:12:"english_name";s:16:"Spanish (Mexico)";s:11:"native_name";s:19:"Español de México";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_MX.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_GT";a:8:{s:8:"language";s:5:"es_GT";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-17 17:56:31";s:12:"english_name";s:19:"Spanish (Guatemala)";s:11:"native_name";s:21:"Español de Guatemala";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_GT.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_ES";a:8:{s:8:"language";s:5:"es_ES";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-31 08:03:58";s:12:"english_name";s:15:"Spanish (Spain)";s:11:"native_name";s:8:"Español";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_ES.zip";s:3:"iso";a:1:{i:1;s:2:"es";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_CO";a:8:{s:8:"language";s:5:"es_CO";s:7:"version";s:6:"4.3-RC";s:7:"updated";s:19:"2015-08-04 06:10:33";s:12:"english_name";s:18:"Spanish (Colombia)";s:11:"native_name";s:20:"Español de Colombia";s:7:"package";s:65:"https://downloads.wordpress.org/translation/core/4.3-RC/es_CO.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_CL";a:8:{s:8:"language";s:5:"es_CL";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-17 22:11:44";s:12:"english_name";s:15:"Spanish (Chile)";s:11:"native_name";s:17:"Español de Chile";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_CL.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_AR";a:8:{s:8:"language";s:5:"es_AR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-19 13:48:04";s:12:"english_name";s:19:"Spanish (Argentina)";s:11:"native_name";s:21:"Español de Argentina";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_AR.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"es_VE";a:8:{s:8:"language";s:5:"es_VE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-17 12:34:44";s:12:"english_name";s:19:"Spanish (Venezuela)";s:11:"native_name";s:21:"Español de Venezuela";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/es_VE.zip";s:3:"iso";a:2:{i:1;s:2:"es";i:2;s:3:"spa";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:2:"et";a:8:{s:8:"language";s:2:"et";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-22 16:41:36";s:12:"english_name";s:8:"Estonian";s:11:"native_name";s:5:"Eesti";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/et.zip";s:3:"iso";a:2:{i:1;s:2:"et";i:2;s:3:"est";}s:7:"strings";a:1:{s:8:"continue";s:6:"Jätka";}}s:2:"eu";a:8:{s:8:"language";s:2:"eu";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-27 18:10:49";s:12:"english_name";s:6:"Basque";s:11:"native_name";s:7:"Euskara";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/eu.zip";s:3:"iso";a:2:{i:1;s:2:"eu";i:2;s:3:"eus";}s:7:"strings";a:1:{s:8:"continue";s:8:"Jarraitu";}}s:5:"fa_IR";a:8:{s:8:"language";s:5:"fa_IR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-23 20:20:40";s:12:"english_name";s:7:"Persian";s:11:"native_name";s:10:"فارسی";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/fa_IR.zip";s:3:"iso";a:2:{i:1;s:2:"fa";i:2;s:3:"fas";}s:7:"strings";a:1:{s:8:"continue";s:10:"ادامه";}}s:2:"fi";a:8:{s:8:"language";s:2:"fi";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-15 18:30:48";s:12:"english_name";s:7:"Finnish";s:11:"native_name";s:5:"Suomi";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/fi.zip";s:3:"iso";a:2:{i:1;s:2:"fi";i:2;s:3:"fin";}s:7:"strings";a:1:{s:8:"continue";s:5:"Jatka";}}s:5:"fr_FR";a:8:{s:8:"language";s:5:"fr_FR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-02 11:49:52";s:12:"english_name";s:15:"French (France)";s:11:"native_name";s:9:"Français";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/fr_FR.zip";s:3:"iso";a:1:{i:1;s:2:"fr";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuer";}}s:5:"fr_CA";a:8:{s:8:"language";s:5:"fr_CA";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-10 18:17:57";s:12:"english_name";s:15:"French (Canada)";s:11:"native_name";s:19:"Français du Canada";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/fr_CA.zip";s:3:"iso";a:2:{i:1;s:2:"fr";i:2;s:3:"fra";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuer";}}s:5:"fr_BE";a:8:{s:8:"language";s:5:"fr_BE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-10 18:42:25";s:12:"english_name";s:16:"French (Belgium)";s:11:"native_name";s:21:"Français de Belgique";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/fr_BE.zip";s:3:"iso";a:2:{i:1;s:2:"fr";i:2;s:3:"fra";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuer";}}s:2:"gd";a:8:{s:8:"language";s:2:"gd";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-23 17:41:37";s:12:"english_name";s:15:"Scottish Gaelic";s:11:"native_name";s:9:"Gàidhlig";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/gd.zip";s:3:"iso";a:3:{i:1;s:2:"gd";i:2;s:3:"gla";i:3;s:3:"gla";}s:7:"strings";a:1:{s:8:"continue";s:15:"Lean air adhart";}}s:5:"gl_ES";a:8:{s:8:"language";s:5:"gl_ES";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-21 15:44:17";s:12:"english_name";s:8:"Galician";s:11:"native_name";s:6:"Galego";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/gl_ES.zip";s:3:"iso";a:2:{i:1;s:2:"gl";i:2;s:3:"glg";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:2:"gu";a:8:{s:8:"language";s:2:"gu";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-08 11:09:06";s:12:"english_name";s:8:"Gujarati";s:11:"native_name";s:21:"ગુજરાતી";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/gu.zip";s:3:"iso";a:2:{i:1;s:2:"gu";i:2;s:3:"guj";}s:7:"strings";a:1:{s:8:"continue";s:31:"ચાલુ રાખવું";}}s:3:"haz";a:8:{s:8:"language";s:3:"haz";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2015-12-05 00:59:09";s:12:"english_name";s:8:"Hazaragi";s:11:"native_name";s:15:"هزاره گی";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.4.2/haz.zip";s:3:"iso";a:1:{i:3;s:3:"haz";}s:7:"strings";a:1:{s:8:"continue";s:10:"ادامه";}}s:5:"he_IL";a:8:{s:8:"language";s:5:"he_IL";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-25 19:56:49";s:12:"english_name";s:6:"Hebrew";s:11:"native_name";s:16:"עִבְרִית";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/he_IL.zip";s:3:"iso";a:1:{i:1;s:2:"he";}s:7:"strings";a:1:{s:8:"continue";s:8:"המשך";}}s:5:"hi_IN";a:8:{s:8:"language";s:5:"hi_IN";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-03 13:43:01";s:12:"english_name";s:5:"Hindi";s:11:"native_name";s:18:"हिन्दी";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/hi_IN.zip";s:3:"iso";a:2:{i:1;s:2:"hi";i:2;s:3:"hin";}s:7:"strings";a:1:{s:8:"continue";s:12:"जारी";}}s:2:"hr";a:8:{s:8:"language";s:2:"hr";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-07 15:12:28";s:12:"english_name";s:8:"Croatian";s:11:"native_name";s:8:"Hrvatski";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/hr.zip";s:3:"iso";a:2:{i:1;s:2:"hr";i:2;s:3:"hrv";}s:7:"strings";a:1:{s:8:"continue";s:7:"Nastavi";}}s:5:"hu_HU";a:8:{s:8:"language";s:5:"hu_HU";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-06 20:18:25";s:12:"english_name";s:9:"Hungarian";s:11:"native_name";s:6:"Magyar";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/hu_HU.zip";s:3:"iso";a:2:{i:1;s:2:"hu";i:2;s:3:"hun";}s:7:"strings";a:1:{s:8:"continue";s:10:"Folytatás";}}s:2:"hy";a:8:{s:8:"language";s:2:"hy";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2016-02-04 07:13:54";s:12:"english_name";s:8:"Armenian";s:11:"native_name";s:14:"Հայերեն";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.4.2/hy.zip";s:3:"iso";a:2:{i:1;s:2:"hy";i:2;s:3:"hye";}s:7:"strings";a:1:{s:8:"continue";s:20:"Շարունակել";}}s:5:"id_ID";a:8:{s:8:"language";s:5:"id_ID";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-22 05:34:53";s:12:"english_name";s:10:"Indonesian";s:11:"native_name";s:16:"Bahasa Indonesia";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/id_ID.zip";s:3:"iso";a:2:{i:1;s:2:"id";i:2;s:3:"ind";}s:7:"strings";a:1:{s:8:"continue";s:9:"Lanjutkan";}}s:5:"is_IS";a:8:{s:8:"language";s:5:"is_IS";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-29 11:28:08";s:12:"english_name";s:9:"Icelandic";s:11:"native_name";s:9:"Íslenska";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/is_IS.zip";s:3:"iso";a:2:{i:1;s:2:"is";i:2;s:3:"isl";}s:7:"strings";a:1:{s:8:"continue";s:6:"Áfram";}}s:5:"it_IT";a:8:{s:8:"language";s:5:"it_IT";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-19 08:05:09";s:12:"english_name";s:7:"Italian";s:11:"native_name";s:8:"Italiano";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/it_IT.zip";s:3:"iso";a:2:{i:1;s:2:"it";i:2;s:3:"ita";}s:7:"strings";a:1:{s:8:"continue";s:8:"Continua";}}s:2:"ja";a:8:{s:8:"language";s:2:"ja";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-01 15:23:06";s:12:"english_name";s:8:"Japanese";s:11:"native_name";s:9:"日本語";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/ja.zip";s:3:"iso";a:1:{i:1;s:2:"ja";}s:7:"strings";a:1:{s:8:"continue";s:9:"続ける";}}s:5:"ka_GE";a:8:{s:8:"language";s:5:"ka_GE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-29 11:51:34";s:12:"english_name";s:8:"Georgian";s:11:"native_name";s:21:"ქართული";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ka_GE.zip";s:3:"iso";a:2:{i:1;s:2:"ka";i:2;s:3:"kat";}s:7:"strings";a:1:{s:8:"continue";s:30:"გაგრძელება";}}s:5:"ko_KR";a:8:{s:8:"language";s:5:"ko_KR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-24 07:18:31";s:12:"english_name";s:6:"Korean";s:11:"native_name";s:9:"한국어";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ko_KR.zip";s:3:"iso";a:2:{i:1;s:2:"ko";i:2;s:3:"kor";}s:7:"strings";a:1:{s:8:"continue";s:6:"계속";}}s:5:"lt_LT";a:8:{s:8:"language";s:5:"lt_LT";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-11 21:29:34";s:12:"english_name";s:10:"Lithuanian";s:11:"native_name";s:15:"Lietuvių kalba";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/lt_LT.zip";s:3:"iso";a:2:{i:1;s:2:"lt";i:2;s:3:"lit";}s:7:"strings";a:1:{s:8:"continue";s:6:"Tęsti";}}s:2:"lv";a:8:{s:8:"language";s:2:"lv";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-26 17:38:44";s:12:"english_name";s:7:"Latvian";s:11:"native_name";s:16:"Latviešu valoda";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/lv.zip";s:3:"iso";a:2:{i:1;s:2:"lv";i:2;s:3:"lav";}s:7:"strings";a:1:{s:8:"continue";s:9:"Turpināt";}}s:5:"mk_MK";a:8:{s:8:"language";s:5:"mk_MK";s:7:"version";s:5:"4.5.6";s:7:"updated";s:19:"2016-05-12 13:55:28";s:12:"english_name";s:10:"Macedonian";s:11:"native_name";s:31:"Македонски јазик";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.5.6/mk_MK.zip";s:3:"iso";a:2:{i:1;s:2:"mk";i:2;s:3:"mkd";}s:7:"strings";a:1:{s:8:"continue";s:16:"Продолжи";}}s:2:"mr";a:8:{s:8:"language";s:2:"mr";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-13 20:38:52";s:12:"english_name";s:7:"Marathi";s:11:"native_name";s:15:"मराठी";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/mr.zip";s:3:"iso";a:2:{i:1;s:2:"mr";i:2;s:3:"mar";}s:7:"strings";a:1:{s:8:"continue";s:25:"सुरु ठेवा";}}s:5:"ms_MY";a:8:{s:8:"language";s:5:"ms_MY";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-14 14:18:43";s:12:"english_name";s:5:"Malay";s:11:"native_name";s:13:"Bahasa Melayu";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ms_MY.zip";s:3:"iso";a:2:{i:1;s:2:"ms";i:2;s:3:"msa";}s:7:"strings";a:1:{s:8:"continue";s:8:"Teruskan";}}s:5:"my_MM";a:8:{s:8:"language";s:5:"my_MM";s:7:"version";s:6:"4.1.15";s:7:"updated";s:19:"2015-03-26 15:57:42";s:12:"english_name";s:17:"Myanmar (Burmese)";s:11:"native_name";s:15:"ဗမာစာ";s:7:"package";s:65:"https://downloads.wordpress.org/translation/core/4.1.15/my_MM.zip";s:3:"iso";a:2:{i:1;s:2:"my";i:2;s:3:"mya";}s:7:"strings";a:1:{s:8:"continue";s:54:"ဆက်လက်လုပ်ဆောင်ပါ။";}}s:5:"nb_NO";a:8:{s:8:"language";s:5:"nb_NO";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-16 13:09:49";s:12:"english_name";s:19:"Norwegian (Bokmål)";s:11:"native_name";s:13:"Norsk bokmål";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/nb_NO.zip";s:3:"iso";a:2:{i:1;s:2:"nb";i:2;s:3:"nob";}s:7:"strings";a:1:{s:8:"continue";s:8:"Fortsett";}}s:5:"nl_NL";a:8:{s:8:"language";s:5:"nl_NL";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2017-01-08 18:34:47";s:12:"english_name";s:5:"Dutch";s:11:"native_name";s:10:"Nederlands";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/nl_NL.zip";s:3:"iso";a:2:{i:1;s:2:"nl";i:2;s:3:"nld";}s:7:"strings";a:1:{s:8:"continue";s:8:"Doorgaan";}}s:12:"nl_NL_formal";a:8:{s:8:"language";s:12:"nl_NL_formal";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-14 13:24:10";s:12:"english_name";s:14:"Dutch (Formal)";s:11:"native_name";s:20:"Nederlands (Formeel)";s:7:"package";s:71:"https://downloads.wordpress.org/translation/core/4.6.1/nl_NL_formal.zip";s:3:"iso";a:2:{i:1;s:2:"nl";i:2;s:3:"nld";}s:7:"strings";a:1:{s:8:"continue";s:8:"Doorgaan";}}s:5:"nn_NO";a:8:{s:8:"language";s:5:"nn_NO";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-28 08:58:28";s:12:"english_name";s:19:"Norwegian (Nynorsk)";s:11:"native_name";s:13:"Norsk nynorsk";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/nn_NO.zip";s:3:"iso";a:2:{i:1;s:2:"nn";i:2;s:3:"nno";}s:7:"strings";a:1:{s:8:"continue";s:9:"Hald fram";}}s:3:"oci";a:8:{s:8:"language";s:3:"oci";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-23 13:45:11";s:12:"english_name";s:7:"Occitan";s:11:"native_name";s:7:"Occitan";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.6.1/oci.zip";s:3:"iso";a:2:{i:1;s:2:"oc";i:2;s:3:"oci";}s:7:"strings";a:1:{s:8:"continue";s:9:"Contunhar";}}s:5:"pl_PL";a:8:{s:8:"language";s:5:"pl_PL";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-22 09:54:16";s:12:"english_name";s:6:"Polish";s:11:"native_name";s:6:"Polski";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/pl_PL.zip";s:3:"iso";a:2:{i:1;s:2:"pl";i:2;s:3:"pol";}s:7:"strings";a:1:{s:8:"continue";s:9:"Kontynuuj";}}s:2:"ps";a:8:{s:8:"language";s:2:"ps";s:7:"version";s:6:"4.1.15";s:7:"updated";s:19:"2015-03-29 22:19:48";s:12:"english_name";s:6:"Pashto";s:11:"native_name";s:8:"پښتو";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.1.15/ps.zip";s:3:"iso";a:2:{i:1;s:2:"ps";i:2;s:3:"pus";}s:7:"strings";a:1:{s:8:"continue";s:19:"دوام ورکړه";}}s:5:"pt_PT";a:8:{s:8:"language";s:5:"pt_PT";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2017-01-10 08:18:16";s:12:"english_name";s:21:"Portuguese (Portugal)";s:11:"native_name";s:10:"Português";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/pt_PT.zip";s:3:"iso";a:1:{i:1;s:2:"pt";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"pt_BR";a:8:{s:8:"language";s:5:"pt_BR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-26 14:59:30";s:12:"english_name";s:19:"Portuguese (Brazil)";s:11:"native_name";s:20:"Português do Brasil";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/pt_BR.zip";s:3:"iso";a:2:{i:1;s:2:"pt";i:2;s:3:"por";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuar";}}s:5:"ro_RO";a:8:{s:8:"language";s:5:"ro_RO";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-20 20:55:13";s:12:"english_name";s:8:"Romanian";s:11:"native_name";s:8:"Română";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ro_RO.zip";s:3:"iso";a:2:{i:1;s:2:"ro";i:2;s:3:"ron";}s:7:"strings";a:1:{s:8:"continue";s:9:"Continuă";}}s:5:"ru_RU";a:8:{s:8:"language";s:5:"ru_RU";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-30 19:40:04";s:12:"english_name";s:7:"Russian";s:11:"native_name";s:14:"Русский";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ru_RU.zip";s:3:"iso";a:2:{i:1;s:2:"ru";i:2;s:3:"rus";}s:7:"strings";a:1:{s:8:"continue";s:20:"Продолжить";}}s:5:"sk_SK";a:8:{s:8:"language";s:5:"sk_SK";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-08 14:52:32";s:12:"english_name";s:6:"Slovak";s:11:"native_name";s:11:"Slovenčina";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/sk_SK.zip";s:3:"iso";a:2:{i:1;s:2:"sk";i:2;s:3:"slk";}s:7:"strings";a:1:{s:8:"continue";s:12:"Pokračovať";}}s:5:"sl_SI";a:8:{s:8:"language";s:5:"sl_SI";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-11-04 18:38:43";s:12:"english_name";s:9:"Slovenian";s:11:"native_name";s:13:"Slovenščina";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/sl_SI.zip";s:3:"iso";a:2:{i:1;s:2:"sl";i:2;s:3:"slv";}s:7:"strings";a:1:{s:8:"continue";s:8:"Nadaljuj";}}s:2:"sq";a:8:{s:8:"language";s:2:"sq";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-14 07:00:01";s:12:"english_name";s:8:"Albanian";s:11:"native_name";s:5:"Shqip";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/sq.zip";s:3:"iso";a:2:{i:1;s:2:"sq";i:2;s:3:"sqi";}s:7:"strings";a:1:{s:8:"continue";s:6:"Vazhdo";}}s:5:"sr_RS";a:8:{s:8:"language";s:5:"sr_RS";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-12 16:41:17";s:12:"english_name";s:7:"Serbian";s:11:"native_name";s:23:"Српски језик";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/sr_RS.zip";s:3:"iso";a:2:{i:1;s:2:"sr";i:2;s:3:"srp";}s:7:"strings";a:1:{s:8:"continue";s:14:"Настави";}}s:5:"sv_SE";a:8:{s:8:"language";s:5:"sv_SE";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-01 10:58:06";s:12:"english_name";s:7:"Swedish";s:11:"native_name";s:7:"Svenska";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/sv_SE.zip";s:3:"iso";a:2:{i:1;s:2:"sv";i:2;s:3:"swe";}s:7:"strings";a:1:{s:8:"continue";s:9:"Fortsätt";}}s:3:"szl";a:8:{s:8:"language";s:3:"szl";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-09-24 19:58:14";s:12:"english_name";s:8:"Silesian";s:11:"native_name";s:17:"Ślōnskŏ gŏdka";s:7:"package";s:62:"https://downloads.wordpress.org/translation/core/4.6.1/szl.zip";s:3:"iso";a:1:{i:3;s:3:"szl";}s:7:"strings";a:1:{s:8:"continue";s:13:"Kōntynuować";}}s:2:"th";a:8:{s:8:"language";s:2:"th";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-10-12 07:04:13";s:12:"english_name";s:4:"Thai";s:11:"native_name";s:9:"ไทย";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/th.zip";s:3:"iso";a:2:{i:1;s:2:"th";i:2;s:3:"tha";}s:7:"strings";a:1:{s:8:"continue";s:15:"ต่อไป";}}s:2:"tl";a:8:{s:8:"language";s:2:"tl";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2015-11-27 15:51:36";s:12:"english_name";s:7:"Tagalog";s:11:"native_name";s:7:"Tagalog";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.4.2/tl.zip";s:3:"iso";a:2:{i:1;s:2:"tl";i:2;s:3:"tgl";}s:7:"strings";a:1:{s:8:"continue";s:10:"Magpatuloy";}}s:5:"tr_TR";a:8:{s:8:"language";s:5:"tr_TR";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-16 10:50:15";s:12:"english_name";s:7:"Turkish";s:11:"native_name";s:8:"Türkçe";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/tr_TR.zip";s:3:"iso";a:2:{i:1;s:2:"tr";i:2;s:3:"tur";}s:7:"strings";a:1:{s:8:"continue";s:5:"Devam";}}s:5:"ug_CN";a:8:{s:8:"language";s:5:"ug_CN";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-01 16:07:46";s:12:"english_name";s:6:"Uighur";s:11:"native_name";s:9:"Uyƣurqə";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/ug_CN.zip";s:3:"iso";a:2:{i:1;s:2:"ug";i:2;s:3:"uig";}s:7:"strings";a:1:{s:8:"continue";s:26:"داۋاملاشتۇرۇش";}}s:2:"uk";a:8:{s:8:"language";s:2:"uk";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2017-01-04 23:08:07";s:12:"english_name";s:9:"Ukrainian";s:11:"native_name";s:20:"Українська";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/uk.zip";s:3:"iso";a:2:{i:1;s:2:"uk";i:2;s:3:"ukr";}s:7:"strings";a:1:{s:8:"continue";s:20:"Продовжити";}}s:2:"ur";a:8:{s:8:"language";s:2:"ur";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2017-01-08 10:11:20";s:12:"english_name";s:4:"Urdu";s:11:"native_name";s:8:"اردو";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.6.1/ur.zip";s:3:"iso";a:2:{i:1;s:2:"ur";i:2;s:3:"urd";}s:7:"strings";a:1:{s:8:"continue";s:19:"جاری رکھیں";}}s:2:"vi";a:8:{s:8:"language";s:2:"vi";s:7:"version";s:5:"4.4.2";s:7:"updated";s:19:"2015-12-09 01:01:25";s:12:"english_name";s:10:"Vietnamese";s:11:"native_name";s:14:"Tiếng Việt";s:7:"package";s:61:"https://downloads.wordpress.org/translation/core/4.4.2/vi.zip";s:3:"iso";a:2:{i:1;s:2:"vi";i:2;s:3:"vie";}s:7:"strings";a:1:{s:8:"continue";s:12:"Tiếp tục";}}s:5:"zh_TW";a:8:{s:8:"language";s:5:"zh_TW";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-08-18 13:53:15";s:12:"english_name";s:16:"Chinese (Taiwan)";s:11:"native_name";s:12:"繁體中文";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/zh_TW.zip";s:3:"iso";a:2:{i:1;s:2:"zh";i:2;s:3:"zho";}s:7:"strings";a:1:{s:8:"continue";s:6:"繼續";}}s:5:"zh_HK";a:8:{s:8:"language";s:5:"zh_HK";s:7:"version";s:5:"4.6.1";s:7:"updated";s:19:"2016-12-05 11:58:02";s:12:"english_name";s:19:"Chinese (Hong Kong)";s:11:"native_name";s:16:"香港中文版	";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.6.1/zh_HK.zip";s:3:"iso";a:2:{i:1;s:2:"zh";i:2;s:3:"zho";}s:7:"strings";a:1:{s:8:"continue";s:6:"繼續";}}s:5:"zh_CN";a:8:{s:8:"language";s:5:"zh_CN";s:7:"version";s:5:"4.5.6";s:7:"updated";s:19:"2016-04-17 03:29:01";s:12:"english_name";s:15:"Chinese (China)";s:11:"native_name";s:12:"简体中文";s:7:"package";s:64:"https://downloads.wordpress.org/translation/core/4.5.6/zh_CN.zip";s:3:"iso";a:2:{i:1;s:2:"zh";i:2;s:3:"zho";}s:7:"strings";a:1:{s:8:"continue";s:6:"继续";}}}', 'no'),
(352, '_transient_timeout_wc_upgrade_notice_2.6.7', '1488853329', 'no'),
(353, '_transient_wc_upgrade_notice_2.6.7', '', 'no'),
(354, 'theme_mods_twentyfifteen', 'a:2:{i:0;b:0;s:16:"sidebars_widgets";a:2:{s:4:"time";i:1488767343;s:4:"data";a:2:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}}}}', 'yes'),
(357, '_site_transient_timeout_wporg_theme_feature_list', '1488777853', 'no'),
(358, '_site_transient_wporg_theme_feature_list', 'a:3:{s:6:"Layout";a:7:{i:0;s:11:"grid-layout";i:1;s:10:"one-column";i:2;s:11:"two-columns";i:3;s:13:"three-columns";i:4;s:12:"four-columns";i:5;s:12:"left-sidebar";i:6;s:13:"right-sidebar";}s:8:"Features";a:20:{i:0;s:19:"accessibility-ready";i:1;s:10:"buddypress";i:2;s:17:"custom-background";i:3;s:13:"custom-colors";i:4;s:13:"custom-header";i:5;s:11:"custom-menu";i:6;s:12:"editor-style";i:7;s:21:"featured-image-header";i:8;s:15:"featured-images";i:9;s:15:"flexible-header";i:10;s:14:"footer-widgets";i:11;s:20:"front-page-post-form";i:12;s:19:"full-width-template";i:13;s:12:"microformats";i:14;s:12:"post-formats";i:15;s:20:"rtl-language-support";i:16;s:11:"sticky-post";i:17;s:13:"theme-options";i:18;s:17:"threaded-comments";i:19;s:17:"translation-ready";}s:7:"Subject";a:9:{i:0;s:4:"blog";i:1;s:10:"e-commerce";i:2;s:9:"education";i:3;s:13:"entertainment";i:4;s:14:"food-and-drink";i:5;s:7:"holiday";i:6;s:4:"news";i:7;s:11:"photography";i:8;s:9:"portfolio";}}', 'no'),
(360, '_transient_twentyfifteen_categories', '1', 'yes'),
(363, 'site_icon', '0', 'yes'),
(365, 'category_children', 'a:0:{}', 'yes'),
(366, '_site_transient_timeout_poptags_40cd750bba9870f18aada2478b24840a', '1488783269', 'no'),
(367, '_site_transient_poptags_40cd750bba9870f18aada2478b24840a', 'a:100:{s:6:"widget";a:3:{s:4:"name";s:6:"widget";s:4:"slug";s:6:"widget";s:5:"count";s:4:"6205";}s:6:"plugin";a:3:{s:4:"name";s:6:"plugin";s:4:"slug";s:6:"plugin";s:5:"count";s:4:"3809";}s:4:"post";a:3:{s:4:"name";s:4:"Post";s:4:"slug";s:4:"post";s:5:"count";s:4:"3808";}s:5:"admin";a:3:{s:4:"name";s:5:"admin";s:4:"slug";s:5:"admin";s:5:"count";s:4:"3337";}s:5:"posts";a:3:{s:4:"name";s:5:"posts";s:4:"slug";s:5:"posts";s:5:"count";s:4:"2904";}s:9:"shortcode";a:3:{s:4:"name";s:9:"shortcode";s:4:"slug";s:9:"shortcode";s:5:"count";s:4:"2633";}s:11:"woocommerce";a:3:{s:4:"name";s:11:"woocommerce";s:4:"slug";s:11:"woocommerce";s:5:"count";s:4:"2300";}s:7:"sidebar";a:3:{s:4:"name";s:7:"sidebar";s:4:"slug";s:7:"sidebar";s:5:"count";s:4:"2256";}s:6:"google";a:3:{s:4:"name";s:6:"google";s:4:"slug";s:6:"google";s:5:"count";s:4:"2178";}s:4:"page";a:3:{s:4:"name";s:4:"page";s:4:"slug";s:4:"page";s:5:"count";s:4:"2151";}s:7:"twitter";a:3:{s:4:"name";s:7:"twitter";s:4:"slug";s:7:"twitter";s:5:"count";s:4:"2114";}s:6:"images";a:3:{s:4:"name";s:6:"images";s:4:"slug";s:6:"images";s:5:"count";s:4:"2080";}s:8:"comments";a:3:{s:4:"name";s:8:"comments";s:4:"slug";s:8:"comments";s:5:"count";s:4:"2019";}s:5:"image";a:3:{s:4:"name";s:5:"image";s:4:"slug";s:5:"image";s:5:"count";s:4:"1975";}s:8:"facebook";a:3:{s:4:"name";s:8:"Facebook";s:4:"slug";s:8:"facebook";s:5:"count";s:4:"1811";}s:3:"seo";a:3:{s:4:"name";s:3:"seo";s:4:"slug";s:3:"seo";s:5:"count";s:4:"1707";}s:9:"wordpress";a:3:{s:4:"name";s:9:"wordpress";s:4:"slug";s:9:"wordpress";s:5:"count";s:4:"1684";}s:6:"social";a:3:{s:4:"name";s:6:"social";s:4:"slug";s:6:"social";s:5:"count";s:4:"1502";}s:7:"gallery";a:3:{s:4:"name";s:7:"gallery";s:4:"slug";s:7:"gallery";s:5:"count";s:4:"1419";}s:5:"email";a:3:{s:4:"name";s:5:"email";s:4:"slug";s:5:"email";s:5:"count";s:4:"1331";}s:5:"links";a:3:{s:4:"name";s:5:"links";s:4:"slug";s:5:"links";s:5:"count";s:4:"1314";}s:7:"widgets";a:3:{s:4:"name";s:7:"widgets";s:4:"slug";s:7:"widgets";s:5:"count";s:4:"1183";}s:5:"pages";a:3:{s:4:"name";s:5:"pages";s:4:"slug";s:5:"pages";s:5:"count";s:4:"1156";}s:9:"ecommerce";a:3:{s:4:"name";s:9:"ecommerce";s:4:"slug";s:9:"ecommerce";s:5:"count";s:4:"1110";}s:5:"media";a:3:{s:4:"name";s:5:"media";s:4:"slug";s:5:"media";s:5:"count";s:4:"1046";}s:6:"jquery";a:3:{s:4:"name";s:6:"jquery";s:4:"slug";s:6:"jquery";s:5:"count";s:4:"1037";}s:7:"content";a:3:{s:4:"name";s:7:"content";s:4:"slug";s:7:"content";s:5:"count";s:4:"1006";}s:5:"video";a:3:{s:4:"name";s:5:"video";s:4:"slug";s:5:"video";s:5:"count";s:4:"1002";}s:5:"login";a:3:{s:4:"name";s:5:"login";s:4:"slug";s:5:"login";s:5:"count";s:3:"996";}s:10:"responsive";a:3:{s:4:"name";s:10:"responsive";s:4:"slug";s:10:"responsive";s:5:"count";s:3:"978";}s:4:"ajax";a:3:{s:4:"name";s:4:"AJAX";s:4:"slug";s:4:"ajax";s:5:"count";s:3:"948";}s:3:"rss";a:3:{s:4:"name";s:3:"rss";s:4:"slug";s:3:"rss";s:5:"count";s:3:"920";}s:10:"e-commerce";a:3:{s:4:"name";s:10:"e-commerce";s:4:"slug";s:10:"e-commerce";s:5:"count";s:3:"896";}s:8:"security";a:3:{s:4:"name";s:8:"security";s:4:"slug";s:8:"security";s:5:"count";s:3:"883";}s:10:"javascript";a:3:{s:4:"name";s:10:"javascript";s:4:"slug";s:10:"javascript";s:5:"count";s:3:"881";}s:10:"buddypress";a:3:{s:4:"name";s:10:"buddypress";s:4:"slug";s:10:"buddypress";s:5:"count";s:3:"847";}s:5:"share";a:3:{s:4:"name";s:5:"Share";s:4:"slug";s:5:"share";s:5:"count";s:3:"805";}s:7:"youtube";a:3:{s:4:"name";s:7:"youtube";s:4:"slug";s:7:"youtube";s:5:"count";s:3:"804";}s:5:"photo";a:3:{s:4:"name";s:5:"photo";s:4:"slug";s:5:"photo";s:5:"count";s:3:"797";}s:4:"spam";a:3:{s:4:"name";s:4:"spam";s:4:"slug";s:4:"spam";s:5:"count";s:3:"789";}s:9:"analytics";a:3:{s:4:"name";s:9:"analytics";s:4:"slug";s:9:"analytics";s:5:"count";s:3:"783";}s:6:"slider";a:3:{s:4:"name";s:6:"slider";s:4:"slug";s:6:"slider";s:5:"count";s:3:"781";}s:4:"link";a:3:{s:4:"name";s:4:"link";s:4:"slug";s:4:"link";s:5:"count";s:3:"781";}s:4:"form";a:3:{s:4:"name";s:4:"form";s:4:"slug";s:4:"form";s:5:"count";s:3:"770";}s:3:"css";a:3:{s:4:"name";s:3:"CSS";s:4:"slug";s:3:"css";s:5:"count";s:3:"766";}s:4:"feed";a:3:{s:4:"name";s:4:"feed";s:4:"slug";s:4:"feed";s:5:"count";s:3:"759";}s:8:"category";a:3:{s:4:"name";s:8:"category";s:4:"slug";s:8:"category";s:5:"count";s:3:"750";}s:5:"embed";a:3:{s:4:"name";s:5:"embed";s:4:"slug";s:5:"embed";s:5:"count";s:3:"744";}s:6:"search";a:3:{s:4:"name";s:6:"search";s:4:"slug";s:6:"search";s:5:"count";s:3:"741";}s:6:"custom";a:3:{s:4:"name";s:6:"custom";s:4:"slug";s:6:"custom";s:5:"count";s:3:"734";}s:6:"photos";a:3:{s:4:"name";s:6:"photos";s:4:"slug";s:6:"photos";s:5:"count";s:3:"718";}s:4:"menu";a:3:{s:4:"name";s:4:"menu";s:4:"slug";s:4:"menu";s:5:"count";s:3:"664";}s:9:"slideshow";a:3:{s:4:"name";s:9:"slideshow";s:4:"slug";s:9:"slideshow";s:5:"count";s:3:"663";}s:6:"button";a:3:{s:4:"name";s:6:"button";s:4:"slug";s:6:"button";s:5:"count";s:3:"662";}s:5:"stats";a:3:{s:4:"name";s:5:"stats";s:4:"slug";s:5:"stats";s:5:"count";s:3:"654";}s:9:"dashboard";a:3:{s:4:"name";s:9:"dashboard";s:4:"slug";s:9:"dashboard";s:5:"count";s:3:"643";}s:5:"theme";a:3:{s:4:"name";s:5:"theme";s:4:"slug";s:5:"theme";s:5:"count";s:3:"642";}s:6:"mobile";a:3:{s:4:"name";s:6:"mobile";s:4:"slug";s:6:"mobile";s:5:"count";s:3:"638";}s:7:"comment";a:3:{s:4:"name";s:7:"comment";s:4:"slug";s:7:"comment";s:5:"count";s:3:"629";}s:4:"tags";a:3:{s:4:"name";s:4:"tags";s:4:"slug";s:4:"tags";s:5:"count";s:3:"624";}s:10:"categories";a:3:{s:4:"name";s:10:"categories";s:4:"slug";s:10:"categories";s:5:"count";s:3:"609";}s:10:"statistics";a:3:{s:4:"name";s:10:"statistics";s:4:"slug";s:10:"statistics";s:5:"count";s:3:"607";}s:6:"editor";a:3:{s:4:"name";s:6:"editor";s:4:"slug";s:6:"editor";s:5:"count";s:3:"602";}s:4:"user";a:3:{s:4:"name";s:4:"user";s:4:"slug";s:4:"user";s:5:"count";s:3:"599";}s:3:"ads";a:3:{s:4:"name";s:3:"ads";s:4:"slug";s:3:"ads";s:5:"count";s:3:"598";}s:12:"social-media";a:3:{s:4:"name";s:12:"social media";s:4:"slug";s:12:"social-media";s:5:"count";s:3:"592";}s:5:"users";a:3:{s:4:"name";s:5:"users";s:4:"slug";s:5:"users";s:5:"count";s:3:"578";}s:12:"contact-form";a:3:{s:4:"name";s:12:"contact form";s:4:"slug";s:12:"contact-form";s:5:"count";s:3:"568";}s:4:"list";a:3:{s:4:"name";s:4:"list";s:4:"slug";s:4:"list";s:5:"count";s:3:"567";}s:9:"affiliate";a:3:{s:4:"name";s:9:"affiliate";s:4:"slug";s:9:"affiliate";s:5:"count";s:3:"564";}s:9:"marketing";a:3:{s:4:"name";s:9:"marketing";s:4:"slug";s:9:"marketing";s:5:"count";s:3:"558";}s:6:"simple";a:3:{s:4:"name";s:6:"simple";s:4:"slug";s:6:"simple";s:5:"count";s:3:"557";}s:4:"shop";a:3:{s:4:"name";s:4:"shop";s:4:"slug";s:4:"shop";s:5:"count";s:3:"547";}s:7:"plugins";a:3:{s:4:"name";s:7:"plugins";s:4:"slug";s:7:"plugins";s:5:"count";s:3:"545";}s:9:"multisite";a:3:{s:4:"name";s:9:"multisite";s:4:"slug";s:9:"multisite";s:5:"count";s:3:"545";}s:3:"api";a:3:{s:4:"name";s:3:"api";s:4:"slug";s:3:"api";s:5:"count";s:3:"530";}s:7:"picture";a:3:{s:4:"name";s:7:"picture";s:4:"slug";s:7:"picture";s:5:"count";s:3:"525";}s:7:"contact";a:3:{s:4:"name";s:7:"contact";s:4:"slug";s:7:"contact";s:5:"count";s:3:"518";}s:3:"url";a:3:{s:4:"name";s:3:"url";s:4:"slug";s:3:"url";s:5:"count";s:3:"497";}s:10:"newsletter";a:3:{s:4:"name";s:10:"newsletter";s:4:"slug";s:10:"newsletter";s:5:"count";s:3:"493";}s:10:"navigation";a:3:{s:4:"name";s:10:"navigation";s:4:"slug";s:10:"navigation";s:5:"count";s:3:"475";}s:4:"html";a:3:{s:4:"name";s:4:"html";s:4:"slug";s:4:"html";s:5:"count";s:3:"473";}s:6:"events";a:3:{s:4:"name";s:6:"events";s:4:"slug";s:6:"events";s:5:"count";s:3:"473";}s:8:"pictures";a:3:{s:4:"name";s:8:"pictures";s:4:"slug";s:8:"pictures";s:5:"count";s:3:"467";}s:8:"tracking";a:3:{s:4:"name";s:8:"tracking";s:4:"slug";s:8:"tracking";s:5:"count";s:3:"463";}s:10:"shortcodes";a:3:{s:4:"name";s:10:"shortcodes";s:4:"slug";s:10:"shortcodes";s:5:"count";s:3:"459";}s:8:"calendar";a:3:{s:4:"name";s:8:"calendar";s:4:"slug";s:8:"calendar";s:5:"count";s:3:"452";}s:4:"meta";a:3:{s:4:"name";s:4:"meta";s:4:"slug";s:4:"meta";s:5:"count";s:3:"449";}s:8:"lightbox";a:3:{s:4:"name";s:8:"lightbox";s:4:"slug";s:8:"lightbox";s:5:"count";s:3:"448";}s:11:"advertising";a:3:{s:4:"name";s:11:"advertising";s:4:"slug";s:11:"advertising";s:5:"count";s:3:"447";}s:12:"notification";a:3:{s:4:"name";s:12:"notification";s:4:"slug";s:12:"notification";s:5:"count";s:3:"439";}s:3:"tag";a:3:{s:4:"name";s:3:"tag";s:4:"slug";s:3:"tag";s:5:"count";s:3:"437";}s:6:"paypal";a:3:{s:4:"name";s:6:"paypal";s:4:"slug";s:6:"paypal";s:5:"count";s:3:"437";}s:9:"thumbnail";a:3:{s:4:"name";s:9:"thumbnail";s:4:"slug";s:9:"thumbnail";s:5:"count";s:3:"436";}s:5:"popup";a:3:{s:4:"name";s:5:"popup";s:4:"slug";s:5:"popup";s:5:"count";s:3:"436";}s:4:"news";a:3:{s:4:"name";s:4:"News";s:4:"slug";s:4:"news";s:5:"count";s:3:"431";}s:6:"upload";a:3:{s:4:"name";s:6:"upload";s:4:"slug";s:6:"upload";s:5:"count";s:3:"431";}s:16:"custom-post-type";a:3:{s:4:"name";s:16:"custom post type";s:4:"slug";s:16:"custom-post-type";s:5:"count";s:3:"428";}s:8:"linkedin";a:3:{s:4:"name";s:8:"linkedin";s:4:"slug";s:8:"linkedin";s:5:"count";s:3:"427";}s:7:"sharing";a:3:{s:4:"name";s:7:"sharing";s:4:"slug";s:7:"sharing";s:5:"count";s:3:"424";}}', 'no'),
(371, '_site_transient_update_core', 'O:8:"stdClass":4:{s:7:"updates";a:4:{i:0;O:8:"stdClass":10:{s:8:"response";s:7:"upgrade";s:8:"download";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.7.3.zip";s:6:"locale";s:5:"es_ES";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.7.3.zip";s:10:"no_content";b:0;s:11:"new_bundled";b:0;s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:5:"4.7.3";s:7:"version";s:5:"4.7.3";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"4.7";s:15:"partial_version";s:0:"";}i:1;O:8:"stdClass":10:{s:8:"response";s:7:"upgrade";s:8:"download";s:59:"https://downloads.wordpress.org/release/wordpress-4.7.3.zip";s:6:"locale";s:5:"en_US";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:59:"https://downloads.wordpress.org/release/wordpress-4.7.3.zip";s:10:"no_content";s:70:"https://downloads.wordpress.org/release/wordpress-4.7.3-no-content.zip";s:11:"new_bundled";s:71:"https://downloads.wordpress.org/release/wordpress-4.7.3-new-bundled.zip";s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:5:"4.7.3";s:7:"version";s:5:"4.7.3";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"4.7";s:15:"partial_version";s:0:"";}i:2;O:8:"stdClass":11:{s:8:"response";s:10:"autoupdate";s:8:"download";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.7.3.zip";s:6:"locale";s:5:"es_ES";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.7.3.zip";s:10:"no_content";b:0;s:11:"new_bundled";b:0;s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:5:"4.7.3";s:7:"version";s:5:"4.7.3";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"4.7";s:15:"partial_version";s:0:"";s:9:"new_files";s:1:"1";}i:3;O:8:"stdClass":11:{s:8:"response";s:10:"autoupdate";s:8:"download";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.6.4.zip";s:6:"locale";s:5:"es_ES";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:65:"https://downloads.wordpress.org/release/es_ES/wordpress-4.6.4.zip";s:10:"no_content";b:0;s:11:"new_bundled";b:0;s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:5:"4.6.4";s:7:"version";s:5:"4.6.4";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"4.7";s:15:"partial_version";s:0:"";s:9:"new_files";s:1:"1";}}s:12:"last_checked";i:1490046542;s:15:"version_checked";s:5:"4.6.1";s:12:"translations";a:0:{}}', 'no'),
(375, 'duplicator_settings', 'a:10:{s:7:"version";s:6:"1.1.34";s:18:"uninstall_settings";b:1;s:15:"uninstall_files";b:1;s:16:"uninstall_tables";b:1;s:13:"package_debug";b:0;s:17:"package_mysqldump";b:0;s:22:"package_mysqldump_path";s:0:"";s:24:"package_phpdump_qrylimit";s:3:"100";s:17:"package_zip_flush";b:0;s:20:"storage_htaccess_off";b:0;}', 'yes'),
(376, 'duplicator_version_plugin', '1.1.34', 'yes'),
(377, 'duplicator_package_active', 'O:11:"DUP_Package":23:{s:7:"Created";s:19:"2017-03-06 03:57:15";s:7:"Version";s:6:"1.1.34";s:9:"VersionWP";s:5:"4.6.1";s:9:"VersionDB";s:7:"10.1.16";s:10:"VersionPHP";s:5:"7.0.9";s:9:"VersionOS";s:5:"WINNT";s:2:"ID";N;s:4:"Name";s:13:"20170306_bida";s:4:"Hash";s:29:"58bcde1b07eb53023170306035715";s:8:"NameHash";s:43:"20170306_bida_58bcde1b07eb53023170306035715";s:4:"Type";i:0;s:5:"Notes";s:0:"";s:9:"StorePath";s:42:"C:/xampp/htdocs/wordpress/wp-snapshots/tmp";s:8:"StoreURL";s:40:"http://localhost/wordpress/wp-snapshots/";s:8:"ScanFile";s:53:"20170306_bida_58bcde1b07eb53023170306035715_scan.json";s:7:"Runtime";N;s:7:"ExeSize";N;s:7:"ZipSize";N;s:6:"Status";N;s:6:"WPUser";N;s:7:"Archive";O:11:"DUP_Archive":13:{s:10:"FilterDirs";s:0:"";s:10:"FilterExts";s:0:"";s:13:"FilterDirsAll";a:0:{}s:13:"FilterExtsAll";a:0:{}s:8:"FilterOn";i:0;s:4:"File";N;s:6:"Format";s:3:"ZIP";s:7:"PackDir";s:25:"C:/xampp/htdocs/wordpress";s:4:"Size";i:0;s:4:"Dirs";a:0:{}s:5:"Files";a:0:{}s:10:"FilterInfo";O:23:"DUP_Archive_Filter_Info":6:{s:4:"Dirs";O:34:"DUP_Archive_Filter_Scope_Directory":4:{s:7:"Warning";a:0:{}s:10:"Unreadable";a:0:{}s:4:"Core";a:0:{}s:8:"Instance";a:0:{}}s:5:"Files";O:29:"DUP_Archive_Filter_Scope_File":5:{s:4:"Size";a:0:{}s:7:"Warning";a:0:{}s:10:"Unreadable";a:0:{}s:4:"Core";a:0:{}s:8:"Instance";a:0:{}}s:4:"Exts";O:29:"DUP_Archive_Filter_Scope_Base":2:{s:4:"Core";a:0:{}s:8:"Instance";a:0:{}}s:9:"UDirCount";i:0;s:10:"UFileCount";i:0;s:9:"UExtCount";i:0;}s:10:"\0*\0Package";O:11:"DUP_Package":23:{s:7:"Created";s:19:"2017-03-06 03:57:15";s:7:"Version";s:6:"1.1.34";s:9:"VersionWP";s:5:"4.6.1";s:9:"VersionDB";s:7:"10.1.16";s:10:"VersionPHP";s:5:"7.0.9";s:9:"VersionOS";s:5:"WINNT";s:2:"ID";N;s:4:"Name";s:13:"20170306_bida";s:4:"Hash";s:29:"58bcde1b07eb53023170306035715";s:8:"NameHash";s:43:"20170306_bida_58bcde1b07eb53023170306035715";s:4:"Type";i:0;s:5:"Notes";s:0:"";s:9:"StorePath";s:42:"C:/xampp/htdocs/wordpress/wp-snapshots/tmp";s:8:"StoreURL";s:40:"http://localhost/wordpress/wp-snapshots/";s:8:"ScanFile";N;s:7:"Runtime";N;s:7:"ExeSize";N;s:7:"ZipSize";N;s:6:"Status";N;s:6:"WPUser";N;s:7:"Archive";r:22;s:9:"Installer";O:13:"DUP_Installer":12:{s:4:"File";N;s:4:"Size";i:0;s:10:"OptsDBHost";s:0:"";s:10:"OptsDBPort";s:0:"";s:10:"OptsDBName";s:0:"";s:10:"OptsDBUser";s:0:"";s:12:"OptsSSLAdmin";i:0;s:12:"OptsSSLLogin";i:0;s:11:"OptsCacheWP";i:0;s:13:"OptsCachePath";i:0;s:10:"OptsURLNew";s:0:"";s:10:"\0*\0Package";r:52;}s:8:"Database";O:12:"DUP_Database":13:{s:4:"Type";s:5:"MySQL";s:4:"Size";N;s:4:"File";N;s:4:"Path";N;s:12:"FilterTables";s:0:"";s:8:"FilterOn";i:0;s:4:"Name";N;s:10:"Compatible";s:0:"";s:8:"Comments";s:31:"mariadb.org binary distribution";s:10:"\0*\0Package";r:52;s:25:"\0DUP_Database\0dbStorePath";N;s:23:"\0DUP_Database\0EOFMarker";s:0:"";s:26:"\0DUP_Database\0networkFlush";b:0;}}}s:9:"Installer";r:74;s:8:"Database";r:87;}', 'yes'),
(380, 'auto_updater.lock', '1490046543', 'no'),
(381, '_transient_timeout_external_ip_address_::1', '1490651343', 'no'),
(382, '_transient_external_ip_address_::1', '186.155.52.145', 'no'),
(386, 'core_updater.lock', '1490046545', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(387, '_site_transient_update_plugins', 'O:8:"stdClass":4:{s:12:"last_checked";i:1490047235;s:8:"response";a:2:{s:19:"akismet/akismet.php";O:8:"stdClass":8:{s:2:"id";s:2:"15";s:4:"slug";s:7:"akismet";s:6:"plugin";s:19:"akismet/akismet.php";s:11:"new_version";s:3:"3.3";s:3:"url";s:38:"https://wordpress.org/plugins/akismet/";s:7:"package";s:54:"https://downloads.wordpress.org/plugin/akismet.3.3.zip";s:6:"tested";s:5:"4.7.3";s:13:"compatibility";O:8:"stdClass":1:{s:6:"scalar";O:8:"stdClass":1:{s:6:"scalar";b:0;}}}s:27:"woocommerce/woocommerce.php";O:8:"stdClass":8:{s:2:"id";s:5:"25331";s:4:"slug";s:11:"woocommerce";s:6:"plugin";s:27:"woocommerce/woocommerce.php";s:11:"new_version";s:6:"2.6.14";s:3:"url";s:42:"https://wordpress.org/plugins/woocommerce/";s:7:"package";s:61:"https://downloads.wordpress.org/plugin/woocommerce.2.6.14.zip";s:6:"tested";s:5:"4.7.3";s:13:"compatibility";O:8:"stdClass":1:{s:6:"scalar";O:8:"stdClass":1:{s:6:"scalar";b:0;}}}}s:12:"translations";a:0:{}s:9:"no_update";a:3:{s:25:"duplicator/duplicator.php";O:8:"stdClass":6:{s:2:"id";s:5:"22600";s:4:"slug";s:10:"duplicator";s:6:"plugin";s:25:"duplicator/duplicator.php";s:11:"new_version";s:6:"1.1.34";s:3:"url";s:41:"https://wordpress.org/plugins/duplicator/";s:7:"package";s:60:"https://downloads.wordpress.org/plugin/duplicator.1.1.34.zip";}s:9:"hello.php";O:8:"stdClass":6:{s:2:"id";s:4:"3564";s:4:"slug";s:11:"hello-dolly";s:6:"plugin";s:9:"hello.php";s:11:"new_version";s:3:"1.6";s:3:"url";s:42:"https://wordpress.org/plugins/hello-dolly/";s:7:"package";s:58:"https://downloads.wordpress.org/plugin/hello-dolly.1.6.zip";}s:91:"woocommerce-gateway-paypal-express-checkout/woocommerce-gateway-paypal-express-checkout.php";O:8:"stdClass":6:{s:2:"id";s:5:"70549";s:4:"slug";s:43:"woocommerce-gateway-paypal-express-checkout";s:6:"plugin";s:91:"woocommerce-gateway-paypal-express-checkout/woocommerce-gateway-paypal-express-checkout.php";s:11:"new_version";s:5:"1.1.2";s:3:"url";s:74:"https://wordpress.org/plugins/woocommerce-gateway-paypal-express-checkout/";s:7:"package";s:92:"https://downloads.wordpress.org/plugin/woocommerce-gateway-paypal-express-checkout.1.1.2.zip";}}}', 'no'),
(388, '_site_transient_update_themes', 'O:8:"stdClass":4:{s:12:"last_checked";i:1490047238;s:7:"checked";a:4:{s:10:"responsive";s:7:"1.9.9.0";s:13:"twentyfifteen";s:3:"1.6";s:14:"twentyfourteen";s:3:"1.8";s:13:"twentysixteen";s:3:"1.3";}s:8:"response";a:3:{s:10:"responsive";a:4:{s:5:"theme";s:10:"responsive";s:11:"new_version";s:3:"2.2";s:3:"url";s:40:"https://wordpress.org/themes/responsive/";s:7:"package";s:56:"https://downloads.wordpress.org/theme/responsive.2.2.zip";}s:13:"twentyfifteen";a:4:{s:5:"theme";s:13:"twentyfifteen";s:11:"new_version";s:3:"1.7";s:3:"url";s:43:"https://wordpress.org/themes/twentyfifteen/";s:7:"package";s:59:"https://downloads.wordpress.org/theme/twentyfifteen.1.7.zip";}s:14:"twentyfourteen";a:4:{s:5:"theme";s:14:"twentyfourteen";s:11:"new_version";s:3:"1.9";s:3:"url";s:44:"https://wordpress.org/themes/twentyfourteen/";s:7:"package";s:60:"https://downloads.wordpress.org/theme/twentyfourteen.1.9.zip";}}s:12:"translations";a:0:{}}', 'no'),
(389, '_site_transient_timeout_browser_58769e6f77965f1b81999b5fbb0b69b5', '1490651365', 'no'),
(390, '_site_transient_browser_58769e6f77965f1b81999b5fbb0b69b5', 'a:9:{s:8:"platform";s:7:"Windows";s:4:"name";s:6:"Chrome";s:7:"version";s:12:"56.0.2924.87";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'no'),
(391, '_transient_timeout_wc_report_sales_by_date', '1490132965', 'no'),
(392, '_transient_wc_report_sales_by_date', 'a:7:{s:32:"d7b94c7ef2d065aa2f32ce630e6f074c";a:0:{}s:32:"ad77f1707aa497f70ae98db712df97e0";a:0:{}s:32:"2b3cf2a511ccedbb87068d467f06a4e7";a:0:{}s:32:"2615865acadd12e5c1b2db659e829aa0";N;s:32:"89672b079a19110cdf3775fa345d64f9";a:0:{}s:32:"59e81ef05af0174bc97b507bfc257414";a:0:{}s:32:"d63926d0e28c0ef1978a78102150dfdc";a:0:{}}', 'no'),
(393, '_transient_timeout_wc_admin_report', '1490132965', 'no'),
(394, '_transient_wc_admin_report', 'a:1:{s:32:"57a9e0c8fbd4bc53f635d8b59972026b";a:0:{}}', 'no'),
(395, '_transient_timeout_feed_ef605fdbfbba53a6c98437c00d402dfe', '1490089770', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(396, '_transient_feed_ef605fdbfbba53a6c98437c00d402dfe', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"\n\n\n";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:49:"\n	\n	\n	\n	\n	\n	\n	\n	\n	\n	\n		\n		\n		\n		\n		\n		\n		\n		\n		\n	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:3:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:8:"Español";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:24:"https://es.wordpress.org";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8:"Español";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:13:"lastBuildDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 14 Mar 2017 15:54:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"es-ES";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:40:"https://wordpress.org/?v=4.8-alpha-40293";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:10:{i:0;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/03/13/eventos-wordpress-para-la-semana-11-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/03/13/eventos-wordpress-para-la-semana-11-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 13 Mar 2017 07:23:12 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1207";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:395:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 16/03 &#8211; Alcalá de Henares &#8211; Uso del editor Elementor y nociones de responsive 16/03 &#8211; Collado Villalba &#8211; RamsonWare &#8211; Hacking ético y seguridad WordPress 17/03 &#8211; Bilbao &#8211; El [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:4278:"<p><img class="aligncenter size-full wp-image-1150" src="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png" alt="Eventos WordPress para esta semana en españa" width="1280" height="476" srcset="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w" sizes="(max-width: 1280px) 100vw, 1280px" /></p>\n<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>16/03 &#8211; <strong>Alcalá de Henares</strong> &#8211; <a href="https://www.meetup.com/es-ES/Alcala-de-Henares-WordPress-Meetup/events/237979284/" target="_blank">Uso del editor Elementor y nociones de responsive</a></li>\n<li>16/03 &#8211; <strong>Collado Villalba</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Collado-Villalba-Meetup/events/238192166/" target="_blank">RamsonWare &#8211; Hacking ético y seguridad WordPress</a></li>\n<li>17/03 &#8211; <strong>Bilbao</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Bilbao/events/237977121/" target="_blank">El Negocio de la Web</a></li>\n<li>17/03 &#8211; <strong>Pontevedra</strong> &#8211; <a href="https://www.meetup.com/es-ES/Pontevedra-WordPress-Meetup/events/238053342/" target="_blank">3 maquetadores visuales gratuitos que debes conocer</a></li>\n</ul>\n<h3>Fotos de las Meetups de la semana anterior</h3>\n<a href="https://es.wordpress.org/2017/03/13/eventos-wordpress-para-la-semana-11-17/#gallery-1207-1-slideshow">Haga click para ver el pase de diapositivas.</a>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/03/13/eventos-wordpress-para-la-semana-11-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:57:"\n		\n		\n		\n		\n		\n				\n		\n		\n		\n		\n		\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:60:"WordPress 4.7.3: Actualización de seguridad y mantenimiento";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:95:"https://es.wordpress.org/2017/03/06/wordpress-4-7-3-actualizacion-de-seguridad-y-mantenimiento/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:104:"https://es.wordpress.org/2017/03/06/wordpress-4-7-3-actualizacion-de-seguridad-y-mantenimiento/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 20:07:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:6:{i:0;a:5:{s:4:"data";s:15:"Actualizaciones";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:13:"Mantenimiento";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:9:"Seguridad";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:3:"4.7";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:4;a:5:{s:4:"data";s:5:"4.7.3";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:5;a:5:{s:4:"data";s:13:"mantenimiento";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1204";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:428:"Ya está disponible WordPress 4.7.3. Esta es una actualización de seguridad para todas las versiones previas y te animamos encarecidamente a actualizar inmediatamente tus sitios. Todas las versiones de WordPress 4.7.2 y anteriores están afectadas por seis problemas de seguridad: Cross-site scripting (XSS) a través de metadatos de archivos de medios. Informado por Chris Andrè Dale, Yorick Koster y Simon P. [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Fernando Tellado";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:6522:"<p>Ya está disponible WordPress 4.7.3. Esta es una <strong>actualización de seguridad</strong> para todas las versiones previas y te animamos encarecidamente a actualizar inmediatamente tus sitios.</p>\n<p>Todas las versiones de WordPress 4.7.2 y anteriores están afectadas por seis problemas de seguridad:</p>\n<ol>\n<li>Cross-site scripting (XSS) a través de metadatos de archivos de medios. Informado por <a href="https://www.securesolutions.no/">Chris Andrè Dale</a>, <a href="https://twitter.com/yorickkoster">Yorick Koster</a> y Simon P. Briggs.</li>\n<li>Los caracteres de control pueden engañar a la validación de redirección de la URL. Informado por <a href="http://www.danielchatfield.com/">Daniel Chatfield</a>.</li>\n<li>Los administradores pueden borrar archivos sin querer al usar la funcionalidad de borrado de plugins.  Informado por <a href="http://b.360.cn/">xuliang</a>.</li>\n<li>Cross-site scripting (XSS) a través de la URL del vídeo en incrustados de YouTube. Informado por <a href="https://twitter.com/marcs0h">Marc Montpas</a>.</li>\n<li>Cross-site scripting (XSS) a través de nombres de términos de taxonomías. Informado por <a href="https://profiles.wordpress.org/deltamgm2">Delta</a>.</li>\n<li>Cross-site request forgery (CSRF) en Publicar esto que lleva a un consumo excesivo de recursos del servidor. Informado por Sipke Mellema.</li>\n</ol>\n<p>Gracias a los que informaron de estos problemas practicando la <a href="https://make.wordpress.org/core/handbook/testing/reporting-security-vulnerabilities/">revelación responsable</a>.</p>\n<p>Además de los problemas de seguridad informados arriba, WordPress 4.7.3 contiene 39 ajustes de mantenimiento para toda la serie de versiones 4.7. Para más información revisa las <a href="https://codex.wordpress.org/Version_4.7.3">notas de la versión</a> o consulta la <a href="https://core.trac.wordpress.org/query?status=closed&amp;milestone=4.7.3&amp;group=component&amp;col=id&amp;col=summary&amp;col=component&amp;col=status&amp;col=owner&amp;col=type&amp;col=priority&amp;col=keywords&amp;order=priority">lista de cambios</a>.</p>\n<p><a href="https://es.wordpress.org/releases/">Descarga WordPress 4.7.3</a> o pásate por el escritorio de WordPress → Actualizaciones y simplemente haz clic en “Actualizar ahora”Los sitios compatibles con las actualizaciones automáticas en segundo plano ya se están actualizando solos a WordPress 4.7.3.</p>\n<p>Gracias a todos los que han colaborado con la versión 4.7.3: <a href="https://profiles.wordpress.org/aaroncampbell/">Aaron D. Campbell</a>, <a href="https://profiles.wordpress.org/adamsilverstein/">Adam Silverstein</a>, <a href="https://profiles.wordpress.org/xknown/">Alex Concha</a>, <a href="https://profiles.wordpress.org/afercia/">Andrea Fercia</a>, <a href="https://profiles.wordpress.org/azaozz/">Andrew Ozz</a>, <a href="https://profiles.wordpress.org/asalce/">asalce</a>, <a href="https://profiles.wordpress.org/blobfolio/">blobfolio</a>, <a href="https://profiles.wordpress.org/gitlost/">bonger</a>, <a href="https://profiles.wordpress.org/boonebgorges/">Boone Gorges</a>, <a href="https://profiles.wordpress.org/bor0/">Boro Sitnikovski</a>, <a href="https://profiles.wordpress.org/bradyvercher/">Brady Vercher</a>, <a href="https://profiles.wordpress.org/drrobotnik/">Brandon Lavigne</a>, <a href="https://profiles.wordpress.org/bhargavbhandari90/">Bunty</a>, <a href="https://profiles.wordpress.org/ccprog/">ccprog</a>, <a href="https://profiles.wordpress.org/ketuchetan/">chetansatasiya</a>, <a href="https://profiles.wordpress.org/davidakennedy/">David A. Kennedy</a>, <a href="https://profiles.wordpress.org/dlh/">David Herrera</a>, <a href="https://profiles.wordpress.org/dhanendran/">Dhanendran</a>, <a href="https://profiles.wordpress.org/dd32/">Dion Hulse</a>, <a href="https://profiles.wordpress.org/ocean90/">Dominik Schilling (ocean90)</a>, <a href="https://profiles.wordpress.org/drivingralle/">Drivingralle</a>, <a href="https://profiles.wordpress.org/iseulde/">Ella Van Dorpe</a>, <a href="https://profiles.wordpress.org/pento/">Gary Pendergast</a>, <a href="https://profiles.wordpress.org/iandunn/">Ian Dunn</a>, <a href="https://profiles.wordpress.org/ipstenu/">Ipstenu (Mika Epstein)</a>, <a href="https://profiles.wordpress.org/jnylen0/">James Nylen</a>, <a href="https://profiles.wordpress.org/jazbek/">jazbek</a>, <a href="https://profiles.wordpress.org/jeremyfelt/">Jeremy Felt</a>, <a href="https://profiles.wordpress.org/jpry/">Jeremy Pry</a>, <a href="https://profiles.wordpress.org/joehoyle/">Joe Hoyle</a>, <a href="https://profiles.wordpress.org/joemcgill/">Joe McGill</a>, <a href="https://profiles.wordpress.org/johnbillion/">John Blackbourn</a>, <a href="https://profiles.wordpress.org/johnjamesjacoby/">John James Jacoby</a>, <a href="https://profiles.wordpress.org/desrosj/">Jonathan Desrosiers</a>, <a href="https://profiles.wordpress.org/ryelle/">Kelly Dwan</a>, <a href="https://profiles.wordpress.org/markoheijnen/">Marko Heijnen</a>, <a href="https://profiles.wordpress.org/matheusgimenez/">MatheusGimenez</a>, <a href="https://profiles.wordpress.org/mnelson4/">Mike Nelson</a>, <a href="https://profiles.wordpress.org/mikeschroder/">Mike Schroder</a>, <a href="https://profiles.wordpress.org/codegeass/">Muhammet Arslan</a>, <a href="https://profiles.wordpress.org/celloexpressions/">Nick Halsey</a>, <a href="https://profiles.wordpress.org/swissspidy/">Pascal Birchler</a>, <a href="https://profiles.wordpress.org/pbearne/">Paul Bearne</a>, <a href="https://profiles.wordpress.org/pavelevap/">pavelevap</a>, <a href="https://profiles.wordpress.org/peterwilsoncc/">Peter Wilson</a>, <a href="https://profiles.wordpress.org/rachelbaker/">Rachel Baker</a>, <a href="https://profiles.wordpress.org/reldev/">reldev</a>, <a href="https://profiles.wordpress.org/sanchothefat/">Robert O’Rourke</a>, <a href="https://profiles.wordpress.org/welcher/">Ryan Welcher</a>, <a href="https://profiles.wordpress.org/sanketparmar/">Sanket Parmar</a>, <a href="https://profiles.wordpress.org/seanchayes/">Sean Hayes</a>, <a href="https://profiles.wordpress.org/sergeybiryukov/">Sergey Biryukov</a>, <a href="https://profiles.wordpress.org/netweb/">Stephen Edgar</a>, <a href="https://profiles.wordpress.org/triplejumper12/">triplejumper12</a>, <a href="https://profiles.wordpress.org/westonruter/">Weston Ruter</a> y <a href="https://profiles.wordpress.org/wpfo/">wpfo</a>.</p>\n<div class="sharedaddy sd-sharing-enabled"></div>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:100:"https://es.wordpress.org/2017/03/06/wordpress-4-7-3-actualizacion-de-seguridad-y-mantenimiento/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/03/06/eventos-wordpress-para-la-semana-10-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/03/06/eventos-wordpress-para-la-semana-10-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 12:37:27 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1198";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:351:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Aprovechamos para dar la enhorabuena a todo el equipo de la WordCamp Alicante 2017 por el excelente trabajo realizado durante este fin de semana. En este enlace puedes encontrar todas [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:5452:"<p><img class="aligncenter size-full wp-image-1150" src="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png" alt="Eventos WordPress para esta semana en españa" width="1280" height="476" srcset="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w" sizes="(max-width: 1280px) 100vw, 1280px" /></p>\n<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<p>Aprovechamos para dar la enhorabuena a todo el equipo de la <strong>WordCamp Alicante 2017</strong> por el excelente trabajo realizado durante este fin de semana. En este enlace puedes encontrar <a href="https://2017.alicante.wordcamp.org/diapositivas-ponentes-wordcamp-alicante-2017/" target="_blank">todas las diapositivas</a> del evento.</p>\n<figure id="attachment_1199" style="width: 692px" class="wp-caption aligncenter"><img class="wp-image-1199 size-large" src="https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017-1024x768.jpg" alt="wordcamp alicante 2017" width="692" height="519" srcset="https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017-1024x768.jpg 1024w, https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017-300x225.jpg 300w, https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017-768x576.jpg 768w, https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017-440x330.jpg 440w, https://es.wordpress.org/files/2017/03/wordcamp-alicante-2017.jpg 1280w" sizes="(max-width: 692px) 100vw, 692px" /><figcaption class="wp-caption-text">Equipo organizador de la WordCamp Alicante 2017</figcaption></figure>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>09/03 &#8211; <strong>Granollers</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPressGranollers/events/237340550/" target="_blank">¿Cómo Mantener WordPress Actualizado Sin Problemas?</a></li>\n<li>10/03 &#8211; <strong>Madrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Madrid/events/237845233/" target="_blank">Control de versiones y trabajo entre entornos de desarrollo</a></li>\n<li>10/03 &#8211; <strong>Bilbao</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Bilbao/events/237977099/" target="_blank">Cómo usar video marketing para tu negocio</a></li>\n<li>10/03 &#8211; <strong>Alcázar de San Juan</strong> &#8211; <a href="https://www.meetup.com/Alcazar-de-San-Juan-WordPress-Meetup/events/237780665/?_locale=es-ES" target="_blank">Cómo tener nuestro primer blog con WordPress.com GRATIS!!</a></li>\n</ul>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/03/06/eventos-wordpress-para-la-semana-10-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/02/27/eventos-wordpress-para-la-semana-09-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:84:"https://es.wordpress.org/2017/02/27/eventos-wordpress-para-la-semana-09-17/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 27 Feb 2017 10:11:22 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1167";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:358:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 02/03 &#8211; Madrid &#8211; WooCommerce desde otro punto de vista Fotos de las Meetups de la semana anterior WordCamps Sigue de cerca la organización de los próximos WordCamps que [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:4808:"<p><img class="aligncenter size-full wp-image-1150" src="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png" alt="Eventos WordPress para esta semana en españa" width="1280" height="476" srcset="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w" sizes="(max-width: 1280px) 100vw, 1280px" /></p>\n<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>02/03 &#8211; <strong>Madrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Madrid/events/237504020/" target="_blank">WooCommerce desde otro punto de vista</a></li>\n</ul>\n<h3>Fotos de las Meetups de la semana anterior</h3>\n<a href="https://es.wordpress.org/2017/02/27/eventos-wordpress-para-la-semana-09-17/#gallery-1167-2-slideshow">Haga click para ver el pase de diapositivas.</a>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/02/27/eventos-wordpress-para-la-semana-09-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/02/20/eventos-wordpress-para-la-semana-08-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/02/20/eventos-wordpress-para-la-semana-08-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 20 Feb 2017 09:17:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1157";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:430:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 21/02 &#8211; Majadahona &#8211; Pesadilla después de Navidad (Seguridad WordPress) 23/02 &#8211; Málaga &#8211; Seguridad en WordPress para evitar ataques de bots 23/02 &#8211; Sevilla  &#8211; CPT: el primer paso hacia la personalización 23/02 [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:6295:"<p><img class="aligncenter size-full wp-image-1150" src="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png" alt="Eventos WordPress para esta semana en españa" width="1280" height="476" srcset="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w" sizes="(max-width: 1280px) 100vw, 1280px" /></p>\n<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>21/02 &#8211; <strong>Majadahona</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Majadahonda/events/237660965/" target="_blank">Pesadilla después de Navidad (Seguridad WordPress)</a></li>\n<li>23/02 &#8211; <strong>Málaga</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Malaga/events/237603137/" target="_blank">Seguridad en WordPress para evitar ataques de bots</a></li>\n<li>23/02 &#8211; <strong>Sevilla </strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Sevilla/events/237613439/">CPT: el primer paso hacia la personalización</a></li>\n<li>23/02 &#8211; <strong>Zaragoza </strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Zaragoza/events/237703566/" target="_blank">Coloquio abierto</a></li>\n<li>23/02 &#8211; <strong>Valladolid</strong> &#8211; <a href="https://www.meetup.com/es-ES/Valladolid-WordPress-Meetup/events/236839196/" target="_blank">Usar WP desde cero y &#8220;meter mano&#8221; al código sin tener mucha idea.By Kike García</a></li>\n<li>24/02 &#8211; <strong>Pontevedra</strong> &#8211; <a href="https://www.meetup.com/es-ES/Pontevedra-WordPress-Meetup/events/237481054/" target="_blank">Preguntas y respuestas sobre WordPress</a></li>\n<li>24/02 &#8211; <strong>Bilbao</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Bilbao/events/237754299/" target="_blank">WordCamp Europe en Bilbao</a></li>\n<li>24/02 &#8211; <strong>Palmas de Gran Canaria</strong> &#8211; <a href="https://www.meetup.com/es-ES/Las-Palmas-de-Gran-Canaria-WordPress-Meetup/events/237671816/" target="_blank">WorkShop: Aprende todo sobre formularios en WordPress y ContactForm7</a></li>\n</ul>\n<h3>Fotos de las Meetups de la semana anterior</h3>\n<a href="https://es.wordpress.org/2017/02/20/eventos-wordpress-para-la-semana-08-17/#gallery-1157-3-slideshow">Haga click para ver el pase de diapositivas.</a>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/02/20/eventos-wordpress-para-la-semana-08-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/02/13/eventos-wordpress-para-la-semana-07-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/02/13/eventos-wordpress-para-la-semana-07-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 13 Feb 2017 11:14:14 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1144";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:405:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 13/02 &#8211; Mallorca &#8211; Plugins para Backup / HotJar (Conversión) 16/02 &#8211; Madrid &#8211; Muestra campos de ACF en tu web sin programar 16/02 &#8211; Collado de Villalba &#8211; Tipos de contenidos personalizados [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:5670:"<p><img class="aligncenter size-full wp-image-1150" src="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png" alt="Eventos WordPress para esta semana en españa" width="1280" height="476" srcset="https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w" sizes="(max-width: 1280px) 100vw, 1280px" /></p>\n<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>13/02 &#8211; <strong>Mallorca</strong> &#8211; <a href="https://www.meetup.com/es-ES/Mallorca-WordPress-Meetup/events/237094695/" target="_blank">Plugins para Backup / HotJar (Conversión)</a></li>\n<li>16/02 &#8211; <strong>Madrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Madrid/events/237188153/" target="_blank">Muestra campos de ACF en tu web sin programar</a></li>\n<li>16/02 &#8211; <strong>Collado de Villalba</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Collado-Villalba-Meetup/events/237221273/" target="_blank">Tipos de contenidos personalizados (custom post types)</a></li>\n<li>17/02 &#8211; <strong>Bilbao </strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Bilbao/events/237240501/" target="_blank">SEO, Analítica y CRO: Puesta a punto express de tu WordPress</a></li>\n<li>17/02 &#8211; <strong>Chiclana</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Meetup-Chiclana/events/237605539/">Email Marketing con WordPress: Crea tu newsletter</a></li>\n<li>18/02 &#8211; <strong>Valencia</strong> &#8211; <a href="https://www.meetup.com/wordpress-valencia-meetup/events/237671103/?_locale=es-ES">WP CLI: la navaja suiza para WordPress que te da superpoderes</a></li>\n</ul>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/02/13/eventos-wordpress-para-la-semana-07-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/02/05/eventos-wordpress-para-la-semana-06-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/02/05/eventos-wordpress-para-la-semana-06-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 05 Feb 2017 08:30:57 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1127";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:420:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 09/02 &#8211; Granollers &#8211; Page Builders en WordPress, Conoce sus Pros y Contras. 09/02 &#8211; Alicante &#8211; Información y dudas sobre la WordCamp Alicante 10/02 &#8211; Marbella  &#8211; ¿Está mi WordPress preparado para los [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:4649:"<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>09/02 &#8211; <strong>Granollers</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPressGranollers/events/235753674/" target="_blank">Page Builders en WordPress, Conoce sus Pros y Contras.</a></li>\n<li>09/02 &#8211; <strong>Alicante</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Alicante/events/237299428/" target="_blank">Información y dudas sobre la WordCamp Alicante</a></li>\n<li>10/02 &#8211; <strong>Marbella </strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Meetup-Marbella/events/237319250/" target="_blank">¿Está mi WordPress preparado para los nuevos cambios con la LOPD?</a></li>\n</ul>\n<h3>Fotos de las Meetups de la semana anterior</h3>\n<a href="https://es.wordpress.org/2017/02/05/eventos-wordpress-para-la-semana-06-17/#gallery-1127-4-slideshow">Haga click para ver el pase de diapositivas.</a>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | Programa | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-voluntarios-call-for-volunteers/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/horario-academico/" target="_blank">Horario Académico</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/02/05/eventos-wordpress-para-la-semana-06-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/01/30/eventos-wordpress-para-la-semana-05-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/01/30/eventos-wordpress-para-la-semana-05-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 30 Jan 2017 09:10:22 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1098";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:407:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. También aprovechamos para darle la bienvenida al nuevo grupo de Meetup de Granada, ¡Enhorabuena! Meetups 31/01 &#8211; Chiclana &#8211; Email Marketing con WordPress 31/01 &#8211; Las Palmas &#8211; Ampliando WordPress. Publicación de [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:5603:"<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.<br />\nTambién aprovechamos para darle la bienvenida al nuevo grupo de <a href="https://www.meetup.com/es-ES/Granada-WordPress-Meetup/" target="_blank">Meetup de Granada</a>, ¡Enhorabuena!</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>31/01 &#8211; <strong>Chiclana</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Meetup-Chiclana/events/237160891/" target="_blank">Email Marketing con WordPress</a></li>\n<li>31/01 &#8211; <strong>Las Palmas</strong> &#8211; <a href="https://www.meetup.com/es-ES/Las-Palmas-de-Gran-Canaria-WordPress-Meetup/events/236851686/" target="_blank">Ampliando WordPress. Publicación de contenidos enfocado a resultados</a></li>\n<li>01/02 &#8211; <strong>Granada </strong> &#8211; <a href="https://www.meetup.com/es-ES/Granada-WordPress-Meetup/events/237139740/" target="_blank">Comunidad WordPress ¡Aparece!</a> (nuevo Meetup <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f389.png" alt="🎉" class="wp-smiley" style="height: 1em; max-height: 1em;" /><img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f44f.png" alt="👏" class="wp-smiley" style="height: 1em; max-height: 1em;" /><img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f3fb.png" alt="🏻" class="wp-smiley" style="height: 1em; max-height: 1em;" />)</li>\n<li>01/02 &#8211; <strong>Rivas Vaciamadrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/Rivas-WordPress-Meetup/events/237017936/" target="_blank">Tu tienda on-line desde 0 . WordPress te ayuda con WooCommerce</a></li>\n<li>02/02 &#8211; <strong>Barcelona</strong> &#8211; <a href="https://www.meetup.com/es-ES/wordpressbcn/events/237309696/?eventId=237309696" target="_blank">Todo sobre el equipo de Comunidad de WordPress.org, Meetups y WordCamps</a></li>\n<li>02/02 &#8211; <strong>Madrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Madrid/events/236912586/" target="_blank">Creación de shortcodes para que lo use “El Cliente”</a></li>\n</ul>\n<h3>Fotos de las Meetups de la semana anterior</h3>\n<a href="https://es.wordpress.org/2017/01/30/eventos-wordpress-para-la-semana-05-17/#gallery-1098-5-slideshow">Haga click para ver el pase de diapositivas.</a>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.madrid.wordcamp.org/entradas/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/programa/" target="_blank">Programa</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/01/30/eventos-wordpress-para-la-semana-05-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:51:"\n		\n		\n		\n		\n		\n				\n		\n		\n		\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:47:"WordPress 4.7.2 – Actualización de seguridad";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:79:"https://es.wordpress.org/2017/01/27/wordpress-4-7-2-actualizacion-de-seguridad/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:88:"https://es.wordpress.org/2017/01/27/wordpress-4-7-2-actualizacion-de-seguridad/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 27 Jan 2017 11:35:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:4:{i:0;a:5:{s:4:"data";s:15:"Actualizaciones";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:9:"Seguridad";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:3:"4.7";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:5:"4.7.2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1095";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:376:"Ya está disponible WordPress 4.7.2. Es una actualización de seguridad para todas las versiones y te animamos encarecidamente a actualizar tus sitios de inmediato. Las versiones de WordPress 4.7.1 y anteriores están afectadas por estos tres problemas de seguridad: La interfaz de usuario en la que se asignan términos a taxonomías en Publicar esto se muestra a [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Fernando Tellado";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1650:"<p>Ya está disponible WordPress 4.7.2. Es una <strong>actualización de seguridad</strong> para todas las versiones y te animamos encarecidamente a actualizar tus sitios de inmediato.</p>\n<p>Las versiones de WordPress 4.7.1 y anteriores están afectadas por estos tres problemas de seguridad:</p>\n<ol>\n<li>La interfaz de usuario en la que se asignan términos a taxonomías en Publicar esto se muestra a usuarios que no tienen permisos para usarlas. Informado por David Herrera de <a href="https://www.alleyinteractive.com/">Alley Interactive</a>.</li>\n<li><code>WP_Query</code> rs vulnerable a una inyección SQL (SQLi) al pasar datos no seguros. El núcleo de WordPress no es vulnerable directamente a este problema pero hemos añadido refuerzo para evitar que plugins y temas puedan provocar accidentalmente una vulnerabilidad. Informado por <a href="https://github.com/mjangda">Mo Jangda</a> (batmoo).</li>\n<li>Se ha descubierto una vulnerabilidad de cross-site scripting (XSS) en la tabla de lista de entradas. Informado por <a href="https://iandunn.name/">Ian Dunn</a> del equipo de seguridad de WordPress.</li>\n</ol>\n<p>Gracias a los que informaron de estos problemas practicando la <a href="https://make.wordpress.org/core/handbook/testing/reporting-security-vulnerabilities/">revelación responsable</a>.</p>\n<p><a href="https://es.wordpress.org/releases/">Descarga WordPress 4.7.2</a> o pásate por el escritorio de WordPress → Actualizaciones y simplemente haz clic en “Actualizar ahora”Los sitios compatibles con las actualizaciones automáticas en segundo plano ya se están actualizando solos a WordPress 4.7.2.</p>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:84:"https://es.wordpress.org/2017/01/27/wordpress-4-7-2-actualizacion-de-seguridad/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:42:"\n		\n		\n		\n		\n		\n				\n\n		\n		\n				\n			\n		\n		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Eventos para la semana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://es.wordpress.org/2017/01/20/eventos-wordpress-para-la-semana-04-17/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:83:"https://es.wordpress.org/2017/01/20/eventos-wordpress-para-la-semana-04-17/#respond";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 20 Jan 2017 10:42:43 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://es.wordpress.org/?p=1079";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:372:"¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Enhorabuena al nuevo grupo de Meetup de Valladolid y a los organizadores de la reciente publicada WordCamp Alicante. Meetups 24/01 &#8211; Madrid &#8211; Haciendo un buen uso de los campos personalizados [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Mauricio Gelves";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:5668:"<p><strong>¡Buenos días a todos!</strong> Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps.<br />\nEnhorabuena al nuevo grupo de <a href="https://www.meetup.com/es-ES/Valladolid-WordPress-Meetup/" target="_blank">Meetup de Valladolid</a> y a los organizadores de la reciente publicada <a href="https://2017.alicante.wordcamp.org/" target="_blank">WordCamp Alicante</a>.</p>\n<hr />\n<h2>Meetups</h2>\n<ul>\n<li>24/01 &#8211; <strong>Madrid</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Madrid/events/236911916/" target="_blank">Haciendo un buen uso de los campos personalizados con ACF</a></li>\n<li>24/01 &#8211; <strong>Sevilla</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Sevilla/events/221757477/" target="_blank">Control de versiones: Git</a></li>\n<li>24/01 &#8211; <strong>Majadahonda</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Majadahonda/events/236813537/" target="_blank">Dale a tu contenido el espacio que se merece &#8211; WordPress Custom Post Types</a></li>\n<li>25/01 &#8211; <strong>Zaragoza</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Zaragoza/events/236815141/" target="_blank">Iniciación a Gravity Forms</a></li>\n<li>26/01 &#8211; <strong>Alcalá de Henares</strong> &#8211; <a href="https://www.meetup.com/es-ES/Alcala-de-Henares-WordPress-Meetup/events/236024376/" target="_blank">Quedada para puesta en común de ideas, dudas e inquietudes sobre WordPress</a></li>\n<li>26/01 &#8211; <strong>Collado Villalba</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Collado-Villalba-Meetup/events/236804775/" target="_blank">Trucos ocultos para convertirte en un Ninja de WordPress</a></li>\n<li>26/01 &#8211; <strong>Málaga</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPress-Malaga/events/236959119/" target="_blank">Comenzando con WordPress. Instalación y configuración. Trucos y consejos.</a></li>\n<li>26/01 &#8211; <strong>Valladolid</strong> &#8211; <a href="https://www.meetup.com/es-ES/Valladolid-WordPress-Meetup/events/236821199/" target="_blank">Presentación Comunidad WordPress</a> (nuevo Meetup <strong><img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f389.png" alt="🎉" class="wp-smiley" style="height: 1em; max-height: 1em;" /></strong>)</li>\n<li>27/01 &#8211; <strong>Granollers</strong> &#8211; <a href="https://www.meetup.com/es-ES/WordPressGranollers/events/236897558/" target="_blank">Taller Práctico, Ven con Tu Portátil <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f609.png" alt="😉" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a></li>\n</ul>\n<hr />\n<h2>WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2017.</p>\n<ul>\n<li><strong>WordCamp Madrid 22-23 de Abril 2017<br />\n</strong><a href="https://2017.madrid.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-patrocinadores-call-for-sponsors/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.madrid.wordcamp.org/llamada-a-ponentes-call-for-speakers/" target="_blank">Llamada a ponentes<br />\n</a><img class="wp-image-1088" src="https://es.wordpress.org/files/2017/01/wordcamp-madrid-2017-1024x341.png" alt="WordCamp Madrid 2017" width="308" height="72" /></li>\n<li><strong>WordCamp Bilbao 12-14 de Mayo 2017<br />\n</strong><a href="https://2017.bilbao.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-patrocinadores/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.bilbao.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="http://2017.bilbao.wordcamp.org/llamada-voluntarios" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.bilbao.wordcamp.org/compra-tu-entrada" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1090" src="https://es.wordpress.org/files/2017/01/wordpress-bilbao-2017.jpg" alt="WordCamp Bilbao 2017" width="311" height="159" /></li>\n<li><strong>WordCamp Alicante 4 de Marzo 2017</strong><br />\n<a href="https://2017.alicante.wordcamp.org/" target="_blank">Web</a> | <a href="https://2017.alicante.wordcamp.org/patrocina-el-evento/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-ponentes/" target="_blank">Llamada a ponentes</a> | <a href="https://2017.alicante.wordcamp.org/llamada-a-voluntarios/" target="_blank">Llamada a voluntarios</a> | <a href="https://2017.alicante.wordcamp.org/tickets-wordcamp-alicante-2017/" target="_blank">Tickets <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f39f.png" alt="🎟" class="wp-smiley" style="height: 1em; max-height: 1em;" /></a><br />\n<img class="alignnone wp-image-1091" src="https://es.wordpress.org/files/2017/01/wordcamp-alicante-2017.png" alt="WordCamp Alicante 2017" width="312" height="156" /></li>\n</ul>\n<hr />\n<h2>Otros eventos WordPress</h2>\n<p>Aquí podrás encontrar otros eventos interesantes en torno al mundo WordPress.</p>\n<ul>\n<li><strong>WPCampus Bilbao 24 de Marzo 2017<br />\n</strong><a href="https://2017.campuswp.es/" target="_blank">Web</a> | <a href="https://2017.campuswp.es/patrocina-wpcampus-2017/" target="_blank">Llamada a patrocinadores</a> | <a href="https://2017.campuswp.es/horario-academico/profesores/" target="_blank">Llamada a profesores</a></li>\n</ul>\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:80:"https://es.wordpress.org/2017/01/20/eventos-wordpress-para-la-semana-04-17/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:30:"https://es.wordpress.org/feed/";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:44:"http://purl.org/rss/1.0/modules/syndication/";a:2:{s:12:"updatePeriod";a:1:{i:0;a:5:{s:4:"data";s:6:"hourly";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:15:"updateFrequency";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";O:42:"Requests_Utility_CaseInsensitiveDictionary":1:{s:7:"\0*\0data";a:8:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Mon, 20 Mar 2017 21:49:27 GMT";s:12:"content-type";s:34:"application/rss+xml; charset=UTF-8";s:6:"x-olaf";s:3:"⛄";s:13:"last-modified";s:29:"Tue, 14 Mar 2017 15:54:44 GMT";s:4:"link";s:61:"<https://es.wordpress.org/wp-json/>; rel="https://api.w.org/"";s:15:"x-frame-options";s:10:"SAMEORIGIN";s:4:"x-nc";s:11:"HIT lax 249";}}s:5:"build";s:14:"20130911090210";}', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(397, '_transient_timeout_feed_mod_ef605fdbfbba53a6c98437c00d402dfe', '1490089770', 'no'),
(398, '_transient_feed_mod_ef605fdbfbba53a6c98437c00d402dfe', '1490046570', 'no'),
(399, '_transient_timeout_feed_d117b5738fbd35bd8c0391cda1f2b5d9', '1490089771', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(400, '_transient_feed_d117b5738fbd35bd8c0391cda1f2b5d9', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"\n\n\n";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:61:"\n	\n	\n	\n	\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"WordPress Planet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:28:"http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:2:"en";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:47:"WordPress Planet - http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:50:{i:0;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:119:"WPTavern: PressShack Forks Edit Flow to Create PublishPress, Aims to Improve Multi-User Editorial Workflow in WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67574";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:129:"https://wptavern.com/pressshack-forks-edit-flow-to-create-publishpress-aims-to-improve-multi-user-editorial-workflow-in-wordpress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6808:"<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/publish-press.png?ssl=1"><img /></a></p>\n<p>Last week Steve Burge and the team at <a href="https://pressshack.com/" target="_blank">PressShack</a> released <a href="https://wordpress.org/plugins/publishpress/" target="_blank">PublishPress</a>, a fork of Automattic&#8217;s <a href="https://wordpress.org/plugins/edit-flow/" target="_blank">Edit Flow</a> plugin. PressShack is operated by the same team behind <a href="http://ostraining.com/" target="_blank">OSTraining</a> with a focus on creating publishing plugins for larger organizations.</p>\n<p><a href="https://wordpress.org/plugins/edit-flow/" target="_blank">Edit Flow</a> has more than 10,000 active installs but is updated sporadically and is not very well supported. The PressShack creators saw an opportunity to fork the plugin and sell commercial support and add-ons. <a href="https://wordpress.org/plugins/publishpress/" target="_blank">PublishPress</a> is now available on WordPress.org with a seamless <a href="https://pressshack.com/publishpress/docs/migrate/" target="_blank">migration for Edit Flow users</a>.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/edit-flow-publishpress-migration.png?ssl=1"><img /></a></p>\n<p>The first release offers the same features as Edit Flow along with a complete face lift, making interaction with the plugin&#8217;s settings more user-friendly. The new tabbed interface puts all the settings on one screen. PressShack has also tweaked the language of the plugin, changing Story Budget” to “Overview”, and simplifying other terms.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/publishpress-ui.png?ssl=1"><img /></a></p>\n<p>PublishPress introduces a few changes to the calendar, allowing users to click anywhere on a date to add content. It exposes the iCal or Google Calendar feed and uses icons to show post statuses, saving space for other information.</p>\n<p>Burge said that PublishPress will be making a fresh start and will not be following and incorporating updates from Edit Flow. The team plans to add a host of new features that improve the publishing workflow to handle multiple users:</p>\n<ul>\n<li><strong>Multisite and multiple site support</strong>: Content creators log into one site but can publish to multiple sites</li>\n<li><strong>Pre-publishing checklists</strong>: For example, featured image, word count, Yoast SEO green light</li>\n<li><strong>More use cases beyond media sites</strong>: In addition to magazine-style user groups for reporting, PublishPress plans to add more use cases, such as WooCommerce products, EDD downloads, bbPress topics, and The Events Calendar listings</li>\n<li><strong>Multiple authors</strong>: Assign multiple author bylines to a story</li>\n</ul>\n<p>Most of these feature are slated for release in mid-2017 and will be <a href="https://pressshack.com/publishpress/" target="_blank">offered as commercial add-ons</a>. The team is currently still focused on writing unit tests for the core plugin and adding improvements to it on WordPress.org.</p>\n<h3>PressShack Takes Inspiration from Drupal for Expanding Content Workflows</h3>\n<p>PressShack&#8217;s creators also work closely with other open source publishing platforms. Burge said the team took some inspiration from the Drupal ecosystem, which offers more advanced features for modifying editorial workflows.</p>\n<p>&#8220;In Drupal, the workflow features are being demanded and developed by large organizations that use the platform,&#8221; Burge said. &#8220;As a result, Drupal does have a very big head start in this area. &#8220;In Drupal 7, the main workflow module was called <a href="https://www.drupal.org/project/workbench" target="_blank">Workbench</a>. It was built to meet the needs of large customers such as universities, media outlets, and government agencies who have many different content managers.&#8221;</p>\n<p>Prior to having editorial workflow tools available, Burge said that Drupal agencies kept losing projects to rivals such as Adobe and OpenText, because they had publishing workflows built for multiple users. Building better publishing tools became a necessity for Drupal agencies that wanted to win projects from large organizations.</p>\n<p>Drupal 8 moves many of these editorial workflow improvements into core. Drupal 8.3, which is slated for April 2017, will <a href="http://buytaert.net/moving-the-drupal-8-workflow-initiative-along" target="_blank">introduce the ability to create multiple types of content workflows</a>.</p>\n<p>&#8220;What’s really interesting about the Drupal 8 implementation is that they are thinking beyond just content publishing,&#8221; Burge said. &#8220;It will soon be possible to put whole sections of your site into a workflow. The demand for these features is still coming from enterprise customers: much of the work is being done by a team of Drupal developers inside Pfizer.&#8221;</p>\n<p>Burge cited a few examples of typical users requiring more elaborate publishing workflows:</p>\n<ul>\n<li>A university with 50+ academic departments and several hundred content creators</li>\n<li>A pharmaceutical company with hundreds of products and a micro-site for each one</li>\n<li>A newspaper that employs writers and at least one layer of editors</li>\n<li>A publicly-listed company that needs approval from several staff members to ensure that the content it publishes is 110% accurate</li>\n</ul>\n<p>WordPress core is tailored to a single-author blog workflow, and there are relatively few plugins that modify the default editorial workflow for large teams. <a href="https://wptavern.com/coschedule-a-viable-alternative-to-the-edit-flow-wordpress-plugin" target="_blank">CoSchedule is one alternative to Edit Flow</a> and PublishPress that has 10,000 active installs. It takes a SaaS approach and has more of a content marketing slant. Burge said he thinks the WordPress ecosystem&#8217;s scarcity of options for extending publishing workflows may be due to current limitations in core.</p>\n<p>&#8220;It’s possible there are some technical hurdles: for example, WordPress core has fairly limited user permissions,&#8221; he said. &#8220;It’s also possible that now is the right time for WordPress to start adding these features.&#8221;</p>\n<p>&#8220;WordPress agencies are building more enterprise sites and these demands are popping-up,&#8221; Burge said. &#8220;Matt just announced the <a href="https://ma.tt/2017/03/wordpress-collaborative-editing/" target="_blank">Google Docs integration</a> as a quick way to bring some collaborative features into WordPress. I think we’ll see more and more tools available for teams, rather than single authors.&#8221;</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 20 Mar 2017 21:21:19 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"Donncha: How to Auto Schedule WordPress Posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"https://odd.blog/?p=89500175";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"https://odd.blog/2017/03/18/how-to-auto-schedule-wordpress-posts/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2759:"<p>If you post to a WordPress blog on a regular basis like I do on <a href="https://inphotos.org/">In Photos dot Org</a> you&#8217;ll no doubt recognise the fatigue that comes from adjusting the publish date every single time on a new post so it appears a day later. If you have multiple posts like on a daily photoblog you have to remember what day the last post was made and adjust the date accordingly. </p>\n<p>A few years ago I wrote a small plugin that I never released to help schedule posts. In the media uploader you could select multiple photos and click a few buttons to be brought to a new page where you could enter title, content and tags for each image. Based on this experience, I suggested it as an idea to one of the teams at Automattic who built <a href="https://postbot.co/">Post Bot</a>. I used that for a long time and it has its strengths. If you&#8217;re posting content that has the same or similar tags you can copy and paste the tags from one post to another. I posted lots of black and white street images from my home town this way and it was super useful! </p>\n<p>I got tired of manually typing out tags, and unfortunately the site broke a few times, with posts not scheduling or one time they scheduled all in one go. Luckily the problems were quickly fixed. However, I started using the WordPress post editor again and scheduling a bunch of photos that way.</p>\n<p>Manually editing the publish date quickly became a chore. Lazarus, the form saver Chrome extension, would sometimes popup if I didn&#8217;t click exactly on the date, or as I said before I had to remember when the last post was made. They say there&#8217;s a plugin for everything, and there is for this too. Check out <a href="https://wordpress.org/plugins/publish-to-schedule/">Publish to Schedule</a>.</p>\n<p>You tell &#8220;Publish to Schedule&#8221; which days and how many posts should be published and when you go into the post editor the next available date is picked for you! The date doesn&#8217;t change until you hit Publish but I already used it to schedule a number of posts and it works really well.</p>\n<p><a href="https://odd.blog/files/2017/03/Screen-Shot-2017-03-14-at-17.21.11.png"><img /></a></p>\n\n<p><strong>Related Posts</strong><ul><li> <a href="https://odd.blog/2010/09/07/odd-games-of-bad-company-2/" rel="bookmark" title="Permanent Link: Odd games of bad company 2!">Odd games of bad company 2!</a></li><li> <a href="https://odd.blog/2010/12/28/im-on-top-of-the-world/" rel="bookmark" title="Permanent Link: I&#8217;m on top of the world">I&#8217;m on top of the world</a></li><li> <a href="https://odd.blog/2010/09/03/rage-quit-in-cod-4/" rel="bookmark" title="Permanent Link: Rage quit in COD 4!">Rage quit in COD 4!</a></li></ul></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 18 Mar 2017 16:50:49 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:7:"Donncha";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:90:"WPTavern: GitHub Adds Plain English Explanations to License Pages for Open Source Projects";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67550";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:101:"https://wptavern.com/github-adds-plain-english-explanations-to-license-pages-for-open-source-projects";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2475:"<p>GitHub took another step towards beefing up its support for open source projects this week with <a href="https://github.com/blog/2335-open-source-license-descriptions-and-metadata" target="_blank">a new feature that makes it easier to understand a project&#8217;s license</a>. If the project is using a popular open source license, GitHub will automatically add a short, plain-English description of the license and its permissions, conditions, and limitations. This allows GitHub users to see the implications of a project&#8217;s license at a glance.</p>\n<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/03/github-license-display.png?ssl=1"><img /></a></p>\n<p>GitHub pulls this data from <a href="http://ChooseALicense.com" target="_blank">ChooseALicense.com</a>, the site it created in 2013 to help developers understand and select an open source license. The license descriptions and metadata are also open source and developers can incorporate them into their own projects using GithUb&#8217;s <a href="https://developer.github.com/v3/licenses/#get-an-individual-license" target="_blank">License API</a>.</p>\n<p>This new feature follows GitHub&#8217;s release of <a href="https://opensource.guide/" target="_blank">Open Source Guides</a> in February. The guides are a collection of 10 resources to help people get involved in open source, start their own open source projects, and manage large communities. The documents include helpful stories and tips from maintainers of successful open source projects.</p>\n<p>It was around this time last year that GitHub was <a href="https://wptavern.com/open-source-project-maintainers-confront-github-with-open-letter-on-issue-management" target="_blank">confronted by open source project maintainers with an open letter</a> of complaints regarding issue management. Nearly 2,000 maintainers signed the letter, requesting that GitHub prioritize features that open source project maintainers need. The company dragged its feet before eventually responding, while competing code hosting service GitLab capitalized on the situation with a new initiative focused on “<a href="https://gitlab.com/gitlab-org/gitlab-ce/issues/8938" target="_blank">making GitLab the best place for big open source projects</a>.” Over the past year, GitHub has consistently released new features and improved existing ones in affirmation of its continued support for open source projects.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 18 Mar 2017 03:03:24 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"WPTavern: In Case You Missed It – Issue 19";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:58:"https://wptavern.com?p=67590&preview=true&preview_id=67590";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"https://wptavern.com/in-case-you-missed-it-issue-19";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5660:"<a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2016/01/ICYMIFeaturedImage.png?ssl=1" rel="attachment wp-att-50955"><img /></a>photo credit: <a href="http://www.flickr.com/photos/112901923@N07/16153818039">Night Moves</a> &#8211; <a href="https://creativecommons.org/licenses/by-nc/2.0/">(license)</a>\n<p>There’s a lot of great WordPress content published in the community but not all of it is featured on the Tavern. This post is an assortment of items related to WordPress that caught my eye but didn’t make it into a full post.</p>\n<h2>Apple Pay for WooCommerce</h2>\n<p>WooCommerce <a href="https://woocommerce.com/2017/03/apple-pay-woocommerce/">announced</a> that Apple Pay is now available for stores accepting payments using Stripe. According to Marina Pape, WooCommerce is the first open source platform to integrate with Apple Pay.</p>\n<blockquote><p>We’re also proud to be the first open source platform to integrate with Apple Pay. Open source is the default for us, but it’s exciting to continue that level of openness with such an important payment solution.</p></blockquote>\n<h2>Human Made Makes Two Big Hires</h2>\n<p><a href="https://hmn.md/">Human Made</a>, a web development agency based in the UK recently announced two big hires. The first is <a href="https://hmn.md/2017/03/16/mike-little-joins-human-made/">Mike Little</a>, co-creator of the WordPress open source project, as a WordPress Specialist. The second is <a href="https://hmn.md/2017/03/17/jenny-beaumont-joins-human-made/">Jenny Beaumont</a>, who will take on the role of Senior Project Manager.</p>\n<h2>Editor User Experience Survey</h2>\n<p>The WordPress core development team has <a href="https://make.wordpress.org/core/2017/03/15/editor-experience-survey/">published a survey</a> seeking feedback and data on how people use the editor. The editor is likely the most commonly used feature in WordPress. This is an opportunity for those who use it to provide feedback.</p>\n<blockquote class="wp-embedded-content"><p><a href="https://make.wordpress.org/core/2017/03/15/editor-experience-survey/">Editor Experience Survey</a></p></blockquote>\n<p></p>\n<h2>Behind the Scenes of how Search works on the New WordPress Plugin Directory</h2>\n<p>Greg Brown <a href="https://data.blog/2017/03/15/improving-relevance-and-elasticsearch-query-patterns/">published details</a> on Data.blog on how he improved the search relevancy for the new WordPress plugin directory using Elasticsearch. The post is technical in nature but provides great background information into how it works.</p>\n<blockquote><p>In improving the fidelity of search results, it’s not just a question of how we satisfy a single user’s search query, but how we satisfy thousands of users for each unique search term: which plugins will support that volume of users and their requests for support? Which are most likely to give all of these users a great WordPress experience?</p></blockquote>\n<h1 class="entry-title">NextGEN Gallery Surpasses 17 Million Downloads</h1>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">NextGEN Gallery just reached over 17 million downloads. <a href="https://twitter.com/hashtag/WordPress?src=hash">#WordPress</a></p>\n<p>&mdash; Imagely (@imagely) <a href="https://twitter.com/imagely/status/842532503265185792">March 17, 2017</a></p></blockquote>\n<p></p>\n<h2>MainWP Reaches 1K Five-star Reviews</h2>\n<p>After three years of being on the <a href="https://wordpress.org/support/plugin/mainwp/reviews/?filter=5">WordPress plugin directory</a>, the MainWP plugin has received <a href="https://mainwp.com/mainwp-reaches-1000-5-star-reviews/">1,000 five-star reviews</a>.</p>\n<h2>Heather Burns HeroPress Essay</h2>\n<p>Heather Burns, founder of <a href="https://webdevlaw.uk/">WebDevLaw</a>, published an <a href="https://heropress.com/essays/going-back-roots/?utm_source=twitter&utm_medium=hand-made&utm_term=going-back-roots&utm_content=first-tweet">incredible essay</a> on HeroPress this week. Burns describes the hardships encountered with her first job and how it and other circumstances led her down the path of discovering WordPress.</p>\n<blockquote><p>By this point I’d started playing around with WordPress, and I learned about a local meetup group. I tiptoed in one night and awkwardly introduced myself and was welcomed right in.</p>\n<p>I realized over time that this was a very different sort of group. Everyone was grassroots volunteers, putting in the effort because they wanted to learn, not because they wanted social status. There was no tiresome hierarchy, no obsession with &#8216;prestige&#8217;, no kowtowing to the person with the sexiest car (in fact, we all took the bus.) If you had a question, you could ask it without being laughed out the room. No one was obliged to give anything more than they were able to give.</p></blockquote>\n<h2>HeroPress Wapuu!</h2>\n<p>In what is a traditional part of this series, I end each issue by featuring a Wapuu design. For those who don&#8217;t know, Wapuu is the <a href="http://wapuu.jp/2015/12/12/wapuu-origins/">unofficial mascot</a> of the WordPress project.</p>\n<img />HeroPress Wapuu\n<p>&nbsp;</p>\n<p>I present HeroPress Wapuu in celebration of HeroPress recently publishing <a href="https://heropress.com/heropress-at-100/">its 100th essay. </a>If you&#8217;re a fan of HeroPress and want to see it flourish, please consider <a href="https://heropress.com/sponsorship/">being a sponsor</a>.</p>\n<p>That&#8217;s it for issue nineteen. If you recently discovered a cool resource or post related to WordPress, please share it with us in the comments.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 17 Mar 2017 21:52:21 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"WPTavern: Take the WordPress Editor Experience Survey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67499";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"https://wptavern.com/take-the-wordpress-editor-experience-survey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2410:"<a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/two-pencils.jpg?ssl=1"><img /></a>photo credit: <a href="https://stocksnap.io/photo/TBLSDTI1UL">Joanna Kosinska</a>\n<p>WordPress core contributors have published a <a href="http://wordpressdotorg.polldaddy.com/s/editor-survey" target="_blank">survey</a> to collect feedback on how people are using the editor. The results of the short 15-question survey will assist the team in redesigning the editing experience in the WordPress admin.</p>\n<p>Participants are asked to identify how they use WordPress and if they use certain features like formatting buttons and distraction-free writing. The survey also asks how easy-to-use they consider the current editor to be and how organized it is. Users are also asked if they have ever installed a plugin that adds features to the editor, presumably to determine if there are features missing that should be considered for core.</p>\n<p>One question asks participants if they use any assistive technologies along with a screen reader. WordPress Accessibility team member Amanda Rush <a href="https://www.customerservant.com/wordpress-editor-experience-survey/" target="_blank">published some tips for screen reader users who want to take the survey</a>. It includes several questions with radio buttons and screenshots that are not so friendly to screen readers. Rush provides a general walk-through with more explanation for those who are using screen readers to participate.</p>\n<p>So far, this survey has been more widely shared than the design team&#8217;s recent customizer survey, which was <a href="https://wptavern.com/initial-customizer-survey-results-reveal-majority-of-respondents-dont-use-it" target="_blank">published after receiving just 50 results</a>. WordPress contributors rely heavily on these surveys to make decisions about projects they are working on, as they do not have any telemetry data about what features people are using or not using. This is one example where data could quickly demonstrate how widely the distraction-free writing mode has been adopted and show what editor formatting buttons people are using.</p>\n<p>If you have a few minutes over the weekend and want to contribute to the future of WordPress, take the <a href="http://wordpressdotorg.polldaddy.com/s/editor-survey" target="_blank">Editor Experience Survey</a>.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 17 Mar 2017 21:01:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:67:"WPTavern: How to View Upcoming WordCamps in the WordPress Dashboard";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67572";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:78:"https://wptavern.com/how-to-view-upcoming-wordcamps-in-the-wordpress-dashboard";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2067:"<p>Over the course of a year, WordCamps take place nearly every weekend. Although you can view <a href="https://central.wordcamp.org/schedule/">upcoming events</a> on WordCamp Central, a relatively new plugin exist that enables you to see upcoming WordCamps on the WordPress Dashboard.</p>\n<p>It&#8217;s called <a href="https://wordpress.org/plugins/wc-dashboard-widget/">WordCamp Dashboard Widget</a> developed by <a href="https://profiles.wordpress.org/ajitbohra/">Ajit Bohra</a>. Once activated, a new widget appears on the dashboard that lists upcoming WordCamps. Data is retrieved by using the public <a href="https://central.wordcamp.org/wp-json/posts?type=wordcamp%29">JSON API</a> available on WordCamp Central, is stored in a transient, and refreshed every day to reflect new data.</p>\n<img />Upcoming WordCamps Widget\n<p>Users can adjust the number of camps shown per page, sort events by location, date, or Twitter information. You can also display this information on any post or page using the [wordcamps] shortcode. The locations are linked to the event&#8217;s official WordCamp page. The @ symbol links to the official Twitter account associated with the event and the # symbol links to the official hashtag.</p>\n<p>During testing I noticed that the Twitter account for some events was either missing or incorrect. For example, WordCamp London links to <a href="https://twitter.com/wcldn">@wcldn</a> when it should link to <a href="https://twitter.com/WordCampLondon">@WordCampLondon</a>. I&#8217;m not a fan of the way dates are presented in a Day/Month/Year format as I prefer Month/Day/Year.</p>\n<p>Bohra is continuing to improve the plugin with an option to refresh data, improve data fetching, and more filtering options for 1.0. I tested the plugin on a site running WordPress 4.8 alpha and didn&#8217;t encounter any issues. If you encounter a bug or have feedback, you can submit a new issue on the <a href="https://github.com/lubusIN/wordcamp-dashboard-widget/issues">project&#8217;s GitHub page. </a></p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 17 Mar 2017 20:09:37 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:131:"WPTavern: Jetpack Introduces Theme Installation from WordPress.com, Sparks Controversy with Alternative Marketplace for Free Themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67531";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:141:"https://wptavern.com/jetpack-introduces-theme-installation-from-wordpress-com-sparks-controversy-with-alternative-marketplace-for-free-themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:12403:"<p>Today Jetpack <a href="https://jetpack.com/2017/03/16/165-beautiful-free-themes/" target="_blank">announced</a> that its users now have access to a collection of 165 free themes from WordPress.com. Jetpack users can browse, preview, and activate themes by visiting the <a href="https://wordpress.com/design" target="_blank">WordPress.com Theme Showcase</a>. WordPress.com has also added the ability for Jetpack users to upload a theme from its interface as well, a feature that targets those who are heavily using Jetpack Manage instead of the WordPress admin.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/jetpack-theme-install.png?ssl=1"><img /></a></p>\n<p>Many of the free themes are already available from <a href="https://wordpress.org/themes/author/automattic/" target="_blank">Automattic&#8217;s account</a> on the WordPress.org Themes Directory, but the limitations of the preview functionality doesn&#8217;t present themes in their best light. The Theme Review Team added a new rule last year that theme authors can only upload one theme at a time and will have to wait for it to pass through the queue before submitting another. This severely restricts individuals and companies that are prolific theme authors, requiring them to wait months in the queue. Authors can realistically expect to only publish one or two themes per year on WordPress.org.</p>\n<p>After Zerif Lite, one of the most popular themes on WordPress.org, was <a href="https://wptavern.com/zerif-lite-returns-to-wordpress-org-after-5-month-suspension-and-63-decline-in-revenue" target="_blank">suspended for five months</a> for violations of content portability requirements, Matt Mullenweg was one of the most vocal opponents of what he <a href="https://wptavern.com/zerif-lite-returns-to-wordpress-org-after-5-month-suspension-and-63-decline-in-revenue#comment-210935" target="_blank">called</a> &#8220;draconian requirements.&#8221; In 2015, Mullenweg went so far to <a href="https://wordpress.slack.com/archives/themereview/p1432861605003292" target="_blank">say</a> that he is &#8220;completely okay with having something in the directory that breaks every guideline, as long as it’s interesting.&#8221;</p>\n<p>The Theme Review Team has not made significant changes that would give authors more freedom. Instead, much of the Team&#8217;s time seems to be spent looking for ways to reduce the queue. It&#8217;s no wonder that a company like Automattic, with the infrastructure of Jetpack Manage and WordPress.com, would choose to distribute themes via a more efficient route. However, this move has left some WordPress.org theme authors wondering if WordPress.org improvements will be less of a priority in the future.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Can you blame him? No. They (he?) needs to wrangle in the experience, avoid fragmentation, compete with other consumer hosted platforms.</p>\n<p>&mdash; Matt Medeiros (@mattmedeiros) <a href="https://twitter.com/mattmedeiros/status/842406199551221760">March 16, 2017</a></p></blockquote>\n<p></p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">But what does it all mean for us surviving off of the .org distribution? Tough cookies, that''s what.</p>\n<p>&mdash; Matt Medeiros (@mattmedeiros) <a href="https://twitter.com/mattmedeiros/status/842406347324948481">March 16, 2017</a></p></blockquote>\n<p></p>\n<p>&#8220;Today&#8217;s announcement is the glue that holds together Matt&#8217;s vision for the future .org experience, delivered via Jetpack,&#8221; WordPress.org theme author <a href="http://mattreport.com" target="_blank">Matt Medeiros</a> said. &#8220;Solving the dark cloud above the repo seems a lot less critical when we can throw Jetpack in front of users as an alternative. It&#8217;s a calculated measure to control the on-boarding experience of new users, which WP desperately needs for continued growth amidst a field of competitors like Wix and Squarespace.&#8221;</p>\n<p>According to Jetpack team member Richard Muscat, WordPress.com has &#8220;no immediate plans to sell themes at this time.&#8221; Jetpack users have access to free themes but will not, in the foreseeable future, be invited to purchase WordPress.com&#8217;s commercial themes. The team also plans to continue its presence on WordPress.org.</p>\n<p>&#8220;We have no plans to stop releasing themes into the .org directory,&#8221; Muscat said. &#8220;We just believe this makes an even nicer, more integrated experience for accessing the themes we offer on the WordPress.com side of things.&#8221;</p>\n<p>Jetpack&#8217;s announcement has also reignited fears of what the plugin&#8217;s commercialization might do to the WordPress ecosystem. In the past, Mullenweg has <a href="https://wptavern.com/woocommerce-powers-42-of-all-online-stores" target="_blank">identified both Jetpack and WooCommerce as &#8220;multi-billion dollar opportunities&#8221;</a> that could each individually be larger than WordPress.com. If WordPress.org is failing to attract new users with its theme previews, then Jetpack/WordPress.com is likely to pull even more eyes away with its separate marketplace.</p>\n<p>&#8220;As a small business (a label that&#8217;s critical) product creator, I see this as a motion in the direction to increase the visibility of Jetpack&#8217;s free/paid feature set, above the rest of us trying to desperately make a living out here,&#8221; Medeiros said. &#8220;Jetpack will be marketed as the one-stop-solution for all of your small business website needs, if that hasn&#8217;t already been woven into the fabric of it&#8217;s current messaging. It is ultimately positioning itself as the trusted source of functionality for new users, versus us &#8216;third-party&#8217; plugins. After all, who wouldn&#8217;t trust the company &#8216;behind WordPress?''&#8221;</p>\n<p>Ionut Neagu, CEO at <a href="https://themeisle.com/" target="_blank">Themeisle.com</a>, and the author of Zerif Lite, shares Medeiros&#8217; concerns about Jetpack&#8217;s more recent commercialization efforts.</p>\n<p>“What worries me more is the speed at which Automattic is pushing Jetpack,&#8221; Neagu said. &#8220;The Personal plan was introduced, and yesterday I got a cold email from some company they work with promoting their affiliate program. Today themes were introduced. It makes me wonder how far they plan to go and how this will affect theme and plugin developers.&#8221;</p>\n<p>However, Neagu takes a more optimistic stance on self-hosted users installing themes from WordPress.com.</p>\n<p>&#8220;As a theme author, I am not that worried about this particular aspect. Right now those themes are quite hard to find (it took me 10 minutes), are more targeted towards people using Jetpack Manage, and as far as I can see lots of them are looking a bit outdated.&#8221;</p>\n<p>Neagu sees a disconnect between what WordPress.org thinks users want and what they are actually looking for. Based on his research and experience selling themes, Neagu has found that users still expect complete solutions from themes. WordPress has grown beyond being just a blogging platform. Neagu said he hopes WordPress.org&#8217;s research for the new editor will reveal how many people are actually using the software for business.</p>\n<p>&#8220;We run a themes directory as well and we did extensive heatmaps to understand what kind of themes/screenshots users click on/ like,&#8221; Neagu said. &#8220;Looking at the results of a &#8216;business&#8217; query, I am quite sure that users won’t be excited.&#8221;</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/business-themes.png?ssl=1"><img /></a></p>\n<p>This is likely the first iteration, and data from more Jetpack users should help WordPress.com refine the queries to present a mix of newer and popular themes. At the moment it looks to be simply a way to offer all of their available themes without the red tape of WordPress.org.</p>\n<h3>Automattic Addresses Confusion Over WordPress.org Plugin Directory Guideline Regarding Executable Code and Installs</h3>\n<p>The news of WordPress.com installing and updating themes for Jetpack users gave rise to speculation about whether or not this move is a violation of the <a href="https://developer.wordpress.org/plugins/wordpress-org/detailed-plugin-guidelines/" target="_blank">plugin directory guidelines</a>. Discussions centered around guideline #8, which states that plugins may not send executable code via third-party systems:</p>\n<blockquote><p>Serving updates or otherwise installing plugins, themes, or add-ons from servers other than WordPress.org’s.</p></blockquote>\n<p>Jetpack representative Richard Muscat gave us the following statement on behalf of Automattic:</p>\n<blockquote><p>The guidelines prohibit _plugins_ from installing third party code directly but Jetpack doesn’t do that for this feature. The guidelines state that: “Executing outside code within a plugin *when not acting as a service* is not allowed.”</p>\n<p>The service Jetpack provides with respect to themes is via WordPress.com which _is_ acting as a service. This is identical to how Akismet operates with respect to spam-filtering and other Jetpack services such as data sync and backup, content delivery (Photon), and plugin installation/updates.</p>\n<p>We ask users to opt-in to WordPress.com services when connecting Jetpack and all our services follow established guidelines.</p></blockquote>\n<p>The public discussions also prompted WordPress.org Plugin Directory representatives to <a href="https://make.wordpress.org/plugins/2017/03/16/clarification-of-guideline-8-executable-code-and-installs/" target="_blank">post</a> an article clarifying that Jetpack is not in violation for installing themes.</p>\n<p>&#8220;The trick here, and this is what is about to sound like hair splitting, is that it’s not the plugin UI on your site that does the install,&#8221; Mika Epstein said. &#8220;In order for Manage WP and Jetpack to work, you have to go to your panel on their sites and install the items.&#8221;</p>\n<p>As SaaS products have not yet been used extensively in the WordPress ecosystem, developers are still figuring out how this type of implementation can interact with WordPress sites via plugins installed from the official directory. The plugin team clarified that if you are pushing plugin or theme installs or updates from a third-party service on its website, then it is no longer a third-party service but rather a first-party service where you are directly initiating those actions.</p>\n<p>However, not all developers agree that this distinction makes any difference.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr"><a href="https://twitter.com/daljo628">@daljo628</a> <a href="https://twitter.com/TheJeffMatson">@thejeffmatson</a> <a href="https://twitter.com/williamsba">@williamsba</a> <a href="https://twitter.com/chriswallace">@chriswallace</a> <a href="https://twitter.com/mattmedeiros">@mattmedeiros</a> Saying SaaS can install plugins but plugin cannot install plugins is silly.</p>\n<p>&mdash; Carl Hancock <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f680.png" alt="🚀" class="wp-smiley" /> (@carlhancock) <a href="https://twitter.com/carlhancock/status/842485294863712256">March 16, 2017</a></p></blockquote>\n<p></p>\n<p>Gravity Forms founder Carl Hancock contends that ManageWP is different in that it doesn&#8217;t provide users with themes and plugins &#8211; it&#8217;s just a service for managing your sites.</p>\n<p>&#8220;You can install plugins from the WordPress.org plugin and theme repository, you can connect your Dropbox account and install plugins from your Dropbox account, or you can upload your own plugins,&#8221; Hancock said. &#8220;The key is it’s either plugins and themes from WordPress.org OR bring your own. Just like WordPress itself.</p>\n<p>&#8220;They [ManageWP] do not provide an alternative repository of themes and/or plugins that competes with the WordPress.org repos.&#8221;</p>\n<p>This is where much of the controversy lies for WordPress.org theme authors who depend on the official directory for distribution. Competing with equally free themes that are hosted on WordPress.com with a much better sorting UI and preview functionality is a new challenge they will have to embrace.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 17 Mar 2017 00:08:20 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:123:"WPTavern: U.S. Department of Defense Launches Code.mil Open Source Initiative, First Release Tests Impact of AGPL Licensing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67451";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:132:"https://wptavern.com/u-s-department-of-defense-launches-code-mil-open-source-initiative-first-release-tests-impact-of-agpl-licensing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:7190:"<a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/department-of-defense.jpg?ssl=1"><img /></a>A U.S. Air Force F-15E Strike Eagle aircraft flies over northern Iraq Sept. 23, 2014, after conducting airstrikes in Syria. &#8211; photo credit: <a href="https://www.flickr.com/photos/39955793@N07/15172530147/">U.S. Department of Defense</a>\n<p>The U.S. Department of Defense (DoD) is <a href="https://www.defense.gov/News/News-Releases/News-Release-View/Article/1092364/dod-announces-the-launch-of-codemil-an-experiment-in-open-source" target="_blank">experimenting with open sourcing more of its code</a> on GitHub. <a href="http://Code.mil" target="_blank">Code.mil</a> invites developers from around the world to collaborate with federal employees on unclassified code. The Defense Digital Service (DDS), which brings in experts from top technology companies like Google, Amazon, and Netflix for short assignments, is organizing the initiative to open source more government code.</p>\n<p>&#8220;Open source and free software (which refers to software freedom, not free of cost) are industry best practices and integral parts of modern software development,&#8221; the department said in a <a href="https://www.defense.gov/News/News-Releases/News-Release-View/Article/1092364/dod-announces-the-launch-of-codemil-an-experiment-in-open-source" target="_blank">statement</a> announcing the initiative. &#8220;They, however, are concepts yet to be widely adopted within the department. With Code.mil, DoD can access a depth and breadth of technical skill previously underutilized while offering software tools created by the government for free public use.&#8221;</p>\n<p>The FAQ document for the initiative states that &#8220;modern software is open sourced software&#8221; and that the department is aiming to more actively participate in the open source and free software communities.</p>\n<p>Licensing is one of the unique challenges of making government code open source, as code written by federal employees is not protected by copyright under U.S. laws. After consulting the Open Source Initiative and Free Software Foundation, the DoD devised an open source licensing strategy where code written by federal employees will fall under the public domain with no restrictions. DDS developed a GitHub webhook to ensure commits from government employees follow the <a href="https://developercertificate.org/" target="_blank">Developer Certificate of Origin</a> process. Private sector contributions will be protected by standard OSS licenses. This is outlined in the <a href="https://github.com/deptofdefense/code.mil/blob/master/Proposal/INTENT.md" target="_blank">INTENT.md</a> document on the Code.mil repository.</p>\n<h3>Code.mil&#8217;s First Open Source Project Released Under AGPL to &#8220;Test GPL as an Approach&#8221;</h3>\n<p>In addressing one person&#8217;s <a href="https://github.com/deptofdefense/code.mil/issues/19#issuecomment-282333798" target="_blank">feedback</a> advocating for all Code.mil projects to be MIT-licensed, DDS engineer Tom Bereknyei confirmed that the team will leave this decision to each project&#8217;s leadership.</p>\n<p>&#8220;We&#8217;ve had these same discussions internally,&#8221; Bereknyei said. &#8220;We did not want to endorse a particular license and we intend each project to decide which license is appropriate for them. Some may choose MIT, BSD, Apache, or eventually GPL. We did not want to take that choice away from them.&#8221;</p>\n<p><a href="https://github.com/deptofdefense/eMCM" target="_blank">eMCM</a>, a web-based viewer for the Manual for Courts-Martial (MCM), is the first open source project to be released on Code.mil. It provides a canonical &#8220;live&#8221; edition of the manual that is easier to access and maintain than previous versions. eMCM was released this week under the AGPL license.</p>\n<p>&#8220;We chose to use the Affero General Public License (AGPL) for the eMCM because every military member has the right to know how the raw legal code (i.e., MCM) will be transformed or manipulated by the eMCM,&#8221; the Defense Digital Service stated in the <a href="https://medium.com/@DefenseDigitalService/code-mil-an-open-source-initiative-at-the-pentagon-5ae4986b79bc#.f9bw1s2ha" target="_blank">announcement</a>. &#8220;Applying the AGPL is a small but important way to help ensure the public has that freedom and transparency to the process.&#8221;</p>\n<p>In the pull-request for <a href="https://github.com/deptofdefense/eMCM/pull/5" target="_blank">updating the license on the project</a>, Bereknyei explained why he proposed the AGPL:</p>\n<blockquote><p>It&#8217;s a user-facing project, not a library. Ultimately it would be good to preserve the rights of the public to inspect how the raw MCM is transformed by the viewer.</p>\n<p>Among the projects we have, this seems to be the best candidate for a GPL test. It is fairly self contained, doesn&#8217;t integrate with any systems, front-end heavy, small enough that a corporate rewrite is easy, and uses only a few libraries. My goal is only to test GPL as an approach. If this project isn&#8217;t suited, I&#8217;m sure we can find another.</p></blockquote>\n<p>When Bereknyei was questioned by DDS colleague Nicholas Small about why he opted for AGPL over MIT, he said he wanted to protect the code from being redistributed as closed-source.</p>\n<p>&#8220;MIT would allow someone to fork, improve, and release closed-source,&#8221; Bereknyei said. &#8220;The rule of thumb I am trying to apply is that when the rights/convenience for developers are more important, go with MIT/BSD/ISC. When the rights/convenience for users are more important, go with GPL.&#8221;</p>\n<p>Historically, the DoD has <a href="http://dodcio.defense.gov/Open-Source-Software-FAQ/#Q:_When_a_DoD_contractor_is_developing_a_new_system.2Fsoftware_as_a_deliverable_in_a_typical_DoD_contract.2C_is_it_possible_to_use_existing_software_licensed_using_the_GNU_General_Public_License_.28GPL.29.3F_Can_the_DoD_used_GPL-licensed_software.3F" target="_blank">used GPL-licensed software extensively</a> and even <a href="http://dodcio.defense.gov/Open-Source-Software-FAQ/#Q:_What_license_should_the_government_or_contractor_choose.2Fselect_when_releasing_open_source_software.3F" target="_blank">recommends government contractors select a GPL-compatible license</a> when developing software as a deliverable in DoD contracts.</p>\n<p>One beneficial byproduct of the DoD&#8217;s initiative to open source more code is that the public can watch and participate as federal employees discuss license selection in the open. The department is finally recognizing that taxpayer-funded code is a public good and inviting private sector professionals to the table to build modern software together. Anyone can open an issue or pull request, regardless of their background, location, or formal qualifications. The DoD plans to expand <a href="https://github.com/deptofdefense/code.mil" target="_blank">Code.mil</a> to include projects from other DoD offices and may develop it into a full-fledged website instead of simply redirecting to GitHub.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 16 Mar 2017 04:50:43 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:97:"WPTavern: WPWeekly Episode 267 – Interview With Aaron D. Campbell, WordPress Security Team Lead";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:58:"https://wptavern.com?p=67502&preview=true&preview_id=67502";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:102:"https://wptavern.com/wpweekly-episode-267-interview-with-aaron-d-campbell-wordpress-security-team-lead";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2376:"<p>In this episode, <a href="http://marcuscouch.com/">Marcus Couch</a> and I are joined by <a href="https://aarondcampbell.com/">Aaron D. Campbell</a>, WordPress Security Team Lead. Campbell provides insight into who&#8217;s on the team and what they do behind the scenes to coordinate security releases. We discuss the complex nature of <a href="https://aarondcampbell.com/tag/disclosure/">disclosures</a>, when to publish them, and how much information they should have.</p>\n<p>In light of <a href="https://wordpress.org/news/2017/01/wordpress-4-7-2-security-release/">WordPress 4.7.2</a>, Campbell shares the lessons he learned and how they&#8217;ll be applied to future releases. If you&#8217;ve ever wondered about the security aspects of WordPress, this is the episode for you.</p>\n<h2>Stories Discussed:</h2>\n<p><a href="https://wptavern.com/woocommerce-3-0-0-scheduled-for-release-april-4th">WooCommerce 3.0.0 Scheduled for Release April 4th</a></p>\n<h2>Plugins Picked By Marcus:</h2>\n<p><a href="https://wordpress.org/plugins/fb-live-chat/">Facebook Live Chat for WordPress</a> makes it easier for customers to connect with businesses via Facebook Messenger.</p>\n<p><a href="https://wordpress.org/plugins/cf7-database/">Contact Form 7 Database</a> saves submissions from Contact Form 7 to the database for future reference. You can also view them in the WordPress backend.</p>\n<p><a href="https://wordpress.org/plugins/total-spent-by-customer-for-woocommerce/">Total Spent by Customer for WooCommerce</a> adds a sortable column to the users list to show how much the user spent on your WooCommerce Store. This is useful to figure out who your top customers are.</p>\n<h2>WPWeekly Meta:</h2>\n<p><strong>Next Episode:</strong> Wednesday, March 22nd 3:00 P.M. Eastern</p>\n<p><strong>Subscribe To WPWeekly Via Itunes: </strong><a href="https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via RSS: </strong><a href="https://wptavern.com/feed/podcast" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via Stitcher Radio: </strong><a href="http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr" target="_blank">Click here to subscribe</a></p>\n<p><strong>Listen To Episode #267:</strong><br />\n</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 15 Mar 2017 22:36:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"HeroPress: Going Back To My Roots";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:56:"https://heropress.com/?post_type=heropress-essays&p=1650";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"https://heropress.com/essays/going-back-roots/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:16907:"<img width="960" height="480" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/031517-1024x512.jpg" class="attachment-large size-large wp-post-image" alt="Pull Quote: Thanks to the WordPress Community, I''ve made friends for life, travelled to new places, and had adventures I never thought possible," /><p>“Get out there and look at that f****n car. <em>Look at that f****n car!</em>”</p>\n<p>And all of the good little office girls jumped up and ran outside to ogle and coo over the chairman’s latest “prestige motor.”</p>\n<p>Me being me – someone who couldn’t care less about cars, or massaging the needy egos of the men who feel a need to show them off – I stayed sat at my desk and carried on with my work.</p>\n<p>My absence outside would be noted, and would not do me any favours.</p>\n<p>I had taken a job at a local business support organisation because I needed the work. I’d been told that my experience and abilities could benefit the organisation and, by extension, the local business community. The joke was on me.</p>\n<p>In truth, the organisation was a back-slapping boys&#8217; club which didn&#8217;t even have a business plan. Its main income source was, and remains to this day, the revenue from a vanity awards dinner, where members nominate themselves for meaningless awards and then pay thousands of pounds to find out if they won. Beyond that, its sole purpose was to provide the board and management with &#8220;prestige and status&#8221; (my manager&#8217;s words, not mine.) The office atmosphere was so toxic that the HR manager, faking every excuse in the book, hadn&#8217;t bothered to show up in months, which meant that I never saw a job description, had a performance review, or was signed up for the company pension; in fact, the only way I got a contract was by going in on a Saturday to type it up myself. It was all pretty ironic for an organisation which officially exists to support other businesses.</p>\n<p>But bills need to be paid, so I kept my head down and did my work and breathed deeply through the increasingly dysfunctional dramas of the board and management.</p>\n<blockquote><p>Believing that you can keep calm and avoid office politics in a dysfunctional workplace is a unique form of denial.</p></blockquote>\n<p>By showing up for work in the morning, observing the backstabbing behavior around you, and keeping your nose above the parapet, you make yourself easy pickings.</p>\n<p>It did not help that my job required me to read certain documents, pass on certain email exchanges, see certain expense receipts, and take minutes at certain meetings. I knew everything. I knew what everyone was up to. I knew too much.</p>\n<p>The things I knew too much about erupted violently in the space of a fortnight. Sackings, retaliatory sackings, accusations, slanders, backstabs, screaming, lies, people literally being escorted out the back door, people breaking into file cabinets and document storage, the whole ugly lot.</p>\n<p>I decided life was too short to put up with that nonsense and scurried off the sinking ship. Unemployment was preferable to working in a dysfunctional war zone.</p>\n<p>A few days later I was sitting in my living room in my pajamas (as unemployed people do), staring blankly at the Christmas tree, barely aware if it was day or night, my head still spinning about what had just happened and what I was going to do next. Then there was a knock at the door. The postman, I assumed.</p>\n<p>No, it was the police. They wanted to come in. So they did.</p>\n<p>Allegations had been made. Statements had been taken. Criminal charges would be filed.</p>\n<p>Against me.</p>\n<p>Merry Christmas.</p>\n<p>Merry Christmas to you too, I replied as I saw them out.</p>\n<p>Because that’s how office politics work, folks. You don&#8217;t walk away from egomaniacs on your own terms. That implies there is something wrong with them. They have to take you down on their own terms. That implies there is something wrong with you. You may think you have left the backstabbers to get on with their petty games without you taking the meeting minutes and processing the strip club expense receipts. You&#8217;re wrong. They have got to find a way to take you down and make you keep your mouth shut. And they will.</p>\n<h3>Moving On</h3>\n<p>I moved on with my life. I found a stable temp job which had the option to go permanent, and I was quite content with it. I even almost forgot about the police visit. The Scottish justice system, you see, is notoriously slow. So when a letter arrived four months later informing me that I would be standing in a criminal trial at the local sheriff court, I threw up.</p>\n<p>I was throwing up all the time at that point because I had just found out I was pregnant.</p>\n<p>Most women spend pregnancy in a dreamy haze surrounded by friends, family, and affection. I spent it taking unpaid breaks from my temp jobs to meet with a legal aid solicitor (being unemployed and on a temp wage, I couldn’t afford to pay a lawyer) to plan my defence. He was nice enough, but was clearly not sure what to make of the whole situation. He was used to dealing with actual crimes – stabbings, domestic assaults, and the like. And there was a five foot two pregnant lady in front of him explaining all the plot twists and characters in this pathetic real-life soap opera. He probably looked forward to getting back to the stabbings.</p>\n<p>In the meantime, for health and safety reasons, I had to inform my temp employer about the pregnancy. The permanent job offer evaporated instantly.</p>\n<blockquote><p>I spent the rest of my time taking whatever demeaning temp admin jobs a heavily pregnant woman could get in order to work the minimum number of days required to qualify for the basic state maternity allowance, which at the time was £106 a week for six months.</p></blockquote>\n<p>Suffice to say my dignity took a bit of a beating that year.</p>\n<p>By the time the date of preliminary hearing rolled around – again, the Scottish justice system being as slow as it is – I was on the edge of my third trimester. And so there I was, standing alone in the dock in a criminal courtroom, in sheriff court, next to drug dealers and knife thugs, wearing a hideous Marks and Spencer maternity dress, to plead not guilty to something that had never happened.</p>\n<p>All of that because of office politics.</p>\n<p>Now, the thing about legal aid is that you get what you pay for. My solicitor didn’t show up. He faxed an instruction to one of the solicitors at the sheriff court who acts on behalf of others in those matters. In hindsight, this was a strategy to suggest to the court that the case was so stupid it was not worth showing up for. On the day, though, I was completely, totally, alone, left to stand up and speak for myself.</p>\n<blockquote><p>The only person I had in the world to support me was kicking furiously in my stomach, as if to say: go, mum, go.</p></blockquote>\n<p>At that moment I had an insight. This, I realised, is it. This is the low point of my life. This is absolute rock bottom. It does not get any worse than this. From here, you can’t go any lower. It is only up from here. And that, standing there in that dock, was strangely liberating.</p>\n<p>Now here’s the thing about elderly male judges in curly 18th century wigs. They’re not stupid. He took one look at the charge sheet, one look at the folder of statements and evidence against me, and one look at me. He asked the befuddled prosecuting solicitor what on earth was going on here; the solicitor replied that they were looking to gather more evidence against me. “And how much longer are we to wait for that? This was ten months ago,” he replied to her, very, very cross. This is all very interesting, I thought.</p>\n<p>Two days later my solicitor phoned: the judge had ruled the case was “not in the public interest.” That is Scottish legal parlance for “an absolute load of crap.” All charges were dropped; I would have no criminal record; I was done. I was finished. I was free.</p>\n<p>Well, free, unemployed, heavily pregnant, destitute, my reputation had been destroyed, and now I had a large hole in my CV which would be awfully difficult to explain. Other than that, I was fine.</p>\n<h3>Moving On Again</h3>\n<p>I went on state maternity pay early and took some time to get my head back together. That gave me the breathing space to realise a few things.</p>\n<p>One was that I was done with office life. That meant I would have to find something to do on my own.</p>\n<p>Two was that I was pretty good with this web stuff – I’d been making web sites since 1997, had been running a very popular web site since 1998, and had always been the go-to girl for the web site in everywhere I’d ever worked – and so I might as well do that for a living.</p>\n<p>And three was that I had learned the law is bloody terrifying if you let other people blindside you with it. If you know what you are looking at, where you stand within it, and how others are seeking to use it to further their position, you are no longer a hapless bystander to it. You are an equal participant with a fair chance. That is your choice to make.</p>\n<h3>Setting Up Shop</h3>\n<p>So I set up shop as a self-employed web designer, working quite happily from home with my biggest fan babbling next to me in the playpen. The money wasn’t great, but my stress levels were non-existent, and I had no co-workers to stab me in the back.</p>\n<p>Lack of co-workers should never mean lack of colleagues, though, and after a few years I realised local business networking groups simply weren’t for me. I also needed people other than the members of an ancient listserv to bounce questions and ideas off of in real-time. By this point I’d started playing around with WordPress, and I learned about a local meetup group. I tiptoed in one night and awkwardly introduced myself and was welcomed right in.</p>\n<p>I realised over time that this was a very different sort of group. Everyone was grassroots volunteers, putting in the effort because they wanted to learn, not because they wanted social status. There was no tiresome hierarchy, no obsession with “prestige”, no kowtowing to the person with the sexiest car (in fact, we all took the bus.) If you had a question, you could ask it without being laughed out the room. No one was obliged to give anything more than they were able to give.</p>\n<blockquote><p>In short, it was my kind of group, and these were my kind of people.</p></blockquote>\n<p>After a few years we got ambitious enough to decide to put on a conference (which due to various reasons was a WordPress conference but not a WordCamp – ah, the good old days.) We were short of speakers. I suggested to Martin, the lead organiser, that someone should do a talk on that “cookie law” thing that at the time was coming into play very shortly.</p>\n<p>“Thank you for volunteering,” said Martin.</p>\n<p>“You’re a b*****d, you know that, Martin?” I replied.</p>\n<p>So Martin sent me off to do my homework and put together this conference talk. I thought it would just be a simple slide deck: what the law is, how it works, how to comply. Much to my surprise, putting that talk together changed my life.</p>\n<h3>The Old Becomes New</h3>\n<p>As I sat at my laptop, doing the research, I felt something strange stirring. It was old me.</p>\n<p>Old me, who had done an undergraduate degree in international politics. Old me, who’d been a policy intern at think tanks and research centers. Old me, who’d sat in Congressional committees and worked on the Hill and ate politics for breakfast. Old me who’d trained very hard to do one thing and had gotten sidetracked by real life and was now doing something else because something bad had happened. Old me was now new me reading the full text of a piece of EU legislation about how the internet is supposed to work while shouting at my laptop screen, “there is no bloody way that is ever going to work,” while my biggest fan looked at me baffled and then asked me for a cup of juice.</p>\n<blockquote><p>Whoever I was now, and whatever crap had happened to me in those intervening years, I was back.</p></blockquote>\n<p>That conference talk turned into an obsession. I began writing about law and policy issues that impact our work – be it regulations on accessibility, e-commerce, privacy and data protection, taxation, UX, contracts, copyright, geoblocking, or any of the smaller issues that touch our work every day. I even became a student again and earned a postgraduate certification in internet law and policy from the University of Strathclyde. I still did the client-facing web work but my enthusiasm for it waned by the month.</p>\n<p>At WordCamp London 2015 I gave a talk on various digital policy issues, then spent the rest of the time sitting in the track devoted to charity and not-for-profit web sites, as that was what my business did. As the speakers gave their superb talks I felt myself sinking lower in my chair. Another insight. Oh, woman, you’re in the wrong job. This isn’t what you are supposed to be doing. For the first time I asked myself why I was devoting such passion to the digital policy side while still carrying on with a web design business I started up to give myself a job with a newborn baby. A few months later I was flown out to Seville on a few days’ notice to speak at WordCamp Europe, where I replaced a speaker who had been hospitalised. I felt a tremendous sense of obligation because of that – it was deeply humbling to be given an opportunity because of someone else’s illness – and I resolved to do more to give back to the WordPress community.</p>\n<p>I hung up my web design mouse in the autumn of that year. I still do odd bits and bobs for a handful of existing clients but I now focus entirely on digital law and policy. My blog is read by the UK Parliament, the European Commission, and the US Department of State. I speak to non-WordPress groups ranging from Joomla developers to Ruby programmers, but WordPress remains my home and my community. I encourage members of the community to respect the law and to work within it, not to fear it. I think, all things considered, I’m more than qualified to understand why that’s true.</p>\n<p>Thanks to the WordPress community I’ve made friends for life, travelled to new places, and had adventures I never thought possible. I’ve built a new career while connecting with the important things I thought I had left behind. And last year when I was pickpocketed en route to a conference talk, the WordPress community in that city – none of whom I had ever met – leapt into action to provide me with food, beer, and hugs. In a strange city where I didn’t speak the language and had no money, being part of the community meant I didn’t have to be scared and alone.</p>\n<p>I&#8217;ve come a long way from that lonely courtroom dock.</p>\n<div class="rtsocial-container rtsocial-container-align-right rtsocial-horizontal"><div class="rtsocial-twitter-horizontal"><div class="rtsocial-twitter-horizontal-button"><a title="Tweet: Going Back To My Roots" class="rtsocial-twitter-button" href="https://twitter.com/share?text=Going%20Back%20To%20My%20Roots&via=heropress&url=https%3A%2F%2Fheropress.com%2Fessays%2Fgoing-back-roots%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-fb-horizontal fb-light"><div class="rtsocial-fb-horizontal-button"><a title="Like: Going Back To My Roots" class="rtsocial-fb-button rtsocial-fb-like-light" href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fessays%2Fgoing-back-roots%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-linkedin-horizontal"><div class="rtsocial-linkedin-horizontal-button"><a class="rtsocial-linkedin-button" href="https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fessays%2Fgoing-back-roots%2F&title=Going+Back+To+My+Roots" rel="nofollow" target="_blank" title="Share: Going Back To My Roots"></a></div></div><div class="rtsocial-pinterest-horizontal"><div class="rtsocial-pinterest-horizontal-button"><a class="rtsocial-pinterest-button" href="https://pinterest.com/pin/create/button/?url=https://heropress.com/essays/going-back-roots/&media=https://heropress.com/wp-content/uploads/2017/03/031517-150x150.jpg&description=Going Back To My Roots" rel="nofollow" target="_blank" title="Pin: Going Back To My Roots"></a></div></div><a rel="nofollow" class="perma-link" href="https://heropress.com/essays/going-back-roots/" title="Going Back To My Roots"></a></div><p>The post <a rel="nofollow" href="https://heropress.com/essays/going-back-roots/">Going Back To My Roots</a> appeared first on <a rel="nofollow" href="https://heropress.com">HeroPress</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 15 Mar 2017 12:00:22 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Heather Burns";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:86:"WPTavern: Bocoup Launches Study to Measure Impact of Open Work on Developer Well-Being";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67447";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:97:"https://wptavern.com/bocoup-launches-study-to-measure-impact-of-open-work-on-developer-well-being";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1980:"<a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2015/06/survey.jpg?ssl=1"><img /></a>photo credit: <a href="https://stocksnap.io/photo/FI3UYVGNFD">Lukasz Kowalewski</a>\n<p><a href="https://bocoup.com/" target="_blank">Bocoup</a>, an open source technology and design consulting company, is recruiting for a new study that aims to &#8220;measure the impact of open work on developer well-being and productivity.&#8221; The company is partnering with MIT and UCLA to develop an open work email-bot that will interact with organizations that sign up to participate. The study is open to teams that use source control.</p>\n<p>&#8220;We&#8217;re defining &#8216;open work&#8217; as a project where tasks/work product are/can be shared outside the group immediately responsible for those tasks,&#8221; Bocoup Director of Research Boaz Sender said.</p>\n<p>Participating organizations will get hooked up with Bocoup&#8217;s email-bot, which offers tools for recognizing team members or open source community members for their contributions to projects. Bocoup plans to publish the average results with the goal of educating businesses and policy makers about the value of open source work. Data from organizations participating in the study will be anonymized and untraceable.</p>\n<p>With all the new ways of working together on the web (GitHub, Slack, GitLab, etc.) it&#8217;s good to see a company prioritizing research on how this impacts developers. The study begins in March and will end in June. If you&#8217;re interested to have your organization be a part of it, you can find out more on the <a href="https://docs.google.com/forms/d/e/1FAIpQLSc9sYreLFTZDxn-LuUhGCl043QDcagls9g0t_TbZ3Pd3ZnYNA/viewform?c=0&w=1" target="_blank">signup form</a> and get a better understanding of the time commitment on the <a href="https://docs.google.com/document/d/1EWD9c4cmIfyNVe4pGFsvPiLO83i1ZOij4mpF-cLVfTc/edit" target="_blank">FAQ</a> page.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 15 Mar 2017 02:10:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"WPTavern: WooCommerce 3.0.0 Scheduled for Release April 4th";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67438";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:70:"https://wptavern.com/woocommerce-3-0-0-scheduled-for-release-april-4th";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4981:"<p>Big changes are on the way for <a href="https://wordpress.org/plugins/woocommerce/">WooCommerce</a>. Mike Jolley, lead developer of WooCommerce, <a href="https://woocommerce.wordpress.com/2017/03/13/important-update-regarding-the-upcoming-woocommerce-release-2-7-will-be-3-0-0/">announced</a> that WooCommerce 2.7 will be versioned 3.0.0 with a scheduled release date of April 4th. During the 2.7 beta testing phase, the team discovered a <a href="https://github.com/woocommerce/woocommerce/issues/13498">significant bug</a> in the way that timestamps are handled.</p>\n<p>&#8220;Essentially, some developers need a way to reliably get UTC timestamps as well as dates according to the site’s timezone,&#8221; Jolley said. &#8220;To resolve this we’re working on a solution which accepts <em>either</em> a UTC timestamp, or an ISO8601 datetime string, and returns a <a href="http://php.net/manual/en/class.datetime.php">DateTime object</a> so timezone information can be retrieved if needed. This approach is not compatible with the <code>get_date_x</code> getters found in 2.7 beta.&#8221;</p>\n<p>Beginning with WooCommerce 3.0.0, the project will use semantic versioning or <a href="http://semver.org/">SemVer</a>. WooCommerce has incrementally versioned its releases similar to WordPress. For example, WooCommerce 2.5, 2.6, 2.7. Semantic versioning allows for three digit version numbers and should make it easier to discern major versions from maintenance and bug fix releases. The three digits stand for major, minor, and patch.</p>\n<p>According to the <a href="http://semver.org/">SemVer site</a>, each number is incremented when:</p>\n<ul>\n<li>MAJOR version for incompatible API changes.</li>\n<li>MINOR version when you add functionality in a backwards-compatible manner.</li>\n<li>PATCH version when you make backwards-compatible bug fixes.</li>\n</ul>\n<p>Under this system, WooCommerce 3.0.0 is a major update with 3.1.0 being a minor update. The next major update will be 4.0.0. Developers should take note that in 3.0.0 RC1, the versioning and @since properties are relabeled to 3.0.0. &#8220;If you have used version_compare statements in your code, they will still work since 3.0.0 is greater than 2.7.0, however, you can change these for clarity,&#8221; Jolley said. Themes with template files versioned 2.7.0 may need to be updated to use 3.0.0 to prevent reports of outdated template files.</p>\n<p>In addition to version changes and fixing major bugs, the team is allowing up to three weeks for 3.0.0 RC1 to be tested. The amount of time to test has been extended from one week to three <a href="https://woocommerce.wordpress.com/2017/02/17/woocommerce-2-7-beta-3/#comment-2589">based on feedback </a>from extension developers.</p>\n<p>&#8220;An RC is really the first point in time when people can look at the code and feel confident it&#8217;s probably not going to change a lot before the official release,&#8221; Brent Shepherd, founder of <a href="http://prospress.com/">Prospress Inc</a>. said. &#8220;With that in mind, having 3 months of beta testing, but only 1 week for the RC, doesn’t make a lot of sense. It makes sense to give more time in that later stage after the RC.&#8221;</p>\n<p>Josh Kohlbach, a WooCommerce extension developer, <a href="https://woocommerce.wordpress.com/2017/02/17/woocommerce-2-7-beta-3/#comment-2604">also agreed</a> with extending the RC testing time. &#8220;Currently from our company’s perspective we’ve had to put other priorities on hold in order to put WC2.7 changes ahead,&#8221; Kohlbach said. &#8220;The 2.7 changes we were holding off on doing until RC, which is what we normally do.&#8221;</p>\n<p>&#8220;However, when it was announced that there would be only one week between, we figured that wouldn’t be enough time for proper testing and pushing updates on all of our products so we’re compatible on day one,&#8221; he said. &#8220;It just isn’t enough time so we, like many others by the sounds of it, started making our compatibility fixes around Beta 2 this time even though we knew there might be more changes coming down the pipe before RC gets here.&#8221;</p>\n<p>Extension developers are praising the team for changing to a semantic versioning system and extending the time to test Release Candidates. &#8220;I’m very happy to see these changes,&#8221; Shepherd said. &#8220;Big props for making the tough call late in the release cycle. Hopefully it will help ensure a smoother release for all WC users of this version.&#8221;</p>\n<p>&#8220;I think this is a really positive move forward for WooCommerce,&#8221; Kohlback said. &#8220;I for one want to thank you on behalf of all the third-party developers for being so open and taking on board all of our various points, really makes us happy to be part of the community!&#8221;</p>\n<p>If all goes well, you can expect to see an update for WooCommerce in your WordPress dashboard on April 4th.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 14 Mar 2017 22:23:12 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:93:"WPTavern: Varying Vagrant Vagrants 2.0.0 Introduces YAML Configuration, Revamps Documentation";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67436";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:103:"https://wptavern.com/varying-vagrant-vagrants-2-0-0-introduces-yaml-configuration-revamps-documentation";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4545:"<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/03/vvv-github.png?ssl=1"><img /></a></p>\n<p><a href="https://varyingvagrantvagrants.org/blog/2017/03/13/varying-vagrant-vagrants-2-0-0.html" target="_blank">Varying Vagrant Vagrants 2.0.0</a> was released yesterday with support for a <a href="https://varyingvagrantvagrants.org/docs/en-US/vvv-config/" target="_blank">YAML configuration</a> file. This is a major improvement that gives VVV users more flexibility in customizing their configurations. The new <code>vvv-config.yml</code> file includes the defaults and users can create a <code>vvv-custom.yml</code> file to change the default provisioning. Utilities have been broken out into their own repository, allowing users to specify PHP 5.6, 7.0, or 7.1 for new projects.</p>\n<p>&#8220;In the past, it was often difficult as a maintainer to say no to feature requests because I knew that the customizations would either be really annoying for someone to implement on their own or would require a fork, possibly losing the benefit of future changes,&#8221; VVV Project Lead Jeremy Felt said. &#8220;At the same time, it was hard to say yes because not everyone needs the same features. Those two clash, and the easiest answer is to stall. The new changes provide a pretty straight forward way of providing these custom changes and make it easy to stay in sync upstream.&#8221;</p>\n<p>Version 2.0.0 was also released with <a href="https://varyingvagrantvagrants.org/docs/en-US/" target="_blank">new documentation on the VVV website</a>. Contributors are migrating docs from the wiki on GitHub to the new website and plan to make them translatable in the future.</p>\n<p>Felt also recently <a href="https://jeremyfelt.com/2017/03/05/documenting-vvvs-governance-model/" target="_blank">documented VVV’s governance model</a> and promoted Lorelei Aurora to the role of Lead Developer on the project. VVV has 108 contributors, by Felt&#8217;s count, and he estimates approximately 100 clones of the project per day based on GitHub&#8217;s analytics. For the past five years, Felt has cultivated VVV’s growing community of contributors by developing a friendly and welcoming culture within the project.</p>\n<p>&#8220;Very early on I read something about OSS project maintenance that inspired me to always greet new commenters, issue creators, and developers in an effort to make them feel welcome from the beginning,&#8221; Felt said. &#8220;Removing even the smallest hurdles of contributing to open source goes a long way. Being friendly encourages people to stick around. Even in small projects like VVV, it can be overwhelming to figure out if you&#8217;re doing things right.&#8221;</p>\n<p>Felt said he wished he would have written the governance document sooner, because it provides a roadmap for contributors. He found that having this information available to the community from the beginning may be just as important as having a license in place.</p>\n<p>&#8220;It starts to answer the &#8216;what kind of impact can I have&#8217; question when someone is getting started,&#8221; Felt said. &#8220;The current list of committers is a little misleading in that they are all people who were very active early in the project, but not as much now. Their input continues to be trusted, but commit access probably won&#8217;t be used very much. This isn&#8217;t a bad thing, as a project goes through cycles, but something to keep track of as a maintainer. Having a process is a healthy thing. I&#8217;m hoping it attracts even more contributors!&#8221;</p>\n<h3>What&#8217;s Next on the VVV Roadmap?</h3>\n<p>The next focus on the VVV roadmap is building out the rest of the documentation on <a href="http://varyingvagrantvagrants.org" target="_blank">varyingvagrantvagrants.org</a>. Felt said he hopes it will become a great place for basic setup, detailed guides, and frequent troubleshooting tips. Translated docs is the next item that Felt said he hopes can be a huge benefit to the project and the community.</p>\n<p>&#8220;There are a couple things that would be fun for flexibility,&#8221; Felt said. &#8220;A long-running pull request that introduces PHP Brew would be nice to finally tackle. Introducing MySQL Sandbox would be cool. And who knows? Everyone should stop by and <a href="https://github.com/Varying-Vagrant-Vagrants/VVV" target="_blank">leave a note</a> with the feature they&#8217;d like to see most. I&#8217;m more comfortable saying &#8216;no&#8217; now.&#8221;</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 14 Mar 2017 19:28:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:81:"WPTavern: WordPress.com Updates Its Post Editor With a Distraction-Free Interface";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67429";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:92:"https://wptavern.com/wordpress-com-updates-its-post-editor-with-a-distraction-free-interface";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3321:"<p>WordPress.com has <a href="https://en.blog.wordpress.com/2017/03/13/a-distraction-free-writing-space-at-wordpress-com/">unveiled a refreshed post editor</a> that makes content front and center.</p>\n<p>The most noticeable change is the user interface. The sidebar of meta boxes is now on the right-hand side instead of the left. Clicking the Post Settings link hides the sidebar, providing a cleaner interface. The preview and publish buttons are no longer in a metabox and are permanently displayed.</p>\n<img />New WordPress.com Post Editor\n<p>Drafts are quickly accessible by clicking the number next to the Write button. Hovering over a draft title displays a small excerpt of the post. Unlike the distraction-free writing mode in the self-hosted version of WordPress, sidebars and other items on the screen do not disappear and reappear. This animation has <a href="https://wptavern.com/whats-your-first-impression-of-distraction-free-writing-in-wordpress-4-1#comment-62784">been described</a> by some as a distraction.</p>\n<p>Joen Asmussen and Matías Ventura, two Automatticians based in Europe, helped create the new interface. In an interview conducted by John Maeda, <span class="st">Global Head of Computational Design and Inclusion at Automattic, Asmussen describes what he&#8217;s most excited about with the improvements. </span></p>\n<p>&#8220;Everything has a right place,&#8221; Asmussen said. &#8220;In this iteration, we’ve tried to find those places for the preview and publish buttons, as well as the post settings. By making the buttons permanently visible and the sidebar optionally toggled, my hope is that the combination will provide a seamless flow for both the person who just wants to <i>write</i>, as well as the person who needs to configure their post settings.&#8221;</p>\n<p>Ventura says he is happy to bring the focus back on the content by placing it in the center. &#8220;I’m also fond of the recent drafts menu next to the &#8216;Write&#8217; button, as it provides a quick way to carry on with your unfinished posts,&#8221; he said. &#8220;These editor refinements have the potential to let your work on WordPress keep you deeply in the productive state of flow.&#8221;</p>\n<p>The core team continues to <a href="https://wptavern.com/wordpress-core-editor-team-publishes-ui-prototype-for-gutenberg-an-experimental-block-based-editor">work on a block based editor</a> for the open-source WordPress project and <span class="st">Asmussen</span> hints that this approach to writing could one day end up in the WordPress.com post editor.</p>\n<p>After testing the new editor on WordPress.com, I can say that it&#8217;s more enjoyable to use than the distraction-free writing mode in WordPress. There&#8217;s less distraction, meta boxes are either on the screen or they&#8217;re not, and I enjoyed writing without interface elements disappearing and reappearing on the screen.</p>\n<p>If you&#8217;d like to try the new editor on a self-hosted WordPress site, you can do so through Jetpack. Visit the Jetpack dashboard in the WordPress backend, click on the Apps link, then click the Try the New Editor button.</p>\n<p>After using the new editor, let us know what you think. How does it compare to the writing experience currently in WordPress?</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 14 Mar 2017 02:03:50 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:90:"WPTavern: John Maeda’s 2017 Design in Tech Report Puts the Spotlight on Inclusive Design";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67406";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:98:"https://wptavern.com/john-maedas-2017-design-in-tech-report-puts-the-spotlight-on-inclusive-design";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6207:"<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/03/design-in-tech-2017.png?ssl=1"><img /></a></p>\n<p><a href="https://maedastudio.com/" target="_blank">John Maeda</a>, Automattic&#8217;s Global Head of Computational Design and Inclusion, presented his third annual &#8220;<a href="https://designintechreport.wordpress.com/" target="_blank">Design in Tech</a>&#8221; report at SXSW over the weekend. The previous reports have received more than two million views and this one is equally loaded with thought-provoking information about the future of the design industry.</p>\n<p>&#8220;Design isn’t just about beauty; it’s about market relevance and meaningful results,&#8221; Maeda said. He highlighted how design leaders are increasingly top hires at major corporations, due to market demand. Businesses are beginning to embrace design as a fundamental tool for success. Design used to be relegated to extra-curricular clubs in business schools, but many schools are shifting to include design in the curriculum.</p>\n<p>Constant connectivity in the digital era has brought the idea of &#8220;computational design&#8221; to the forefront, which Maeda describes as &#8220;designing for billions of individual people and in realtime.&#8221; Designing at this scale requires an approach that is inclusive of the widest number of consumers, essentially designing for everyone.</p>\n<p>Maeda believes that &#8220;design and inclusion are inseparable&#8221; and he is on a mission to prove that inclusive design is good business. </p>\n<p>&#8220;When we separate inclusion into essentially an HR compliance topic, it loses its energy,&#8221; Maeda said. &#8220;It&#8217;s important, of course, but it loses the creativity that&#8217;s intrinsic to inclusion.&#8221; His 2017 Design in Tech report focuses on how inclusion matters in business. Maeda admits there are not many examples of how inclusion drives better financial outcomes, but one of his professional aims is to demonstrate how inclusive design can make a financial difference.</p>\n<p>&#8220;That&#8217;s why I joined Automattic,&#8221; Maeda said. &#8220;My hope is that this approach can lead to better business outcomes for the WordPress ecosystem. I don&#8217;t know if it will be possible but that&#8217;s my goal. I want to show that it&#8217;s possible numerically.&#8221;</p>\n<p>Making inclusive design profitable hinges on the principle that if you want to reach a larger market, you have to reach people you&#8217;re not already reaching by being inclusive. This new frontier of design requires some technical understanding outside of purely classical design. The hybrid designer/developer, often referred to as a &#8220;unicorn&#8221; in the tech industry, is often relied upon to bridge that gap.</p>\n<p>Maeda predicts that the scarcity of hybrid designer/developers will soon decrease, due to how things are changing in the industry. After surveying design leaders in 2016, Maeda found that 1/3 had formal engineering/science training, suggesting that &#8220;hybrid&#8221; talent has considerably increased in recent years. He shared his observations from surveying Automattic designers and developers about JavaScript competency. He found a significant segment of designers approaching moderate fluency in JavaScript after WordPress&#8217; 2015 initiative to encourage JavaScript mastery.</p>\n<p>&#8220;The world is moving, and moving with the world is what designers do,&#8221; Maeda said. He also made a bold recommendation for those who are maintaining a design-only skill set:</p>\n<p>&#8220;I encourage you, if you&#8217;re a pure pure designer, to &#8216;impurify yourself,&#8217; because it&#8217;s a whole new world and there&#8217;s a lot to learn,&#8221; Maeda said. &#8220;Anyone who&#8217;s in this game, if you aren&#8217;t watching videos and learning, you get behind in two months.&#8221; </p>\n<p>Maeda also encouraged listeners to shed biases that prevent them from seeing important trends and changes on the web. He addressed misconceptions about how products &#8220;made in China&#8221; are often thought of as something cheap or copycat, but China is moving forward in the mobile revolution in a far more advanced way than many other countries. He highlighted some major design trends pioneered by Chinese designers and how they are impacting the tech industry. </p>\n<p>Maeda closely monitors design-related M&#038;A activity and funds that are design and/or inclusion oriented. His data shows that tech companies are finding more value in design tool companies and design community platforms, with acquisitions steadily increasing every year. The value of design companies is especially evident in China where Maeda noted three designer co-founded Chinese companies have a combined market cap of over $300 billion. </p>\n<p>He also shared what he has learned about designers since taking his position at Automattic, which employs more than 500 people working remotely across 50 countries.</p>\n<p>&#8220;People want to have challenging work; they want to make change happen,&#8221; Maeda said. &#8220;With creative people this is their main driver. If that can&#8217;t be sated, they get unhappy and they leave. The problem is this kind of work is the kind that seems like bonus work, not the main work. So my question as a manager is, &#8216;How do I put the two together in some constructive way?&#8217; How do you make time to learn and grow? That&#8217;s something I didn&#8217;t know was pervasive in a busy busy tech company.&#8221;</p>\n<p>Maeda concludes that it is a good time to be a designer, especially if you&#8217;re willing to make up for the design education gap and teach yourself new skills online. His 2017 Design in Tech report is a must-read, not just for designers but for anyone working in tech or hiring tech talent. Check out the <a href="https://designintechreport.wordpress.com/" target="_blank">full report</a> on WordPress.com. You can also <a href="https://designintechreport.wordpress.com/2017/03/12/design-in-tech-report-2017-video/" target="_blank">listen to the audio of Maeda&#8217;s presentation</a> while viewing the slides.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 13 Mar 2017 20:07:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:15;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:75:"Post Status: JavaScript frameworks in a WordPress context — Draft podcast";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"https://poststatus.com/?p=35232";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:77:"https://poststatus.com/javascript-frameworks-wordpress-context-draft-podcast/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2808:"<p>Welcome to the Post Status <a href="https://poststatus.com/category/draft">Draft podcast</a>, which you can find <a href="https://itunes.apple.com/us/podcast/post-status-draft-wordpress/id976403008">on iTunes</a>, <a href="https://play.google.com/music/m/Ih5egfxskgcec4qadr3f4zfpzzm?t=Post_Status__Draft_WordPress_Podcast">Google Play</a>, <a href="http://www.stitcher.com/podcast/krogsgard/post-status-draft-wordpress-podcast">Stitcher</a>, and <a href="http://simplecast.fm/podcasts/1061/rss">via RSS</a> for your favorite podcatcher. Post Status Draft is hosted by Joe Hoyle &#8212; the CTO of Human Made &#8212; and Brian Krogsgard.</p>\n<p><span>Live from the A Day of REST workshops, Brian, Joe, and Zac talk about the state of working with JavaScript &#8212; including several popular JavaScript frameworks &#8212; and WordPress. They go through the pros and cons of using each one, what to watch out for when working with them and WordPress, and ways they think the process can improve.</span></p>\n<p><!--[if lt IE 9]><script>document.createElement(''audio'');</script><![endif]-->\n<a href="https://audio.simplecast.com/62575.mp3">https://audio.simplecast.com/62575.mp3</a><br />\n<a href="https://audio.simplecast.com/62575.mp3">Direct Download</a></p>\n<h3>Links</h3>\n<ul>\n<li><a href="https://javascriptforwp.com/">JavaScript for WP</a></li>\n<li><a href="https://facebook.github.io/react/">React</a></li>\n<li><a href="https://vuejs.org/">Vue</a></li>\n<li><a href="http://backbonejs.org/">Backbone</a></li>\n<li><a href="http://underscorejs.org/">Underscores</a></li>\n<li><a href="https://angularjs.org/">Angular</a></li>\n<li><a href="https://adayofrest.hm/boston-2017/">A Day of Rest</a></li>\n</ul>\n<h3>Sponsor: WP Migrate DB Pro</h3>\n<p><span>Today’s show is sponsored by</span><a href="https://deliciousbrains.com/"> <span>Delicious Brains</span></a><span>.</span><a href="https://deliciousbrains.com/wp-migrate-db-pro/"> <span>WP Migrate DB Pro</span></a> <span>makes moving and copying databases simple. They  also have an exciting new project for merging databases, called Mergebot. Go to</span><a href="https://mergebot.com/"> <span>Mergebot.com</span></a><span> for updates on that, and</span><a href="https://deliciousbrains.com/"> <span>deliciousbrains.com</span></a><span> for more information on WPMigrate DB Pro. Thanks to the team at Delicious Brains for being a Post Status partner.</span></p>\n<h3>Special Thanks: Bocoup</h3>\n<p><span>Special thanks to <a href="https://bocoup.com/">Bocoup</a> for allowing us to record this podcast episode in their office. Bocoup was a partner and workshop host for A Day of REST, and were incredibly hospitable. Checkout <a href="https://bocoup.com/">Bocoup</a> to learn more about how they embrace open source as a consulting agency.</span></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 13 Mar 2017 00:56:04 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Katie Richards";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:16;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:74:"WPTavern: Hacker News Question: Developers with kids, how do you skill up?";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67259";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:82:"https://wptavern.com/hacker-news-question-developers-with-kids-how-do-you-skill-up";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:9488:"<a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2016/03/child-theme.jpg?ssl=1"><img /></a>photo credit: <a href="https://stocksnap.io/photo/R0C7A5M4WB">Leeroy</a>\n<p>By now you&#8217;ve probably seen the viral <a href="https://twitter.com/JOE_co_uk/status/840165524038377472" target="_blank">clip</a> of a father getting interrupted by his children while giving a live interview on BBC. Working parents everywhere, especially remote workers, could identify with the humorous embarrassment of the situation. Even those who have had pets interrupt Skype calls know the feeling. You want to be thought of as a professional and taken seriously but little home office invaders have other plans.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">This BBC interview is amazing. Just wait until the mum rushes in&#8230; <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f602.png" alt="😂" class="wp-smiley" /> <a href="https://t.co/LGw1ACR9rg">pic.twitter.com/LGw1ACR9rg</a></p>\n<p>&mdash; JOE.co.uk (@JOE_co_uk) <a href="https://twitter.com/JOE_co_uk/status/840165524038377472">March 10, 2017</a></p></blockquote>\n<p></p>\n<p>Many developers who work from home with children know the daily struggle of balancing family life with work, which generally leaves very little time for improving professional skills. A popular question on Hacker News this week asks, <strong>&#8220;<a href="https://news.ycombinator.com/item?id=13816627" target="_blank">Developers with kids, how do you skill up?</a>&#8220;</strong>: </p>\n<blockquote><p>I recently had one of my colleagues comment on my GitHub account graph &#8211; &#8216;There won&#8217;t be many green boxes in your account once you have a kid&#8217;. This was in response to my suggestions on how we should all keep learning. I argued many good programmers have family with kids and still manage to keep up. They brushed me off saying it&#8217;s just not possible or they don&#8217;t look after their kids.</p>\n<p>When I look on the internet I find people doing full time jobs delivering products while having a family and some still find plenty of time to blog or write books. How is this possible? Are these people super-human? How are you all doing or managing if you have kids/family?</p></blockquote>\n<p>The question received nearly 500 replies with tips and stories from those who are making it work. One of the first participants on the thread is <a href="https://news.ycombinator.com/item?id=13821164" target="_blank">Rachel Andrew</a>, who shares how she learned Perl as a single mother, launching a new career in web development. She said found success by &#8220;simply working every possible moment&#8221; she could and learning to be organized and focused with her time.  </p>\n<p>One common theme among the replies is that having kids is like getting a crash course in time management. When your available time is significantly reduced, you are forced to become more purposeful about how you spend it.</p>\n<blockquote><p>What I learned: your time does get reduced drastically, but you spend the remaining time with more focus/direction. Also, you use your time smarter, e.g. I used to do sports (indoor climbing), but now I just cycle every day from/to work (~1 hour) to stay fit. It takes approximately the same time as going by train or car.</p></blockquote>\n<blockquote><p>If i have clear priorities in my head &#8211; what I want to achieve in the &#8216;extra time&#8217; that I have got. The clearer the goal, the better the results.</p></blockquote>\n<blockquote><p>&#8230;due to lack of free time and the newfound need to use it efficiently, I&#8217;ve found that I&#8217;ve probably read more actual physics in the last four years than in the previous many years of dreaming about it.</p></blockquote>\n<blockquote><p>Time management, to me, is a more powerful &#8220;skill up&#8221; than anything that could keep your GitHub green. When you know you have limited hours in the day and you have hard time commitments, you have no choice but to learn and work efficiently.</p></blockquote>\n<blockquote><p>\nI&#8217;d add that kids have taught me to be a better planner, and to break my priorities down into small, well defined chunks that can be slotted into a busy life. This has been valuable in general, not just for programming.</p></blockquote>\n<p>One commenter said he misses the days when he could stay up all night working and exploring new technologies; now it seems the world is going on without him. Other commenters reject the idea of &#8220;skilling up&#8221; entirely and encourage the original poster not to get too hung up on shiny new frameworks.</p>\n<blockquote><p>I agree with you about the need to remain buzzword compliant for jobs, but are we &#8220;skilling up&#8221; or spinning our wheels? There is some worthwhile learning, but a lot of it is just BS status signaling. Learning another SPA framework that solves the problems of the last framework, while introducing new problems? Learning yet another way to bundle your web content? A new transpiled language to patch the holes in JavaScript?</p>\n<p>A lot of what we regard as &#8220;skilling up&#8221; is just a product of our immature dev culture-learning stuff for the sake of buzzword compliance that doesn&#8217;t improve anything in the long run. And the high failure rate of software projects shows that we aren&#8217;t gaining a lot from this culture anyway.</p></blockquote>\n<h3>Combatting the Myth that You Can&#8217;t Do Anything with Just 15 Minutes</h3>\n<p>Another theme among the comments is the &#8220;myths&#8221; parents create that keep them from using the short increments of time that pop up throughout the day. One commenter <a href="https://news.ycombinator.com/item?id=13822865" target="_blank">summarizes</a> the self-limiting mindset that many adopt after having children:</p>\n<blockquote><p>New parents create limitations for themselves in their belief that it is utterly impossible to do anything outside of parenting. The OP is saying that meaningful work can be done in the 15 minutes your baby might be asleep. A year of 15 minutes adds up to a lot.</p></blockquote>\n<p>The key to productivity is being able to take those 15 minute increments and string them into bite-sized accomplishments towards a larger goal. Developer Chris Dawson shared how he wrote an app late at night while caring for his first child. </p>\n<p>&#8220;I only have ten minutes here, fifteen minutes there. I need focused hours of time to build something. That is just a story,&#8221; Dawson said. He used these short bits of time to create <a href="http://blog.teddyhyde.com/2013/04/03/teddy-hyde-the-no-compromise-extensible-one-handed-jekyll-blog-editor-for-android" target="_blank">a one-handed blogging tool</a>, because he needed a way to blog with one hand while holding his sleeping son.</p>\n<p>&#8220;When my daughter was born two years later, my wife was so exhausted she would go to bed at 8,&#8221; Dawson said. &#8220;I&#8217;d get my son to sleep and then promised myself I would write for just fifteen minutes before bed. That usually turned into an hour or two and three years later I had written <a href="http://shop.oreilly.com/product/mobile/0636920043027.do" target="_blank">a book for O&#8217;Reilly</a>.&#8221; </p>\n<p>&#8220;There are so many times I&#8217;m exhausted after getting the kids to bed and I just browse the Internet,&#8221; Dawson said. &#8220;If I was really intentional about my time, even that fifteen minutes could be used to work towards my goals. But there is a powerful story telling me that it won&#8217;t make a difference if I just waste that time.&#8221;</p>\n<p>Dawson doesn&#8217;t consider himself an extraordinary high achiever. He found success by changing his perspective about the sleep he was losing.</p>\n<p>&#8220;I&#8217;m not the greatest developer &#8211; I struggled with the Google interview I got,&#8221; Dawson said. &#8220;But, success is 90% perspiration and 10% ingenuity. Who cares if you are sweating because you are exhausted and sleep deprived caring for infants as compared to pulling all-night coding sessions?&#8221;</p>\n<p>&#8220;Most of what we think of as being &#8216;too busy&#8217; for any particular thing is a cognitive bias for forgetting just how much time we waste,&#8221; JavaScript engineer Sean McBeth said.</p>\n<p><a href="https://twitter.com/samlittlewood" target="_blank">Sam Littlewood</a>, senior architect at V-Nova, offered a few practical tips on the thread:</p>\n<ul>\n<li>Don&#8217;t use the computer to waste time &#8211; if I need decompression time, try and make it doing something w/ kids (LEGO!)</li>\n<li>A solid dev. environment where you can walk up, crank an iteration, and walk away. (Like in the time it takes a kettle to boil)</li>\n<li>Learning to code in my head &#8211; basically planning the path of changes/tests I will make next time I am back at my machine. It feels to me somewhat like the &#8216;method of loci&#8217; &#8211; a definite journey. Often times, the plan goes awry, but the successes make it worth it. After 12 years of reading to the kids, I can do this whilst reading a story to them.</li>\n</ul>\n<p>The comments are full of inspiring stories and ideas for routines and tips that can help parents be more productive. There&#8217;s no magical path to success but, as many working parents have discovered, you may find more time than you thought you had.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 11 Mar 2017 23:32:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:17;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"WPTavern: In Case You Missed It – Issue 18";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67263";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"https://wptavern.com/in-case-you-missed-it-issue-18";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:7020:"<a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2016/01/ICYMIFeaturedImage.png?ssl=1" rel="attachment wp-att-50955"><img /></a>photo credit: <a href="http://www.flickr.com/photos/112901923@N07/16153818039">Night Moves</a> &#8211; <a href="https://creativecommons.org/licenses/by-nc/2.0/">(license)</a>\n<p>There’s a lot of great WordPress content published in the community but not all of it is featured on the Tavern. This post is an assortment of items related to WordPress that caught my eye but didn’t make it into a full post.</p>\n<h2>The REST API Democratizes Reading</h2>\n<p>Mika Epstein <a href="https://halfelf.org/2017/rest-api-democratizing-reading/">explains</a> how the WordPress REST API democratizes reading by making content more discoverable and accessible.</p>\n<blockquote><p>When you look at a website you see the design and the layout and the wonderful beauty. When an app reads your data, however, it doesn’t want or need any of that. An app needs the raw data. And the REST API does that. It outputs the data in a super basic and simple way. Furthermore, it lets you add on to this and output specific data in special ways.</p></blockquote>\n<h2>TechSPARK Interviews WordCamp Bristol Organizer</h2>\n<p>Bristol, UK, is gearing up for its <a href="https://2017.bristol.wordcamp.org/">first WordCamp</a> and local media is taking notice. TechSPARK, a digital publication that covers tech in Bristol, Bath, and the West of England <a href="https://techspark.co/wordcamp-bristol/">published</a> an interview with Janice Tye, one of the lead organizers of the event.</p>\n<p>In the interview, Tye explains what a WordCamp is and how people can get involved. WordCamp Bristol takes place May 13-14th, 2017 and has a limited <a href="https://2017.bristol.wordcamp.org/tickets/">number of tickets</a> available.</p>\n<h2>Fishing Guide&#8217;s Site Used by Hackers for eCommerce Fraud</h2>\n<p>TechCrunch <a href="https://techcrunch.com/2017/03/03/woe-are-the-great-fish-of-cape-cod/">published</a> an interesting story of how a Cape Cod fishing guide&#8217;s website that runs on WordPress was hacked and used to host an eCommerce store. The moral of the story is to keep WordPress and its plugins and themes updated. An additional safety measure is to enable two-factor authentication.</p>\n<h2>Being a Full-time Contributor Through Sponsorships</h2>\n<p>Late last year, John James Jacoby <a href="https://jjj.blog/2016/12/%f0%9f%92%af%e2%88%9e/">outlined his goal</a> for his 100 initiative. &#8220;My goal is be a fully funded independent ambassador for WordPress and the surrounding initiatives, backed by many of the best companies who continue to push WordPress beyond its limits on a daily basis,&#8221; Jacoby said.</p>\n<p>Jacoby provided <a href="https://jjj.blog/2017/03/january-february/">an update</a> on what he&#8217;s been working on since obtaining sponsorship from Pagely and Pantheon. He plans to take a two-week break in March to attend WordCamp Miami and will be speaking at other events. If you&#8217;re interested in sponsoring Jacoby to work on WordPress full-time for a month, please get <a href="http://jjj.me/">in touch with him</a>.</p>\n<h1 class="entry-title">Mode Effect Builds Website for WordPress.com&#8217;s Affiliate Program</h1>\n<p><a href="https://modeeffect.com/">Mode Effect</a>, a web design agency, <a href="https://modeeffect.com/wordpress-com-creators-select-wordpress-agency-mode-effect-to-build-affiliate-program/">built the site</a> for <a href="https://refer.wordpress.com/">WordPress.com&#8217;s affiliate program</a>. According to Jon Burke, team lead for events, marketing, and advertising at Automattic, the agency was chosen based on recommendations and its previous work with the <a href="https://vip.wordpress.com/">WordPress VIP program</a>.</p>\n<h2>New Features for WordPress.com Stats</h2>\n<p>WordPress.com unveiled a <a href="https://en.blog.wordpress.com/2017/03/06/your-stats-page-updated/">number of new enhancements</a> to WordPress.com stats. More insights, summaries, and better use of wide screens are just a few of the improvements that were made.</p>\n<h2>Remembering HostReviews.io</h2>\n<p>Kevin Ohashi, founder of Review Signal, takes a <a href="http://reviewsignal.com/blog/2017/03/06/goodbye-hostingreviews-io-i-will-miss-you/">look back at </a><span class="skimlinks-unlinked"><a href="http://reviewsignal.com/blog/2017/03/06/goodbye-hostingreviews-io-i-will-miss-you/">HostingReviews.io</a> created by Steven Gliebe that was recently acquired by HostingFacts.com. </span></p>\n<p>&#8220;I&#8217;m truly saddened because it&#8217;s disappearing at some point &#8216;soon.&#8217; The only real competitor whose data I trusted to compare myself against. So I thought I would take the opportunity to write about my favorite competitor,&#8221; Ohashi said.</p>\n<p>He compared the data that was manually curated by Gliebe to the data on Review Signal and discovered it was similar. Ohashi says he will miss having a trustworthy competitor to compare his data too.</p>\n<p>&#8220;It has been nice having <span class="skimlinks-unlinked">HostingReviews.io</span> around when it was actively being updated (the manual process is certainly overwhelming for any individual I think!). I will miss having a real competitor to compare what I&#8217;m seeing in my data.&#8221;</p>\n<h2>Challenges of Security Disclosure</h2>\n<p>Aaron Campbell, WordPress security lead, <a href="https://aarondcampbell.com/2017/03/the-difficulties-of-security-disclosure/">provides insight</a> into the challenges associated with security disclosure. Campbell describes disclosure as a constant balancing act.</p>\n<p>&#8220;But security isn’t a single balancing act,&#8221; Campbell said. &#8220;Many of the decisions we must make require finding the right balance. Each requires thought and consideration, as well as a clear set of priorities. Especially when it comes to disclosing vulnerabilities.&#8221;</p>\n<p>&#8220;Every situation is going to be unique, but knowing the right questions to ask will help. The time to think through these questions is now, hopefully long before you are faced with them.&#8221;</p>\n<p>On the topic of security disclosure, I recommend reading <a href="https://nacin.com/2014/05/30/security-is-nuanced/">Security is Nuanced</a> by Andrew Nacin.</p>\n<h2>WordCamp Auckland Wapuu!</h2>\n<p>In what is a traditional part of this series, I end each issue by featuring a Wapuu design. For those who don&#8217;t know, Wapuu is the <a href="http://wapuu.jp/2015/12/12/wapuu-origins/">unofficial mascot</a> of the WordPress project.</p>\n<p><img /></p>\n<p>WordCamp <a href="https://2017.auckland.wordcamp.org/">Auckland, New Zealand</a> is this weekend and the event&#8217;s Wapuu is appropriately enough, holding a Kiwi.</p>\n<p>That&#8217;s it for issue eighteen. If you recently discovered a cool resource or post related to WordPress, please share it with us in the comments.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 11 Mar 2017 02:07:14 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:18;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:42:"Matt: Review: From Plato to Post-modernism";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:22:"https://ma.tt/?p=47161";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:58:"https://ma.tt/2017/03/review-from-plato-to-post-modernism/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2379:"<p><img />One thing I&#8217;m going to try this year is to write a review of every book I get a chance to read. It&#8217;s March already so I&#8217;m a bit behind and the next few will be out of order, but this seems like as good a place to start as any.</p>\n<p>One new thing I&#8217;ve been doing this year is listening to audiobooks with an Audible account, so this first book review is actually an audiobook. <a href="http://www.thegreatcourses.com/">Great Courses</a> is actually an old school thing where you could order college lectures on tape. From the references throughout the lectures I listened to, my guess is that the recordings are from the 90s. This one is called <a href="https://www.amazon.com/dp/B00DTO6LZ2/">From Plato to Post-modernism: Understanding the Essence of Literature and the Role of the Author</a> ($25 on Audible, $9.99 on cassette tape <img src="https://s.w.org/images/core/emoji/2.2.1/72x72/1f643.png" alt="🙃" class="wp-smiley" />).</p>\n<p>I really enjoyed this series. Some of the early lectures covering Aristotle, Longinus, and Sidney&#8217;s &#8220;Apology for Poetry&#8221; were quite brilliant. Later ones from Foucault and Derrida on were weaker and harder to follow, which I think is a function of both the material, which can be dense when it starts getting into Modernism, the length, fixed at 30 minutes, and the lecturer, <a href="https://en.wikipedia.org/wiki/Louis_Markos">Louis Markos</a>. Markos teaches <a href="https://www.hbu.edu/contact/louis-markos/">at Houston Baptist University</a> and his asides can sometimes be a little traditional, but in an adorable grandpa way. He has an infectious enthusiasm that makes even the slower chapters on Kant and Schiller bearable, but his love of and fluency in the earlier classics is really a pleasure.</p>\n<p>It made me curious to look into more online lectures and sometime this year I&#8217;m going to check out <a href="https://www.khanacademy.org/partner-content/wi-phi/wiphi-value-theory">this one on Value Theory at Khan academy</a>. I also picked up a used copy of <a href="https://www.amazon.com/gp/product/0155055046/">Critical Theory Since Plato</a> which had the original text for many things discussed in the lecture, so was a great reference point when I was at home in Houston, where I end up listening to most audio content since it&#8217;s a driving town.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 10 Mar 2017 20:48:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:19;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WPTavern: “Open Source in Brazil” eBook Now Available for Free";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66404";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:71:"https://wptavern.com/open-source-in-brazil-ebook-now-available-for-free";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3365:"<a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/02/brazil.jpg?ssl=1"><img /></a>photo credit: <a href="https://commons.wikimedia.org/w/index.php?title=User:Ccarelo&action=edit&redlink=1" class="new" title="User:Ccarelo (page does not exist)">Ccarelo</a> &#8211; <span class="int-own-work" lang="en">Own work</span>, <a href="http://creativecommons.org/licenses/by-sa/3.0" title="Creative Commons Attribution-Share Alike 3.0">CC BY-SA 3.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=40606618">Link</a>\n<p><a href="http://www.oreilly.com/programming/free/files/open-source-in-brazil.pdf" target="_blank">Open Source in Brazil</a> is a new free eBook from O’Reilly Media that offers an inside look into the growth of Brazil&#8217;s free software community despite the country&#8217;s unique barriers. Brazil has a vibrant IT and startup culture and hosts the largest open source conference in Latin America, <a href="http://softwarelivre.org/fisl16" target="_blank">Fórum Internacional Software Livre (FISL)</a>. The conference has been running for 17 years and had 5,200 participants in 2016.</p>\n<p>According to Andy Oram, the book&#8217;s author, open source software is ubiquitous in the country but challenges in business, education, and government have slowed its wider adoption. The book offers a fascinating account of how the free software movement won political favor in the early 2000&#8217;s, launching many governmental initiatives to use open source solutions instead of proprietary software.</p>\n<p>Unfortunately, the government was unable to deliver on these initiatives due to lack of expertise in evaluating software and working with open source communities. These factors, combined with a scarcity of local companies to help bridge the gap, and eventually corruption, caused more delays to converting government operations to open source software. These setbacks resulted in what Oram described as &#8220;inertia and corruption that leave companies and government agencies feeding huge amounts of money into proprietary software that was designed for the North American market.&#8221;</p>\n<p>Brazil has also struggled to keep highly skilled developers who can mentor the next generation due to a &#8220;brain drain&#8221; to international cities with higher wages:</p>\n<blockquote><p>The education of developers that takes place in many developed countries is hampered in Brazil, as in many countries, by a brain drain. Basically, if you become an expert in your technological area, you can get a foreign job that pays more than Brazillian jobs and offers the enticements of living in a major tech center such as London or San Francisco. Thus, the people who could be attending meetups and mentoring the next generation of experts are drawn away.</p></blockquote>\n<p>Despite the free software community&#8217;s temporary loss of momentum, its unique challenges have prompted Brazilian developers to rely less on government support and find new ways of promoting open source software. &#8220;Open Source in Brazil&#8221; is available for free in both <a href="http://www.oreilly.com/programming/free/files/open-source-in-brazil.pdf" target="_blank">English</a> and <a href="http://www.oreilly.com/programming/free/open-source-no-brasil.csp" target="_blank">Portuguese</a>.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 10 Mar 2017 18:19:54 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:20;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"BuddyPress: BuddyPress 2.8.2 Security Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://buddypress.org/?p=264593";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"https://buddypress.org/2017/03/buddypress-2-8-2-security-release/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:843:"<p>BuddyPress 2.8.2 is now available. This is a security release. We strongly encourage all BuddyPress sites to upgrade as soon as possible.</p>\n<p>BuddyPress 2.8.1 and earlier versions were affected by the following three security issues:</p>\n<ol>\n<li>Cross-site request forgery (CSRF) in the XProfile administration Dashboard panel.</li>\n<li>Cross-site request forgery (CSRF) in a number of user-facing AJAX endpoints.</li>\n<li>Cross-site request forgery (CSRF) when dismissing a pending email change.</li>\n</ol>\n<p>These vulnerabilities were reported privately by <a href="https://dk.linkedin.com/in/skansing">Ronnie Skansing</a>. Our thanks to Ronnie for reporting security issues in accordance with <a href="https://make.wordpress.org/core/handbook/testing/reporting-security-vulnerabilities/">WordPress&#8217;s security policies</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 10 Mar 2017 16:04:12 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Boone Gorges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:21;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:74:"WPTavern: WeFoster Launches Hosting Platform Catered to Online Communities";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67151";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:85:"https://wptavern.com/wefoster-launches-hosting-platform-catered-to-online-communities";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5536:"<p><a href="https://wefoster.co/">WeFoster</a>, co-founded by <a href="https://wefoster.co/profiles/marion/profile/">Marion Gooding</a> and <a href="https://wefoster.co/profiles/bowromir/profile/">Bowe Frankema</a>, is a new managed hosting platform fine-tuned specifically for online communities.</p>\n<p>The duo came up with the idea for WeFoster <a href="https://wefoster.co/about/">two years ago</a> at WordCamp London 2015. &#8220;Bowe and I sat down and thought of ideas on how we could contribute to the open source community,&#8221; Gooding said. &#8220;We eventually decided on BuddyPress and to build a business around it. We brainstormed on the basic premise of growing awareness, interest, and the user base of BuddyPress.&#8221;</p>\n<p>While BuddyPress is at the core of what WeFoster does, it isn&#8217;t limited to it. The hosting provider caters to all kinds of community building tools whether its <a href="https://www.peepso.com/">Peepso</a>, <a href="https://s2member.com/">s2Member</a>, or <a href="https://www.memberpress.com/">Memberpress</a>.</p>\n<p>One of the things that sets WeFoster apart is its community creation wizard. Customers are asked a series of questions related to their community. For example, one of the questions asks if you&#8217;d like to have discussion forums. If you answer yes, bbPress will automatically be installed in the background. This process replaces the need to manually search and install a variety of plugins after installing WordPress.</p>\n<img />WeFoster Community Creation Wizard\n<p>When creating a community, customers can select from a set of partner templates. Partner templates are pre-configured WordPress installations setup specifically around a product. Partner templates include a white labeled dashboard allowing partners to brand it to match their product. Partners also receive a variety of other perks.</p>\n<p>The partner program is not an affiliate program and partners are hand selected. The team is looking for partners that are in line with the company&#8217;s vision of building better communities. For more information and to apply to be a partner, check out the <a href="https://wefoster.co/platform/partners/">partner application</a> page.</p>\n<h2>WeFoster Uses Google&#8217;s Cloud Platform</h2>\n<p>WeFoster is built on <a href="https://cloud.google.com/">Google&#8217;s Cloud Platform</a> enabling each site to be hosted in a container separate from others. The technology stack consists of PHP7, Nginx, Redis/Memcached, and MariaDB. If for whatever reason you need to downgrade to PHP 5.6, you can do so at the click of a button.</p>\n<img />Switching PHP Versions\n<p>WeFoster uses a custom caching solution dubbed CommunityCaching that it claims loads sites up to six times faster than traditional shared hosts and almost twice as fast as Managed WordPress hosts.</p>\n<p>The host is also a certified CloudFlare partner taking advantage of CloudFlare&#8217;s data centers located across the world. The partnership provides access to free SSL certificates. All sites created on WeFoster have SSL enabled by default and are served over the <a href="https://www.cloudflare.com/http2/what-is-http2/">HTTP/2 protocol</a>.</p>\n<p>Sites are actively monitored for malware and are backed up to Amazon Secure Storage. Site owners can restore to any point in time since backups are stored indefinitely.</p>\n<h2>Tools for Developers</h2>\n<p>Although WeFoster has focused on eliminating technical hurdles experienced by those who manage online communities, the company didn&#8217;t forget about developers. Each site has a developer section that includes a code editor, database manager, an area for debugging, and other related tools. The code editor is a full-featured IDE that works in the browser. This eliminates the need use an FTP client to upload files to the web server.</p>\n<img />Developer Tools\n<p>Those who manage sites using a command line interface will be happy to know that WeFoster supports <a href="http://wp-cli.org/">WP-CLI</a>.</p>\n<img />WP-CLI Support\n<h2>The WeFoster Community Hub</h2>\n<p>In addition to hosting communities, WeFoster itself <a href="https://wefoster.co/platform/community-features/">is a community</a>. The WeFoster community hub is a place where community builders share advice, network with other builders, and gain access to exclusive resources. Prospecting developers can join the <a href="https://wefoster.co/profiles/type/developers/">developer directory</a> and be part of <a href="https://wefoster.co/platform/community-care/">Community Care</a>. Community Care enables community managers to submit tasks that are then completed by one or more experts from the developer directory for a fee.</p>\n<h2>Co-Founders Give a Guided Tour</h2>\n<p>WeFoster offers a <a href="https://wefoster.co/platform/launch">seven-day free trial</a> for all <a href="https://wefoster.co/platform/pricing/">its plans</a> and will migrate existing communities for free. Prices start at $29 per month for the Village plan and go as high as $249 for the Metropolis plan. If at the end of the trial period you decide not to use the service, remove your payment information so you don&#8217;t get charged.</p>\n<p>What I&#8217;ve highlighted above is only scratching the surface as to what WeFoster offers. To learn and see how it works, watch this 47 minute video where Gooding and Frankema give a guided tour and explain the thought process behind many of its features.</p>\n<div class="embed-wrap"></div>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 10 Mar 2017 06:23:27 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:22;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:118:"WPTavern: Stack Overflow Jobs Data Shows ReactJS Skills in High Demand, WordPress Market Oversaturated with Developers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67202";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:128:"https://wptavern.com/stack-overflow-jobs-data-shows-reactjs-skills-in-high-demand-wordpress-market-oversaturated-with-developers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4805:"<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2016/07/stack-overflow.png?ssl=1"><img /></a></p>\n<p>Stack Overflow published its analysis of <a href="https://stackoverflow.blog/2017/03/09/developer-hiring-trends-2017/" target="_blank">2017 hiring trends</a> based on the targeting options employers selected when posting to <a href="http://stackoverflow.com/jobs" target="_blank">Stack Overflow Jobs</a>. The report, which compares data from 200 companies since 2015, ranks ReactJS, Docker, and Ansible at the top of the fastest growing skills in demand. When comparing the percentage change from 2015 to 2016, technologies like AJAX, Backbone.js, jQuery, and WordPress are less in demand.</p>\n<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/03/ChangesinDemand.png?ssl=1"><img /></a></p>\n<p>Stack Overflow also measured the demand relative to the available developers in different tech skills. The demand for backend, mobile, and database engineers is higher than the number of qualified candidates available. WordPress is last among the oversaturated fields with a surplus of developers relative to available positions.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/HighDemand.png?ssl=1"><img /></a></p>\n<p>In looking at these results, it&#8217;s important to consider the inherent biases within the Stack Overflow ecosystem. In 2016, the site surveyed more than 56,000 developers but noted that the survey was &#8220;biased against devs who don&#8217;t speak English.&#8221; The average age of respondents was 29.6 years old and 92.8% of them were male. </p>\n<p>For two years running, Stack Overflow survey respondents have <a href="https://wptavern.com/stack-overflow-survey-results-show-wordpress-is-trending-up-despite-being-ranked-among-most-dreaded-technologies" target="_blank">ranked WordPress among the most dreaded technologies</a> that they would prefer not to use. This may be one reason why employers wouldn&#8217;t be looking to advertise positions on the site&#8217;s job board, which is the primary source of the data for this report.</p>\n<p>Many IT career forecasts focus more generally on job descriptions and highest paying positions. Stack Overflow is somewhat unique in that it identifies trends in specific tech skills, pulling this data out of how employers are tagging their listings for positions. It presents demand in terms of number of skilled developers relative to available positions, a slightly more complicated approach than measuring demand based on advertised salary. However, Stack Overflow&#8217;s data presentation could use some refining. </p>\n<p>One commenter, Bruce Van Horn, <a href="https://stackoverflow.blog/2017/03/09/developer-hiring-trends-2017/#comment-3194770754" target="_blank">noted</a> that jobs tagged as &#8220;Full Stack Developer&#8221; already assume many of the skills that are listed separately: </p>\n<blockquote><p>I wonder how many of these skills are no longer listed because they are &#8220;table stakes&#8221;. You used to have to put CSS, jQuery, and JSON on the job description. I wouldn&#8217;t expect to have to put that on a Full Stack Developer description today &#8211; if you don&#8217;t know those then you aren&#8217;t a Full Stack Web Developer, and I&#8217;m more interested in whether you know the shiny things like React, Redux, and Angular2.</p></blockquote>\n<p>It would be interesting to know what is meant by tagging &#8220;WordPress&#8221; as a skill &#8211; whether it is the general ability to work within the WordPress ecosystem of tools or if it refers to specific skills like PHP. Browsing a few jobs on Stack Overflow, <a href="http://stackoverflow.com/jobs?sort=i&q=wordpress" target="_blank">WordPress positions</a> vary in the skills they require, such as React.js, Angular, PHP, HTML, CSS, and other technologies. This is a reflection of the diversity of technology that can be leveraged in creating WordPress-powered sites and applications, and several of these skills are listed independently of WordPress in the data. </p>\n<p>Regardless of how much credibility you give Stack Overflow&#8217;s analysis of hiring trends, the report&#8217;s recommendation for those working in technologies oversaturated with developers is a good one: &#8220;Consider brushing up on some technologies that offer higher employer demand and less competition.&#8221; WordPress&#8217; code base is currently <a href="https://www.openhub.net/p/wordpress/analyses/latest/languages_summary" target="_blank">59% PHP and 27% JavaScript</a>. The percentage of PHP has grown over time, but newer features and improvements to core are also being built in JavaScript. These are both highly portable skills that are in demand on the web.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 09 Mar 2017 23:16:02 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:23;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"WPTavern: Google Launches Invisible reCAPTCHA";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67177";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:56:"https://wptavern.com/google-launches-invisible-recaptcha";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4216:"<p>Three years ago Google introduced its new <a href="https://wptavern.com/googles-new-recaptcha-api-replaces-distorted-text-with-a-checkbox" target="_blank">reCAPTCHA v2 API</a>, replacing distorted text challenges with a simple &#8220;I&#8217;m not a robot&#8221; checkbox for validating users. This was a welcome improvement over the fuzzy text in a box that frustrated and infuriated real humans.</p>\n<a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2014/12/recaptcha.png?ssl=1"><img /></a>reCAPTCHA v1\n<a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2014/12/nocaptcha.gif?ssl=1"><img /></a>reCAPTCHA v2 photo credit: <a href="http://googleonlinesecurity.blogspot.com/2014/12/are-you-robot-introducing-no-captcha.html">Google Online Security Blog</a>\n<p>reCAPTCHA v1 is no longer supported as of May 2016 and most sites have moved on to use v2. WordPress.org was one of the early adopters of reCAPTCHA v2 and still uses it to validate users on its <a href="https://login.wordpress.org/register" target="_blank">registration form</a>. </p>\n<p>The evolution of reCAPTCHA technology continues, as Google <a href="https://www.google.com/recaptcha/admin" target="_blank">opened up registration</a> for its new Invisible reCAPTCHA today. With the exception of the &#8220;Protected by reCAPTCHA&#8221; badge on forms, the newest implementation is invisible. It doesn&#8217;t require the user to click anything. Invisible reCAPTCHA validates users in the background and is invoked when the user clicks on an existing button on the site. It can also be invoked by a JavaScript API call. If it deems the traffic to be suspicious, it will require the user to solve a captcha. </p>\n<h3>Invisible reCaptcha for WordPress</h3>\n<p><a href="https://wordpress.org/plugins/invisible-recaptcha/" target="_blank">Invisible reCaptcha for WordPress</a> is the first plugin to implement the new API. It was launched in December 2016, shortly after Invisible reCAPTCHA went into beta. The settings page lets users paste in the site key and secret key Google issues after <a href="https://www.google.com/recaptcha/admin" target="_blank">registering on the reCAPTCHA site</a>.   </p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/invisible-recaptcha-settings.png?ssl=1"><img /></a></p>\n<p>Invisible reCaptcha for WordPress has options to enable protection on the WordPress login, registration, comments, and forgot password forms. It is compatible with WooCommerce for protecting the login, registration, product review, lost password, and reset password forms. The plugin also works with Contact Form 7 to protect form submission.</p>\n<p>On the frontend users will see the &#8220;Protected by reCAPTCHA&#8221; badge. I&#8217;m not fond of the sticky badge on the right side of the viewport that slides out on hover, as it seems too obtrusive. It looks better in the context of the form, and the plugin offers an option to display it inline and add custom CSS.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/invisible-recaptcha-plugin-frontend.png?ssl=1"><img /></a></p>\n<p>After testing the plugin and seeing Invisible reCAPTCHA in action, I was impressed with how easy it was to set up. It took less than a minute to get my site added at Google and the plugin configured. However, I was disappointed that the captcha is not truly invisible. Google&#8217;s overt branding on what is meant to be an invisible product makes it only a slight improvement over the v2 checkbox implementation in terms of what the user sees when interacting with the form. It is possible to hide the badge using CSS but this may violate reCAPTCHA&#8217;s policies, as the badge links to Google&#8217;s terms and privacy documents.</p>\n<p><a href="https://wordpress.org/plugins/invisible-recaptcha/" target="_blank">Invisible reCaptcha for WordPress</a> is free on WordPress.org and should greatly reduce the spam coming through WordPress forms. The plugin is compatible with Multisite and can be activated network-wide or on a single site. Detailed instructions for extending it to protect any plugin or custom form are available on WordPress.org.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 09 Mar 2017 05:13:46 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:24;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:101:"WPTavern: WPWeekly Episode 266 – Clef Is Shutting Down, Configuring User Avatars, and WPCampus 2017";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:58:"https://wptavern.com?p=67181&preview=true&preview_id=67181";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:106:"https://wptavern.com/wpweekly-episode-266-clef-is-shutting-down-configuring-user-avatars-and-wpcampus-2017";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4263:"<p>In this episode, <a href="http://marcuscouch.com/">Marcus Couch</a> and I discuss the stories that are making headlines including, Clef shutting down, WordPress 4.7.3, and WordPress.com&#8217;s new add-on for Chrome. I shared two lessons I recently learned from managing a site that has open registration and uses BuddyPress. We also share details of WPCampus 2017.</p>\n<h2>Stories Discussed:</h2>\n<p><a href="https://wptavern.com/wordpress-4-7-3-patches-six-security-vulnerabilities-immediate-update-advised">WordPress 4.7.3 Patches Six Security Vulnerabilities, Immediate Update Advised</a><br />\n<a href="https://wptavern.com/clef-is-shutting-down-june-6th">Clef is Shutting Down June 6th</a><br />\n<a href="https://wptavern.com/wordpress-com-releases-chrome-add-on-for-google-docs">WordPress.com Releases Chrome Add-On for Google Docs</a><br />\n<a href="https://wptavern.com/freemius-launches-insights-for-wordpress-themes">Freemius Launches Insights for WordPress Themes</a><br />\n<a href="https://wptavern.com/configuring-a-user-avatar-in-wordpress-is-not-as-easy-as-it-should-be">Configuring a User Avatar in WordPress Is Not as Easy as It Should Be</a><br />\n<a href="https://wptavern.com/buddypress-core-contributors-working-on-a-way-to-safely-edit-a-groups-permalink">BuddyPress Core Contributors Working on a Way to Safely Edit a Group’s Permalink</a><br />\n<a href="https://wptavern.com/wpcampus-2017-to-take-place-july-14-15-in-buffalo-ny">WPCampus 2017 to Take Place July 14-15 in Buffalo, NY</a></p>\n<h2>What&#8217;s on WordPress.tv:</h2>\n<p><a href="http://wordpress.tv/2017/03/06/wordpress-community-interview-with-jenny-beaumont/">WordPress Community Interview With Jenny Beaumont </a></p>\n<p>Jenny Beaumont is a multicultural, multidisciplinary maker and writer of things. She is a leader of people and of projects, who values communication above all else as a means to successful collaboration. Jenny and Paolo Belcastro, are the co-organizers of WordCamp Europe. She is the team lead of the local WordPress Community.</p>\n<p><a href="http://wordpress.tv/2017/03/05/rob-ruiz-admin-experience-the-new-ux/">Rob Ruiz: Admin Experience – The New UX</a></p>\n<p>This presentation is part of WordCamp Omaha 2016. Too often, User Experience is only considered on the front-end of a WordPress site design. Although that is very important, too many WP Designers/Developers stop there. This video goes over tricks and methods to make updating and administrating WordPress sites much more user-friendly for the admin/site-owner/client.</p>\n<p><a href="http://wordpress.tv/2016/10/27/chris-klosowski-democratizing-inspiration/">Chris Klosowski: Democratizing Inspiration</a></p>\n<p>This presentation is part of WordCamp Phoenix 2016. All businesses and stories start as an idea. WordPress is a democratized platform for that inspiration, where ideas are empowered to evolve into meaningful products and stories that shape and create the world we want.</p>\n<h2>Plugins Picked By Marcus:</h2>\n<p><a href="https://wordpress.org/plugins/clone-menu/">WP Clone Menu</a> enables you to clone menus using existing menus.</p>\n<p><a href="https://wordpress.org/plugins/list-images-to-optimize/">WordPress List Images to Optimize</a> gives users an idea of which ones need to be optimized or re-uploaded.</p>\n<p><a href="https://wordpress.org/plugins/wp-raffle/">WP Raffle</a> fully automates an online raffle. Simply install, start the appropriate raffle and prizes, and this plugin does the rest; picking the winners at the designated raffle draw date.</p>\n<h2>WPWeekly Meta:</h2>\n<p><strong>Next Episode:</strong> Wednesday, March 15th 3:00 P.M. Eastern</p>\n<p><strong>Subscribe To WPWeekly Via Itunes: </strong><a href="https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via RSS: </strong><a href="https://wptavern.com/feed/podcast" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via Stitcher Radio: </strong><a href="http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr" target="_blank">Click here to subscribe</a></p>\n<p><strong>Listen To Episode #266:</strong><br />\n</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 09 Mar 2017 02:49:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:25;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:73:"WPTavern: Google is Retiring Its Adsense for WordPress Plugin in May 2017";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66886";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"https://wptavern.com/google-is-retiring-its-adsense-for-wordpress-plugin-in-may-2017";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3035:"<p>Google <a href="https://support.google.com/adsense/answer/3380626?hl=en-GB" target="_blank">announced</a> that it is retiring its <a href="https://wordpress.org/plugins/google-publisher/" target="_blank">official Adsense plugin</a>, previously known as the Google Publisher plugin. For the past three years it has allowed WordPress users to easily add Adsense ads to their sites, enable mobile-specific ad layouts, and manage ads with a point-and-click interface. </p>\n<p>&#8220;After reviewing the AdSense Plugin for WordPress, we&#8217;ve decided that in the future we can support WordPress publishers better with new innovative features like our automatic ad formats and other upcoming initiatives,&#8221; Google said. &#8220;As a result, we will be deprecating the AdSense Plugin for WordPress in May 2017.&#8221;</p>\n<p>Google published the following timeline for sunsetting the plugin:</p>\n<ul>\n<li>Early March 2017: New publishers will not be able to sign up for AdSense by using the plugin.</li>\n<li>Early April 2017: Existing publishers will not be able to change their ad settings or ad units through the plugin.</li>\n<li>Early May 2017: Google will no longer provide support for the plugin.</li>\n</ul>\n<p>Although Google&#8217;s Adsense plugin was used by more than 200,000 WordPress sites, the company has not provided support for the plugin for the past two years. It has been poorly reviewed throughout its three-year listing on WordPress.org and is currently hovering at 2.7/5 stars.</p>\n<p>This change will also affect <a href="https://wordpress.org/plugins/search.php?type=term&q=google+adsense" target="_blank">dozens of other Google Adsense plugins</a>, as Google is changing its ad display recommendations and does not endorse or support using any other WordPress plugins for this purpose.</p>\n<p>Affected publishers received an email with information on how to display ads without the plugin. Google recommends deactivating and removing the plugin, followed by using the QuickStart option or creating and placing ad units by inserting the ad code into text widgets. Those who are manually placing ads using widgets will need to make sure they comply with Google&#8217;s detailed <a href="https://support.google.com/adsense/answer/1346295" target="_blank">ad placement policies</a>. </p>\n<p>The new <a href="https://support.google.com/adsense/answer/7171740" target="_blank">QuickStart</a> method is a <a href="https://support.google.com/adsense/answer/6245304" target="_blank">page-level ad format</a> that automatically displays ads at &#8220;optimal times&#8221; when Adsense deems they will perform well and provide a good experience for visitors. These ads can be turned on by placing the QuickStart code within the  tag. It&#8217;s easier to set up but not nearly as flexible as placing ads in text widgets, which can be conditionally displayed or hidden on pages, categories, tags, and post types using widget visibility rules offered in Jetpack or another plugin.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 08 Mar 2017 21:23:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:26;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:37:"Matt: WordPress Collaborative Editing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:22:"https://ma.tt/?p=47145";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:54:"https://ma.tt/2017/03/wordpress-collaborative-editing/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2390:"<p>I&#8217;m really excited about the <a href="https://en.blog.wordpress.com/2017/03/07/introducing-wordpress-com-for-google-docs-a-new-way-forward-for-collaborative-editing/">new Google Docs integration that just launched</a> &#8212; basically it builds a beautiful bridge between what is probably the best collaborative document editor on the planet right now, <a href="https://www.google.com/docs/about/">Google&#8217;s</a>, and let&#8217;s you one-click bring a document there into a WordPress draft with all the formatting, links, and everything brought over. There&#8217;s even a clever feature that if you are copying and pasting from Docs it&#8217;ll tell you about the integration.</p>\n<p>I think this is highly complementary to the work we&#8217;re doing with the new Editor in core WordPress. Why? Google Docs represents the web pinnacle of the WordPerfect / Word legacy of editing &#8220;pages&#8221;, what I&#8217;ll call a document editor. It runs on the web, but it&#8217;s not native to the web in that its fundamental paradigm is still about the document itself. With the new WordPress Editor the blocks will be all about bringing together building blocks from all over &#8212; maps, videos, galleries, forms, images &#8212; and making them like Legos you can use to build a rich, web-native post or page.</p>\n<p>We&#8217;re going to look into some collaborative features, but Google&#8217;s annotations, comments, and real-time co-editing are years ahead there. So if you&#8217;re drafting something that looks closer to something in the 90s you could print out, <a href="https://en.blog.wordpress.com/2017/03/07/introducing-wordpress-com-for-google-docs-a-new-way-forward-for-collaborative-editing/">Docs will be the best place to start and collaborate</a> (and better than Medium). If you want to built a richer experience, something that really only makes sense on an interactive screen, that&#8217;s what the new WordPress editor will be for.</p>\n<p>One final note, the <a href="https://chrome.google.com/webstore/detail/wordpresscom-for-google-d/baibkfjlahbcogbckhjljjenalhamjbp">Docs web store</a> makes it tricky to use different Google accounts to add integrations like this one. To make it easy, open up a Google Doc under the account you want to use, then go to Add-ons -&gt; Get add-ons… -&gt; search for “Automattic&#8221; and you&#8217;ll be all set.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 08 Mar 2017 20:12:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:27;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"HeroPress: Coming Home";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:56:"https://heropress.com/?post_type=heropress-essays&p=1634";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:41:"https://heropress.com/essays/coming-home/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:13077:"<img width="960" height="480" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/030817-min-1024x512.jpg" class="attachment-large size-large wp-post-image" alt="Pull Quote: I love that the WordPress community wants everyone to feel welcome and included," /><p>When I was 17, I attended the school for graphical design and printing. I remember one time a teacher yelling at me: ‘With an attitude like that, you won’t get very far in life’.</p>\n<p>I don’t know why this pops into my mind at the very moment I started to writing this piece for HeroPress. I guess I always wanted to do things my way. I have had pretty strong thoughts about how and why I wanted to do things in life, both personally and work wise.</p>\n<p>I’ve felt a great love for the DIY and making industry all my life, and was surrounded by people in small alternative ecosystems in my early twenties. Doing printing, music, squatting, cooking… those were the days. After a while, I sort of drifted apart. My career and life seemed to go a different way from what I actually loved. However, I did some small DIY internet projects on the computer that I got halfway through the nineties. I built some blogs and figured out how to do html. I was all on the side though, never professional.</p>\n<h3>A New Beginning</h3>\n<p>Around 2002, I really wanted to go away from what I had and dream, make plans and start a new life. So I ditched my management job, husband and newly built house. With a new love in my life, I bought a 150 year old farmhouse in a rural part of the Netherlands. We were busy doing it up and dreamt about starting our own business someday. Not to depend on a time &amp; place based 9-5 job anymore.</p>\n<p>In 2007, we started our own webshop in organic gardening and sustainable, handmade garden tools. I experimented with code, Open Source Systems and SEO. I did graphical design, e-mail marketing, text writing, photography… we grew and grew and grew. And then we hit the ground. We got struck by the crisis and everything fell apart.</p>\n<p>It made me rethink my career and 2011 was the start for me working with WordPress. I had built websites , but never designed a website with a content management system (besides the webshop). I knew WordPress from the dot com blog I had, so after comparing a few systems and asking for advice on Twitter, I decided to have WordPress as a basis for my future work.</p>\n<p>At the time, I didn’t know what WordPress was. I mean, what WordPress really was. Basically it was the software I chose to work with, but that was that. I spent a lot of time finding out about the plugins, themes and adjusting code and css.</p>\n<blockquote><p>But I never knew about the WordPress community that was there, and I wish I had.</p></blockquote>\n<p>Although I’ve learned a great deal from my research and mistakes, it would have been so much easier having the supportive community around in the early days of my life as a web designer.</p>\n<p>It took me quite a while to find out about the WordPress community. I had discovered WordPress support, but never realised these were all hardworking people like me, giving back some time and knowledge to the community without getting paid for it. I guess the anonymity of the internet was part of the reason for me not knowing. At some point I heard about these web developer and design conferences in general, not WordPress specific. It never occurred to me to go there, because I thought I wouldn’t fit in. I didn’t see myself as a real professional, because nearly all my knowledge was self taught. (Later on, I found out that’s the story of nearly everyone I met within the WordPress community). Besides that, designing websites was just part of my job. I also did graphical design, print work, marketing and copywriting. Another reason to feel like a fool among all these smart guys speaking code to each other!</p>\n<h3>A Revelation</h3>\n<p>Only in 2015 things changed. One of my friends told me about Meetups and was surprised I hadn’t heard of it, since I was her geeky friend. But I had been so busy with keeping my head up after breaking up with my boyfriend, building my company, starting a part time study (I decided to get my bachelor on Media, Information an Communication). In the meantime, I had moved to a new part of the Netherlands again. Looking at local Meetups, I found a WordPress Meetup in Rotterdam, approx. 15 minutes by train from where I lived. On a Monday evening, I decided to go there, not knowing anyone attending. I’m not a shy person at all, but sometimes stepping into a new network can be tough, even for extroverts like me.</p>\n<a href="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/rotterdam_meetup-min.jpg"><img class="size-large wp-image-1636" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/rotterdam_meetup-min-1024x633.jpg" alt="Scene from the back of the room, Monique with her hand up to ask a question." width="960" height="593" /></a>Asking a question at the Rotterdam meetup.\n<p>Arriving in the pouring rain, I stepped into the elevator bringing me to the right floor. A friendly women called Marleen stepped in with me and we started talking. We had a good click right away and chatted all evening. She then told me I should go to WordCamp Netherlands later on that year, convincing me I would fit in and it wouldn’t be all development and code boys, but all kinds of people like bloggers, marketeers, teachers or entrepreneurs.</p>\n<blockquote><p>So October 2015 I went to my first WordCamp ever and had a really good time. It definitely was an eye opener.</p></blockquote>\n<p>Finishing my thesis (and moving houses again!), I was too busy looking around, so unfortunately I couldn’t attend any other Meetups after that, but I was determined to go to the next Dutch WordCamp. I started following their Twitter to stay updated. At some point I saw them mentioning a WordCamp Europe. By that time, I hadn’t really figured out this whole WordCamp thing (and certainly hadn’t realised the impact it would have on me later).</p>\n<p>But what? WordCamp Europe? Vienna? End of June? Well that would be a great graduation present after three years of hard work! So I bought myself a ticket. And started to look forward going to a lovely city. As the date got closer, I realised this was much bigger than I expected. Wow, are there really people flying in from all over the world to be here? So it’s not just a Europe-thing? I was getting more and more impressed (and excited) by the day.</p>\n<h3>WordCamp Europe 2017</h3>\n<p>To have some pre-travelling fun, I started following the WordCamp Europe hashtag (<a href="https://twitter.com/search?q=%23wceu">#wceu</a>) on Twitter. Soon, I found out there were all these warmup events and I hooked up with some Dutch WordPressers for a cycling trip through Vienna in the scorching heat. For three hours, we chased our guide Franz through Vienna and I had the best time of my life. Immediately I felt at home with this group that I had never met before, apart from speaking to one of them briefly on WordCamp Netherlands. Apparently they had done a bike tour in Sevilla the year before, and as real Dutchies, they thought to continue the tradition.</p>\n<p>For the next few days, we sort of met on and off, having dinner or drinks with other people they knew. I was impressed with WordCamp itself as well. I don’t think I’ve ever been to an event organised this well. The catering was great, the talks were great and the weather was perfect. The social on Saturday night was unforgettable. All volunteers were so dedicated and the atmosphere all through the event was the best ever. After returning I was so enthusiastic about being part of this, but it was difficult to describe how I really felt. I guess you have to be part of it to know what WordPress really is.</p>\n<blockquote><p>Because WordPress in fact ís the community. I seriously doubt it would exist without the community.</p></blockquote>\n<p>What I found truly amazing about it, is that there is so much respect. People make an effort to make the WordCamps accessible for everyone. Disabled, bad eyesight or hearing: WordCamps are accessible for wheelchairs, have live subtitles on the talks or someone who knows sign language. Children? Of course there’s a child care department, so parents can enjoy the talks as well. Crazy diets? Not one diet is too crazy for WordCamp. Event managers should definitely attend a WordCamp or sign up as a volunteer because they could learn a great deal.</p>\n<p>I love that the WordPress community wants everybody to feel welcome and included. And this is what I thought of when this remark of my teacher popped into my mind. Ever since I was a child, I have a great feeling for justice. I want people to be equal and not being judged on whatever. That’s my attitude he had problems with, because he thought I should adapt to what big bosses would tell me in life and that they would never accept the different opinion I had. Within the WordPress community, I feel that people live by this rule of justice (the code of conduct I think helps a great deal) and it goes without saying. I believe this is very very welcome in times like these and I feel happy that I’ve discovered the WordPress community. It really felt like coming home and meeting people on WordCamps help me keep faith in humanity.</p>\n<a href="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/wordcamp_netherlands2-min.jpg"><img class="size-large wp-image-1638" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/wordcamp_netherlands2-min-1024x536.jpg" alt="WordCamp Netherlands Volunteers" width="960" height="503" /></a>WordCamp Netherlands Volunteers\n<p>I went to the Dutch WordCamp last October, this time giving back a little bit by volunteering. And at the time of writing, I’m looking forward to my next WordCamp which will be in London from 17-19 March. It will be great to go to one of my favourite cities, but I’m excited to go to this WordCamp for more than one reason: I applied and got selected as as speaker! Not that I’m so keen on standing on that stage, but because it’s a great opportunity to for me to share knowledge and learn. Because that’s what WordCamps are for aren’t they?</p>\n<h3>Your Turn</h3>\n<p>So this is a shout out to all WordPress newbies: get your arse over to the nearest WordCamp, you won’t regret it! We were all newbies once too, and we’re all still learning everyday and willing to teach you. We could probably learn from your expertise too!</p>\n<p>At the same time it’s a shout out to the WordPress community too: make it as easy as possible for new people to attend WordCamps. Invite them, buy tickets for them. Make them aware of the added value of the lively WordPress community both offline and online. Maybe it could become part of WordPress news in new installs? A link to all the great resources on <a href="http://wordpress.tv/">WordPress.tv</a> and support, and a notification of <a href="https://central.wordcamp.org/">upcoming WordCamps</a>? I definitely have intentions of visiting as many WordCamps as possible in the years coming, so hopefully I&#8217;ll meet you at one of them!</p>\n<div class="rtsocial-container rtsocial-container-align-right rtsocial-horizontal"><div class="rtsocial-twitter-horizontal"><div class="rtsocial-twitter-horizontal-button"><a title="Tweet: Coming Home" class="rtsocial-twitter-button" href="https://twitter.com/share?text=Coming%20Home&via=heropress&url=https%3A%2F%2Fheropress.com%2Fessays%2Fcoming-home%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-fb-horizontal fb-light"><div class="rtsocial-fb-horizontal-button"><a title="Like: Coming Home" class="rtsocial-fb-button rtsocial-fb-like-light" href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fessays%2Fcoming-home%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-linkedin-horizontal"><div class="rtsocial-linkedin-horizontal-button"><a class="rtsocial-linkedin-button" href="https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fessays%2Fcoming-home%2F&title=Coming+Home" rel="nofollow" target="_blank" title="Share: Coming Home"></a></div></div><div class="rtsocial-pinterest-horizontal"><div class="rtsocial-pinterest-horizontal-button"><a class="rtsocial-pinterest-button" href="https://pinterest.com/pin/create/button/?url=https://heropress.com/essays/coming-home/&media=https://heropress.com/wp-content/uploads/2017/03/030817-min-150x150.jpg&description=Coming Home" rel="nofollow" target="_blank" title="Pin: Coming Home"></a></div></div><a rel="nofollow" class="perma-link" href="https://heropress.com/essays/coming-home/" title="Coming Home"></a></div><p>The post <a rel="nofollow" href="https://heropress.com/essays/coming-home/">Coming Home</a> appeared first on <a rel="nofollow" href="https://heropress.com">HeroPress</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 08 Mar 2017 12:00:56 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"Monique Dubbelman";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:28;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:40:"WPTavern: Clef is Shutting Down June 6th";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66963";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"https://wptavern.com/clef-is-shutting-down-june-6th";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3854:"<p><a href="https://getclef.com/">Clef</a>, a two-factor authentication service founded in 2013 <a href="https://blog.getclef.com/discontinuing-support-for-clef-6c89febef5f3#.9b7u28s9p">has announced</a> that it is discontinuing its product. Clef is most well known for removing the burden of remembering usernames and passwords by replacing them with a 300 character key using mobile cryptography.</p>\n<p>The service&#8217;s <a href="https://wordpress.org/plugins/wpclef">WordPress plugin</a> is active on more than 1M sites and has been removed from the directory. Clef will continue operating until June 6th, 2017. After June 6th, the mobile app will stop functioning and be removed from the Google Play and Apple App stores.</p>\n<p>Users are highly encouraged to transition to a different two-factor authentication provider as soon as possible. Clef has published a <a href="http://support.getclef.com/article/136-transitioning-away-from-clef-for-two-factor-authentication">transition guide</a> to help users switch to <a href="https://wordpress.org/plugins/two-factor/">Two-Factor</a>, <a href="https://www.authy.com/integrations/wordpress/">Authy</a>, or <a href="https://wordpress.org/plugins/google-authenticator/installation/">Google Authenticator</a>.</p>\n<p>The announcement offers few details as to why the service is shutting down. Brennen Byrne, Clef&#8217;s CEO, says the team is joining another company and that more details will be published soon.</p>\n<p>Users and customers reacted to the news by expressing disappointment and sadness in the comments, &#8220;I am very very sad for that,&#8221; Furio Detti said. &#8220;And I must admit a bit disappointed — Clef was clever, clean, quick.&#8221;</p>\n<p>&#8220;I need no more and no other. I’d like to know if the shutdown could be a sign of bad luck in business or a changing of strategy to improve the product. I tried many systems, but CLEF was the very best, the others, almost annoying crap.&#8221;</p>\n<p>Others questioned how the company reached the point of shutting down, &#8220;Has something gone wrong or incredibly right?,&#8221; John Walker asked. &#8220;How can something so useful and reassuring be canned?&#8221;</p>\n<p>&#8220;WordPress installer states over 1 million active users. That’s a lot of websites to just drop without tangible explanation.&#8221;</p>\n<p>The decision to sunset the product was not an easy one, &#8220;We&#8217;ve considered a lot of options for how we can satisfy our responsibility to the folks who have used our product for a long time, but ultimately we felt like this was the only responsible option we could take,&#8221; Byrne said.</p>\n<p>The service offered commercial business plans, including a $1,000 a month plan but couldn&#8217;t find a business model that worked, &#8220;We&#8217;ve been so happy to build a product that people loved and which had widespread adoption in the WordPress community, but we haven&#8217;t been able to find a business model which made the company sustainable,&#8221; he said.</p>\n<p>It&#8217;s evident by the comments that Clef offered something unique. Whether it was the <a href="https://medium.com/@friendly_amy/im-so-sad-to-see-it-go-f978154fda9e?source=responses---------24----------">user experience</a>, <a href="https://medium.com/@zachatkinson85/this-is-very-unfortunate-a27f79d2e7dd?source=responses---------4----------">ease of use</a>, or <a href="https://medium.com/@rogerioleme/too-bad-i-always-enjoyed-the-clef-authenticator-dee40dd7ebf3?source=responses---------3-32---------">working like magic</a>, the service has a devoted fanbase that love the product.</p>\n<p>Please spread the word that Clef is shutting down as potentially thousands of users may not discover it until their keycodes stop working on June 6th.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 08 Mar 2017 09:05:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:29;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:62:"WPTavern: WordPress.com Releases Chrome Add-On for Google Docs";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66941";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"https://wptavern.com/wordpress-com-releases-chrome-add-on-for-google-docs";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3597:"<p>WordPress.com <a href="https://en.blog.wordpress.com/2017/03/07/introducing-wordpress-com-for-google-docs-a-new-way-forward-for-collaborative-editing/" target="_blank">released</a> its new Chrome <a href="https://chrome.google.com/webstore/detail/wordpresscom-for-google-d/baibkfjlahbcogbckhjljjenalhamjbp" target="_blank">Add-on for Google Docs</a> today. The free add-on allows users to edit documents collaboratively in Google Docs and then send the document directly to any WordPress.com site as a draft post. The add-on can also connect to Jetpack-enabled sites, offering the same functionality for self-hosted WordPress users.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/wp-google-docs.jpg?ssl=1"><img /></a></p>\n<p>After installing the add-on from the Google Chrome Store, users will be asked to give permission for it to send posts to WordPress.com. Clicking on the Add-ons menu within the document will open a sidebar where you can add sites. When the document is ready to send to one of your sites, you can click on the &#8220;Save Draft&#8221; button. You&#8217;ll be given a preview link to check out how it looks on the site. </p>\n<p>Ordinarily, copying and pasting content from Google Docs into WordPress results in a messy draft that lacks the same formatting. The new add-on was created to tackle this problem. It duplicates the document&#8217;s images and formatting into WordPress, cutting out a lot of secondary formatting that used to be required.</p>\n<p>&#8220;Collaboration has been a big area of interest for us, and we want to investigate a lot of different approaches,&#8221; Automattic representative Mark Armstrong said. &#8220;Google Docs made perfect sense because it&#8217;s where a lot of people already do collaborative editing. If we could streamline that process for publishing a Google Doc on WordPress, that would help so many people. We&#8217;ve been testing it with publishers and heard a lot of great feedback.&#8221; </p>\n<p>Armstrong didn&#8217;t have any data for how often users paste content from Google docs to WordPress.com, but making content more portable between the two platforms is an often requested feature. The WordPress Plugin Directory has <a href="https://wordpress.org/plugins/search.php?q=Google+Docs" target="_blank">several plugins for embedding Google documents inside content</a> via a shortcode embed or oEmbed, demonstrating that thousands of users are already interested in bringing content over from Google Docs to WordPress.</p>\n<p>After testing the add-on with a sample document that includes special formatting and images, I found that it is a great improvement over the clunky copy and paste experience. Sending posts to WordPress.com is fairly seamless and works as advertised. </p>\n<p>In testing with multiple Jetpack-enabled sites I received some errors when authenticating, which may be due to a security limitation of my host. We had the same issue with the Tavern and were not able to fully test it for self-hosted WordPress sites, but are continuing to investigate the issue. However, other Jetpack-enabled sites are reportedly working with the add-on as expected, according to Armstrong.</p>\n<p>Heavy users of Google Docs and WordPress are excited by the prospect of having the two platforms play nicely together. It saves users quite a bit of time and the new tool will do a lot to bridge the gap for those who rely on Google Docs for collaborative editing. It&#8217;s the next best thing to having collaborative editing built into WordPress. </p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 07 Mar 2017 22:14:37 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:30;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:88:"WPTavern: WordPress 4.7.3 Patches Six Security Vulnerabilities, Immediate Update Advised";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=67001";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:98:"https://wptavern.com/wordpress-4-7-3-patches-six-security-vulnerabilities-immediate-update-advised";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2298:"<p><a href="https://wordpress.org/news/2017/03/wordpress-4-7-3-security-and-maintenance-release/" target="_blank">WordPress 4.7.3</a> is now available with patches for six security vulnerabilities that affect version 4.7.2 and all previous versions. WordPress.org is strongly encouraging users to update their sites immediately. </p>\n<p>The release includes fixes for three XSS vulnerabilities that affect media file metadata, video URLs in YouTube embeds, and taxonomy term names. It also includes patches for three other security issues:</p>\n<ul>\n<li>Control characters can trick redirect URL validation</li>\n<li>Unintended files can be deleted by administrators using the plugin deletion functionality</li>\n<li>Cross-site request forgery (CSRF) in Press This leading to excessive use of server resources</li>\n</ul>\n<p>These vulnerabilities were responsibly disclosed by a variety of different sources contributing to WordPress security.</p>\n<p>Version 4.7.3 is also a maintenance release with fixes for <a href="https://core.trac.wordpress.org/query?status=closed&milestone=4.7.3&group=component&col=id&col=summary&col=component&col=status&col=owner&col=type&col=priority&col=keywords&order=priority" target="_blank">39 issues</a>. This includes a fix for an annoying bug that popped up after 4.7.1 where certain <a href="https://core.trac.wordpress.org/ticket/39550" target="_blank">non-image files failed to upload</a>, giving an error message that said: &#8220;Sorry, this file type is not permitted for security reasons.&#8221; Those who were negatively impacted have been waiting on this fix for two months.</p>\n<p>WordPress sites that haven&#8217;t been updated have been subject to a rash of exploits during the last month after a <a href="https://wptavern.com/wordpress-rest-api-vulnerability-is-being-actively-exploited-hundreds-of-thousands-of-sites-defaced" target="_blank">WP REST API vulnerability was disclosed</a>. Now that the patched vulnerabilities in 4.7.3 are public, it is only a matter of time before hackers begin exploiting sites that do not update. If you have auto-updates on, your site has probably already updated by now. If for some reason you have auto-updates disabled, you will want to manually update as soon as possible.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 07 Mar 2017 20:39:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:31;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:23:"Matt: The Job Interview";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:22:"https://ma.tt/?p=47141";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"https://ma.tt/2017/03/the-job-interview/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:358:"<p>Inc. writes <a href="http://www.inc.com/marcel-schwantes/science-81-percent-of-people-lie-in-job-interviews-heres-what-top-companies-are-.html">The Job Interview Will Soon Be Dead. Here&#8217;s What the Top Companies Are Replacing It With</a>, and looks at how our brains mislead us in interviews and how Menlo Innovations and Automattic approach it.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 07 Mar 2017 11:46:15 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:32;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:64:"WPTavern: NRKbeta Open Sources Comment Quiz Plugin for WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66935";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://wptavern.com/nrkbeta-open-sources-comment-quiz-plugin-for-wordpress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3418:"<p><a href="https://nrkbeta.no" target="_blank">NRKbeta</a>, the Norwegian Broadcasting Corporation&#8217;s media and technology site, is <a href="https://nrkbeta.no/2017/02/13/et-eksperiment-for-et-enda-bedre-kommentarfelt/" target="_blank">experimenting with a new way of keeping comments on topic</a>. A new plugin on the WordPress-powered site aims to ensure commenters have read the article by requiring them to complete a short, three-question quiz before opening the comment form. Visitors who get the questions wrong cannot contribute to the discussion.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/Quiz-1450x1001-e1488844634864.jpg?ssl=1"><img /></a></p>\n<p>The custom plugin was created to narrow the commenting field to those who are operating on a common basis of understanding of the article. It prevents commenters from skimming the article and then going on a rant.</p>\n<p>The NRKbeta team <a href="https://github.com/nrkbeta/nrkbetaquiz" target="_blank">open sourced the plugin on GitHub</a> today. It&#8217;s also in the review queue for the WordPress Plugin Directory and will be available for a one-click install after it passes review.</p>\n<p><a href="https://wordpress.org/plugins/quiz/" target="_blank">Quiz</a> is an another WordPress.org plugin that performs a similar function. Despite not having been updated for two years, the plugin is active on more than 2,000 sites. Post authors can create a question for each post in the &#8220;Comment Quiz&#8221; meta box. The plugin was also designed to help reduce spam comments.</p>\n<p>NRKbeta&#8217;s new Comment Quiz plugin takes a slightly different format, offering multiple choice in the form of radio buttons as well as the ability to add multiple questions. The comment form automatically slides into view after the visitor answers correctly.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/comment-quiz-plugin.png?ssl=1"><img /></a></p>\n<p>The idea of quizzing visitors before allowing them to comment gained quite a bit of interest after NRKbeta announced the experiment, but the publication is still experimenting to see how the quizzes affect commenting. Ensuring that readers have fully read the article comes at the expense of well-intentioned commenters who are now subjected to a time-wasting test. The plugin puts the burden of proof on the commenter in hopes of fewer rants and off-topic responses getting through.</p>\n<p>Some visitors may perceive the quiz as infantilizing potential commenters while others may see it as a mild annoyance. The quiz is a simple hurdle, easy to bypass by guessing until you land on the correct answer. It amounts to more of a speed bump than a true test of having read the article. It doesn&#8217;t take into account that many commenters who are prone to trolling and ranting off topic can be quite motivated and not significantly inconvenienced by a short quiz.</p>\n<p>If the questions are written to condition the commenter for a desired response, then it does little to promote free thinking. This seems like an expensive trade-off for fewer rants in the moderation queue. It all depends on how the publication implements the plugin. Hopefully NRKbeta will report back on how effective the Comment Quiz plugin was at deterring undesirable off-topic responses while retaining level-headed commenters.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 07 Mar 2017 05:15:50 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:33;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:79:"WPTavern: Configuring a User Avatar in WordPress Is Not as Easy as It Should Be";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66954";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:90:"https://wptavern.com/configuring-a-user-avatar-in-wordpress-is-not-as-easy-as-it-should-be";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3135:"<p>I maintain a website with active user registration and a common support question I&#8217;m asked is, &#8220;How do I change my profile picture?&#8221; The answer is not easy as it should be. WordPress&#8217; profile image system is powered by <a href="http://gravatar.com/">Gravatar</a>, an Automattic owned service. It replaced the old method of uploading a profile picture in <a href="https://wordpress.org/news/2008/03/wordpress-25-brecker/">WordPress 2.5 &#8220;Brecker&#8221;</a>.</p>\n<p>The longer I maintain the site, the <a href="https://twitter.com/jeffr0/status/837833604218617856">more frustrated I get</a> that Gravatar is the default way users create and manage their profile image. In the past, I&#8217;ve written how <a href="https://wptavern.com/managing-gravatars-in-wordpress-is-a-jarring-user-experience">managing Gravatars in WordPress</a> is a bad user experience and not much has changed. Many of the people requesting support simply want an Upload button or link that enables them to upload an image and use it as their avatar.</p>\n<p>One way to replace Gravatar is with the<a href="https://wordpress.org/plugins/wp-user-avatars/"> WP User Avatars</a> plugin developed by <a href="https://profiles.wordpress.org/johnjamesjacoby/">John James Jacoby</a>. WP User Avatars is part of the <a href="https://profiles.wordpress.org/stuttter/">Stutter collection</a> of plugins that replaces Gravatar and adds the ability for registered users to upload an image from their machine. Alternatively, users can click the Choose from Media button to choose an image from the Media Library. Existing profile images are preserved.</p>\n<img />WP User Avatar Interface\n<p>I tested the plugin on WordPress 4.7.3 and didn&#8217;t encounter any issues. It&#8217;s worth noting that according to the <a href="https://wordpress.org/plugins/wp-user-avatars/faq/">plugin&#8217;s FAQ</a>, it doesn&#8217;t work well with multisite.</p>\n<p>There has recently been some discussion on a<a href="https://core.trac.wordpress.org/ticket/16020"> six-year-old trac ticket</a> requesting upload functionality for custom avatars. Some have even suggested that <a class="ext-link" href="https://wordpress.org/plugins/simple-local-avatars/">Simple Local Avatars</a>, <a class="ext-link" href="https://wordpress.org/plugins/wp-user-avatar/">WP User Avatar</a> or <a class="ext-link" href="https://wordpress.org/plugins/add-local-avatar/">Add Local Avatar</a> could be merged into core to provide the functionality. All three plugins combined are active on nearly 300K sites.</p>\n<p>The site I administer is the first I&#8217;ve managed in my WordPress career that has open registration. Interacting with registered users who are often new to WordPress has opened my eyes to how bad of an experience configuring an avatar is. Relying on a third-party service as core functionality to manage profile images doesn&#8217;t make any sense.</p>\n<p>Let us know what your experience is like configuring an avatar in WordPress. If you use a plugin that adds local avatar support, share a link to it in the comments.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 22:35:24 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:34;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:92:"WPTavern: BuddyPress Core Contributors Working on a Way to Safely Edit a Group’s Permalink";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66940";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:100:"https://wptavern.com/buddypress-core-contributors-working-on-a-way-to-safely-edit-a-groups-permalink";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3656:"<p>This past weekend while managing a site that runs BuddyPress, I ran into a situation where I needed to change a group&#8217;s slug or permalink. Editing the permalink for a post or page in WordPress is easy but BuddyPress doesn&#8217;t have the same functionality. As you can see in the screenshot below, an edit button to change a group&#8217;s permalink doesn&#8217;t exist.</p>\n<img />No Way to Edit a Group&#8217;s Permalink\n<p>Changing the permalink of a post in WordPress automatically creates a redirect so the previous URL doesn&#8217;t generate a 404 error. BuddyPress doesn&#8217;t offer the same convenience. According to John James Jacoby, BuddyPress lead developer, groups do not have a canonical redirection, or keep track of their slug history.</p>\n<p>In my scenario, I had two choices. I could either change the slug and break a number of links or delete the group and recreate it with the slug of my choice. Since the group already has more than 300 members and a handful of posts, I chose the first option.</p>\n<p>After a cursory search of Google on how to change a group&#8217;s slug, I came across many results that referenced the <a href="https://wordpress.org/plugins/bp-edit-group-slug/">BP Edit Group Slug</a> plugin created by Jacoby that had not been updated in seven years. As recently as two months ago, a <a href="https://buddypress.org/support/topic/changing-the-groups-slug-2/#post-262550">thread on the BuddyPress support forums</a> confirmed that the plugin was broken and generated a lot of errors.</p>\n<p>After speaking to Jacoby on Slack and linking him to the forum thread, he graciously spent two hours of his time to update the plugin. I can confirm that it works as advertised with BuddyPress 2.8.1. To change a group&#8217;s slug after activation the plugin, visit the Group&#8217;s management page on the front-end of the site.</p>\n<img />Editing a Group&#8217;s Slug\n<p>Eight years ago, <a href="https://buddypress.trac.wordpress.org/ticket/281">a ticket was created</a> on BuddyPress trac requesting the ability to change a Group&#8217;s slug. The ticket was eventually closed and labeled wontfix by <a href="https://profiles.wordpress.org/boonebgorges/">Boone Gorges</a>, BuddyPress lead developer, &#8220;Adding it as a core feature is likely to introduce lots of problems, because changed group slugs break all existing links to the content,&#8221; Gorges said. &#8220;We don&#8217;t have a graceful fallback system for changed permalinks, like WP posts do. For now, let&#8217;s leave this to a plugin. If we ever overhaul groups to have a different storage mechanism, we can revisit.&#8221;</p>\n<p>In the BuddyPress Slack channel, David Cavins offered the following idea on how the feature could work, &#8220;We could probably add a step after the lookup fails that looks in another place, like <code>group_meta</code> for key = <code>previous_slug</code> and value = <code>slug that missed a group</code>,&#8221; he said. Both Gorges and Jacoby approved the idea and encouraged Cavins to work on it for BuddyPress core.</p>\n<p>Until the feature is added to core, perhaps a note could be added to the BuddyPress group creation screen for step three that emphasizes how important it is to make sure the permalink is correct.</p>\n<img />BuddyPress Group Creation Step Three\n<p>I was willing to sacrifice broken links in order to have the correct slug for my Group but it&#8217;s a lesson I learned the hard way. I&#8217;m hopeful that others don&#8217;t make the same mistake and that BuddyPress one day has a graceful fallback system for tracking permalink changes.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 22:16:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:35;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:89:"WPTavern: Initial Customizer Survey Results Reveal Majority of Respondents Don’t Use It";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66809";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:97:"https://wptavern.com/initial-customizer-survey-results-reveal-majority-of-respondents-dont-use-it";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5605:"<p>In January 2017, WordPress core design contributors posted a survey titled <a href="https://make.wordpress.org/design/2017/01/27/what-are-you-using-the-customizer-for/" target="_blank">What are you using the Customizer for?</a> The link was published on the Make WordPress Design blog and wasn&#8217;t widely shared, so it only received 50 replies. Responses were anonymous, but most seem to have come from the WordPress developer community.</p>\n<p>Despite the small sample number, the design team deemed the <a href="https://make.wordpress.org/design/2017/03/01/customizer-survey-results/" target="_blank">initial results</a> important enough to share with the community. Responses on the first question show that 53% never or rarely use the Customizer and 7.8% tend to only use it when setting up a site for the first time. Those who do use it (39.3%) range in frequency from monthly, weekly, and daily.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/customizer-survey-results-1.png?ssl=1"><img /></a></p>\n<p>More than half of respondents (53.6%) do not add plugins to extend the Customizer. Those who do are adding plugins for theme options (12.5%), colors (5.4%), layout (7.1%), and other (21.4%). The majority of respondents indicated they use themes that add new functionality to the Customizer (53.9%) and those specified include colors, layout, typography, theme options, and design features.</p>\n<p>When asked if is there anything in the Customizer they cannot live without, 53.2% of respondents said no. This isn&#8217;t surprising given that most of them seem to be developers who are likely familiar with adding custom CSS or making edits to a child theme. Only 6.4% said they could not live without live previews. When asked if there was anything in the Customizer they never use, 31.3% of respondents said &#8220;Everything,&#8221; 20.8% said &#8220;No,&#8221; and the others identified specific features.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/customizer-survey-results-2.png?ssl=1"><img /></a></p>\n<p>The negative comments on the questions are a general indicator of the lingering dissatisfaction with the Customizer. For those who use the feature regularly, one strong theme in their comments is that the separation between what settings are available in the Customizer versus the backend is confusing:</p>\n<blockquote><p>Setting up theme styling, redesigning, setting up sites, etc. Very useful for quick changes like a new header image to change up the look. Wish you could edit everything there instead of going elsewhere to edit content too.</p></blockquote>\n<blockquote><p>I don’t like it and wish that I didn’t have to use it. Most often if there is a setting I had to use the customizer for, I will either forget that something was set in the customizer and end up hunting around for it for a long time before remembering that’s where it was. More often than not the “preview” functionality doesn’t work and you have to save the settings anyway. Also there doesn’t seem to be any consistent logic as to what features should be in the customizer, and theme authors just put whatever they feel like putting in there.</p></blockquote>\n<blockquote><p>What would be great, it is to incorporate more settings in the Customizer in order to avoid the back and forth to set up the site (date format, title, tagline, posts per page, …).</p></blockquote>\n<p>Many users don&#8217;t understand the separation between content and presentation and don&#8217;t approach the Customizer with this mindset. Therefore, the Customizer&#8217;s omissions create a disjointed experience for users who are new to WordPress.</p>\n<blockquote><p>Absolutely! Most of my clients complain about the footer and why is it so difficult to modify something so basic as this sentence: “Proudly powered by WordPress”… It is really nonsense having so many options in customizer and still having to create a child theme only to be able to edit the standard footer sentence… That doesn’t make any sense, really!”</p></blockquote>\n<p>These kinds of frustrations are likely to continue until the Customizer can unify the content and theme editing experience. Currently, the bulk of content editing happens in the admin, but Customizer contributors are working towards adding <a href="https://wptavern.com/customize-posts-plugin-and-selective-refresh-are-paving-the-way-for-front-end-editing-powered-by-the-customizer" target="_blank">frontend editing powered by the Customizer</a>.</p>\n<p>It is difficult to know how to place this data, since the survey didn&#8217;t ask for any information about the respondents&#8217; WordPress background. However, the large number of negative responses underscore the importance of having the Customizer as one of the three focuses for WordPress core development in 2017.</p>\n<p>Customizer component co-maintainer Weston Ruter said he&#8217;s &#8220;not really surprised&#8221; by the negative feedback in the survey, as there are lots of passionate opinions about the Customizer.</p>\n<p>&#8220;Everyone should agree that the Customizer isn&#8217;t a finished product, but the answer to that is to make it a focus and make it the live preview interface that WP needs, not rip it out,&#8221; Ruter said. &#8220;And that focus is what 2017 includes.&#8221;</p>\n<p>The <a href="http://13233232.polldaddy.com/s/what-are-you-using-customizer-for" target="_blank">survey is still open</a>, if you want to contribute more data for the design team to consider.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 19:06:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:36;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Dev Blog: WordPress 4.7.3 Security and Maintenance Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://wordpress.org/news/?p=4696";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"https://wordpress.org/news/2017/03/wordpress-4-7-3-security-and-maintenance-release/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6146:"<p>WordPress 4.7.3 is now available. This is a <strong>security release</strong> for all previous versions and we strongly encourage you to update your sites immediately.</p>\n<p>WordPress versions 4.7.2 and earlier are affected by six security issues:</p>\n<ol>\n<li>Cross-site scripting (XSS) via media file metadata.  Reported by <a href="https://www.securesolutions.no/">Chris Andrè Dale</a>, <a href="https://twitter.com/yorickkoster">Yorick Koster</a>, and Simon P. Briggs.</li>\n<li>Control characters can trick redirect URL validation.  Reported by <a href="http://www.danielchatfield.com/">Daniel Chatfield</a>.</li>\n<li>Unintended files can be deleted by administrators using the plugin deletion functionality.  Reported by <a href="https://hackerone.com/triginc">TrigInc</a> and <a href="http://b.360.cn/">xuliang</a>.</li>\n<li>Cross-site scripting (XSS) via video URL in YouTube embeds.  Reported by <a href="https://twitter.com/marcs0h">Marc Montpas</a>.</li>\n<li>Cross-site scripting (XSS) via taxonomy term names.  Reported by <a href="https://profiles.wordpress.org/deltamgm2">Delta</a>.</li>\n<li>Cross-site request forgery (CSRF) in Press This leading to excessive use of server resources.  Reported by Sipke Mellema.</li>\n</ol>\n<p>Thank you to the reporters for practicing <a href="https://make.wordpress.org/core/handbook/testing/reporting-security-vulnerabilities/">responsible disclosure</a>.</p>\n<p>In addition to the security issues above, WordPress 4.7.3 contains 39 maintenance fixes to the 4.7 release series. For more information, see the <a href="https://codex.wordpress.org/Version_4.7.3">release notes</a> or consult the <a href="https://core.trac.wordpress.org/query?status=closed&milestone=4.7.3&group=component&col=id&col=summary&col=component&col=status&col=owner&col=type&col=priority&col=keywords&order=priority">list of changes</a>.</p>\n<p><a href="https://wordpress.org/download/">Download WordPress 4.7.3</a> or venture over to Dashboard → Updates and simply click “Update Now.” Sites that support automatic background updates are already beginning to update to WordPress 4.7.3.</p>\n<p>Thanks to everyone who contributed to 4.7.3: <a href="https://profiles.wordpress.org/aaroncampbell/">Aaron D. Campbell</a>, <a href="https://profiles.wordpress.org/adamsilverstein/">Adam Silverstein</a>, <a href="https://profiles.wordpress.org/xknown/">Alex Concha</a>, <a href="https://profiles.wordpress.org/afercia/">Andrea Fercia</a>, <a href="https://profiles.wordpress.org/azaozz/">Andrew Ozz</a>, <a href="https://profiles.wordpress.org/asalce/">asalce</a>, <a href="https://profiles.wordpress.org/blobfolio/">blobfolio</a>, <a href="https://profiles.wordpress.org/gitlost/">bonger</a>, <a href="https://profiles.wordpress.org/boonebgorges/">Boone Gorges</a>, <a href="https://profiles.wordpress.org/bor0/">Boro Sitnikovski</a>, <a href="https://profiles.wordpress.org/bradyvercher/">Brady Vercher</a>, <a href="https://profiles.wordpress.org/drrobotnik/">Brandon Lavigne</a>, <a href="https://profiles.wordpress.org/bhargavbhandari90/">Bunty</a>, <a href="https://profiles.wordpress.org/ccprog/">ccprog</a>, <a href="https://profiles.wordpress.org/ketuchetan/">chetansatasiya</a>, <a href="https://profiles.wordpress.org/davidakennedy/">David A. Kennedy</a>, <a href="https://profiles.wordpress.org/dlh/">David Herrera</a>, <a href="https://profiles.wordpress.org/dhanendran/">Dhanendran</a>, <a href="https://profiles.wordpress.org/dd32/">Dion Hulse</a>, <a href="https://profiles.wordpress.org/ocean90/">Dominik Schilling (ocean90)</a>, <a href="https://profiles.wordpress.org/drivingralle/">Drivingralle</a>, <a href="https://profiles.wordpress.org/iseulde/">Ella Van Dorpe</a>, <a href="https://profiles.wordpress.org/pento/">Gary Pendergast</a>, <a href="https://profiles.wordpress.org/iandunn/">Ian Dunn</a>, <a href="https://profiles.wordpress.org/ipstenu/">Ipstenu (Mika Epstein)</a>, <a href="https://profiles.wordpress.org/jnylen0/">James Nylen</a>, <a href="https://profiles.wordpress.org/jazbek/">jazbek</a>, <a href="https://profiles.wordpress.org/jeremyfelt/">Jeremy Felt</a>, <a href="https://profiles.wordpress.org/jpry/">Jeremy Pry</a>, <a href="https://profiles.wordpress.org/joehoyle/">Joe Hoyle</a>, <a href="https://profiles.wordpress.org/joemcgill/">Joe McGill</a>, <a href="https://profiles.wordpress.org/johnbillion/">John Blackbourn</a>, <a href="https://profiles.wordpress.org/johnjamesjacoby/">John James Jacoby</a>, <a href="https://profiles.wordpress.org/desrosj/">Jonathan Desrosiers</a>, <a href="https://profiles.wordpress.org/ryelle/">Kelly Dwan</a>, <a href="https://profiles.wordpress.org/markoheijnen/">Marko Heijnen</a>, <a href="https://profiles.wordpress.org/matheusgimenez/">MatheusGimenez</a>, <a href="https://profiles.wordpress.org/mnelson4/">Mike Nelson</a>, <a href="https://profiles.wordpress.org/mikeschroder/">Mike Schroder</a>, <a href="https://profiles.wordpress.org/codegeass/">Muhammet Arslan</a>, <a href="https://profiles.wordpress.org/celloexpressions/">Nick Halsey</a>, <a href="https://profiles.wordpress.org/swissspidy/">Pascal Birchler</a>, <a href="https://profiles.wordpress.org/pbearne/">Paul Bearne</a>, <a href="https://profiles.wordpress.org/pavelevap/">pavelevap</a>, <a href="https://profiles.wordpress.org/peterwilsoncc/">Peter Wilson</a>, <a href="https://profiles.wordpress.org/rachelbaker/">Rachel Baker</a>, <a href="https://profiles.wordpress.org/reldev/">reldev</a>, <a href="https://profiles.wordpress.org/sanchothefat/">Robert O&#8217;Rourke</a>, <a href="https://profiles.wordpress.org/welcher/">Ryan Welcher</a>, <a href="https://profiles.wordpress.org/sanketparmar/">Sanket Parmar</a>, <a href="https://profiles.wordpress.org/seanchayes/">Sean Hayes</a>, <a href="https://profiles.wordpress.org/sergeybiryukov/">Sergey Biryukov</a>, <a href="https://profiles.wordpress.org/netweb/">Stephen Edgar</a>, <a href="https://profiles.wordpress.org/triplejumper12/">triplejumper12</a>, <a href="https://profiles.wordpress.org/westonruter/">Weston Ruter</a>, and <a href="https://profiles.wordpress.org/wpfo/">wpfo</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 17:53:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"James Nylen";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:37;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:84:"Post Status: Making a living without client work, with Carrie Dils — Draft podcast";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"https://poststatus.com/?p=34997";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:69:"https://poststatus.com/making-living-without-client-work-carrie-dils/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3279:"<p>Welcome to the Post Status <a href="https://poststatus.com/category/draft">Draft podcast</a>, which you can find <a href="https://itunes.apple.com/us/podcast/post-status-draft-wordpress/id976403008">on iTunes</a>, <a href="https://play.google.com/music/m/Ih5egfxskgcec4qadr3f4zfpzzm?t=Post_Status__Draft_WordPress_Podcast">Google Play</a>, <a href="http://www.stitcher.com/podcast/krogsgard/post-status-draft-wordpress-podcast">Stitcher</a>, and <a href="http://simplecast.fm/podcasts/1061/rss">via RSS</a> for your favorite podcatcher. Post Status Draft is hosted by Brian Krogsgard and this episode&#8217;s special guest, Carrie Dils.</p>\n<p><span>Carrie Dils has been self-employed for a long time. After years of client work, she now makes her full-time living through multiple different channels, but is not currently doing client services. In this episode, Brian and Carrie talk about various methods for generating revenue, and some helpful tools to do so.</span></p>\n<a href="https://audio.simplecast.com/61980.mp3">https://audio.simplecast.com/61980.mp3</a>\n<p><a href="https://audio.simplecast.com/61980.mp3">Direct Download</a></p>\n<h3>Links</h3>\n<ul>\n<li><a href="http://waitbutwhy.com/2013/10/why-procrastinators-procrastinate.html">Why Procrastinators Procrastinate</a></li>\n<li><a href="https://convertkit.com">ConvertKit</a></li>\n<li><a href="https://mailchimp.com">Mailchimp</a></li>\n<li><a href="https://chimpessentials.com/">Chimp Essentials Mailchimp course</a></li>\n<li><a href="https://officehours.fm/podcast/136-2/">Paul Jarvis on Carrie&#8217;s podcast</a></li>\n<li><a href="https://pjrvs.com/signup/">Sunday Dispatches</a></li>\n<li><a href="http://www.nerdmarketing.com/">Nerd Marketing</a></li>\n<li><a href="https://amylynnandrews.com/">Amy Lynn Andrews</a></li>\n<li><a href="https://en.todoist.com/">Todoist</a></li>\n<li><a href="https://simplenote.com/">Simplenote</a></li>\n<li><a href="http://gettingthingsdone.com/">Getting Things Done</a></li>\n<li><a href="https://1password.com/">1Password</a></li>\n<li><a href="https://poststatus.com/art-self-employed-web-consultant-draft-podcast/">Interview with Diane Kinney</a></li>\n</ul>\n<h3>Links to Carrie&#8217;s Work</h3>\n<ul>\n<li><span><a href="https://carriedils.com/business-lessons/">Experience as an Uber driver</a> </span></li>\n<li><span><a href="https://officehours.fm">Office Hours</a> </span></li>\n<li><span><a href="https://carriedils.com/blog/">Carrie’s blog</a> </span></li>\n<li><a href="https://carriedils.com/courses/"><span>WordPress courses </span></a></li>\n<li><span><a href="https://store.carriedils.com/downloads/utility-pro/">Utility Pro theme</a> </span></li>\n<li><span><a href="http://realworldfreelancing.com/">Real World Freelancing book</a> </span></li>\n</ul>\n<h3>Sponsor: Prospress</h3>\n<p><span><a href="https://prospress.com/">Prospress</a>  makes the WooCommerce Subscriptions plugin, that enables you to turn your online business into a recurring revenue business. Whether you want to ship a box or setup digital subscriptions like I have on Post Status, Prospress has you covered. Check out <a href="https://prospress.com/">Prospress.com</a> for more, and thanks to Prospress for being a Post Status partner.</span></p>\n<p><em>Photo by Karyn Kelbaugh</em></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 06 Mar 2017 15:44:48 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Katie Richards";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:38;a:6:{s:4:"data";s:11:"\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:27:"HeroPress: HeroPress at 100";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://heropress.com/?p=1639";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:39:"https://heropress.com/heropress-at-100/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5332:"<img width="960" height="547" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/heropress_media-1024x583.png" class="attachment-large size-large wp-post-image" alt="HeroPress Media Thumbnails" /><p>March 8th we&#8217;ll have 100 HeroPress essays published. This seems like an auspicious time to look back at what we&#8217;ve built.</p>\n<p>Since the first one I&#8217;ve only missed maybe 2 weeks. One essay has been taken down for security reasons. Only once has anyone really stood me up, and only four times or so has anyone asked for more time at the last second. In those times someone always stepped up.</p>\n<p>A goal of mine has always been diversity, across a number of vectors. I did pretty poorly in the first few months and ended up with diversity debt. Here are some stats as of the 100th post:</p>\n<table border="1">\n<tbody>\n<tr>\n<th>Men</th>\n<th>Women</th>\n<th>Americans</th>\n<th>Non-Americans</th>\n</tr>\n<tr>\n<td>55</td>\n<td>44</td>\n<td>34</td>\n<td>66</td>\n</tr>\n</tbody>\n</table>\n<p>That said, if you look at the last 50, the numbers look much more diverse:</p>\n<table border="1">\n<tbody>\n<tr>\n<th>Men</th>\n<th>Women</th>\n<th>Americans</th>\n<th>Non-Americans</th>\n</tr>\n<tr>\n<td>22</td>\n<td>26</td>\n<td>16</td>\n<td>34</td>\n</tr>\n</tbody>\n</table>\n<p>I have the next 8 contributors planned out, and they continue to enhance the diversity of HeroPress.</p>\n<h3>Sponsorship</h3>\n<p>Last June XWP started sponsoring HeroPress. As I&#8217;ve mentioned many times before, I&#8217;m wary of mixing money with HeroPress, because I never want to make money from the stories of these people I admire and respect so much. That said, the sponsorship makes it easier for me to spend the time away from my family working on HeroPress. Some wise people have told me that using money appropriately won&#8217;t lose me any real friends, so there we are.</p>\n<p>If you&#8217;re interested in talking to me about sponsorship, just send me an email, topher at this domain.</p>\n<h3>The Future</h3>\n<p>I don&#8217;t have any plans for changing the way essays work. I have people lined up through the end of April. I&#8217;ve recently found some new ways to find WordPressers in places I couldn&#8217;t access before, and I&#8217;m excited about the new places we&#8217;re going to hear about.</p>\n<p>I&#8217;ve been talking for months about doing a podcast. It would simply be me and someone far away from me talking about how they work and live. I hesitate to talk to Americans, because I already know how they live and work, but on the other hand, people outside America might be interested. We&#8217;ll see what happens after some research.</p>\n<p>I have some ideas about scholarships and software accessibility programs, but I&#8217;m still putting those together. I&#8217;ve recently been contacted by another organization that wants to work together on a scholarship, and that sounds exciting.  Again, we&#8217;ll see what happens.</p>\n<h3>Thanks</h3>\n<p>I&#8217;d like to thanks everyone that&#8217;s been involved in making HeroPress great.  At this point there are too many to name. Those of you that have tweeted, blogged, podcasted, and generally spread the word are amazing. Thanks to those that have written essays especially.  Without contributors HeroPress wouldn&#8217;t exist at all.</p>\n<p>Thanks to those that have facilitated getting me to WordCamps like Pune, Europe, and US.</p>\n<p>Lastly, thanks to those that have committed to the future of HeroPress. I&#8217;m looking forward to all the things to come.</p>\n<div class="rtsocial-container rtsocial-container-align-right rtsocial-horizontal"><div class="rtsocial-twitter-horizontal"><div class="rtsocial-twitter-horizontal-button"><a title="Tweet: HeroPress at 100" class="rtsocial-twitter-button" href="https://twitter.com/share?text=HeroPress%20at%20100&via=heropress&url=https%3A%2F%2Fheropress.com%2Fheropress-at-100%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-fb-horizontal fb-light"><div class="rtsocial-fb-horizontal-button"><a title="Like: HeroPress at 100" class="rtsocial-fb-button rtsocial-fb-like-light" href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fheropress-at-100%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-linkedin-horizontal"><div class="rtsocial-linkedin-horizontal-button"><a class="rtsocial-linkedin-button" href="https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fheropress-at-100%2F&title=HeroPress+at+100" rel="nofollow" target="_blank" title="Share: HeroPress at 100"></a></div></div><div class="rtsocial-pinterest-horizontal"><div class="rtsocial-pinterest-horizontal-button"><a class="rtsocial-pinterest-button" href="https://pinterest.com/pin/create/button/?url=https://heropress.com/heropress-at-100/&media=https://heropress.com/wp-content/uploads/2017/03/heropress_media-150x150.png&description=HeroPress at 100" rel="nofollow" target="_blank" title="Pin: HeroPress at 100"></a></div></div><a rel="nofollow" class="perma-link" href="https://heropress.com/heropress-at-100/" title="HeroPress at 100"></a></div><p>The post <a rel="nofollow" href="https://heropress.com/heropress-at-100/">HeroPress at 100</a> appeared first on <a rel="nofollow" href="https://heropress.com">HeroPress</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 05 Mar 2017 16:15:10 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:39;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:108:"WPTavern: Web Annotations are Now a W3C Standard, Paving the Way for Decentralized Annotation Infrastructure";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66802";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:118:"https://wptavern.com/web-annotations-are-now-a-w3c-standard-paving-the-way-for-decentralized-annotation-infrastructure";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:13734:"<a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2016/02/writing.jpg?ssl=1"><img /></a>photo credit: <a href="https://stocksnap.io/photo/8Y0EDX4VP9">Green Chameleon</a>\n<p><a href="https://www.w3.org/blog/news/archives/6156" target="_blank">Web annotations</a> became a W3C standard last week but the world hardly noticed. For years, most conversations on the web have happened in the form of comments. Annotations are different in that they usually reference specific parts of a document and add context. They are often critical or explanatory in nature.</p>\n<p>One of the key differences between comments and web annotations, according to the new standard, is that annotations were designed to be decentralized, creating &#8220;a new layer of interactivity and linking on top of the Web.&#8221; Comments are published by the publisher at the same location as the original content, but web annotation content is owned by the reader. Annotations don&#8217;t have to be published on the original content. The reader has the choice to publish using an &#8220;annotation service&#8221; or their own website.</p>\n<p>Doug Schepers, former Developer Relations Lead at W3C, described the difference between annotating and commenting on an <a href="http://thewebahead.net/60" target="_blank">episode on The Web Ahead podcast</a>:</p>\n<blockquote><p>When a comment is at the bottom of a page, it&#8217;s so abstracted out from the rest. They get off track, they start talking about other things that have nothing to do with the original article. If it&#8217;s an even vaguely political topic, you&#8217;ve got the partisans jumping in, yelling at one another, how they&#8217;re all idiots. You lose track with the content of the article. There&#8217;s this viscerality, this immediacy, of actually commenting on something in its context.</p></blockquote>\n<p>Do people want to annotate the web? Popular implementations of this concept, such as <a href="https://genius.com/web-annotator" target="_blank">Genius Web Annotator</a> and Medium&#8217;s annotation-style commenting, show that people enjoy interacting on the web in this way. The W3C Web Annotation Working Group&#8217;s goal in standardizing the technology behind web annotations was to produce a set of specifications for &#8220;interoperable, sharable, distributed Web Annotation architecture,&#8221; enabling healthy competition between services and discouraging publisher lock-in.</p>\n<p>Decentralization is critical to unlocking the full potential of annotations on the web. If commenters have control of their own content, they have the freedom to publish it wherever they like. Open comments sections can sometimes offer the illusion of discourse, but are ultimately under the control of the publisher. This is obvious if you&#8217;ve ever seen a controversial blog post, which should undoubtedly have comments with varying viewpoints, but the only comments published are those in agreement with the author.</p>\n<p>&#8220;This notion that whoever controls the original source also controls the dialog &#8211; that&#8217;s dangerous,&#8221; Schepers said. &#8220;This is why I like the idea of annotations. It&#8217;s inherent in the idea of annotations, this indie web aspect of, &#8216;I want to control what I say, what channels it goes out to.&#8217; I can&#8217;t control who puts it into a different channel but I can control what channels I try to put it out into. I can actively publish in multiple channels.&#8221;</p>\n<h3>Hypothesis Plugin Brings Web Annotations to WordPress</h3>\n<p><a href="https://hypothes.is" target="_blank">Hypothesis</a> is a non-profit organization that is building an open platform for annotation on the web, based on the <a href="http://annotatorjs.org/" target="_blank">Annotator.js</a> library. It allows readers to highlight text and select whether they want to annotate it or highlight it.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/hypothesis-annotations.png?ssl=1"><img /></a></p>\n<p>The Hypothes.is community has an ecosystem of <a href="https://hypothes.is/tools-plug-ins-and-integrations/" target="_blank">tools and integrations</a> for various technologies and publishing platforms, including WordPress. The <a href="https://wordpress.org/plugins/hypothesis/" target="_blank">Hypothesis plugin on WordPress.org</a> offers the same functionality that you see on the Hypothesis website with the ability to select text and have a sidebar slide out for taking notes. Annotation requires an account with Hypothesis. You can test it by pasting any link into the tool on the <a href="https://hypothes.is/" target="_blank">Hypothesis</a> homepage.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/03/annotating.png?ssl=1"><img /></a></p>\n<p>The mission of the Hypothesis project is &#8220;to bring a new layer to the web&#8221; that enables conversations on top of the world&#8217;s collected knowledge. The project also allows you to publish annotations privately, creating your own personal notebook of observations as you surf the web.</p>\n<p>The Hypothesis plugin allows users to customize the defaults and behavior and control where it&#8217;s loaded (front page, blog page, posts, pages, etc.) Highlights can be on or off by default and the sidebar can be collapsed or open. Annotations can also be enabled on PDFs in the Media Library. Hypotheses can be allowed/disallowed on a list of specific posts or pages, which is helpful for sites where the author may only want annotation on scholarly material.</p>\n<p><a href="https://github.com/kshaffer/hypothesis_aggregator" target="_blank">Hypothesis Aggregator</a> is another plugin for WordPress that offers a shortcode with different parameters for displaying annotations from the service. It allows site owners to display a collection of annotations from a certain user or topic.</p>\n<p><code>[hypothesis user = ''kris.shaffer'']</p>\n<p>[hypothesis tags = ''IndieWeb'']</p>\n<p>[hypothesis text = "Domain of One''s Own"]</p>\n<p>[hypothesis user = ''kris.shaffer'' tags = ''IndieEdTech'']</code></p>\n<p>The output includes a link to the original content, the highlighted text, the annotation, and the person who curated it.</p>\n<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/03/hypothesis-aggregator.png?ssl=1"><img /></a></p>\n<p>Kris Shaffer, the plugin&#8217;s author, is considering adding support for multiple tags (in both AND and OR configurations) as well as the ability to embed a single annotation in a post, like users can with a tweet.</p>\n<p>The Hypothesis network of annotators is growing, along with the vast collection of knowledge that is getting linked and added every day. The service just completed a record month with nearly 6,000 annotators contributing content.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">A record month <a href="https://twitter.com/hypothes_is">@hypothes_is</a> in February: almost 6K active annotators made 112,385 <a href="https://twitter.com/hashtag/annotations?src=hash">#annotations</a>. Did you help? <a href="https://t.co/R2DZaf6D7i">https://t.co/R2DZaf6D7i</a> <a href="https://t.co/HWNVUXUS9s">pic.twitter.com/HWNVUXUS9s</a></p>\n<p>&mdash; Hypothes.is (@hypothes_is) <a href="https://twitter.com/hypothes_is/status/836993180486684672">March 1, 2017</a></p></blockquote>\n<p></p>\n<p>Members of the Hypothesis team are principal contributors to the Annotator project and the organization was also deeply involved in the effort to make web annotations a W3C standard. The Hypothesis community tools are quite frequently used in the context of scholarly or academic dialogue, but the app aims to bring annotation to all types of websites, including news, blogs, scientific articles, books, terms of service, ballot initiatives, legislation, and more.</p>\n<p>In a <a href="https://www.youtube.com/watch?v=2jTctBbX_kw" target="_blank">presentation</a> at the Personal Democracy Forum in 2013, Dan Whaley, founder and CEO of Hypothesis, described the organization&#8217;s motivation behind annotating all of the web&#8217;s collective knowledge:</p>\n<blockquote><p>Think back 1,000 years, reflect on the key documents produced over that time, like the Magna Carta in 1215 or the Declaration of Independence, for which we only have the document itself. What we&#8217;re missing are the notes passed between co-authors in the drafting, the reviews by others providing feedback on early versions. We lack the perception by the public immediately after and most of the fine-grained citations, quotations, and reuse in the intervening years. Those incessant arguments about why the founding fathers chose this or that particular phrasing &#8211; what if we had a much better idea, the direct record of their internal deliberations? There&#8217;s no shortage of things to annotate, and there&#8217;s more knowledge being created per minute now than ever before &#8211; laws, scientific articles, news, books, tweets, data &#8230;but our tools are crude, balkanized, ill-preserved, and even then only available on a small minority of what&#8217;s important.</p></blockquote>\n<p>The idea of web annotations is to capture the surrounding conversation that doesn&#8217;t necessarily fit into traditional comments, preserving it in a way that is open, sharable, and cooperates nicely with other technologies using the web&#8217;s standard.</p>\n<h3>What Does the W3C Standard Mean for the Future of Annotations?</h3>\n<p>Web annotation seems to promote more critical thinking and collaboration but it&#8217;s doubtful that it would ever fully replace commenting systems. The two serve different purposes and it&#8217;s more likely that annotations will serve to supplement conversations on the web. Not everyone is fond of the current implementations of annotation UI, which require visitors to keep clicking on things as they are reading.</p>\n<p>Despite being first being introduced to the web in the Mosaic browser prototype in 1993, annotation tools are still in their infancy. In a <a href="https://genius.com/Marc-andreessen-why-andreessen-horowitz-is-investing-in-rap-genius-annotated" target="_blank">post</a> announcing Andreessen Horowitz&#8217;s $15 million investment in Rap Genius, Marc Andreesen describes how the technology was almost built into the first web browser:</p>\n<p>&#8220;Only a handful of people know that the big missing feature from the web browser – the feature that was supposed to be in from the start but didn&#8217;t make it – is the ability to annotate any page on the Internet with commentary and additional information.&#8221;</p>\n<p>The implementation was pulled not too long after, because they didn&#8217;t have the capabilities required to host all the annotations and have it scale. For the past 24 years, various companies and organizations have taken a stab at bringing this feature back to the web &#8211; all with varying approaches that don&#8217;t necessarily play well together. That&#8217;s why the W3C standard is an important development.</p>\n<p>&#8220;While Hypothesis and others are already enabling annotation to take place over any page on the Web, a standard means that there is additional incentive for browser vendors to include this functionality natively,&#8221; Dan Whaley <a href="https://hypothes.is/blog/annotation-is-now-a-web-standard/" target="_blank">said</a>. &#8220;The more that these new collaborative layers are present without any additional action on the part of the user, the more their use will grow.&#8221;</p>\n<p>Whaley also said the new W3C standard should send a strong signal to those who have developed proprietary annotation implementations, such as Genius, Readcube, Medium, and Amazon (Kindle).</p>\n<p>&#8220;These technical recommendations have the weight of the web community behind them and can be relied upon,&#8221; Whaley said. &#8220;Our hope is that the standard will not only encourage others to adopt its technical approach, but also ultimately to open their platforms.&#8221;</p>\n<p>In an ideal world, Doug Schepers sees annotation as a feature that is &#8220;baked straight into the web,&#8221; where all users can choose where their content is published. Annotation services would then offer the ability for users to choose which syndicators and aggregators the content is going out to. Publishers in turn would have the ability to consume annotation content and bring it back through their commenting system if they feel it adds value.</p>\n<p>&#8220;We can refine things over time,&#8221; Schepers said. &#8220;We can improve our culture over time. It sounds kind of lofty and maybe sort of abstract, but I think that&#8217;s what annotations can help us do. It can actually increase the growth of ideas and not the suppression of ideas. It can improve how we create our culture in a more conscious way, in a way that includes more critical thinking.&#8221;</p>\n<p>Schepers said it&#8217;s too soon to know how the future will unfold for web annotations and whether or not browsers will be interested in supporting them natively. Annotations may be relegated to live in script libraries forever if they don&#8217;t catch on with browsers. Like any new layer of interaction on the web, it&#8217;s worth building to see how the initial idea evolves based on where the users take it.</p>\n<p>&#8220;I don&#8217;t know what&#8217;s going to happen with annotations,&#8221; Schepers said. &#8220;That&#8217;s what I&#8217;m excited by. I can think of all sorts of things that might happen with annotations if we truly enable this, but I&#8217;m more looking forward to the things that I didn&#8217;t see coming at all.&#8221;</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 03 Mar 2017 23:02:35 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:40;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:63:"WPTavern: WPCampus 2017 to Take Place July 14-15 in Buffalo, NY";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66607";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"https://wptavern.com/wpcampus-2017-to-take-place-july-14-15-in-buffalo-ny";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6398:"<img />WPCampus Date\n<p><span class="st">After the inaugural </span> WPCampus concluded <a href="https://2016.wpcampus.org/">in 2016</a>, organizers <a href="https://wptavern.com/wpcampus-is-accepting-applications-to-host-the-event-in-2017">put out a call</a> for campuses across the country to host the event in 2017. The WPCampus planning committee has <a href="https://2017.wpcampus.org/2017/02/23/announcing-second-annual-wpcampus-conference/">announced</a> that <a href="https://2017.wpcampus.org/">WPCampus 2017</a> will be held July 14-15, at <a href="https://2017.wpcampus.org/venue/">Canisius College</a> in Buffalo, New York.</p>\n<p>In addition to announcing the date, the committee is accepting <a href="https://2017.wpcampus.org/call-for-speakers/">speaker submissions</a> and <a href="https://2017.wpcampus.org/sponsors/">looking for sponsors</a>. Speaker submissions will be accepted until March 24th, 2017.</p>\n<p>Rachel Carden, a Senior Software Engineer for Disney Interactive, came up with the idea for WPCampus in a Tweet published in August, 2015. Since then, the community has grown to more than 500 members.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Ooh. Dream with me: "<a href="https://twitter.com/hashtag/WordCampus?src=hash">#WordCampus</a>: A WordCamp for folks using <a href="https://twitter.com/hashtag/WordPress?src=hash">#WordPress</a> in Higher Education." I like it. <a href="https://twitter.com/hashtag/heweb?src=hash">#heweb</a> <a href="https://t.co/m1zEkpkP4B">https://t.co/m1zEkpkP4B</a></p>\n<p>&mdash; Rachel Carden (@bamadesigner) <a href="https://twitter.com/bamadesigner/status/628324358126235648">August 3, 2015</a></p></blockquote>\n<p></p>\n<h2>Interview With Rachel Carden</h2>\n<p><strong>What did you learn from organizing the first WPCampus that will improve the second event?</strong></p>\n<p>Most of the lessons learned from WPCampus 2016 involved logistics. A brand new community planning a brand new event with very minimal people &#8216;on the ground&#8217; was challenging but, clearly, not impossible.</p>\n<p>Most of the changes we’ve implemented have been on how to make the time we spend planning more efficient, especially since we are an entirely volunteer-driven organization spread out all over the world.</p>\n<p>Overall, our first event was a success but there’s always little notes you take away for the next go round, like &#8216;make sure we take the group photo BEFORE everyone leaves&#8217; and highlighted at the top of the list: &#8216;make sure we have candy again.&#8217;</p>\n<p>Ultimately, our main priority is to ensure attendees aren’t worrying about the &#8216;where&#8217;, &#8216;what&#8217;, and &#8216;how&#8217; so they can instead focus on learning, networking, and making the most out of our short time together. This means taking notice of how we can improve communication, signage, etc.</p>\n<p>&#8216;The secret of all victory lies in the organization of the non-obvious&#8217; could not be more true. The biggest question we asked ourselves after WPCampus 2016 was &#8216;how can we create more opportunities for diverse interaction and discussion?&#8217;</p>\n<p>Our planning team has some great ideas and we’re excited to experiment a little, to see how a conference might be able to drive development outside the usual sessions and lightning talks. We’re really excited for what’s in store for our next event.</p>\n<p><strong>Will there be another WordPress in higher education survey?</strong></p>\n<p>I hope so! If not, it won’t be for lack of desire. Last <a href="https://wptavern.com/wpcampus-survey-results-indicate-misconceptions-of-wordpress-are-slowing-its-growth-in-higher-education">year’s survey</a> offered an incredible amount of insight and data into how WordPress is being used in higher education. It would be great to see what has changed. Stay tuned!</p>\n<p><strong>Why was Canisius College chosen for the event?</strong></p>\n<p>We had some amazing universities apply and invite us all to their campus. An honor for which we are most grateful and appreciative. As was the case with WPCampus 2016, it was really hard to pick just one but ultimately, it comes down to what we believe is best overall for our attendees.</p>\n<p>We even have a grading matrix because, of course we do, we’re in higher education. Canisius College is a beautiful campus in a great location, especially since a majority of the WPCampus community is located in the eastern U.S. and Canada.</p>\n<p>The team at Canisius has also been extremely supportive and is working hard to make sure we have a great time in their top-notch facilities. Buffalo is also a great city with amazing architecture, food, and scenery that we’re excited to explore.</p>\n<h2>WPCampus Is Aiming for Sessions With a Variety of Perspectives</h2>\n<p>For a glimpse into what WPCampus <a href="https://2017.wpcampus.org/about/">is all about</a>, check out these recaps from those who attended the event in 2016. You can also watch most of the sessions from the event via the <a href="https://2016.wpcampus.org/schedule/">schedule page</a>.</p>\n<ul>\n<li><a href="https://calderawp.com/2016/07/wpcampus-2016-recap/">WPCampus 2016 Recap</a></li>\n<li><a href="https://www.thewpcrowd.com/wordpress/wordcamps/wpcampus-2016/">WPCampus 2016: WordPress in Higher Education</a></li>\n<li><a href="https://wpdistrict.sitelock.com/blog/wp-campus-a-wordpress-event-focused-on-higher-education/">WPCampus – A WordPress Event Focused on Higher Education</a></li>\n<li><a href="http://davidbisset.com/wpcampus-review/">WPCampus Review</a></li>\n</ul>\n<p>Registration is not yet available but will open soon.</p>\n<p>&#8220;We aim for our session topics to be a good mix of WordPress in higher ed as well as solely higher ed and solely WordPress,&#8221; Carden said.</p>\n<p>&#8220;We recognize the value and inspiration in all perspectives. We hope the general WordPress community, and other higher ed communities, will see the value in investing in WPCampus and its mission to advance higher education by lending their time, knowledge and experience.&#8221;</p>\n<p>To receive updates related to the event, you can follow <a href="https://twitter.com/wpcampusorg">WPCampus</a> on Twitter or keep an eye on the <a href="https://2017.wpcampus.org/announcements/">announcements page</a>.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 03 Mar 2017 17:24:55 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:41;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"Matt: Henry Crown Fellowship";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:22:"https://ma.tt/?p=47132";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:45:"https://ma.tt/2017/03/henry-crown-fellowship/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:645:"<p>I&#8217;m very excited to have been selected to join the <a href="http://agln.aspeninstitute.org/fellowships/henrycrown/classes/XXI">Henry Crown Fellowship Class of 2017</a>. Many, many folks I admire including Reed Hastings, Kim Polese, Cory Booker, Aileen Lee, Stephen DeBerry, Deven Parekh, Chris Sacca, Tim Ferriss, Reid Hoffman, Scott Heiferman, Troy Carter, Bre Pettis, Lupe Fiasco, and Alexa von Tobel have been through the program in previous years, and several of those people have spoken highly of it to me. I&#8217;m excited to meet and get to know the rest of the 2017 class, and embark on a learning journey alongside them.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 03 Mar 2017 16:27:48 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:42;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:83:"WPTavern: Do You Enjoy WordPress Meetups? Let the Community Marketing Team Know Why";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66806";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:93:"https://wptavern.com/do-you-enjoy-wordpress-meetups-let-the-community-marketing-team-know-why";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2722:"<p>When Matt Mullenweg, co-founder of the WordPress project, delivers his annual <a href="https://ma.tt/2016/12/state-of-the-word-2016/">State of The Word presentation</a>, he always gives props to meetup organizers and attendees. In 2016, there were 3,193 meetup events in 58 countries attended by 62,566 people. <a href="https://www.meetup.com/topics/wordpress/">Meetups</a> are one of the cornerstones of the community and for many are the gateway to discovering WordPress.</p>\n<p>In an effort to raise awareness of the project and its community, the Community Marketing team, a subgroup of the <a href="https://make.wordpress.org/marketing/">Marketing team</a>, is asking volunteers to <a href="https://make.wordpress.org/community/2017/03/01/meetup-video-testimonials-we-need-your-help/">record video testimonials</a> at WordCamps and meetups in March and April. The team wants to hear stories from users on why they use WordPress and how they&#8217;ve benefited from attending meetups.</p>\n<p>Other questions to consider asking include:</p>\n<ul>\n<li>How long have you been using WordPress.</li>\n<li>What brought you to the Meetup?</li>\n<li>How has coming to this Meetup affected you?</li>\n</ul>\n<p>Videos should be 1-5 minutes in length and <a href="http://wordpress.tv/submit-video/">uploaded to WordPress.tv</a> under the Testimonies category. Ideal recording conditions are a quiet room with decent lighting and good audio. Recordings can be planned or spontaneous and minimal post production editing is encouraged. Also consider making the videos more accessible by adding <a href="https://wordpress.tv/using-amara-org-to-caption-or-subtitle-a-wordpress-tv-video/">captions and translations</a>.</p>\n<p>The idea has received positive feedback with meetup attendees and organizers stating their <a href="https://make.wordpress.org/community/2017/03/01/meetup-video-testimonials-we-need-your-help/#comment-23138">intention to participate</a>. For an example on how to record WordPress testimonials, check out this video by Troy Dean where he interviews attendees at <a href="http://wordpress.tv/event/wordcamp-sunshine-coast-2016/">WordCamp Sunshine Coast</a> 2016.</p>\n<div class="embed-wrap"></div>\n<p>If there&#8217;s not a <a href="https://www.meetup.com/topics/wordpress/">WordPress meetup</a> in your area, consider organizing one yourself using <a href="https://wptavern.com/guide-to-starting-and-maintaining-a-wordpress-meetup">our guide</a>. For additional advice, I recommend this <a href="http://ithemes.com/publishing/run-wordpress-meetup/">free ebook by iThemes</a> that includes interviews with several organizers who share their experience managing meetups.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 02 Mar 2017 23:56:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:43;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:63:"WPTavern: WordPress.com Announces New Importer for Medium Posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66836";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:74:"https://wptavern.com/wordpress-com-announces-new-importer-for-medium-posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6732:"<a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2016/08/typewriter.jpg?ssl=1"><img /></a>photo credit: <a href="https://stocksnap.io/photo/4OURRGDU7Z">Sergey Zolkin</a>\n<p>Medium started 2017 on uncertain footing, <a href="https://blog.medium.com/renewing-mediums-focus-98f374a960be#.xij39212w" target="_blank">laying off a third of its staff</a> in January after admitting that its ad-based business model was not working.</p>\n<p>&#8220;We had started scaling up the teams to sell and support products that were, at best, incremental improvements on the ad-driven publishing model, not the transformative model we were aiming for,&#8221; Medium CEO Ev Williams said. &#8220;To continue on this trajectory put us at risk — even if we were successful, business-wise — of becoming an extension of a broken system. Upon further reflection, it’s clear that the broken system is ad-driven media on the internet.&#8221;</p>\n<p>Williams said that Medium will be taking &#8220;a different, bolder approach&#8221; to this problem of driving payment for quality content but that &#8220;it is too soon to say exactly what this will look like.&#8221; Medium may be <a href="https://twitter.com/rrhoover/status/827340315681923072" target="_blank">experimenting with paid subscriptions</a> in the future, but the company has yet to articulate its next strategy for monetization.</p>\n<h3>WordPress.com Now Offers an Importer Tool for Medium</h3>\n<p>Publishers that don&#8217;t want to stick around for Medium&#8217;s next round of experimentation can now easily migrate to WordPress. Automattic <a href="https://en.blog.wordpress.com/2017/03/02/import-your-medium-posts-to-wordpress-com/" target="_blank">announced</a> a new Medium importer for WordPress.com today and the company also plans to make it available to self-hosted WordPress sites through Jetpack.</p>\n<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/03/wordpressdotcom-medium-importer.png?ssl=1"><img /></a></p>\n<p>Medium users can export content to a zip file and then upload it into WordPress.com&#8217;s import tool. The import includes posts, tags, images, and videos and takes approximately 15 minutes to complete. Previously, Medium sites could be imported into WordPress using an RSS importer plugin, but there were significant drawbacks to this approach. WordPress.com&#8217;s importer tool takes this into account.</p>\n<p>&#8220;Using the provided RSS file from Medium&#8217;s export archive was not sufficient, because some of the post data, like embeds, is missing,&#8221; Automattic developer Marko Andrijašević said. &#8220;Because of that, we are combining the data available in RSS and exported HTML files to accurately reproduce the post&#8217;s content.&#8221;</p>\n<p>Medium hasn&#8217;t made it easy for publishers to leave with their full content and has changed the format of its exports multiple times in the past. Andrijašević said this is one of the reasons it took WordPress.com so long to add an importer, along with the fact that the provided data in the exported archive was not sufficient to import everything correctly.</p>\n<p>&#8220;We’ll have Jetpack support coming soon for self-hosted sites,&#8221; Andrijašević said. &#8220;One other workaround for self-hosted site owners would be to use the Medium importer on WordPress.com, and then generate a WXR (WordPress eXtended RSS) file with our exporter. The WXR can then be used with WordPress importer on any self-hosted site.&#8221;</p>\n<p>In addition to its uncertain future and unsightly permalinks, Medium gives users plenty of other reasons to be wary of the platform. <a href="https://www.buzzfeed.com/charliewarzel/when-you-launch-your-publication-the-same-day-medium-changes" target="_blank">Publishers were not notified in advance</a> about the company&#8217;s &#8220;renewed focus&#8221; and its plan to abandon the advertising model. Medium&#8217;s product is its users&#8217; content and the company&#8217;s <a href="https://medium.com/policy/medium-terms-of-service-9db0094a1e0f#.c309bw63n" target="_blank">terms of service</a> state that it can use that content to promote its own products and services, enable advertising, and &#8220;remove any content you post for any reason.&#8221;</p>\n<p>Part of the appeal of Medium is that it removes the burden of site management. Publishers are now expected to navigate things like AMP, FB Instant Articles, social networks, and SEO to drive traffic to their websites. With Medium, publishers are trading site ownership for convenience. If the company is not able to find a workable way to monetize users&#8217; content, it has a very real chance of joining the hundreds of <a href="https://indieweb.org/site-deaths" target="_blank">blogging silos that have died</a> or been bought by a competitor simply to be shut down and have their technology reabsorbed.</p>\n<p>Medium&#8217;s publishing experience is entirely geared towards making the company successful by monetizing the efforts of publishers on its network. In a post titled <a href="http://practicaltypography.com/billionaires-typewriter.html" target="_blank">The Billionaire&#8217;s Typewriter</a>, Matthew But­t­er­ick writes about how the platform&#8217;s limitations on features and customization are designed to &#8220;let Medium extract value from the talent and labor of others.&#8221; He describes digital sharecropping in its shiniest form:</p>\n<blockquote><p>Be­cause in re­turn for that snazzy de­sign, Medium needs you to relinquish con­trol of how your work gets to readers.</p>\n<p>Tempt­ing per­haps. But where does it lead? I fear that writ­ers who limit them­selves to pro­vid­ing “con­tent” for some­one else’s “branded plat­form” are go­ing to end up with as much lever­age as cows on a dairy farm.</p>\n<p>Medium is a new kind of type­writer—the bil­lion­aire’s type­writer. It’s not the only bil­lion­aire’s type­writer. So is the Kin­dle. So is iBooks. So is Twit­ter. <strong>What dis­tin­guishes these new type­writ­ers is not the pos­si­bil­i­ties they make available to writers, but what they take away.</strong></p></blockquote>\n<p>Publishers who want to determine the trajectory and reach of their own work need to migrate to a more stable platform where they have full control of their content. It&#8217;s not yet clear how Medium plans to monetize in the future, but the company will undoubtedly continue reaping the economic rewards of its publishers&#8217; work. Whether you choose open source software or some other avenue, it&#8217;s worth leaving Medium&#8217;s grand experiment in order to own your own work.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 02 Mar 2017 22:10:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:44;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:63:"WPTavern: WPWeekly Episode 265 – Interview with Matt Medeiros";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:58:"https://wptavern.com?p=66822&preview=true&preview_id=66822";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:70:"https://wptavern.com/wpweekly-episode-265-interview-with-matt-medeiros";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3596:"<p>In this episode, <a href="http://marcuscouch.com/">Marcus Couch</a> and I are joined by <a href="http://craftedbymatt.com/">Matt Medeiros</a>, co-founder of <a href="http://slocumstudio.com/">Slocum Studio</a>. Medeiros developed <a href="https://conductorplugin.com/">Conductor</a>, a WordPress plugin that enables people to display content in blocks, similar to the approach that <a href="https://wptavern.com/wordpress-core-editor-team-publishes-ui-prototype-for-gutenberg-an-experimental-block-based-editor">WordPress core is taking</a>. He shares his thoughts and opinions on core&#8217;s approach and how it might impact the content builder market.</p>\n<p>Since Medeiros co-founded Slocum Studio with his father, Mark Medeiros, we discover what it&#8217;s like to operate a web development agency with a family dynamic. Last but not least, he shares his experience in the <a href="https://slocumthemes.com/">commercial theme market</a> and gives us a first-hand account of what it was like to go through the <a href="https://make.wordpress.org/themes/handbook/review/">theme review process</a>. Based on the experience, Medeiros says he will not submit new themes to the directory.</p>\n<h2>Stories Discussed:</h2>\n<p><a href="https://wptavern.com/nextgen-gallery-patches-critical-sql-injection-vulnerability">NextGEN Gallery Patches Critical SQL Injection Vulnerability</a><br />\n<a href="https://wptavern.com/amazon-s3-outage-hits-wordpress-businesses-disrupting-service-and-support">Amazon S3 Outage Hits WordPress Businesses, Disrupting Services and Support</a><br />\n<a href="https://wptavern.com/freemius-launches-insights-for-wordpress-themes">Freemius Launches Insights for WordPress Themes</a></p>\n<h2>Plugins Picked By Marcus:</h2>\n<p><a href="https://wordpress.org/plugins/woo-simple-ads-server/">WooCommerce Simple Ads Server</a> lets you create ads and campaigns for selling your own WooCommerce products on other websites. It lists all of your WooCommerce products on the back-end with options to create and assign banners for each product. It also provides all the scripts and embed codes necessary for your banners.</p>\n<p><a href="https://wordpress.org/plugins/wp-keyword-monitor/">WP Keyword Monitor</a> uses the official API from Google to track your organic keyword rankings. You can track up to 100 keywords per day. This plugin provides full reports and displays a running graph of your rankings and statistics over time.</p>\n<p><a href="https://wordpress.org/plugins/private-uploads/">Private Uploads</a> protects sensitive uploaded files so that only logged-in users can access them. This plugin moves your designated private files to a separate folder and configures the web server to ask WordPress to authenticate access to files in that folder. It&#8217;s more efficient than similar plugins because it only rubs when serving files in the private folders.</p>\n<h2>WPWeekly Meta:</h2>\n<p><strong>Next Episode:</strong> Wednesday, March 8th 3:00 P.M. Eastern</p>\n<p><strong>Subscribe To WPWeekly Via Itunes: </strong><a href="https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via RSS: </strong><a href="https://wptavern.com/feed/podcast" target="_blank">Click here to subscribe</a></p>\n<p><strong>Subscribe To WPWeekly Via Stitcher Radio: </strong><a href="http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr" target="_blank">Click here to subscribe</a></p>\n<p><strong>Listen To Episode #265:</strong><br />\n</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 01 Mar 2017 23:28:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:45;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:48:"HeroPress: WordPress Opened Up a Whole New World";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:56:"https://heropress.com/?post_type=heropress-essays&p=1620";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"https://heropress.com/essays/wordpress-opened-whole-new-world/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:10886:"<img width="960" height="480" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/030117-1024x512.jpg" class="attachment-large size-large wp-post-image" alt="Pull Quote: If it hadn''t been for WordPress, I would never have experience being part of an open-source community." /><h3>Before WordPress</h3>\n<p>Several years ago, I went through a tough time in my life. I lost my job and I was desperately in need of a career change. Because of the economic climate in Zimbabwe, I didn&#8217;t see many options, but I felt that IT held the most promising future.</p>\n<p>So I completed an A+ course and obtained a CCNA certification. Unfortunately, in Zimbabwe, skills and certifications were not enough to secure meaningful employment. Being a college drop-out, I didn&#8217;t have the required diploma or degree that employers were looking for.</p>\n<p>That&#8217;s when I enrolled in a diploma in management of information systems. In this course, there was a module called “Programming and Web Design”. I was introduced to HTML, CSS and Javascript, among other programming languages. But it was only an introduction… it wasn&#8217;t enough to be able to create my own website.</p>\n<p>After graduating, I studied online tutorials and learned how to create a website. That was the beginning of my personal website, franksweb.org, a static HTML website that I created from scratch.</p>\n<p>Not long after that, I was hired by an an online design and marketing firm that was looking for a web developer. To my surprise, I found that they only used content management systems (CMS) to create websites. No one was making static HTML websites!</p>\n<p>Joomla! was the preferred CMS at this company. It wasn&#8217;t until I was assigned to create a website for a local recording artist that I discovered WordPress. I was searching for templates that suited the client&#8217;s needs and discovered a template that just happened to be WordPress!</p>\n<p>I had heard of WordPress, even though they didn&#8217;t teach us about content management systems in my diploma course. All I knew was that WordPress was a free blogging service.</p>\n<blockquote><p>I had no idea how much more was possible using WordPress.</p></blockquote>\n<p>I soon discovered the numerous advantages of using WordPress over Joomla! (There&#8217;s a reason why 27% of the web uses WordPress, whereas Joomla! is used by only 3%!) Soon after, I re-designed <a href="https://franksweb.org/" target="_blank">franksweb.org</a> using WordPress. So began my love affair with WordPress.</p>\n<h3>Freelancing</h3>\n<p>After having worked for my employer for a little over one and a half years, receiving a very small salary, the time came for me to move on. My employer had been failing to pay our salaries and owed me a lot of money in back pay (which has never been paid to me to this day). So I had no choice but to leave and I started freelancing.</p>\n<p>Since I started freelancing, all the websites I&#8217;ve created for my clients (except for one) have been WordPress sites. WordPress has empowered me to make a living from creating functional websites that are easy to manage for my clients.</p>\n<p>Here in Zimbabwe, very few web designers and web developers create static HTML websites. The majority use content management systems, and for good reason. Of course, the overwhelming majority are WordPress sites. This is just a testament to how WordPress makes our jobs easier and the potential to make money using WordPress.</p>\n<h3>The WordPress Community</h3>\n<p>One thing that we were taught in my diploma course was the importance of continuous professional development (CPD). That, and the fact that I had a genuine passion for all things WordPress, led me to soak up anything WordPress-related that I could get my hands on. I watched a lot of Morten Rand-Hendriksen&#8217;s tutorials on lynda.com to advance my skills. The WordPress.org website became a permanent tab on my desktop whenever you opened my web browser (my “WordPress Bible”). I also made sure the “WordPress News” box was always open in all my Dashboards so I could keep up with the latest in WordPress.</p>\n<p>One day I saw a <a href="https://wptavern.com/" target="_blank">WPTavern</a> article in my Dashboard calling for applications to participate in the first WordCamp incubator program. I was very interested since Zimbabwe had never had a WordCamp before. I didn’t know of anyone else in Harare who had the same desire but I applied anyway.</p>\n<p>More than a hundred cities applied so I honestly wasn’t expecting my application to be chosen, especially because of the challenges that my country is facing.</p>\n<blockquote><p>I was shocked when I got an email from Rocio Valdivia and Hugh Lashbrooke saying they wanted to interview me for the incubator program.</p></blockquote>\n<p>Later on, I received an email from Andrea Middleton saying my application to be a WordCamp organizer had been accepted! This was a very exciting time for me. It was now going to be possible to experience the things I had read about the WordPress Community here in Zimbabwe, too.</p>\n<a href="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/meetup_at_CSZ-min.jpeg"><img class="size-large wp-image-1627" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/meetup_at_CSZ-min-1024x576.jpeg" alt="First meetup at the Computer Society of Zimbabwe, August 20, 2016" width="960" height="540" /></a>First meetup at the Computer Society of Zimbabwe, August 20, 2016\n<p>The first thing that I needed to do was start a monthly WordPress meetup group in Harare because there was no regular meetup that I was aware of, and therefore no real WordPress Community. It was a struggle but thanks to the guidance and support of WordCamp Central, and the support of the <a href="http://www.csz.org.zw/" target="_blank">Computer Society of Zimbabwe</a>, we were able to have meetups and the membership grew.</p>\n<blockquote><p>Months later, we hosted the very first WordCamp in Zimbabwe: WordCamp Harare 2016.</p></blockquote>\n<p>It was a success and much better than I thought it would be. Along with our monthly meetups, WordCamp did a lot to promote awareness of the WordPress Community. Since then, quite a number of local WordPress users have become active in the WordPress Community. I absolutely love hosting meetups and sharing knowledge about something which I am passionate about.</p>\n<a href="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/wordcamp_at_harare_city_library-min.jpg"><img class="size-large wp-image-1628" src="http://20094-presscdn.pagely.netdna-cdn.com/wp-content/uploads/2017/03/wordcamp_at_harare_city_library-min-1024x678.jpg" alt="First WordCamp Harare at Harare City Library" width="960" height="636" /></a>First WordCamp Harare at Harare City Library\n<p>On a personal level, working with the WordPress Community opened up a world that I didn&#8217;t know existed within WordPress. I got to know so many amazing people and everyone has been helpful and kind. The WordPress Community is made up of people who are generous and willing to give their time and share knowledge with others. For me, it is very fulfilling to be able to give back to something which I have benefited from so much.</p>\n<p>One of the highlights of WordCamp for me was meeting Job Thomas and Herman Kok, two of our speakers who came from South Africa. They both work for <a href="https://automattic.com/" target="_blank">Automattic</a>, the company that owns WordPress.com, WooCommerce, Jetpack and other WordPress-related products. (Before I became active in the WordPress Community, I had no idea Automattic had an office in South Africa!) Talking to them, I got a strong sense that they were passionate, not only about what they do, but about sharing their knowledge and experience with others.</p>\n<p>I was encouraged and inspired to apply to work for Automattic. The position that I wish to apply for is called “Happiness Engineer”. Basically, your job is customer support. For me, this is a dream job: getting paid to do something that I have a passion for which is share my knowledge of WordPress with others. They say that if you find something that you love to do, you&#8217;ll never work another day in your life. So currently, I spend time helping other users in Automattic product forums in order to gain more direct experience before I apply.</p>\n<p>This past year has been an awesome journey for me. If it wasn&#8217;t for WordPress, I would never have experienced being part of an open-source community and the doors that have opened for me. There are so many awesome people that I never would have gotten to know. WordPress truly changed my life.</p>\n<div class="rtsocial-container rtsocial-container-align-right rtsocial-horizontal"><div class="rtsocial-twitter-horizontal"><div class="rtsocial-twitter-horizontal-button"><a title="Tweet: WordPress Opened Up a Whole New World" class="rtsocial-twitter-button" href="https://twitter.com/share?text=WordPress%20Opened%20Up%20a%20Whole%20New%20World&via=heropress&url=https%3A%2F%2Fheropress.com%2Fessays%2Fwordpress-opened-whole-new-world%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-fb-horizontal fb-light"><div class="rtsocial-fb-horizontal-button"><a title="Like: WordPress Opened Up a Whole New World" class="rtsocial-fb-button rtsocial-fb-like-light" href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fessays%2Fwordpress-opened-whole-new-world%2F" rel="nofollow" target="_blank"></a></div></div><div class="rtsocial-linkedin-horizontal"><div class="rtsocial-linkedin-horizontal-button"><a class="rtsocial-linkedin-button" href="https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fessays%2Fwordpress-opened-whole-new-world%2F&title=WordPress+Opened+Up+a+Whole+New+World" rel="nofollow" target="_blank" title="Share: WordPress Opened Up a Whole New World"></a></div></div><div class="rtsocial-pinterest-horizontal"><div class="rtsocial-pinterest-horizontal-button"><a class="rtsocial-pinterest-button" href="https://pinterest.com/pin/create/button/?url=https://heropress.com/essays/wordpress-opened-whole-new-world/&media=https://heropress.com/wp-content/uploads/2017/03/030117-150x150.jpg&description=WordPress Opened Up a Whole New World" rel="nofollow" target="_blank" title="Pin: WordPress Opened Up a Whole New World"></a></div></div><a rel="nofollow" class="perma-link" href="https://heropress.com/essays/wordpress-opened-whole-new-world/" title="WordPress Opened Up a Whole New World"></a></div><p>The post <a rel="nofollow" href="https://heropress.com/essays/wordpress-opened-whole-new-world/">WordPress Opened Up a Whole New World</a> appeared first on <a rel="nofollow" href="https://heropress.com">HeroPress</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 01 Mar 2017 12:00:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Thabo Tswana";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:46;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:91:"WPTavern: HackerOne Launches Free Community Edition for Non-Commercial Open Source Projects";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66592";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:102:"https://wptavern.com/hackerone-launches-free-community-edition-for-non-commercial-open-source-projects";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5076:"<p><a href="https://i2.wp.com/wptavern.com/wp-content/uploads/2017/02/hackerone-logo.png?ssl=1"><img /></a></p>\n<p><a href="https://www.hackerone.com" target="_blank">HackerOne</a>, the vulnerability coordination and bug bounty platform, has launched a new <a href="https://www.hackerone.com/product/community" target="_blank">Community Edition</a> for open source projects. The company is built around the notion that, &#8220;given enough eyeballs, all vulnerabilities are shallow.&#8221; HackerOne announced a <a href="https://www.hackerone.com/blog/The-best-security-initiative-you-can-take-in-2017" target="_blank">$40 million round of funding</a> earlier this month, which allows the company to expand its market and add new features to the platform.</p>\n<p>Open source projects are one area where HackerOne is expanding its reach. The company participates in the <a href="https://internetbugbounty.org/" target="_blank">Internet Bug Bounty</a> program, which helps secure core internet infrastructure and open source software, but HackerOne is now opening up its own platform.</p>\n<p>&#8220;One of the goals I have had in my work with HackerOne is to build an even closer bridge between HackerOne and the open source community,&#8221; community strategy consultant Jono Bacon said. Bacon <a href="http://www.jonobacon.org/2017/02/09/hackerone-professional-free-open-source-projects/" target="_blank">announced</a> the availability of HackerOne&#8217;s new <a href="https://www.hackerone.com/product/community" target="_blank">Community Edition</a>, which has not yet been formally announced but is already open for applicants.</p>\n<p>The Community Edition has all the same features as HackerOne&#8217;s Professional Edition, including vulnerability submission/coordination, duplicate detection, hacker reputation, analytics, and more. The only difference is that it doesn&#8217;t include paid customer support and program assistance. It also integrates with many popular issue tracking tools, such as JIRA, GitHub, Bugzilla, Zendesk, Track, and others.</p>\n<p><a href="https://i1.wp.com/wptavern.com/wp-content/uploads/2017/02/hackerone-community-edition.png?ssl=1"><img /></a></p>\n<p>Although the name &#8220;Community Edition&#8221; might suggest to some that it is self-hosted, HackerOne actually provides it as a SaaS offering with no setup or deployment required.</p>\n<p>Open source projects are eligible if they meet a few requirements:</p>\n<ul>\n<li>Must be open source projects covered by an <a href="https://opensource.org/licenses" target="_blank">OSI license</a></li>\n<li>Be active and at least 3 months old (age is defined by shipped releases/code contributions)</li>\n<li>Include a SECURITY.md in the project root that provides details for how to submit vulnerabilities (<a href="https://github.com/discourse/discourse/blob/master/docs/SECURITY.md" target="_blank">example</a>)</li>\n<li>Display a link to your HackerOne profile from either the primary or secondary navigation on the project&#8217;s website</li>\n<li>Maintain an initial response to new reports of less than a week</li>\n</ul>\n<p>WordPress doesn&#8217;t have its own listing in the HackerOne directory but <a href="https://hackerone.com/automattic" target="_blank">Automattic&#8217;s page</a> says the company also welcomes reports for WordPress, BuddyPress, and bbPress. Automattic has had 446 bugs resolved through its program on HackerOne, which it has maintained for the past three years. A handful of other WordPress-related projects are also listed in the directory, including the <a href="https://hackerone.com/wordpoints" target="_blank">WordPoints</a> plugin, <a href="https://hackerone.com/iandunn-projects" target="_blank">Ian Dunn&#8217;s projects</a>, and <a href="https://hackerone.com/flox" target="_blank">Flox</a>.</p>\n<p>Having a crowd-sourced security program in place is becoming more critical, as breeches are costing companies billions of dollars every year. The World Economic Forum&#8217;s <a href="http://www3.weforum.org/docs/GRR/WEF_GRR16.pdf" target="_blank">2016 Global Risks Report</a> estimated that &#8220;crimes in cyberspace cost the global economy an estimated $445 billion.&#8221;</p>\n<p>Not all organizations listed on HackerOne offer bug bounties, but bounties are a proven method of attracting security talent. Since HackerOne launched, its customers have resolved more than 37,000 vulnerabilities and have paid out more than $13 million in bug bounties. By the end of 2016, HackerOne&#8217;s community of hackers had grown to nearly 100,000.</p>\n<p>The new <a href="https://www.hackerone.com/product/community" target="_blank">Community Edition</a> gives smaller open source projects and organizations exposure to HackerOne&#8217;s network of thousands of security researchers and the tools for managing communication about vulnerabilities. Projects applying for the Community Edition must be non-commercial and able to run an effective security program. Applications are usually answered within one business week.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 01 Mar 2017 04:56:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:47;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"WPTavern: Freemius Launches Insights for WordPress Themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66740";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"https://wptavern.com/freemius-launches-insights-for-wordpress-themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8722:"<p>Freemius Insights <a href="https://freemius.com/blog/freemius-insights-wordpress-themes/">has announced</a> that its <a href="https://freemius.com/">analytics service</a> that was previously <a href="https://wptavern.com/freemius-insights-enables-plugin-developers-to-make-data-driven-decisions">only available to WordPress plugins</a> is now available for themes. The company was founded in 2015 by <a href="https://twitter.com/vovafeldman">Vova Feldman</a> and his team after discovering how much information is not available to developers who host plugins and themes on the official WordPress directories and marketplaces.</p>\n<img />Freemius Insights for Themes\n<p>Freemius Insights for themes gives developers an opportunity to collect a large variety of data, including, email addresses, PHP, plugin, WordPress version distribution, and more. When a user installs a theme that uses Freemius, an opt-in prompt is displayed that notifies them that data will be sent to Freemius.com to help improve the product. Selecting Skip prevents data from reaching Freemius.com.</p>\n<img />Freemius Opt-in Prompt\n<p>Feldman says that he and his team have worked closely with the <a href="https://make.wordpress.org/themes/">WordPress Theme Review Team</a> to ensure that Freemius Insights does not violate the theme directory <a href="https://make.wordpress.org/themes/handbook/review/required/">requirements.</a> One of the most informative features that Freemius Insights provides is the ability for users to provide feedback if they decide to switch to a different theme.</p>\n<p>When a user switches away from a product using Freemius, a prompt is shown with randomly displayed questions asking for feedback. These responses are saved and can be viewed at a later time in the Freemius dashboard. If a user switches themes because it doesn&#8217;t have a specific feature and it&#8217;s added at some point, a developer can go back and notify them that the feature exists.</p>\n<h2>Data Collection Leads to Description, Settings, and Documentation Improvements for FooBox</h2>\n<p>Adam Warner, Co-founder of <a href="https://fooplugins.com">FooPlugins.com</a>, added Freemius Insights to <a href="https://wordpress.org/plugins/foobox-image-lightbox/">FooBox</a>, an image lightbox plugin after noticing that other plugins were collecting opt-in usage data. His team realized they needed the data but didn&#8217;t have the resources to build a custom solution in a reasonable amount of time.</p>\n<p>Warner shares what he discovered with the data collected by Freemius. &#8220;Install, uninstall, deactivation, and feedback data is some of the most important data we&#8217;ve obtained,&#8221; he responded.</p>\n<p>&#8220;Not long after we discovered that of those who deactivated the plugin, the two top reasons were &#8216;expected something else&#8217; and &#8216;didn&#8217;t understand how it works.&#8217; That is valuable insight that we might not have had otherwise and allowed us to revamp our plugin description on .org and in the plugin settings.&#8221;</p>\n<p>One of the main reasons for collecting data is to improve the product. Based on the data collected, improvements to FooBox were geared towards documentation and the plugin&#8217;s settings pages, &#8220;After learning from the insights that Freemius provided us, we wrote longer explanations of various settings and what they do, as well as putting in links to documentation and video walkthroughs,&#8221; he said.</p>\n<h2>Freemius Usage Data Ramps Up Priority for NextGEN Gallery Wizard</h2>\n<p>NextGEN Gallery is Freemius&#8217; most popular plugin tracked so I asked Erick Danzer, Founder and CEO of Imagely, makers of NextGEN Gallery, what his team has learned and if any improvements are a direct result of the data collected.</p>\n<p>Since adding Freemius to NextGEN Gallery, the opt-in form has been exposed to about 200K new users. Out of these, 37.5% or 75K users have opted to submit data.</p>\n<p>&#8220;We&#8217;ve learned that 21% of users deactivate or uninstall the plugin entirely,&#8221; Danzer said. &#8220;Conversely, that means we have about a 79% retention rate. It&#8217;s hard to know how that compares to the WordPress ecosystem as a whole, but our sense is that retention rate is not bad (even if we&#8217;d like it to be better). I&#8217;d love to see comparative data across other plugins at some point.&#8221;</p>\n<p>Of those who uninstall the plugin, 20% which is the largest share, do so because they don&#8217;t understand how it works, &#8220;This wasn&#8217;t a surprise. We know that NextGEN Gallery is powerful and thus overwhelming to some users,&#8221; Danzer said. &#8220;But this is the first time we&#8217;ve been able to put actual numbers on that behavior.&#8221;</p>\n<p>Some of the biggest improvements to NextGEN Gallery that are a result of the data that&#8217;s been collected deal with the user interface. &#8220;We now know that 21% of users uninstall and that the biggest reason is too much complexity getting started,&#8221; Danzer said. &#8220;That tells us that if we want to improve our retention rate, we need to make it easier to start.&#8221;</p>\n<p>&#8220;To that end, we&#8217;ve done two things. First, we just released a start-up Gallery Wizard late last fall that walks new users through the process of setting up their first gallery. Second, we&#8217;re about 70% done with an overhaul of the interface to simplify the presentation of options. These are both things we probably would have done anyways, but we upped their priority based on Freemius data.&#8221;</p>\n<h2>Data From Freemius Insights Points to a Common Dead-end With Plugins</h2>\n<p>For more than a year, Freemius Insights has been collecting mountains of data for plugins. Feldman was gracious enough to supply the Tavern with some interesting data. There are more than 750 developers registered to the site and more than 400K users have opted-in to usage tracking. <a href="https://wordpress.org/plugins/nextgen-gallery/">NextGEN Gallery</a> is the service&#8217;s most popular tracked plugin active on more than 1.5M sites.</p>\n<p>Out of the plugins tracked, there have been 114K feedback responses on why users deactivated a plugin. The top five reasons plugins were deactivated are:</p>\n<ul>\n<ul>\n<li>23% Expected something else / didn&#8217;t work as expected</li>\n<li>21% Didn&#8217;t understand how it works</li>\n<li>20% No longer needed</li>\n<li>13% Found a better alternative</li>\n<li>6% Didn’t work</li>\n</ul>\n</ul>\n<p>The most interesting aspect of this data is the second most popular reason why users deactivate a plugin. When users activate a plugin, many don&#8217;t know what the next step is. It could be searching for a link to the settings page or not doing anything at all. Most of the time, users have no idea because the plugin doesn&#8217;t tell them.</p>\n<p><a href="https://wordpress.org/plugins/woocommerce/">WooCommerce</a> is a good example of a plugin that bucks this trend with an <a href="https://docs.woocommerce.com/document/woocommerce-onboarding-wizard/">onboarding wizard</a> that when completed, puts users in a place where they can immediately start selling products.</p>\n<img />WooCommerce Onboarding Wizard\n<p>Not every plugin is as complex as WooCommerce and doesn&#8217;t need a onboarding wizard. For these use cases, developers might consider using <a href="https://code.tutsplus.com/articles/integrating-with-wordpress-ui-admin-pointers--wp-26853">Admin Pointers</a>, a feature that was added in WordPress 3.3. With Admin Pointers you can inform users about a new feature or provide further instructions after a plugin is activated.</p>\n<p>Insights for Themes is free for non-commercial themes however, only two weeks of historical aggregated metrics and the 100 most recent user emails will be collected. In exchange for aggregating the data, Freemius asks that a symbolic attribution that &#8216;freemius&#8217; is a contributor be added to the theme&#8217;s readme.txt file. No email exports or webhooks are included with the free plan.</p>\n<p>Freemius is an example of a service that is filling a huge void of nonexistent data from WordPress.org for plugin and theme authors. A void that <a href="https://wptavern.com/solving-the-mystery-of-how-people-actually-use-wordpress">doesn&#8217;t appear likely</a> to be filled anytime soon. As noted above, the data that is collected, especially direct feedback from users, has surfaced issues that may not have otherwise been discovered.</p>\n<p>If you use Freemius Insights in your plugins or themes, please tell us about your experience and what you&#8217;ve learned from the collected data.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 28 Feb 2017 22:43:48 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:48;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:85:"WPTavern: Amazon S3 Outage Hits WordPress Businesses, Disrupting Services and Support";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://wptavern.com/?p=66751";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:94:"https://wptavern.com/amazon-s3-outage-hits-wordpress-businesses-disrupting-service-and-support";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5853:"<p><a href="https://i0.wp.com/wptavern.com/wp-content/uploads/2017/02/Amazon_Web_Services_logo_AWS.jpg?ssl=1"><img /></a></p>\n<p>Amazon is currently experiencing &#8220;high error rates with S3 in US-EAST-1,&#8221; causing a massive outage for sites, apps, and services across the web. The <a href="https://status.aws.amazon.com/" target="_blank">AWS service health dashboard</a> was also temporarily affected by the outage. Amazon says it is working at repairing S3 and that they believe they have identified the root cause.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr"><a href="https://twitter.com/awscloud">@awscloud</a> Care to share the architecture of this status page as an anti-pattern?</p>\n<p>&mdash; Thorben Heins (@thorbenheins) <a href="https://twitter.com/thorbenheins/status/836657580382502912">February 28, 2017</a></p></blockquote>\n<p></p>\n<p>The outage is affecting many popular sites, such as Quora, Netflix, Splitwise, Business Insider, Giphy, Trello, IFTTT, many publishers&#8217; image hosting, filesharing in Slack, and the Docker Registry Hub.</p>\n<p>WordPress businesses are also currently affected, especially those that host customer downloads. WooCommerce customers are currently unable to access downloads they purchased. Similarly Envato customers are having difficulty accessing downloads and content.</p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Yes, we are affected by <a href="https://twitter.com/hashtag/AWS?src=hash">#AWS</a> <a href="https://twitter.com/hashtag/S3?src=hash">#S3</a> outage too. S3 is having a snag right now&#8230;. Quora, Slack, Envato and millions more are suffering&#8230;</p>\n<p>&mdash; WPBakery (@wpbakery) <a href="https://twitter.com/wpbakery/status/836663834437955584">February 28, 2017</a></p></blockquote>\n<p></p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">We''re aware of issues with functionality of the <a href="https://t.co/dGuVluPt9A">https://t.co/dGuVluPt9A</a> site, such as My Downloads. This is related to the <a href="https://twitter.com/awscloud">@awscloud</a> outage</p>\n<p>&mdash; WooCommerce (@WooCommerce) <a href="https://twitter.com/WooCommerce/status/836663491805216768">February 28, 2017</a></p></blockquote>\n<p></p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Amazon S3 has identified high error rate issue that''s impacting the Envato Market specifically our downloads and content. We are monitoring!</p>\n<p>&mdash; Envato Help (@envato_help) <a href="https://twitter.com/envato_help/status/836653583428771840">February 28, 2017</a></p></blockquote>\n<p></p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Downloading and updating our premium plugins is possible again, after a short downtime due to problems at S3. Sorry for the inconvenience!</p>\n<p>&mdash; Yoast (@yoast) <a href="https://twitter.com/yoast/status/836684468513558529">February 28, 2017</a></p></blockquote>\n<p></p>\n<blockquote class="twitter-tweet">\n<p lang="en" dir="ltr">Due to the AWS outage, we are experiencing problems with sales, support, and development.  Please accept our apologies&#8230;we''ll be back soon!</p>\n<p>&mdash; WP Ninjas, LLC (@wpninjas) <a href="https://twitter.com/wpninjas/status/836662320088539136">February 28, 2017</a></p></blockquote>\n<p></p>\n<p>Joost de Valk, CEO and founder of <a href="https://yoast.com/" target="_blank">Yoast</a>, said the company experienced minor effects from the outage but has already been planning on switching from S3 to a new storage provider.</p>\n<p>“The outage doesn’t seem to have affected our revenue much,&#8221; de Valk said. &#8220;It was slightly annoying and led to some images not working and people not being able to download their plugins for a while, which is always a shame. However, not directly related to this, we’re already looking at ditching S3. That&#8217;s because our new hosting setup at SiteGround combined with CDN from MaxCDN actually negates the need for S3 entirely.&#8221;</p>\n<p>Other companies that have AWS integrated into their support services experienced more disruption due to customers not being able to receive help.</p>\n<p>&#8220;Obviously our website is hosted using AWS technology through Pagely,&#8221; <a href="http://wpninjas.com/" target="_blank">WP Ninjas</a> co-founder James Laws said. &#8220;I’m not sure how they’ve been affected directly, but we have noticed intermittent downtime. Perhaps the biggest impact is that our support service is built on AWS and with it down we are completely unable to provide any support to our users.&#8221;</p>\n<p>Laws said the company has had fairly decent uptime with AWS in the past and that the idea of switching services because of an outage would not be worth the effort.</p>\n<p>&#8220;The truth is that 100% uptime is more a fantasy than anything,&#8221; Laws said. &#8220;The idea of having to move a website or change a support system temporarily or even permanently for a short period of downtime would be pretty daunting. You probably could create contingency plans for something like this, but the technical and administrative costs are not generally worth it in my opinion.&#8221;</p>\n<p>The outage serves as a painful reminder of how dependent the web is on cloud storage providers and how few services have a backup plan for instances like these.</p>\n<p>At 12:52 PM PST Amazon released an update, promising improvements for customers within the hour: &#8220;We are seeing recovery for S3 object retrievals, listing and deletions. We continue to work on recovery for adding new objects to S3 and expect to start seeing improved error rates within the hour.&#8221; The ability to retrieve, list, and delete was fully recovered within half an hour and Amazon continues to work on fixing the ability to add new objects to S3.</p>\n<div id="epoch-width-sniffer"></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 28 Feb 2017 21:54:14 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:49;a:6:{s:4:"data";s:13:"\n	\n	\n	\n	\n	\n	\n";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:42:"Donncha: Coming up in WP Super Cache 1.5.0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"https://odd.blog/?p=89500157";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"https://odd.blog/2017/02/28/coming-up-in-wp-super-cache-1-5-0/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5618:"<p>The next version of WP Super Cache will be one with some big changes! There are many small bug fixes and improvements but the one I&#8217;m most excited about is moving the legacy cache files into the supercache directory.</p>\n<p>The legacy cache files were the files created by the old WP-Cache plugin upon which this plugin is based. They&#8217;re really useful as they store the headers sent from the server as well as the page contents. If you&#8217;re serving pages that aren&#8217;t regular html, such as JSON or XML you don&#8217;t want to tell the browser they&#8217;re text/html documents. This caching method is also used for anyone who is logged into your site, or left a comment.<br />\nThere is a problem however. They&#8217;re stored in one directory. If you have many thousands of visitors interacting with your site you may end up with a directory containing thousands of files. The names of the cache files are a hash of the URL, gzip support and browser cookies so one file can match one user, or one file can be used by thousands of anonymous users. In the event that someone left a comment on a popular post the plugin has to search through all those files looking for the pages cached for other users who were also looking at that page. On a busy server that can cause problems.</p>\n<p>So, in <a href="https://github.com/Automattic/wp-super-cache/pull/177">#177</a> I added code that moves the legacy cache files into the supercache directory. That means the files are stored in directories that reflect the URL of the page that was served which makes it very easy to delete the cached files belonging to that page as they&#8217;re all in the same directory!</p>\n<p>The new code will look in the old location for legacy files first as some sites will have a large collection of cached files, but any new cache files will be created in the supercache directory.</p>\n<p>Ian Dunn <a href="https://github.com/Automattic/wp-super-cache/pull/121">submitted code</a> to cache the REST API. It&#8217;s not yet complete but we&#8217;ll be able to build on the changes to the legacy cache to make caching the API more efficient than it would have been before.</p>\n<p>I really need people to help test this. The latest code is running on this site so I&#8217;m very confident in how well it works but just because it works on my odd little server doesn&#8217;t mean it will work right everywhere. If you want to give it a spin, visit <a href="https://github.com/Automattic/wp-super-cache">the plugin Github repository</a> and click on the &#8220;Clone or download&#8221; button. If you don&#8217;t know how to clone a Git respository just grab the zip file and install it on your server, overwriting the files in the plugins/wp-super-cache/ directory. If the changes to where cache files go doesn&#8217;t interest you, some of the changes in this list might:</p>\n<ul>\n<li><a href="https://github.com/Automattic/wp-super-cache/commit/b654bcf6d75655e386f22c2fcbad19272b0d75cd">Don’t output broken warning in robots.txt</li>\n<li><a href="https://github.com/Automattic/wp-super-cache/commit/8b63d5d97f246ba4d442e7b5d32a4d08fce4fd22">Use get_home_url() instead of siteurl because some sites have different homepages</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/176">Remove most calls to get_all_supercache_filenames()</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/145">Fix bottom border in admin</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/199">Use plugins_url() so https links work</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/55">Preload from the newest post</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/101">Stop caching of wp-admin visits sooner</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/177">Store legacy cache files in the supercache directories</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/100">Make the headers more informative to tell how a page was served</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/90">Properly serve 304 requests</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/188">Apply realpath to filenames because of Windows oddities</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/127">Don&#8217;t flush(), output buffers don&#8217;t like it</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/194">Add more file checks around wp_cache_rebuild_or_delete()</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/191">If HTTP_HOST is not defined then disable caching</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/190">Only show html comments on html pages</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/issues/184">Fix caching of mobile requests</a></li>\n<li><a href="https://github.com/Automattic/wp-super-cache/pull/61">Clear the cache for private posts</a></li>\n</ul>\n\n<p><strong>Related Posts</strong><ul><li> <a href="https://odd.blog/2008/10/24/wp-super-cache-084-the-garbage-collector/" rel="bookmark" title="Permanent Link: WP Super Cache 0.8.4, the garbage collector">WP Super Cache 0.8.4, the garbage collector</a></li><li> <a href="https://odd.blog/2009/01/09/wp-super-cache-087/" rel="bookmark" title="Permanent Link: WP Super Cache 0.8.7">WP Super Cache 0.8.7</a></li><li> <a href="https://odd.blog/2010/02/08/wp-super-cache-099/" rel="bookmark" title="Permanent Link: WP Super Cache 0.9.9">WP Super Cache 0.9.9</a></li></ul></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 28 Feb 2017 15:05:34 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:7:"Donncha";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";O:42:"Requests_Utility_CaseInsensitiveDictionary":1:{s:7:"\0*\0data";a:8:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Mon, 20 Mar 2017 21:49:28 GMT";s:12:"content-type";s:8:"text/xml";s:4:"vary";s:15:"Accept-Encoding";s:13:"last-modified";s:29:"Mon, 20 Mar 2017 21:45:10 GMT";s:15:"x-frame-options";s:10:"SAMEORIGIN";s:4:"x-nc";s:11:"HIT lax 250";s:16:"content-encoding";s:4:"gzip";}}s:5:"build";s:14:"20130911090210";}', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(401, '_transient_timeout_feed_mod_d117b5738fbd35bd8c0391cda1f2b5d9', '1490089771', 'no'),
(402, '_transient_feed_mod_d117b5738fbd35bd8c0391cda1f2b5d9', '1490046571', 'no'),
(403, '_transient_timeout_feed_b9388c83948825c1edaef0d856b7b109', '1490089773', 'no'),
(404, '_transient_feed_b9388c83948825c1edaef0d856b7b109', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"\n	\n";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:117:"\n		\n		\n		\n		\n		\n		\n				\n\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n		\n\n	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:34:"WordPress Plugins » View: Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:45:"https://wordpress.org/plugins/browse/popular/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:34:"WordPress Plugins » View: Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 20 Mar 2017 21:27:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:25:"http://bbpress.org/?v=1.1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:30:{i:0;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"WP Super Cache";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"https://wordpress.org/plugins/wp-super-cache/#post-2572";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Nov 2007 11:40:04 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"2572@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:73:"A very fast caching engine for WordPress that produces static html files.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Donncha O Caoimh";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"W3 Total Cache";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:56:"https://wordpress.org/plugins/w3-total-cache/#post-12073";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 29 Jul 2009 18:46:31 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"12073@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:144:"Search Engine (SEO) &#38; Performance Optimization (WPO) via caching. Integrated caching: CDN, Minify, Page, Object, Fragment, Database support.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Frederick Townes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Advanced Custom Fields";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"https://wordpress.org/plugins/advanced-custom-fields/#post-25254";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Mar 2011 04:07:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"25254@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:68:"Customise WordPress with powerful, professional and intuitive fields";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"elliotcondon";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:7:"Akismet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"https://wordpress.org/plugins/akismet/#post-15";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:11:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"15@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:146:"Akismet checks your comments and contact form submissions against our global database of spam to protect you and your site from malicious content.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"TinyMCE Advanced";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:57:"https://wordpress.org/plugins/tinymce-advanced/#post-2082";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Jun 2007 15:00:26 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"2082@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:58:"Extends and enhances TinyMCE, the WordPress Visual Editor.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Andrew Ozz";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"Duplicate Post";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"https://wordpress.org/plugins/duplicate-post/#post-2646";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 05 Dec 2007 17:40:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"2646@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:22:"Clone posts and pages.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Lopo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:24:"Jetpack by WordPress.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:49:"https://wordpress.org/plugins/jetpack/#post-23862";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 Jan 2011 02:21:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"23862@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:148:"The one plugin you need for stats, related posts, search engine optimization, social sharing, protection, backups, speed, and email list management.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Automattic";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"Really Simple CAPTCHA";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"https://wordpress.org/plugins/really-simple-captcha/#post-9542";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 09 Mar 2009 02:17:35 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"9542@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:138:"Really Simple CAPTCHA is a CAPTCHA module intended to be called from other plugins. It is originally created for my Contact Form 7 plugin.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Takayuki Miyoshi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:11:"WooCommerce";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:53:"https://wordpress.org/plugins/woocommerce/#post-29860";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Sep 2011 08:13:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"29860@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:97:"WooCommerce is a powerful, extendable eCommerce plugin that helps you sell anything. Beautifully.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"WooThemes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:9:"Yoast SEO";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:54:"https://wordpress.org/plugins/wordpress-seo/#post-8321";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 01 Jan 2009 20:34:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"8321@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:118:"Improve your WordPress SEO: Write better content and have a fully optimized WordPress site using the Yoast SEO plugin.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Joost de Valk";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:11:"WP-PageNavi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"https://wordpress.org/plugins/wp-pagenavi/#post-363";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 23:17:57 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"363@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:49:"Adds a more advanced paging navigation interface.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Lester Chan";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"Contact Form 7";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"https://wordpress.org/plugins/contact-form-7/#post-2141";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 02 Aug 2007 12:45:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"2141@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:54:"Just another contact form plugin. Simple but flexible.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Takayuki Miyoshi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Google XML Sitemaps";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"https://wordpress.org/plugins/google-sitemap-generator/#post-132";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:31:32 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"132@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:105:"This plugin will generate a special XML sitemap which will help search engines to better index your blog.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Arne Brachhold";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"All in One SEO Pack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"https://wordpress.org/plugins/all-in-one-seo-pack/#post-753";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 30 Mar 2007 20:08:18 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"753@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:83:"The original SEO plugin for WordPress, downloaded over 30,000,000 times since 2007.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"uberdose";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"Regenerate Thumbnails";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"https://wordpress.org/plugins/regenerate-thumbnails/#post-6743";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 23 Aug 2008 14:38:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"6743@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:76:"Allows you to regenerate your thumbnails after changing the thumbnail sizes.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:25:"Alex Mills (Viper007Bond)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:15;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:42:"NextGEN Gallery - WordPress Gallery Plugin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:56:"https://wordpress.org/plugins/nextgen-gallery/#post-1169";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 23 Apr 2007 20:08:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"1169@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:123:"The most popular WordPress gallery plugin and one of the most popular plugins of all time with over 16.5 million downloads.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Alex Rabe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:16;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:49:"Google Analytics for WordPress by MonsterInsights";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:71:"https://wordpress.org/plugins/google-analytics-for-wordpress/#post-2316";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 14 Sep 2007 12:15:27 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"2316@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:125:"The best Google Analytics plugin for WordPress. See how visitors find and use your website, so you can keep them coming back.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Syed Balkhi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:17;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"Wordfence Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"https://wordpress.org/plugins/wordfence/#post-29832";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 04 Sep 2011 03:13:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"29832@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:149:"Secure your website with the most comprehensive WordPress security plugin. Firewall, malware scan, blocking, live traffic, login security &#38; more.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Wordfence";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:18;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:11:"Hello Dolly";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:52:"https://wordpress.org/plugins/hello-dolly/#post-5790";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 29 May 2008 22:11:34 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"5790@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"This is not just a plugin, it symbolizes the hope and enthusiasm of an entire generation summed up in two words sung most famously by Louis Armstrong.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:19;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:26:"Page Builder by SiteOrigin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"https://wordpress.org/plugins/siteorigin-panels/#post-51888";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 10:36:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"51888@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:111:"Build responsive page layouts using the widgets you know and love using this simple drag and drop page builder.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Greg Priday";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:20;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"WordPress Importer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"https://wordpress.org/plugins/wordpress-importer/#post-18101";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 May 2010 17:42:45 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"18101@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:101:"Import posts, pages, comments, custom fields, categories, tags and more from a WordPress export file.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Brian Colinger";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:21;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"UpdraftPlus WordPress Backup Plugin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:53:"https://wordpress.org/plugins/updraftplus/#post-38058";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 May 2012 15:14:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"38058@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:148:"Backup and restoration made easy. Complete backups; manual or scheduled (backup to S3, Dropbox, Google Drive, Rackspace, FTP, SFTP, email + others).";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"David Anderson";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:22;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"Google Analytics Dashboard for WP";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://wordpress.org/plugins/google-analytics-dashboard-for-wp/#post-50539";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 10 Mar 2013 17:07:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"50539@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:125:"Displays Google Analytics stats in your WordPress Dashboard. Inserts the latest Google Analytics tracking code in your pages.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Alin Marcu";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:23;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:10:"Duplicator";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:52:"https://wordpress.org/plugins/duplicator/#post-26607";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 16 May 2011 12:15:41 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"26607@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:88:"Duplicate, clone, backup, move and transfer an entire site from one location to another.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Cory Lamle";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:24;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"Disable Comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:58:"https://wordpress.org/plugins/disable-comments/#post-26907";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 27 May 2011 04:42:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"26907@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"Allows administrators to globally disable comments on their site. Comments can be disabled according to post type. Multisite friendly. Provides tool t";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Samir Shah";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:25;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"WP Multibyte Patch";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"https://wordpress.org/plugins/wp-multibyte-patch/#post-28395";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 14 Jul 2011 12:22:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"28395@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:71:"Multibyte functionality enhancement for the WordPress Japanese package.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"plugin-master";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:26;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:27:"Black Studio TinyMCE Widget";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:69:"https://wordpress.org/plugins/black-studio-tinymce-widget/#post-31973";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 10 Nov 2011 15:06:14 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"31973@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:39:"The visual editor widget for Wordpress.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Marco Chiesi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:27;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:25:"SiteOrigin Widgets Bundle";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"https://wordpress.org/plugins/so-widgets-bundle/#post-67824";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 24 May 2014 14:27:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"67824@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:128:"A collection of all widgets, neatly bundled into a single plugin. It&#039;s also a framework to code your own widgets on top of.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Greg Priday";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:28;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:46:"iThemes Security (formerly Better WP Security)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"https://wordpress.org/plugins/better-wp-security/#post-21738";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 22 Oct 2010 22:06:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"21738@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:146:"Take the guesswork out of WordPress security. iThemes Security offers 30+ ways to lock down WordPress in an easy-to-use WordPress security plugin.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:7:"iThemes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:29;a:6:{s:4:"data";s:30:"\n			\n			\n			\n			\n			\n			\n					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:11:"Ninja Forms";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:53:"https://wordpress.org/plugins/ninja-forms/#post-33147";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 20 Dec 2011 18:11:48 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"33147@https://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:147:"Drag and drop fields in an intuitive UI to create create contact forms, email subscription forms, order forms, payment forms, send emails and more!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Kevin Stover";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:46:"https://wordpress.org/plugins/rss/view/popular";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";O:42:"Requests_Utility_CaseInsensitiveDictionary":1:{s:7:"\0*\0data";a:12:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Mon, 20 Mar 2017 21:49:30 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:4:"vary";s:15:"Accept-Encoding";s:25:"strict-transport-security";s:11:"max-age=360";s:7:"expires";s:29:"Mon, 20 Mar 2017 22:02:25 GMT";s:13:"cache-control";s:0:"";s:6:"pragma";s:0:"";s:13:"last-modified";s:31:"Mon, 20 Mar 2017 21:27:25 +0000";s:15:"x-frame-options";s:10:"SAMEORIGIN";s:4:"x-nc";s:11:"HIT lax 250";s:16:"content-encoding";s:4:"gzip";}}s:5:"build";s:14:"20130911090210";}', 'no'),
(405, '_transient_timeout_feed_mod_b9388c83948825c1edaef0d856b7b109', '1490089773', 'no'),
(406, '_transient_feed_mod_b9388c83948825c1edaef0d856b7b109', '1490046573', 'no'),
(407, '_transient_timeout_plugin_slugs', '1490132973', 'no'),
(408, '_transient_plugin_slugs', 'a:5:{i:0;s:19:"akismet/akismet.php";i:1;s:25:"duplicator/duplicator.php";i:2;s:9:"hello.php";i:3;s:27:"woocommerce/woocommerce.php";i:4;s:91:"woocommerce-gateway-paypal-express-checkout/woocommerce-gateway-paypal-express-checkout.php";}', 'no'),
(409, '_transient_timeout_dash_c05853b002c443ec8e57ff884f56cdde', '1490089773', 'no'),
(410, '_transient_dash_c05853b002c443ec8e57ff884f56cdde', '<div class="rss-widget"><ul><li><a class=''rsswidget'' href=''https://es.wordpress.org/2017/03/13/eventos-wordpress-para-la-semana-11-17/''>Eventos para la semana</a> <span class="rss-date">13 marzo, 2017</span><div class="rssSummary">¡Buenos días a todos! Os dejamos el listado de las Meetups para esta semana como así también el avance de las organizaciones de las distintas WordCamps. Meetups 16/03 – Alcalá de Henares – Uso del editor Elementor y nociones de responsive 16/03 – Collado Villalba – RamsonWare – Hacking ético y seguridad WordPress 17/03 – Bilbao – El [&hellip;]</div></li></ul></div><div class="rss-widget"><ul><li><a class=''rsswidget'' href=''https://wptavern.com/pressshack-forks-edit-flow-to-create-publishpress-aims-to-improve-multi-user-editorial-workflow-in-wordpress''>WPTavern: PressShack Forks Edit Flow to Create PublishPress, Aims to Improve Multi-User Editorial Workflow in WordPress</a></li><li><a class=''rsswidget'' href=''https://odd.blog/2017/03/18/how-to-auto-schedule-wordpress-posts/''>Donncha: How to Auto Schedule WordPress Posts</a></li><li><a class=''rsswidget'' href=''https://wptavern.com/github-adds-plain-english-explanations-to-license-pages-for-open-source-projects''>WPTavern: GitHub Adds Plain English Explanations to License Pages for Open Source Projects</a></li></ul></div><div class="rss-widget"><ul><li class="dashboard-news-plugin"><span>Plugin popular:</span> UpdraftPlus WordPress Backup Plugin&nbsp;<a href="plugin-install.php?tab=plugin-information&amp;plugin=updraftplus&amp;_wpnonce=f06f9e4c25&amp;TB_iframe=true&amp;width=600&amp;height=800" class="thickbox open-plugin-details-modal" aria-label="Instalar UpdraftPlus WordPress Backup Plugin">(Instalar)</a></li></ul></div>', 'no'),
(414, '_site_transient_timeout_theme_roots', '1490052301', 'no'),
(415, '_site_transient_theme_roots', 'a:4:{s:10:"responsive";s:7:"/themes";s:13:"twentyfifteen";s:7:"/themes";s:14:"twentyfourteen";s:7:"/themes";s:13:"twentysixteen";s:7:"/themes";}', 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_postmeta`
--

CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(1, 2, '_wp_page_template', 'default'),
(2, 8, '_edit_last', '1'),
(3, 8, '_edit_lock', '1478614942:1'),
(4, 8, '_visibility', 'visible'),
(5, 8, '_stock_status', 'instock'),
(6, 8, 'total_sales', '0'),
(7, 8, '_downloadable', 'no'),
(8, 8, '_virtual', 'no'),
(9, 8, '_tax_status', 'taxable'),
(10, 8, '_tax_class', ''),
(11, 8, '_purchase_note', ''),
(12, 8, '_featured', 'no'),
(13, 8, '_weight', ''),
(14, 8, '_length', ''),
(15, 8, '_width', ''),
(16, 8, '_height', ''),
(17, 8, '_sku', ''),
(18, 8, '_product_attributes', 'a:0:{}'),
(19, 8, '_regular_price', '200000'),
(20, 8, '_sale_price', '180000'),
(21, 8, '_sale_price_dates_from', ''),
(22, 8, '_sale_price_dates_to', ''),
(23, 8, '_price', '180000'),
(24, 8, '_sold_individually', ''),
(25, 8, '_manage_stock', 'no'),
(26, 8, '_backorders', 'no'),
(27, 8, '_stock', ''),
(28, 8, '_upsell_ids', 'a:0:{}'),
(29, 8, '_crosssell_ids', 'a:0:{}'),
(30, 8, '_product_version', '2.6.7'),
(31, 8, '_product_image_gallery', ''),
(32, 1, '_edit_lock', '1478614983:1'),
(35, 11, '_edit_last', '1'),
(36, 11, '_edit_lock', '1490050223:1'),
(37, 5, '_edit_lock', '1488767282:1'),
(38, 5, '_edit_last', '1'),
(39, 5, '_wp_page_template', 'default'),
(40, 5, '_responsive_layout', 'default'),
(41, 6, '_edit_lock', '1488767297:1'),
(42, 6, '_edit_last', '1'),
(43, 6, '_wp_page_template', 'default'),
(44, 6, '_responsive_layout', 'default'),
(45, 7, '_edit_lock', '1488767308:1'),
(46, 7, '_edit_last', '1'),
(47, 7, '_wp_page_template', 'default'),
(48, 7, '_responsive_layout', 'default'),
(49, 2, '_edit_lock', '1488767319:1'),
(50, 2, '_edit_last', '1'),
(51, 2, '_responsive_layout', 'default'),
(52, 4, '_edit_lock', '1488767570:1'),
(53, 4, '_edit_last', '1'),
(54, 4, '_wp_page_template', 'default'),
(55, 4, '_responsive_layout', 'default'),
(60, 20, '_wp_attached_file', '2017/03/cropped-BBVA_287-.png'),
(61, 20, '_wp_attachment_context', 'custom-header'),
(62, 20, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1293;s:6:"height";i:401;s:4:"file";s:29:"2017/03/cropped-BBVA_287-.png";s:5:"sizes";a:14:{s:9:"thumbnail";a:4:{s:4:"file";s:29:"cropped-BBVA_287--150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:28:"cropped-BBVA_287--300x93.png";s:5:"width";i:300;s:6:"height";i:93;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:29:"cropped-BBVA_287--768x238.png";s:5:"width";i:768;s:6:"height";i:238;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:30:"cropped-BBVA_287--1024x318.png";s:5:"width";i:1024;s:6:"height";i:318;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:29:"cropped-BBVA_287--180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:29:"cropped-BBVA_287--300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:29:"cropped-BBVA_287--600x401.png";s:5:"width";i:600;s:6:"height";i:401;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:28:"cropped-BBVA_287--100x31.png";s:5:"width";i:100;s:6:"height";i:31;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:28:"cropped-BBVA_287--150x47.png";s:5:"width";i:150;s:6:"height";i:47;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:28:"cropped-BBVA_287--200x62.png";s:5:"width";i:200;s:6:"height";i:62;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:28:"cropped-BBVA_287--300x93.png";s:5:"width";i:300;s:6:"height";i:93;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:29:"cropped-BBVA_287--450x140.png";s:5:"width";i:450;s:6:"height";i:140;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:29:"cropped-BBVA_287--600x186.png";s:5:"width";i:600;s:6:"height";i:186;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-900";a:4:{s:4:"file";s:29:"cropped-BBVA_287--900x279.png";s:5:"width";i:900;s:6:"height";i:279;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(63, 20, '_wp_attachment_custom_header_last_used_responsive', '1488767776'),
(64, 20, '_wp_attachment_is_custom_header', 'responsive'),
(65, 21, '_wp_attached_file', '2017/03/2.png'),
(66, 21, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:77;s:6:"height";i:24;s:4:"file";s:13:"2017/03/2.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(67, 22, '_wp_attached_file', '2017/03/cropped-2.png'),
(68, 22, '_wp_attachment_context', 'custom-header'),
(69, 22, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:77;s:6:"height";i:24;s:4:"file";s:21:"2017/03/cropped-2.png";s:5:"sizes";a:0:{}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(70, 22, '_wp_attachment_custom_header_last_used_responsive', '1488767898'),
(71, 22, '_wp_attachment_is_custom_header', 'responsive'),
(72, 23, '_wp_attached_file', '2017/03/cropped-cropped-2.png'),
(73, 23, '_wp_attachment_context', 'site-icon'),
(74, 23, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:512;s:6:"height";i:512;s:4:"file";s:29:"2017/03/cropped-cropped-2.png";s:5:"sizes";a:13:{s:9:"thumbnail";a:4:{s:4:"file";s:29:"cropped-cropped-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:29:"cropped-cropped-2-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:29:"cropped-cropped-2-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:29:"cropped-cropped-2-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:29:"cropped-cropped-2-100x100.png";s:5:"width";i:100;s:6:"height";i:100;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:29:"cropped-cropped-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:29:"cropped-cropped-2-200x200.png";s:5:"width";i:200;s:6:"height";i:200;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:29:"cropped-cropped-2-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:29:"cropped-cropped-2-450x450.png";s:5:"width";i:450;s:6:"height";i:450;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-270";a:4:{s:4:"file";s:29:"cropped-cropped-2-270x270.png";s:5:"width";i:270;s:6:"height";i:270;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-192";a:4:{s:4:"file";s:29:"cropped-cropped-2-192x192.png";s:5:"width";i:192;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}s:13:"site_icon-180";a:4:{s:4:"file";s:29:"cropped-cropped-2-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"site_icon-32";a:4:{s:4:"file";s:27:"cropped-cropped-2-32x32.png";s:5:"width";i:32;s:6:"height";i:32;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(75, 11, '_wp_page_template', 'default'),
(76, 11, '_responsive_layout', 'default'),
(77, 27, '_edit_last', '1'),
(78, 27, '_edit_lock', '1490050268:1'),
(85, 31, '_wp_attached_file', '2017/03/3.png'),
(86, 31, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:2134;s:6:"height";i:1112;s:4:"file";s:13:"2017/03/3.png";s:5:"sizes";a:14:{s:9:"thumbnail";a:4:{s:4:"file";s:13:"3-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:13:"3-300x156.png";s:5:"width";i:300;s:6:"height";i:156;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:13:"3-768x400.png";s:5:"width";i:768;s:6:"height";i:400;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:14:"3-1024x534.png";s:5:"width";i:1024;s:6:"height";i:534;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:13:"3-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:13:"3-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:13:"3-600x600.png";s:5:"width";i:600;s:6:"height";i:600;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:12:"3-100x52.png";s:5:"width";i:100;s:6:"height";i:52;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:12:"3-150x78.png";s:5:"width";i:150;s:6:"height";i:78;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:13:"3-200x104.png";s:5:"width";i:200;s:6:"height";i:104;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:13:"3-300x156.png";s:5:"width";i:300;s:6:"height";i:156;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:13:"3-450x234.png";s:5:"width";i:450;s:6:"height";i:234;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:13:"3-600x313.png";s:5:"width";i:600;s:6:"height";i:313;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-900";a:4:{s:4:"file";s:13:"3-900x469.png";s:5:"width";i:900;s:6:"height";i:469;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(87, 32, '_wp_attached_file', '2017/03/3-1-e1488769651589.png'),
(88, 32, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1000;s:6:"height";i:559;s:4:"file";s:30:"2017/03/3-1-e1488769651589.png";s:5:"sizes";a:14:{s:9:"thumbnail";a:4:{s:4:"file";s:15:"3-1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:15:"3-1-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:15:"3-1-768x429.png";s:5:"width";i:768;s:6:"height";i:429;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:16:"3-1-1024x572.png";s:5:"width";i:1024;s:6:"height";i:572;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:15:"3-1-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:15:"3-1-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:15:"3-1-600x600.png";s:5:"width";i:600;s:6:"height";i:600;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:14:"3-1-100x56.png";s:5:"width";i:100;s:6:"height";i:56;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:14:"3-1-150x84.png";s:5:"width";i:150;s:6:"height";i:84;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:15:"3-1-200x112.png";s:5:"width";i:200;s:6:"height";i:112;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:15:"3-1-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:15:"3-1-450x251.png";s:5:"width";i:450;s:6:"height";i:251;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:15:"3-1-600x335.png";s:5:"width";i:600;s:6:"height";i:335;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-900";a:4:{s:4:"file";s:15:"3-1-900x503.png";s:5:"width";i:900;s:6:"height";i:503;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(89, 27, '_wp_page_template', 'default'),
(90, 27, '_responsive_layout', 'default'),
(91, 27, '_oembed_e279d71bf11c584768db7b2dad88bb1e', '{{unknown}}'),
(92, 27, '_thumbnail_id', '32'),
(93, 32, '_wp_attachment_backup_sizes', 'a:2:{s:9:"full-orig";a:3:{s:5:"width";i:3996;s:6:"height";i:2232;s:4:"file";s:7:"3-1.png";}s:18:"full-1488769651589";a:3:{s:5:"width";i:3996;s:6:"height";i:2232;s:4:"file";s:22:"3-1-e1488769635579.png";}}'),
(94, 37, '_wp_attached_file', '2017/03/3-2.png'),
(95, 37, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:3996;s:6:"height";i:2232;s:4:"file";s:15:"2017/03/3-2.png";s:5:"sizes";a:14:{s:9:"thumbnail";a:4:{s:4:"file";s:15:"3-2-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:15:"3-2-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:15:"3-2-768x429.png";s:5:"width";i:768;s:6:"height";i:429;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:16:"3-2-1024x572.png";s:5:"width";i:1024;s:6:"height";i:572;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:15:"3-2-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:15:"3-2-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:15:"3-2-600x600.png";s:5:"width";i:600;s:6:"height";i:600;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:14:"3-2-100x56.png";s:5:"width";i:100;s:6:"height";i:56;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:14:"3-2-150x84.png";s:5:"width";i:150;s:6:"height";i:84;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:15:"3-2-200x112.png";s:5:"width";i:200;s:6:"height";i:112;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:15:"3-2-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:15:"3-2-450x251.png";s:5:"width";i:450;s:6:"height";i:251;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:15:"3-2-600x335.png";s:5:"width";i:600;s:6:"height";i:335;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-900";a:4:{s:4:"file";s:15:"3-2-900x503.png";s:5:"width";i:900;s:6:"height";i:503;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(96, 39, '_edit_last', '1'),
(97, 39, '_wp_page_template', 'default'),
(98, 39, '_responsive_layout', 'default'),
(99, 39, '_edit_lock', '1490050288:1'),
(100, 41, '_edit_last', '1'),
(101, 41, '_edit_lock', '1490050311:1'),
(102, 41, '_wp_page_template', 'default'),
(103, 41, '_responsive_layout', 'default'),
(114, 49, '_edit_last', '1'),
(115, 49, '_edit_lock', '1490050341:1'),
(116, 49, '_wp_page_template', 'default'),
(117, 49, '_responsive_layout', 'default'),
(118, 51, '_wp_attached_file', '2017/03/4.png'),
(119, 51, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:693;s:6:"height";i:832;s:4:"file";s:13:"2017/03/4.png";s:5:"sizes";a:11:{s:9:"thumbnail";a:4:{s:4:"file";s:13:"4-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:13:"4-250x300.png";s:5:"width";i:250;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:13:"4-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:13:"4-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:13:"4-600x600.png";s:5:"width";i:600;s:6:"height";i:600;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:13:"4-100x120.png";s:5:"width";i:100;s:6:"height";i:120;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:13:"4-150x180.png";s:5:"width";i:150;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:13:"4-200x240.png";s:5:"width";i:200;s:6:"height";i:240;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:13:"4-300x360.png";s:5:"width";i:300;s:6:"height";i:360;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:13:"4-450x540.png";s:5:"width";i:450;s:6:"height";i:540;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:13:"4-600x720.png";s:5:"width";i:600;s:6:"height";i:720;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(122, 55, '_wp_attached_file', '2017/03/5.png'),
(123, 55, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:931;s:6:"height";i:427;s:4:"file";s:13:"2017/03/5.png";s:5:"sizes";a:13:{s:9:"thumbnail";a:4:{s:4:"file";s:13:"5-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:13:"5-300x138.png";s:5:"width";i:300;s:6:"height";i:138;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:13:"5-768x352.png";s:5:"width";i:768;s:6:"height";i:352;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:13:"5-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:13:"5-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:13:"5-600x427.png";s:5:"width";i:600;s:6:"height";i:427;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:12:"5-100x46.png";s:5:"width";i:100;s:6:"height";i:46;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:12:"5-150x69.png";s:5:"width";i:150;s:6:"height";i:69;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:12:"5-200x92.png";s:5:"width";i:200;s:6:"height";i:92;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:13:"5-300x138.png";s:5:"width";i:300;s:6:"height";i:138;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:13:"5-450x206.png";s:5:"width";i:450;s:6:"height";i:206;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:13:"5-600x275.png";s:5:"width";i:600;s:6:"height";i:275;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-900";a:4:{s:4:"file";s:13:"5-900x413.png";s:5:"width";i:900;s:6:"height";i:413;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(124, 60, '_edit_last', '1'),
(125, 60, '_edit_lock', '1490050239:1'),
(126, 61, '_wp_attached_file', '2017/03/6.png'),
(127, 61, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:814;s:6:"height";i:579;s:4:"file";s:13:"2017/03/6.png";s:5:"sizes";a:12:{s:9:"thumbnail";a:4:{s:4:"file";s:13:"6-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:13:"6-300x213.png";s:5:"width";i:300;s:6:"height";i:213;s:9:"mime-type";s:9:"image/png";}s:12:"medium_large";a:4:{s:4:"file";s:13:"6-768x546.png";s:5:"width";i:768;s:6:"height";i:546;s:9:"mime-type";s:9:"image/png";}s:14:"shop_thumbnail";a:4:{s:4:"file";s:13:"6-180x180.png";s:5:"width";i:180;s:6:"height";i:180;s:9:"mime-type";s:9:"image/png";}s:12:"shop_catalog";a:4:{s:4:"file";s:13:"6-300x300.png";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:11:"shop_single";a:4:{s:4:"file";s:13:"6-600x579.png";s:5:"width";i:600;s:6:"height";i:579;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-100";a:4:{s:4:"file";s:12:"6-100x71.png";s:5:"width";i:100;s:6:"height";i:71;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-150";a:4:{s:4:"file";s:13:"6-150x107.png";s:5:"width";i:150;s:6:"height";i:107;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-200";a:4:{s:4:"file";s:13:"6-200x142.png";s:5:"width";i:200;s:6:"height";i:142;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-300";a:4:{s:4:"file";s:13:"6-300x213.png";s:5:"width";i:300;s:6:"height";i:213;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-450";a:4:{s:4:"file";s:13:"6-450x320.png";s:5:"width";i:450;s:6:"height";i:320;s:9:"mime-type";s:9:"image/png";}s:14:"responsive-600";a:4:{s:4:"file";s:13:"6-600x427.png";s:5:"width";i:600;s:6:"height";i:427;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(128, 60, '_wp_page_template', 'default'),
(129, 60, '_responsive_layout', 'default'),
(130, 63, '_edit_last', '1'),
(131, 63, '_edit_lock', '1490050208:1'),
(132, 63, '_wp_page_template', 'default'),
(133, 63, '_responsive_layout', 'default'),
(134, 1, '_wp_trash_meta_status', 'publish'),
(135, 1, '_wp_trash_meta_time', '1488771468'),
(136, 1, '_wp_desired_post_slug', 'hola-mundo'),
(137, 1, '_wp_trash_meta_comments_status', 'a:1:{i:1;s:1:"1";}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_posts`
--

CREATE TABLE `wp_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, 1, '2016-11-08 14:13:45', '2016-11-08 14:13:45', 'Bienvenido a WordPress. Esta es tu primera entrada. Edítala o bórrala, ¡y comienza a escribir!', '¡Hola mundo!', '', 'trash', 'open', 'open', '', 'hola-mundo__trashed', '', '', '2017-03-05 22:37:48', '2017-03-06 03:37:48', '', 0, 'http://localhost/wordpress/?p=1', 0, 'post', '', 1),
(2, 1, '2016-11-08 14:13:45', '2016-11-08 14:13:45', 'Esto es una página de ejemplo. Es diferente a una entrada porque permanece fija en un lugar y se mostrará en la navegación de tu sitio (en la mayoría de los temas). La mayoría de la gente empieza con una página de Acerca de, que les presenta a los potenciales visitantes del sitio. Podría ser algo como esto:\r\n<blockquote>¡Hola! Soy mensajero por el día, aspirante a actor por la noche, y este es mi blog. Vivo en Madrid, tengo un perrazo llamado Duque y me gustan las piñas coladas (y que me pille un chaparrón)</blockquote>\r\n...o algo así:\r\n<blockquote>La empresa XYZ se fundó en 1971 y ha estado ofreciendo "cosas" de calidad al público desde entonces. Situada en Madrid, XYZ emplea a más de 2.000 personas y hace todo tipo de cosas sorprendentes para la comunidad de Madrid.</blockquote>\r\nSi eres nuevo en WordPress deberías ir a <a href="http://localhost/wordpress/wp-admin/">tu escritorio</a> para borrar esta página y crear páginas nuevas con tu propio contenido. ¡Pásalo bien!', 'Página de ejemplo', '', 'draft', 'closed', 'open', '', 'pagina-ejemplo', '', '', '2017-03-05 21:31:00', '2017-03-06 02:31:00', '', 0, 'http://localhost/wordpress/?page_id=2', 0, 'page', '', 0),
(4, 1, '2016-11-08 14:18:13', '2016-11-08 14:18:13', '', 'Tienda', '', 'draft', 'closed', 'closed', '', 'tienda', '', '', '2017-03-05 21:31:13', '2017-03-06 02:31:13', '', 0, 'http://localhost/wordpress/tienda/', 0, 'page', '', 0),
(5, 1, '2016-11-08 14:18:13', '2016-11-08 14:18:13', '[woocommerce_cart]', 'Carrito', '', 'draft', 'closed', 'closed', '', 'carrito', '', '', '2017-03-05 21:29:53', '2017-03-06 02:29:53', '', 0, 'http://localhost/wordpress/carrito/', 0, 'page', '', 0),
(6, 1, '2016-11-08 14:18:13', '2016-11-08 14:18:13', '[woocommerce_checkout]', 'Finalizar compra', '', 'draft', 'closed', 'closed', '', 'finalizar-comprar', '', '', '2017-03-05 21:30:36', '2017-03-06 02:30:36', '', 0, 'http://localhost/wordpress/finalizar-comprar/', 0, 'page', '', 0),
(7, 1, '2016-11-08 14:18:13', '2016-11-08 14:18:13', '[woocommerce_my_account]', 'Mi cuenta', '', 'draft', 'closed', 'closed', '', 'mi-cuenta', '', '', '2017-03-05 21:30:50', '2017-03-06 02:30:50', '', 0, 'http://localhost/wordpress/mi-cuenta/', 0, 'page', '', 0),
(8, 1, '2016-11-08 14:24:31', '2016-11-08 14:24:31', 'Este es un producto de prueba para verificar la funcionalidad de la tienda, tanto de pagos como de visualización.', 'Producto de Prueba', 'Solo corresponde a un producto de prueba', 'publish', 'open', 'closed', '', 'producto-de-prueba', '', '', '2016-11-08 14:24:31', '2016-11-08 14:24:31', '', 0, 'http://localhost/wordpress/?post_type=product&#038;p=8', 0, 'product', '', 0),
(11, 1, '2017-03-05 21:27:46', '2017-03-06 02:27:46', 'BIDA es un proyecto pensado en la creación de un área especializada en el análisis de información de la entidad financiera BBVA en Colombia. Éste nueva unidad será creada <span style="font-weight: 400;">por medio de tres proyectos que abarcan el diseño técnico de la arquitectura, gestiòn de la configuración y el sistema de gestión de seguridad de la información permitiendo así poder implementar de manera exitosa todo este nuevo sistema Big Data en la compañía.</span>\r\n\r\n<span style="font-weight: 400;"><img class="alignnone size-medium wp-image-20 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/cropped-BBVA_287--300x93.png" alt="cropped-BBVA_287-.png" width="300" height="93" /></span>', '¿Qué es BIDA?', '', 'publish', 'closed', 'closed', '', 'que-es-bida', '', '', '2017-03-05 21:52:41', '2017-03-06 02:52:41', '', 0, 'http://localhost/wordpress/?page_id=11', 0, 'page', '', 0),
(12, 1, '2017-03-05 21:27:28', '2017-03-06 02:27:28', '', '¿Qué es BIDA?', '', 'inherit', 'closed', 'closed', '', '11-revision-v1', '', '', '2017-03-05 21:27:28', '2017-03-06 02:27:28', '', 11, 'http://localhost/wordpress/2017/03/05/11-revision-v1/', 0, 'revision', '', 0),
(13, 1, '2017-03-05 21:29:53', '2017-03-06 02:29:53', '[woocommerce_cart]', 'Carrito', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2017-03-05 21:29:53', '2017-03-06 02:29:53', '', 5, 'http://localhost/wordpress/2017/03/05/5-revision-v1/', 0, 'revision', '', 0),
(14, 1, '2017-03-05 21:30:36', '2017-03-06 02:30:36', '[woocommerce_checkout]', 'Finalizar compra', '', 'inherit', 'closed', 'closed', '', '6-revision-v1', '', '', '2017-03-05 21:30:36', '2017-03-06 02:30:36', '', 6, 'http://localhost/wordpress/2017/03/05/6-revision-v1/', 0, 'revision', '', 0),
(15, 1, '2017-03-05 21:30:50', '2017-03-06 02:30:50', '[woocommerce_my_account]', 'Mi cuenta', '', 'inherit', 'closed', 'closed', '', '7-revision-v1', '', '', '2017-03-05 21:30:50', '2017-03-06 02:30:50', '', 7, 'http://localhost/wordpress/2017/03/05/7-revision-v1/', 0, 'revision', '', 0),
(16, 1, '2017-03-05 21:31:00', '2017-03-06 02:31:00', 'Esto es una página de ejemplo. Es diferente a una entrada porque permanece fija en un lugar y se mostrará en la navegación de tu sitio (en la mayoría de los temas). La mayoría de la gente empieza con una página de Acerca de, que les presenta a los potenciales visitantes del sitio. Podría ser algo como esto:\r\n<blockquote>¡Hola! Soy mensajero por el día, aspirante a actor por la noche, y este es mi blog. Vivo en Madrid, tengo un perrazo llamado Duque y me gustan las piñas coladas (y que me pille un chaparrón)</blockquote>\r\n...o algo así:\r\n<blockquote>La empresa XYZ se fundó en 1971 y ha estado ofreciendo "cosas" de calidad al público desde entonces. Situada en Madrid, XYZ emplea a más de 2.000 personas y hace todo tipo de cosas sorprendentes para la comunidad de Madrid.</blockquote>\r\nSi eres nuevo en WordPress deberías ir a <a href="http://localhost/wordpress/wp-admin/">tu escritorio</a> para borrar esta página y crear páginas nuevas con tu propio contenido. ¡Pásalo bien!', 'Página de ejemplo', '', 'inherit', 'closed', 'closed', '', '2-revision-v1', '', '', '2017-03-05 21:31:00', '2017-03-06 02:31:00', '', 2, 'http://localhost/wordpress/2017/03/05/2-revision-v1/', 0, 'revision', '', 0),
(17, 1, '2017-03-05 21:31:13', '2017-03-06 02:31:13', '', 'Tienda', '', 'inherit', 'closed', 'closed', '', '4-revision-v1', '', '', '2017-03-05 21:31:13', '2017-03-06 02:31:13', '', 4, 'http://localhost/wordpress/2017/03/05/4-revision-v1/', 0, 'revision', '', 0),
(20, 1, '2017-03-05 21:36:15', '2017-03-06 02:36:15', '', 'cropped-BBVA_287-.png', '', 'inherit', 'open', 'closed', '', 'cropped-bbva_287-png', '', '', '2017-03-05 21:52:34', '2017-03-06 02:52:34', '', 11, 'http://localhost/wordpress/wp-content/uploads/2017/03/cropped-BBVA_287-.png', 0, 'attachment', 'image/png', 0),
(21, 1, '2017-03-05 21:38:10', '2017-03-06 02:38:10', '', '2', '', 'inherit', 'open', 'closed', '', '2', '', '', '2017-03-05 21:52:06', '2017-03-06 02:52:06', '', 11, 'http://localhost/wordpress/wp-content/uploads/2017/03/2.png', 0, 'attachment', 'image/png', 0),
(22, 1, '2017-03-05 21:38:17', '2017-03-06 02:38:17', '', 'cropped-2.png', '', 'inherit', 'open', 'closed', '', 'cropped-2-png', '', '', '2017-03-05 21:38:17', '2017-03-06 02:38:17', '', 0, 'http://localhost/wordpress/wp-content/uploads/2017/03/cropped-2.png', 0, 'attachment', 'image/png', 0),
(23, 1, '2017-03-05 21:42:15', '2017-03-06 02:42:15', 'http://localhost/wordpress/wp-content/uploads/2017/03/cropped-cropped-2.png', 'cropped-cropped-2.png', '', 'inherit', 'open', 'closed', '', 'cropped-cropped-2-png', '', '', '2017-03-05 21:42:15', '2017-03-06 02:42:15', '', 0, 'http://localhost/wordpress/wp-content/uploads/2017/03/cropped-cropped-2.png', 0, 'attachment', 'image/png', 0),
(25, 1, '2017-03-05 21:51:41', '2017-03-06 02:51:41', 'BIDA es un proyecto pensado en la creación de un área especializada en el análisis de información de la entidad financiera BBVA en Colombia. Éste nueva unidad será creada <span style="font-weight: 400;">por medio de tres proyectos que abarcan el diseño técnico de la arquitectura, gestiòn de la configuración y el sistema de gestión de seguridad de la información permitiendo así poder implementar de manera exitosa todo este nuevo sistema Big Data en la compañía.</span>', '¿Qué es BIDA?', '', 'inherit', 'closed', 'closed', '', '11-revision-v1', '', '', '2017-03-05 21:51:41', '2017-03-06 02:51:41', '', 11, 'http://localhost/wordpress/2017/03/05/11-revision-v1/', 0, 'revision', '', 0),
(26, 1, '2017-03-05 21:52:41', '2017-03-06 02:52:41', 'BIDA es un proyecto pensado en la creación de un área especializada en el análisis de información de la entidad financiera BBVA en Colombia. Éste nueva unidad será creada <span style="font-weight: 400;">por medio de tres proyectos que abarcan el diseño técnico de la arquitectura, gestiòn de la configuración y el sistema de gestión de seguridad de la información permitiendo así poder implementar de manera exitosa todo este nuevo sistema Big Data en la compañía.</span>\r\n\r\n<span style="font-weight: 400;"><img class="alignnone size-medium wp-image-20 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/cropped-BBVA_287--300x93.png" alt="cropped-BBVA_287-.png" width="300" height="93" /></span>', '¿Qué es BIDA?', '', 'inherit', 'closed', 'closed', '', '11-revision-v1', '', '', '2017-03-05 21:52:41', '2017-03-06 02:52:41', '', 11, 'http://localhost/wordpress/2017/03/05/11-revision-v1/', 0, 'revision', '', 0),
(27, 1, '2017-03-05 22:01:36', '2017-03-06 03:01:36', '<span style="font-weight: 400;">Realizaremos el análisis, diseño y desarrollo de un  área completamente nueva  en la compañía encargada de todo el estudio de Big Data junto con todos los artefactos necesarios para su implementación, con el objetivo de brindarle a la compañía la oportunidad de poder ampliar su segmento de clientes, generar un mayor margen de ganancias y poder garantizar la fidelización de nuevos clientes potenciales. Todo esto en base de poder aprovechar toda la información capturada sobre cada una de las diferentes áreas de la compañía que manejan cada uno de los productos del centro de formalización del banco BBVA, con el objetivo de mejorar el sistema actual desde el momento de la recepción documental hasta la última etapa del negocio que es la elevación de los créditos, reduciendo los tiempos, aumentando la productividad, disminuyendo los costos y generar valor agregado al negocio permitiendo la toma decisiones en tiempo real según el informes sobre los avances del dia y de esta manera resaltar en el mercado actual como líderes.</span>\r\n\r\n<img class="alignnone size-medium wp-image-37 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-2-300x168.png" alt="3" width="300" height="168" />\r\n\r\n&nbsp;', '¿Cómo lo lograremos?', '', 'publish', 'closed', 'closed', '', 'como-lo-lograremos', '', '', '2017-03-05 22:33:11', '2017-03-06 03:33:11', '', 0, 'http://localhost/wordpress/?page_id=27', 2, 'page', '', 0),
(31, 1, '2017-03-05 22:00:27', '2017-03-06 03:00:27', '', '3', '', 'inherit', 'open', 'closed', '', '3', '', '', '2017-03-05 22:00:27', '2017-03-06 03:00:27', '', 27, 'http://localhost/wordpress/wp-content/uploads/2017/03/3.png', 0, 'attachment', 'image/png', 0),
(32, 1, '2017-03-05 22:01:19', '2017-03-06 03:01:19', '', '3', '', 'inherit', 'open', 'closed', '', '3-2', '', '', '2017-03-05 22:01:19', '2017-03-06 03:01:19', '', 27, 'http://localhost/wordpress/wp-content/uploads/2017/03/3-1.png', 0, 'attachment', 'image/png', 0),
(33, 1, '2017-03-05 22:01:36', '2017-03-06 03:01:36', '<span style="font-weight: 400;">Realizaremos el análisis, diseño y desarrollo de un  área completamente nueva  en la compañía encargada de todo el estudio de Big Data junto con todos los artefactos necesarios para su implementación, con el objetivo de brindarle a la compañía la oportunidad de poder ampliar su segmento de clientes, generar un mayor margen de ganancias y poder garantizar la fidelización de nuevos clientes potenciales. Todo esto en base de poder aprovechar toda la información capturada sobre cada una de las diferentes áreas de la compañía que manejan cada uno de los productos del centro de formalización del banco BBVA, con el objetivo de mejorar el sistema actual desde el momento de la recepción documental hasta la última etapa del negocio que es la elevación de los créditos, reduciendo los tiempos, aumentando la productividad, disminuyendo los costos y generar valor agregado al negocio permitiendo la toma decisiones en tiempo real según el informes sobre los avances del dia y de esta manera resaltar en el mercado actual como líderes.</span>\r\n\r\n&nbsp;', '¿Cómo lo lograremos?', '', 'inherit', 'closed', 'closed', '', '27-revision-v1', '', '', '2017-03-05 22:01:36', '2017-03-06 03:01:36', '', 27, 'http://localhost/wordpress/2017/03/05/27-revision-v1/', 0, 'revision', '', 0),
(35, 1, '2017-03-05 22:06:24', '2017-03-06 03:06:24', '<span style="font-weight: 400;">Realizaremos el análisis, diseño y desarrollo de un  área completamente nueva  en la compañía encargada de todo el estudio de Big Data junto con todos los artefactos necesarios para su implementación, con el objetivo de brindarle a la compañía la oportunidad de poder ampliar su segmento de clientes, generar un mayor margen de ganancias y poder garantizar la fidelización de nuevos clientes potenciales. Todo esto en base de poder aprovechar toda la información capturada sobre cada una de las diferentes áreas de la compañía que manejan cada uno de los productos del centro de formalización del banco BBVA, con el objetivo de mejorar el sistema actual desde el momento de la recepción documental hasta la última etapa del negocio que es la elevación de los créditos, reduciendo los tiempos, aumentando la productividad, disminuyendo los costos y generar valor agregado al negocio permitiendo la toma decisiones en tiempo real según el informes sobre los avances del dia y de esta manera resaltar en el mercado actual como líderes.</span>\r\n\r\n<img class="alignnone size-medium wp-image-32 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-1-300x168.png" alt="3" width="300" height="168" />\r\n\r\n&nbsp;', '¿Cómo lo lograremos?', '', 'inherit', 'closed', 'closed', '', '27-revision-v1', '', '', '2017-03-05 22:06:24', '2017-03-06 03:06:24', '', 27, 'http://localhost/wordpress/2017/03/05/27-revision-v1/', 0, 'revision', '', 0),
(36, 1, '2017-03-05 22:08:00', '2017-03-06 03:08:00', '<span style="font-weight: 400;">Realizaremos el análisis, diseño y desarrollo de un  área completamente nueva  en la compañía encargada de todo el estudio de Big Data junto con todos los artefactos necesarios para su implementación, con el objetivo de brindarle a la compañía la oportunidad de poder ampliar su segmento de clientes, generar un mayor margen de ganancias y poder garantizar la fidelización de nuevos clientes potenciales. Todo esto en base de poder aprovechar toda la información capturada sobre cada una de las diferentes áreas de la compañía que manejan cada uno de los productos del centro de formalización del banco BBVA, con el objetivo de mejorar el sistema actual desde el momento de la recepción documental hasta la última etapa del negocio que es la elevación de los créditos, reduciendo los tiempos, aumentando la productividad, disminuyendo los costos y generar valor agregado al negocio permitiendo la toma decisiones en tiempo real según el informes sobre los avances del dia y de esta manera resaltar en el mercado actual como líderes.</span>\r\n\r\n<img class="alignnone  wp-image-32 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-1-300x168.png" alt="3" width="590" height="330" />\r\n\r\n&nbsp;', '¿Cómo lo lograremos?', '', 'inherit', 'closed', 'closed', '', '27-revision-v1', '', '', '2017-03-05 22:08:00', '2017-03-06 03:08:00', '', 27, 'http://localhost/wordpress/2017/03/05/27-revision-v1/', 0, 'revision', '', 0),
(37, 1, '2017-03-05 22:15:36', '2017-03-06 03:15:36', '', '3', '', 'inherit', 'open', 'closed', '', '3-3', '', '', '2017-03-05 22:15:36', '2017-03-06 03:15:36', '', 27, 'http://localhost/wordpress/wp-content/uploads/2017/03/3-2.png', 0, 'attachment', 'image/png', 0),
(38, 1, '2017-03-05 22:16:03', '2017-03-06 03:16:03', '<span style="font-weight: 400;">Realizaremos el análisis, diseño y desarrollo de un  área completamente nueva  en la compañía encargada de todo el estudio de Big Data junto con todos los artefactos necesarios para su implementación, con el objetivo de brindarle a la compañía la oportunidad de poder ampliar su segmento de clientes, generar un mayor margen de ganancias y poder garantizar la fidelización de nuevos clientes potenciales. Todo esto en base de poder aprovechar toda la información capturada sobre cada una de las diferentes áreas de la compañía que manejan cada uno de los productos del centro de formalización del banco BBVA, con el objetivo de mejorar el sistema actual desde el momento de la recepción documental hasta la última etapa del negocio que es la elevación de los créditos, reduciendo los tiempos, aumentando la productividad, disminuyendo los costos y generar valor agregado al negocio permitiendo la toma decisiones en tiempo real según el informes sobre los avances del dia y de esta manera resaltar en el mercado actual como líderes.</span>\r\n\r\n<img class="alignnone size-medium wp-image-37 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-2-300x168.png" alt="3" width="300" height="168" />\r\n\r\n&nbsp;', '¿Cómo lo lograremos?', '', 'inherit', 'closed', 'closed', '', '27-revision-v1', '', '', '2017-03-05 22:16:03', '2017-03-06 03:16:03', '', 27, 'http://localhost/wordpress/2017/03/05/27-revision-v1/', 0, 'revision', '', 0),
(39, 1, '2017-03-05 22:18:10', '2017-03-06 03:18:10', 'El RoadMap, define cada una de las tareas a ejecutar mediante los cuartiles definidos a lo largo del proyecto. Se han elegido tres tareas a ejecutar en la primera fase del mismo:\r\n<ul>\r\n 	<li>Seguridad y Gestión de la Información.</li>\r\n 	<li>Diseño técnico y levantamiento de Arquitectura.</li>\r\n 	<li>Gestión de la configuración.</li>\r\n</ul>\r\n<img class="alignnone size-medium wp-image-37 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-2-300x168.png" alt="3" width="300" height="168" />', 'RoadMap', '', 'publish', 'closed', 'closed', '', 'roadmap', '', '', '2017-03-05 22:32:47', '2017-03-06 03:32:47', '', 27, 'http://localhost/wordpress/?page_id=39', 0, 'page', '', 0),
(40, 1, '2017-03-05 22:18:10', '2017-03-06 03:18:10', '', 'RoadMap', '', 'inherit', 'closed', 'closed', '', '39-revision-v1', '', '', '2017-03-05 22:18:10', '2017-03-06 03:18:10', '', 39, 'http://localhost/wordpress/2017/03/05/39-revision-v1/', 0, 'revision', '', 0),
(41, 1, '2017-03-05 22:19:21', '2017-03-06 03:19:21', 'Por medio de los Diagramas de Pert, haremos el seguimiento al tiempo y a los recursos necesarios para completar cada una de las tareas identificadas. Para cada uno de los proyectos elegidos, se definieron los diagramas correspondientes.\r\n\r\n<img class="alignnone size-medium wp-image-55" src="http://localhost/wordpress/wp-content/uploads/2017/03/5-300x138.png" alt="5" width="300" height="138" />', 'Diagrama de Pert', '', 'publish', 'closed', 'closed', '', 'edt', '', '', '2017-03-05 22:29:33', '2017-03-06 03:29:33', '', 27, 'http://localhost/wordpress/?page_id=41', 1, 'page', '', 0),
(42, 1, '2017-03-05 22:19:21', '2017-03-06 03:19:21', '', 'EDT', '', 'inherit', 'closed', 'closed', '', '41-revision-v1', '', '', '2017-03-05 22:19:21', '2017-03-06 03:19:21', '', 41, 'http://localhost/wordpress/2017/03/05/41-revision-v1/', 0, 'revision', '', 0),
(43, 1, '2017-03-05 22:19:38', '2017-03-06 03:19:38', '', 'Diagrama de Pert', '', 'inherit', 'closed', 'closed', '', '41-revision-v1', '', '', '2017-03-05 22:19:38', '2017-03-06 03:19:38', '', 41, 'http://localhost/wordpress/2017/03/05/41-revision-v1/', 0, 'revision', '', 0),
(49, 1, '2017-03-05 22:24:51', '2017-03-06 03:24:51', 'Por medio de Estructuras de Desgloce de Trabajo, determinaremos tareas  y fases para cada uno de los proyectos que especificamos en el RoadMap del proyecto.\r\n\r\n<img class="alignnone size-medium wp-image-51 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/4-250x300.png" alt="4" width="250" height="300" />', 'EDT', '', 'publish', 'closed', 'closed', '', 'edt-2', '', '', '2017-03-05 22:30:06', '2017-03-06 03:30:06', '', 27, 'http://localhost/wordpress/?page_id=49', 1, 'page', '', 0),
(50, 1, '2017-03-05 22:24:51', '2017-03-06 03:24:51', '', 'EDT', '', 'inherit', 'closed', 'closed', '', '49-revision-v1', '', '', '2017-03-05 22:24:51', '2017-03-06 03:24:51', '', 49, 'http://localhost/wordpress/2017/03/05/49-revision-v1/', 0, 'revision', '', 0),
(51, 1, '2017-03-05 22:25:01', '2017-03-06 03:25:01', '', '4', '', 'inherit', 'open', 'closed', '', '4', '', '', '2017-03-05 22:25:01', '2017-03-06 03:25:01', '', 49, 'http://localhost/wordpress/wp-content/uploads/2017/03/4.png', 0, 'attachment', 'image/png', 0),
(52, 1, '2017-03-05 22:25:53', '2017-03-06 03:25:53', 'Por medio de Estructuras de Desgloce de Trabajo, determinaremos tareas  y fases para cada uno de los proyectos que especificamos en el RoadMap de\n\n<img class="alignnone size-medium wp-image-51 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/4-250x300.png" alt="4" width="250" height="300" />', 'EDT', '', 'inherit', 'closed', 'closed', '', '49-autosave-v1', '', '', '2017-03-05 22:25:53', '2017-03-06 03:25:53', '', 49, 'http://localhost/wordpress/2017/03/05/49-autosave-v1/', 0, 'revision', '', 0),
(53, 1, '2017-03-05 22:25:57', '2017-03-06 03:25:57', 'Por medio de Estructuras de Desgloce de Trabajo, determinaremos tareas  y fases para cada uno de los proyectos que especificamos en el RoadMap del proyecto.\r\n\r\n<img class="alignnone size-medium wp-image-51 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/4-250x300.png" alt="4" width="250" height="300" />', 'EDT', '', 'inherit', 'closed', 'closed', '', '49-revision-v1', '', '', '2017-03-05 22:25:57', '2017-03-06 03:25:57', '', 49, 'http://localhost/wordpress/2017/03/05/49-revision-v1/', 0, 'revision', '', 0),
(55, 1, '2017-03-05 22:27:16', '2017-03-06 03:27:16', '', '5', '', 'inherit', 'open', 'closed', '', '5', '', '', '2017-03-05 22:27:16', '2017-03-06 03:27:16', '', 41, 'http://localhost/wordpress/wp-content/uploads/2017/03/5.png', 0, 'attachment', 'image/png', 0),
(56, 1, '2017-03-05 22:28:17', '2017-03-06 03:28:17', 'Por medio de los Diagramas de Pert\n\n<img class="alignnone size-medium wp-image-55" src="http://localhost/wordpress/wp-content/uploads/2017/03/5-300x138.png" alt="5" width="300" height="138" />', 'Diagrama de Pert', '', 'inherit', 'closed', 'closed', '', '41-autosave-v1', '', '', '2017-03-05 22:28:17', '2017-03-06 03:28:17', '', 41, 'http://localhost/wordpress/2017/03/05/41-autosave-v1/', 0, 'revision', '', 0),
(57, 1, '2017-03-05 22:29:33', '2017-03-06 03:29:33', 'Por medio de los Diagramas de Pert, haremos el seguimiento al tiempo y a los recursos necesarios para completar cada una de las tareas identificadas. Para cada uno de los proyectos elegidos, se definieron los diagramas correspondientes.\r\n\r\n<img class="alignnone size-medium wp-image-55" src="http://localhost/wordpress/wp-content/uploads/2017/03/5-300x138.png" alt="5" width="300" height="138" />', 'Diagrama de Pert', '', 'inherit', 'closed', 'closed', '', '41-revision-v1', '', '', '2017-03-05 22:29:33', '2017-03-06 03:29:33', '', 41, 'http://localhost/wordpress/2017/03/05/41-revision-v1/', 0, 'revision', '', 0),
(58, 1, '2017-03-05 22:31:23', '2017-03-06 03:31:23', 'El RoadMap, define cada una de las tareas a ejecutar mediante los cuartiles definidos a lo largo del proyecto. Se han elegido tres tareas a ejecutar en la primera fase del mismo:\n\n&nbsp;', 'RoadMap', '', 'inherit', 'closed', 'closed', '', '39-autosave-v1', '', '', '2017-03-05 22:31:23', '2017-03-06 03:31:23', '', 39, 'http://localhost/wordpress/2017/03/05/39-autosave-v1/', 0, 'revision', '', 0),
(59, 1, '2017-03-05 22:32:47', '2017-03-06 03:32:47', 'El RoadMap, define cada una de las tareas a ejecutar mediante los cuartiles definidos a lo largo del proyecto. Se han elegido tres tareas a ejecutar en la primera fase del mismo:\r\n<ul>\r\n 	<li>Seguridad y Gestión de la Información.</li>\r\n 	<li>Diseño técnico y levantamiento de Arquitectura.</li>\r\n 	<li>Gestión de la configuración.</li>\r\n</ul>\r\n<img class="alignnone size-medium wp-image-37 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/3-2-300x168.png" alt="3" width="300" height="168" />', 'RoadMap', '', 'inherit', 'closed', 'closed', '', '39-revision-v1', '', '', '2017-03-05 22:32:47', '2017-03-06 03:32:47', '', 39, 'http://localhost/wordpress/2017/03/05/39-revision-v1/', 0, 'revision', '', 0),
(60, 1, '2017-03-05 22:35:16', '2017-03-06 03:35:16', 'Para identificar los elementos y procesos que se podían fortalecer o modificar en la compañía, utilizamos el modelo Canvas:\r\n\r\n<img class="alignnone size-medium wp-image-61 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/6-300x213.png" alt="6" width="300" height="213" />', 'Análisis de la compañia', '', 'publish', 'closed', 'closed', '', 'analisis-de-la-compania', '', '', '2017-03-05 22:35:16', '2017-03-06 03:35:16', '', 0, 'http://localhost/wordpress/?page_id=60', 0, 'page', '', 0),
(61, 1, '2017-03-05 22:35:06', '2017-03-06 03:35:06', '', '6', '', 'inherit', 'open', 'closed', '', '6', '', '', '2017-03-05 22:35:06', '2017-03-06 03:35:06', '', 60, 'http://localhost/wordpress/wp-content/uploads/2017/03/6.png', 0, 'attachment', 'image/png', 0),
(62, 1, '2017-03-05 22:35:16', '2017-03-06 03:35:16', 'Para identificar los elementos y procesos que se podían fortalecer o modificar en la compañía, utilizamos el modelo Canvas:\r\n\r\n<img class="alignnone size-medium wp-image-61 aligncenter" src="http://localhost/wordpress/wp-content/uploads/2017/03/6-300x213.png" alt="6" width="300" height="213" />', 'Análisis de la compañia', '', 'inherit', 'closed', 'closed', '', '60-revision-v1', '', '', '2017-03-05 22:35:16', '2017-03-06 03:35:16', '', 60, 'http://localhost/wordpress/2017/03/05/60-revision-v1/', 0, 'revision', '', 0),
(63, 1, '2017-03-05 22:37:15', '2017-03-06 03:37:15', 'SCRUM\r\n\r\nPara este proyecto se decide tomar la metodología de desarrollo ágil SCRUM ya que somos un equipo pequeño de trabajo, tenemos necesidad reducida de documentación y teniendo en cuenta la dimensión del proyecto requerimos hacer entregas rápidas y de valor. Adicionalmente el proyecto es susceptible a modificaciones durante el desarrollo.', 'Metodología', '', 'publish', 'closed', 'closed', '', 'metodologia', '', '', '2017-03-05 22:37:27', '2017-03-06 03:37:27', '', 0, 'http://localhost/wordpress/?page_id=63', 5, 'page', '', 0),
(64, 1, '2017-03-05 22:37:15', '2017-03-06 03:37:15', 'SCRUM\r\n\r\nPara este proyecto se decide tomar la metodología de desarrollo ágil SCRUM ya que somos un equipo pequeño de trabajo, tenemos necesidad reducida de documentación y teniendo en cuenta la dimensión del proyecto requerimos hacer entregas rápidas y de valor. Adicionalmente el proyecto es susceptible a modificaciones durante el desarrollo.', 'Metodología', '', 'inherit', 'closed', 'closed', '', '63-revision-v1', '', '', '2017-03-05 22:37:15', '2017-03-06 03:37:15', '', 63, 'http://localhost/wordpress/2017/03/05/63-revision-v1/', 0, 'revision', '', 0),
(65, 1, '2017-03-05 22:37:48', '2017-03-06 03:37:48', 'Bienvenido a WordPress. Esta es tu primera entrada. Edítala o bórrala, ¡y comienza a escribir!', '¡Hola mundo!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2017-03-05 22:37:48', '2017-03-06 03:37:48', '', 1, 'http://localhost/wordpress/2017/03/05/1-revision-v1/', 0, 'revision', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_term_relationships`
--

CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(1, 1, 0),
(8, 2, 0),
(8, 6, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_term_taxonomy`
--

CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 0),
(2, 2, 'product_type', '', 0, 1),
(3, 3, 'product_type', '', 0, 0),
(4, 4, 'product_type', '', 0, 0),
(5, 5, 'product_type', '', 0, 0),
(6, 6, 'product_tag', '', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_termmeta`
--

CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_termmeta`
--

INSERT INTO `wp_termmeta` (`meta_id`, `term_id`, `meta_key`, `meta_value`) VALUES
(1, 6, 'product_count_product_tag', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_terms`
--

CREATE TABLE `wp_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, 'Sin categoría', 'sin-categoria', 0),
(2, 'simple', 'simple', 0),
(3, 'grouped', 'grouped', 0),
(4, 'variable', 'variable', 0),
(5, 'external', 'external', 0),
(6, 'Prueba', 'prueba', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_usermeta`
--

CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_usermeta`
--

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'nickname', 'jnrubiano'),
(2, 1, 'first_name', ''),
(3, 1, 'last_name', ''),
(4, 1, 'description', ''),
(5, 1, 'rich_editing', 'true'),
(6, 1, 'comment_shortcuts', 'false'),
(7, 1, 'admin_color', 'fresh'),
(8, 1, 'use_ssl', '0'),
(9, 1, 'show_admin_bar_front', 'true'),
(10, 1, 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}'),
(11, 1, 'wp_user_level', '10'),
(12, 1, 'dismissed_wp_pointers', ''),
(13, 1, 'show_welcome_panel', '1'),
(14, 1, 'session_tokens', 'a:1:{s:64:"c93f75c9b5573ea5c456e82dc8933d65f270131cfec14f68e3f598a246e30689";a:4:{s:10:"expiration";i:1490219362;s:2:"ip";s:3:"::1";s:2:"ua";s:113:"Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36";s:5:"login";i:1490046562;}}'),
(15, 1, 'wp_dashboard_quick_press_last_post_id', '10'),
(16, 1, 'manageedit-shop_ordercolumnshidden', 'a:1:{i:0;s:15:"billing_address";}'),
(17, 1, '_woocommerce_persistent_cart', 'a:1:{s:4:"cart";a:0:{}}'),
(18, 1, 'wp_user-settings', 'libraryContent=browse&mfold=o&post_dfw=off'),
(19, 1, 'wp_user-settings-time', '1488769580');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_users`
--

CREATE TABLE `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_users`
--

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'jnrubiano', '$P$BX2snPnA8yK2jD4lvKaiT.EIv1X7X/.', 'jnrubiano', 'jnrubiano@gmail.com', '', '2016-11-08 14:13:45', '', 1, 'jnrubiano');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_api_keys`
--

CREATE TABLE `wp_woocommerce_api_keys` (
  `key_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_ci,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_attribute_taxonomies`
--

CREATE TABLE `wp_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint(20) NOT NULL,
  `attribute_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_label` longtext COLLATE utf8mb4_unicode_ci,
  `attribute_type` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_orderby` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_public` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_downloadable_product_permissions`
--

CREATE TABLE `wp_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint(20) NOT NULL,
  `download_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL DEFAULT '0',
  `order_key` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `downloads_remaining` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_order_itemmeta`
--

CREATE TABLE `wp_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) NOT NULL,
  `order_item_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_order_items`
--

CREATE TABLE `wp_woocommerce_order_items` (
  `order_item_id` bigint(20) NOT NULL,
  `order_item_name` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_item_type` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_payment_tokenmeta`
--

CREATE TABLE `wp_woocommerce_payment_tokenmeta` (
  `meta_id` bigint(20) NOT NULL,
  `payment_token_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_payment_tokens`
--

CREATE TABLE `wp_woocommerce_payment_tokens` (
  `token_id` bigint(20) NOT NULL,
  `gateway_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_sessions`
--

CREATE TABLE `wp_woocommerce_sessions` (
  `session_id` bigint(20) NOT NULL,
  `session_key` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_expiry` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_woocommerce_sessions`
--

INSERT INTO `wp_woocommerce_sessions` (`session_id`, `session_key`, `session_value`, `session_expiry`) VALUES
(6, '1', 'a:18:{s:4:"cart";s:6:"a:0:{}";s:15:"applied_coupons";s:6:"a:0:{}";s:23:"coupon_discount_amounts";s:6:"a:0:{}";s:27:"coupon_discount_tax_amounts";s:6:"a:0:{}";s:21:"removed_cart_contents";s:6:"a:0:{}";s:19:"cart_contents_total";i:0;s:5:"total";i:0;s:8:"subtotal";i:0;s:15:"subtotal_ex_tax";i:0;s:9:"tax_total";i:0;s:5:"taxes";s:6:"a:0:{}";s:14:"shipping_taxes";s:6:"a:0:{}";s:13:"discount_cart";i:0;s:17:"discount_cart_tax";i:0;s:14:"shipping_total";i:0;s:18:"shipping_tax_total";i:0;s:9:"fee_total";i:0;s:4:"fees";s:6:"a:0:{}";}', 1490220093);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_shipping_zone_locations`
--

CREATE TABLE `wp_woocommerce_shipping_zone_locations` (
  `location_id` bigint(20) NOT NULL,
  `zone_id` bigint(20) NOT NULL,
  `location_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_shipping_zone_methods`
--

CREATE TABLE `wp_woocommerce_shipping_zone_methods` (
  `zone_id` bigint(20) NOT NULL,
  `instance_id` bigint(20) NOT NULL,
  `method_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_order` bigint(20) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_shipping_zones`
--

CREATE TABLE `wp_woocommerce_shipping_zones` (
  `zone_id` bigint(20) NOT NULL,
  `zone_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_order` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_tax_rate_locations`
--

CREATE TABLE `wp_woocommerce_tax_rate_locations` (
  `location_id` bigint(20) NOT NULL,
  `location_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_rate_id` bigint(20) NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_woocommerce_tax_rates`
--

CREATE TABLE `wp_woocommerce_tax_rates` (
  `tax_rate_id` bigint(20) NOT NULL,
  `tax_rate_country` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tax_rate` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tax_rate_priority` bigint(20) NOT NULL,
  `tax_rate_compound` int(1) NOT NULL DEFAULT '0',
  `tax_rate_shipping` int(1) NOT NULL DEFAULT '1',
  `tax_rate_order` bigint(20) NOT NULL,
  `tax_rate_class` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_comments`
--
ALTER TABLE `wp_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- Indices de la tabla `wp_duplicator_packages`
--
ALTER TABLE `wp_duplicator_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hash` (`hash`);

--
-- Indices de la tabla `wp_links`
--
ALTER TABLE `wp_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indices de la tabla `wp_options`
--
ALTER TABLE `wp_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- Indices de la tabla `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_posts`
--
ALTER TABLE `wp_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);

--
-- Indices de la tabla `wp_term_relationships`
--
ALTER TABLE `wp_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indices de la tabla `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indices de la tabla `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_terms`
--
ALTER TABLE `wp_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indices de la tabla `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_users`
--
ALTER TABLE `wp_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- Indices de la tabla `wp_woocommerce_api_keys`
--
ALTER TABLE `wp_woocommerce_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indices de la tabla `wp_woocommerce_attribute_taxonomies`
--
ALTER TABLE `wp_woocommerce_attribute_taxonomies`
  ADD PRIMARY KEY (`attribute_id`),
  ADD KEY `attribute_name` (`attribute_name`(191));

--
-- Indices de la tabla `wp_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `wp_woocommerce_downloadable_product_permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(191),`download_id`),
  ADD KEY `download_order_product` (`download_id`,`order_id`,`product_id`);

--
-- Indices de la tabla `wp_woocommerce_order_itemmeta`
--
ALTER TABLE `wp_woocommerce_order_itemmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `order_item_id` (`order_item_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_woocommerce_order_items`
--
ALTER TABLE `wp_woocommerce_order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indices de la tabla `wp_woocommerce_payment_tokenmeta`
--
ALTER TABLE `wp_woocommerce_payment_tokenmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `payment_token_id` (`payment_token_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_woocommerce_payment_tokens`
--
ALTER TABLE `wp_woocommerce_payment_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `wp_woocommerce_sessions`
--
ALTER TABLE `wp_woocommerce_sessions`
  ADD PRIMARY KEY (`session_key`),
  ADD UNIQUE KEY `session_id` (`session_id`);

--
-- Indices de la tabla `wp_woocommerce_shipping_zone_locations`
--
ALTER TABLE `wp_woocommerce_shipping_zone_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `location_type` (`location_type`),
  ADD KEY `location_type_code` (`location_type`,`location_code`(90));

--
-- Indices de la tabla `wp_woocommerce_shipping_zone_methods`
--
ALTER TABLE `wp_woocommerce_shipping_zone_methods`
  ADD PRIMARY KEY (`instance_id`);

--
-- Indices de la tabla `wp_woocommerce_shipping_zones`
--
ALTER TABLE `wp_woocommerce_shipping_zones`
  ADD PRIMARY KEY (`zone_id`);

--
-- Indices de la tabla `wp_woocommerce_tax_rate_locations`
--
ALTER TABLE `wp_woocommerce_tax_rate_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`),
  ADD KEY `location_type` (`location_type`),
  ADD KEY `location_type_code` (`location_type`,`location_code`(90));

--
-- Indices de la tabla `wp_woocommerce_tax_rates`
--
ALTER TABLE `wp_woocommerce_tax_rates`
  ADD PRIMARY KEY (`tax_rate_id`),
  ADD KEY `tax_rate_country` (`tax_rate_country`(191)),
  ADD KEY `tax_rate_state` (`tax_rate_state`(191)),
  ADD KEY `tax_rate_class` (`tax_rate_class`(191)),
  ADD KEY `tax_rate_priority` (`tax_rate_priority`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_comments`
--
ALTER TABLE `wp_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `wp_duplicator_packages`
--
ALTER TABLE `wp_duplicator_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `wp_links`
--
ALTER TABLE `wp_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_options`
--
ALTER TABLE `wp_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=416;
--
-- AUTO_INCREMENT de la tabla `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;
--
-- AUTO_INCREMENT de la tabla `wp_posts`
--
ALTER TABLE `wp_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT de la tabla `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `wp_terms`
--
ALTER TABLE `wp_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT de la tabla `wp_users`
--
ALTER TABLE `wp_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_api_keys`
--
ALTER TABLE `wp_woocommerce_api_keys`
  MODIFY `key_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_attribute_taxonomies`
--
ALTER TABLE `wp_woocommerce_attribute_taxonomies`
  MODIFY `attribute_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `wp_woocommerce_downloadable_product_permissions`
  MODIFY `permission_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_order_itemmeta`
--
ALTER TABLE `wp_woocommerce_order_itemmeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_order_items`
--
ALTER TABLE `wp_woocommerce_order_items`
  MODIFY `order_item_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_payment_tokenmeta`
--
ALTER TABLE `wp_woocommerce_payment_tokenmeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_payment_tokens`
--
ALTER TABLE `wp_woocommerce_payment_tokens`
  MODIFY `token_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_sessions`
--
ALTER TABLE `wp_woocommerce_sessions`
  MODIFY `session_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_shipping_zone_locations`
--
ALTER TABLE `wp_woocommerce_shipping_zone_locations`
  MODIFY `location_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_shipping_zone_methods`
--
ALTER TABLE `wp_woocommerce_shipping_zone_methods`
  MODIFY `instance_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_shipping_zones`
--
ALTER TABLE `wp_woocommerce_shipping_zones`
  MODIFY `zone_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_tax_rate_locations`
--
ALTER TABLE `wp_woocommerce_tax_rate_locations`
  MODIFY `location_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `wp_woocommerce_tax_rates`
--
ALTER TABLE `wp_woocommerce_tax_rates`
  MODIFY `tax_rate_id` bigint(20) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
