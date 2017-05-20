-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-02-2017 a las 02:21:40
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pactohonor`
--
CREATE DATABASE IF NOT EXISTS `pactohonor` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `pactohonor`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (  `id_jugador` int(11) NOT NULL,  `nickname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,  `monedas` int(10) NOT NULL,  `experiencia` decimal(65,0) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juper`
--

CREATE TABLE `juper` (  `id_juper` int(11) NOT NULL,  `id_jugador` int(11) NOT NULL,  `id_personaje` int(11) NOT NULL,  `id_nivel` int(11) NOT NULL,  `fuerza` int(11) NOT NULL,  `poder` int(11) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juperpoder`
--

CREATE TABLE `juperpoder` (  `id_juperpoder` int(11) NOT NULL,  `id_poder` int(11) NOT NULL,  `id_jugador` int(11) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mundo`
--

CREATE TABLE `mundo` (
  `id_mundo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_nivel` int(11) NOT NULL,
  `id_personaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (  `id_nivel` int(11) NOT NULL,  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje`
--

CREATE TABLE `personaje` (  `id_personaje` int(11) NOT NULL,  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,  `personalidad` varchar(255) COLLATE utf8_unicode_ci NOT NULL,  `costo` int(65) NOT NULL,  `id_mundo` int(11) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poder`
--

CREATE TABLE `poder` (  `id_poder` int(11) NOT NULL,  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,  `descipcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador` ADD PRIMARY KEY (`id_jugador`);

--
-- Indices de la tabla `juper`
--
ALTER TABLE `juper`  ADD PRIMARY KEY (`id_juper`),  ADD KEY `FK_JUPER_NIVEL` (`id_nivel`),  ADD KEY `FK_JUPER_NIVEL_JUGADOR` (`id_jugador`),  ADD KEY `FK_JUPER_PERSONAJE` (`id_personaje`);
--
-- Indices de la tabla `juperpoder`
--
ALTER TABLE `juperpoder`  ADD PRIMARY KEY (`id_juperpoder`),  ADD KEY `FK_JUPERPODER_PODER` (`id_poder`),  ADD KEY `FK_JUPERPODER_JUPER` (`id_jugador`);
--
-- Indices de la tabla `mundo`
--
ALTER TABLE `mundo`  ADD PRIMARY KEY (`id_mundo`),  ADD KEY `FK_MUNDO_NIVEL` (`id_nivel`),  ADD KEY `FK_MUNDO_PERSONAJE` (`id_personaje`);
--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`  ADD PRIMARY KEY (`id_nivel`);

--
-- Indices de la tabla `personaje`
--
ALTER TABLE `personaje`  ADD PRIMARY KEY (`id_personaje`),  ADD KEY `FK_PERSONAJE_MUNDO` (`id_mundo`);

--
-- Indices de la tabla `poder`
--
ALTER TABLE `poder`  ADD PRIMARY KEY (`id_poder`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`  MODIFY `id_jugador` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `juper`
--
ALTER TABLE `juper` MODIFY `id_juper` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `juperpoder`
--
ALTER TABLE `juperpoder`  MODIFY `id_juperpoder` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `mundo`
--
ALTER TABLE `mundo`  MODIFY `id_mundo` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`  MODIFY `id_nivel` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `personaje`
--
ALTER TABLE `personaje`  MODIFY `id_personaje` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `poder`
--
ALTER TABLE `poder` MODIFY `id_poder` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `juper`
--
ALTER TABLE `juper`  ADD CONSTRAINT `FK_JUPER_NIVEL` FOREIGN KEY (`id_nivel`) REFERENCES `nivel` (`id_nivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,  ADD CONSTRAINT `FK_JUPER_NIVEL_JUGADOR` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE NO ACTION ON UPDATE NO ACTION,  ADD CONSTRAINT `FK_JUPER_PERSONAJE` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `juperpoder`
--
ALTER TABLE `juperpoder`  ADD CONSTRAINT `FK_JUPERPODER_JUPER` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE NO ACTION ON UPDATE NO ACTION, ADD CONSTRAINT `FK_JUPERPODER_PODER` FOREIGN KEY (`id_poder`) REFERENCES `poder` (`id_poder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `mundo`
--
ALTER TABLE `mundo`  ADD CONSTRAINT `FK_MUNDO_NIVEL` FOREIGN KEY (`id_nivel`) REFERENCES `nivel` (`id_nivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,  ADD CONSTRAINT `FK_MUNDO_PERSONAJE` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje`
--
ALTER TABLE `personaje`  ADD CONSTRAINT `FK_PERSONAJE_MUNDO` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
