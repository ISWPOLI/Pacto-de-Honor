CREATE TABLE `logros` ( `id_logro` int(11) NOT NULL, `nombre` varchar(50) NOT NULL,
 `descripcion` varchar(200) NOT NULL, `esModenas` tinyint(1) NOT NULL, `esRanking` tinyint(1) NOT NULL,
 `esTiempo` tinyint(1) NOT NULL, `monedas` int(11) NOT NULL, `ranking` int(11) NOT NULL,
 `tiempoJugado` int(11) NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=latin1;