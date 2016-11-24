-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-11-2016 a las 23:57:09
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 7.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pasajes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertBus` (IN `v_placa` VARCHAR(15), IN `v_marca` VARCHAR(30), IN `v_num` VARCHAR(10), IN `v_color` VARCHAR(15), IN `v_capacidad` INT, IN `v_tipo` VARCHAR(15), IN `v_img` VARCHAR(150))  BEGIN
IF NOT EXISTS(SELECT id FROM bus WHERE placa LIKE v_placa) THEN
INSERT INTO bus VALUES(null, v_placa, v_marca, v_num, v_color, v_capacidad, v_tipo, v_img,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
ELSE
SELECT 'Error: placa ya registrada' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertChofer` (IN `v_ci` VARCHAR(15), IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_categoria` VARCHAR(5), IN `v_descripcion` TEXT, IN `v_celular` INT, IN `v_fecha_nac` DATE, IN `v_img` VARCHAR(150))  BEGIN
INSERT INTO chofer VALUES(null,v_ci,v_nombre,v_apellido,v_categoria,v_descripcion,v_celular,v_fecha_nac,v_img,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertCliente` (IN `v_ci` VARCHAR(15), IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_fecha_nac` DATE)  BEGIN
IF NOT EXISTS(SELECT id FROM cliente WHERE ci LIKE v_ci) THEN
INSERT INTO cliente VALUES(null,v_ci,v_nombre,v_apellido, v_fecha_nac,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha, 'success' AS error;
ELSE
SELECT 'Error: CI ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertPasaje` (IN `v_id_viaje` INT, IN `v_id_cliente` INT, IN `v_num_asiento` INT, IN `v_ubicacion` VARCHAR(10), IN `v_precio` FLOAT)  BEGIN
DECLARE nombre varchar(50);
DECLARE apellido varchar(50);
DECLARE horario varchar(30);
SET nombre = (SELECT nombre FROM cliente WHERE id = v_id_cliente);
SET apellido = (SELECT apellido FROM cliente WHERE id = v_id_cliente);
SET horario = (SELECT horario FROM viaje WHERE id = v_id_viaje);
IF NOT EXISTS(SELECT id FROM pasaje WHERE id_viaje = v_id_viaje AND num_asiento = v_num_asiento) THEN
INSERT INTO pasaje VALUES(null, v_id_viaje, v_id_cliente, v_num_asiento, v_ubicacion, v_precio,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,nombre,apellido,horario,'success' AS error;
ELSE
SELECT 'Error: Número de asiento ya ocupado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertUser` (IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_correo` VARCHAR(100), IN `v_contra` VARCHAR(100), IN `v_tipo` VARCHAR(5))  BEGIN
IF NOT EXISTS(SELECT id FROM user WHERE correo LIKE v_correo) THEN
INSERT INTO user VALUES(null,v_nombre,v_apellido,v_correo,v_contra,v_tipo,CURRENT_TIMESTAMP);
SELECT @@identity AS id,v_tipo AS tipo, 'success' AS error;
ELSE
SELECT 'Error: Correo ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertViaje` (IN `v_id_chofer` INT, IN `v_id_bus` INT, IN `v_horario` VARCHAR(30), IN `v_origen` VARCHAR(30), IN `v_destino` VARCHAR(30))  BEGIN
DECLARE nameChofer varchar(50);
DECLARE numBus varchar(10);
SET nameChofer = (SELECT nombre FROM chofer WHERE id = v_id_chofer);
SET numBus = (SELECT num FROM bus WHERE id = v_id_bus);
INSERT INTO viaje VALUES(null,v_id_chofer,v_id_bus,v_horario,v_origen,v_destino,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,nameChofer,numBus,'success' AS error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pSession` (IN `v_correo` VARCHAR(100), IN `v_pwd` VARCHAR(100))  BEGIN
DECLARE us int(11);
SET us = (SELECT id FROM user WHERE correo LIKE v_correo);
IF(us) THEN
IF EXISTS(SELECT id FROM user WHERE id = us AND contra LIKE v_pwd) THEN
SELECT id,'success' error,tipo As tipo FROM user WHERE id = us;
ELSE
SELECT 'Error: Contraseña incorrecta.' error;
END IF;
ELSE
SELECT 'Error: Correo no registrado.' error;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bus`
--

CREATE TABLE `bus` (
  `id` int(11) NOT NULL,
  `placa` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `marca` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `color` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `tipo` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `img` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `bus`
--

INSERT INTO `bus` (`id`, `placa`, `marca`, `num`, `color`, `capacidad`, `tipo`, `img`, `fecha`) VALUES
(1, 'placa-A1', 'Marca 1', 'bus-1', 'negro', 60, 'bus cama', 'andes_bus.jpeg', '2016-11-24 04:47:12'),
(3, 'placa-A2', 'marca 2', 'num-2', 'rojo', 64, 'semi', '1479979010.jpeg', '2016-11-24 05:16:50'),
(4, 'asdfRRRR', 'asdfRRR', 'asdfRRR', 'asdfRRR', 12346599, 'normal', '1479979100.jpeg', '2016-11-24 05:18:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chofer`
--

CREATE TABLE `chofer` (
  `id` int(11) NOT NULL,
  `ci` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `categoria` varchar(5) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish_ci,
  `celular` int(11) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `img` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `chofer`
--

INSERT INTO `chofer` (`id`, `ci`, `nombre`, `apellido`, `categoria`, `descripcion`, `celular`, `fecha_nac`, `img`, `fecha`) VALUES
(5, 'bbb', 'bbb', 'bbb', 'cat-C', 'bbbb', 1111, '2016-11-09', '1479696488.jpeg', '2016-11-20 22:48:08'),
(6, '10917752', 'Pedro', 'Fernandez', 'cat-C', 'Con 20 años de experiencia y dos choques', 75784221, '1995-11-08', '1479697043.png', '2016-11-20 22:57:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `ci` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `ci`, `nombre`, `apellido`, `fecha_nac`, `fecha`) VALUES
(1, '60215548', 'nombre cliente 1', 'apellido cliente 1', '1992-11-05', '2016-11-24 17:22:25'),
(2, '20845512', 'nombre cliente 2', 'apellido cliente 2', '1994-05-06', '2016-11-24 17:30:33'),
(3, '30625584', 'nombre cliente 3', 'apellido cliente 3', '2005-03-16', '2016-11-24 17:31:35'),
(8, '1010101010', 'nombre cliente 4', 'apellido cliente 4', '2016-11-16', '2016-11-24 17:38:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasaje`
--

CREATE TABLE `pasaje` (
  `id` int(11) NOT NULL,
  `id_viaje` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `num_asiento` int(11) DEFAULT NULL,
  `ubicacion` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `precio` float DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pasaje`
--

INSERT INTO `pasaje` (`id`, `id_viaje`, `id_cliente`, `num_asiento`, `ubicacion`, `precio`, `fecha`) VALUES
(2, 6, 1, 25, 'pasillo', 80, '2016-11-24 18:32:19'),
(3, 7, 8, 30, 'pasillo', 50, '2016-11-24 18:48:34'),
(4, 7, 2, 20, 'ventana', 150, '2016-11-24 18:49:17'),
(5, 6, 3, 30, 'asdf', 90, '2016-11-24 18:51:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contra` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo` varchar(5) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `nombre`, `apellido`, `correo`, `contra`, `tipo`, `fecha`) VALUES
(1, 'asdf', 'asdf', 'asdfa@adf', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 'admin', '2016-11-20 23:22:04'),
(2, 'Prueba', 'Prueba', 'prueba@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 'admin', '2016-11-24 04:35:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `id` int(11) NOT NULL,
  `id_chofer` int(11) DEFAULT NULL,
  `id_bus` int(11) DEFAULT NULL,
  `horario` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `origen` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `destino` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `viaje`
--

INSERT INTO `viaje` (`id`, `id_chofer`, `id_bus`, `horario`, `origen`, `destino`, `fecha`) VALUES
(6, 5, 1, 'prueba', 'prueba', 'prueba', '2016-11-24 16:41:30'),
(7, 6, 3, 'horario', 'origen', 'destino', '2016-11-24 16:42:24');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `chofer`
--
ALTER TABLE `chofer`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pasaje`
--
ALTER TABLE `pasaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_viaje` (`id_viaje`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_chofer` (`id_chofer`),
  ADD KEY `id_bus` (`id_bus`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bus`
--
ALTER TABLE `bus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `chofer`
--
ALTER TABLE `chofer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `pasaje`
--
ALTER TABLE `pasaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `viaje`
--
ALTER TABLE `viaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pasaje`
--
ALTER TABLE `pasaje`
  ADD CONSTRAINT `pasaje_ibfk_1` FOREIGN KEY (`id_viaje`) REFERENCES `viaje` (`id`),
  ADD CONSTRAINT `pasaje_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `viaje_ibfk_1` FOREIGN KEY (`id_chofer`) REFERENCES `chofer` (`id`),
  ADD CONSTRAINT `viaje_ibfk_2` FOREIGN KEY (`id_bus`) REFERENCES `bus` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
