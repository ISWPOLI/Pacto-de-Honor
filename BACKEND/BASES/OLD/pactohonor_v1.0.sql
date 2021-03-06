-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-04-2017 a las 19:16:50
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pactohonor`
--
CREATE DATABASE IF NOT EXISTS `pactohonor` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `pactohonor`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

create TABLE `categoria` (
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
(19, 1, 1, 'Daniela la Jirafa', 'Caracterizada por ser un personaje talentoso e inteligente. Su estatura está representada en su capacidad de movimiento y agilidad física.', 9500, 950),
(20, 1, 2, 'Daniel León', 'Personajes con grandes cualidades de responsabilidad y compromiso académico. Evitan de manera incondicional cualquier tipo de trabajos de información imprecisa y ausente de fuentes de propiedad intelectual.', 10000, 1000),
(21, 1, 1, 'Pedro Ratón', 'Pedro se destaca por su apariencia pequeña, pero con una gran intuición y agilidad mental frente a los combates.', 10500, 1050);

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
(1, 1, 1, 1, 'Estudiante', 'Demo', 'usuario@poligran.edu.co', 'demo123', '2017-03-04 15:20:16', '87252C725AA64E2CB104E8A985B47405170417155119', '2017-04-17 15:51:19 '),
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
  MODIFY `id_personaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
