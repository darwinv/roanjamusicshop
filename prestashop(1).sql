-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-05-2016 a las 15:47:33
-- Versión del servidor: 10.1.10-MariaDB
-- Versión de PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prestashop`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ps_rj_music`
--

CREATE TABLE `ps_rj_music` (
  `id_music` int(10) UNSIGNED NOT NULL,
  `position` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ps_rj_music`
--

INSERT INTO `ps_rj_music` (`id_music`, `position`, `active`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(5, 1, 1),
(6, 2, 1),
(7, 2, 1),
(8, 2, 1),
(9, 2, 1),
(10, 2, 1),
(11, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ps_rj_music_lang`
--

CREATE TABLE `ps_rj_music_lang` (
  `id_music` int(10) UNSIGNED NOT NULL,
  `id_lang` int(10) UNSIGNED NOT NULL,
  `mp3_name` varchar(255) NOT NULL,
  `mp3_title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `id_product` int(10) UNSIGNED NOT NULL,
  `linked_digital_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ps_rj_music_lang`
--

INSERT INTO `ps_rj_music_lang` (`id_music`, `id_lang`, `mp3_name`, `mp3_title`, `author`, `genero`, `id_product`, `linked_digital_id`) VALUES
(1, 1, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 2, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 3, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 4, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 5, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 6, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 7, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 8, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(1, 9, 'sample-1-1.mp3', 'Sample-1-1', 'Roanja', 'Sample', 1, '1'),
(2, 1, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 2, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 3, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 4, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 5, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 6, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 7, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 8, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(2, 9, 'sample-1-2.mp3', 'Sample-1-2', 'Roanja', 'Sample', 1, '1'),
(3, 1, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 2, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 3, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 4, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 5, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 6, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 7, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 8, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(3, 9, 'sample-1-3.mp3', 'Sample-1-3', 'Roanja', 'Sample', 1, '1'),
(4, 1, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 2, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 3, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 4, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 5, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 6, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 7, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 8, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(4, 9, 'sample-1-4.mp3', 'Sample-1-4', 'Roanja', 'Sample', 1, '1'),
(5, 1, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 2, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 3, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 4, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 5, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 6, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 7, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 8, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(5, 9, 'sample-1-5.mp3', 'Sample-1-5', 'Roanja', 'Sample', 1, '1'),
(6, 1, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 2, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 3, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 4, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 5, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 6, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 7, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 8, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(6, 9, 'sample-2-1.mp3', 'Sample-2-1', 'Roanja', 'Sample', 2, '2'),
(7, 1, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 2, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 3, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 4, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 5, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 6, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 7, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 8, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(7, 9, 'sample-2-2.mp3', 'Sample-2-2', 'Roanja', 'Sample', 2, '2'),
(8, 1, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 2, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 3, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 4, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 5, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 6, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 7, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 8, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(8, 9, 'sample-2-3.mp3', 'Sample-2-3', 'Roanja', 'Sample', 2, '2'),
(9, 1, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 2, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 3, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 4, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 5, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 6, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 7, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 8, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(9, 9, 'sample-2-4.mp3', 'Sample-2-4', 'Roanja', 'Sample', 2, '2'),
(10, 1, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 2, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 3, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 4, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 5, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 6, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 7, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 8, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(10, 9, 'sample-2-5.mp3', 'Sample-2-5', 'Roanja', 'Sample', 2, '2'),
(11, 1, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3'),
(11, 2, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3'),
(11, 3, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3'),
(11, 4, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3'),
(11, 5, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3'),
(11, 6, 'sample-3-1.mp3', 'Sample-3-1', 'Roanja', 'Sample', 3, '3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ps_rj_music_shop`
--

CREATE TABLE `ps_rj_music_shop` (
  `id_music` int(10) UNSIGNED NOT NULL,
  `id_shop` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ps_rj_music_shop`
--

INSERT INTO `ps_rj_music_shop` (`id_music`, `id_shop`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ps_rj_music`
--
ALTER TABLE `ps_rj_music`
  ADD PRIMARY KEY (`id_music`);

--
-- Indices de la tabla `ps_rj_music_lang`
--
ALTER TABLE `ps_rj_music_lang`
  ADD PRIMARY KEY (`id_music`,`id_lang`);

--
-- Indices de la tabla `ps_rj_music_shop`
--
ALTER TABLE `ps_rj_music_shop`
  ADD PRIMARY KEY (`id_music`,`id_shop`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ps_rj_music`
--
ALTER TABLE `ps_rj_music`
  MODIFY `id_music` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `ps_rj_music_shop`
--
ALTER TABLE `ps_rj_music_shop`
  MODIFY `id_music` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
