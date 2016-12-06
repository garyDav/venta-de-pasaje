-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 06-12-2016 a las 07:13:50
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
DECLARE nomCliente varchar(50);
DECLARE apCliente varchar(50);
DECLARE hr varchar(30);
IF NOT EXISTS(SELECT id FROM pasaje WHERE id_viaje = v_id_viaje AND num_asiento = v_num_asiento) THEN
SET nomCliente = (SELECT nombre FROM cliente WHERE id = v_id_cliente);
SET apCliente = (SELECT apellido FROM cliente WHERE id = v_id_cliente);
SET hr = (SELECT horario FROM viaje WHERE id = v_id_viaje);
INSERT INTO pasaje VALUES(null, v_id_viaje, v_id_cliente, v_num_asiento, v_ubicacion, v_precio,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,nomCliente as nombre,apCliente as apellido,hr as horario,'success' AS error;
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
DECLARE apellidoChofer varchar(50);
DECLARE numBus varchar(10);
SET nameChofer = (SELECT nombre FROM chofer WHERE id = v_id_chofer);
SET apellidoChofer = (SELECT apellido FROM chofer WHERE id = v_id_chofer);
SET numBus = (SELECT num FROM bus WHERE id = v_id_bus);
INSERT INTO viaje VALUES(null,v_id_chofer,v_id_bus,v_horario,v_origen,v_destino,CURRENT_TIMESTAMP);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,nameChofer,apellidoChofer,numBus,'success' AS error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pReporte` (IN `v_fecha` DATE)  BEGIN
IF EXISTS(SELECT id FROM pasaje WHERE SUBSTRING(fecha,1,10) LIKE v_fecha) THEN
SELECT p.id,p.num_asiento,p.ubicacion,p.precio,p.fecha,v.horario,
v.origen,v.destino,ch.ci AS ci_chofer,ch.nombre AS nombre_chofer,ch.img AS img_chofer,b.num AS num_bus,
cli.ci AS ci_cliente,cli.nombre AS nombre_cliente,cli.apellido AS apellido_cliente 
FROM bus as b,chofer as ch,viaje as v,cliente as cli,pasaje as p 
WHERE v.id_chofer=ch.id AND v.id_bus=b.id AND p.id_viaje=v.id AND p.id_cliente=cli.id AND 
p.fecha > CONCAT(v_fecha,' ','00:00:01') AND p.fecha < CONCAT(v_fecha,' ','23:59:59');
ELSE
SELECT 'No se encontraron ventas en esa fecha' error;
END IF;
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
(5, '2345ZPL', 'MERCEDES-BENZ', 'Num-001', 'Rojo', 46, 'semi', '1481001195.jpeg', '2016-12-06 01:13:15'),
(6, '7854JDW', 'SETRA', 'Num-002', 'Azul', 46, 'cama', '1481001247.jpeg', '2016-12-06 01:14:07'),
(7, '4589ABC', 'MERCEDES-BENZ', 'Num-003', 'Azul', 46, 'normal', '1481001302.jpeg', '2016-12-06 01:15:02'),
(8, '1254XYZ', 'MERCEDES-BENZ', 'Num-004', 'Negro', 46, 'cama', '1481001341.jpeg', '2016-12-06 01:15:41');

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
(7, '10215548', 'Marco Antonio', 'Pardo Vacaflor', 'cat-C', 'Con 10 de experiencia, sin antecedentes policiales.', 75784522, '1982-05-13', '1481000000.jpeg', '2016-12-06 00:53:20'),
(8, '20154478', 'Miguel Angel', 'Arteaga Zenteno', 'cat-C', 'Con 15 años de experiencia, sin antecedentes policiales, con un choque.', 73006588, '1981-05-07', '1481000476.jpeg', '2016-12-06 01:01:16'),
(9, '40916623', 'Nils', 'Pillco Valverde', 'cat-B', 'Con 5 años de experiencia, y un antecedente por conducir ebrio', 75002144, '1990-09-11', '1481000933.jpeg', '2016-12-06 01:08:53');

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
(9, '20548841', 'Mayer', 'Ortiz Espada', '1993-04-07', '2016-12-06 01:29:40'),
(10, '10514485', 'Marcela', 'Ferrufino Ferreira', '1994-02-09', '2016-12-06 01:31:33'),
(11, '306245123', 'Richard', 'Vaca Ruiz', '1987-07-16', '2016-12-06 01:32:29'),
(12, '80452135', 'Yanina', 'Cardozo Salas', '1993-04-16', '2016-12-06 01:34:00'),
(13, '10215563', 'Paola Andrea', 'Yucra Ortiz', '1995-07-12', '2016-12-06 01:44:37');

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
(14, 12, 9, 10, 'ventana', 100, '2016-12-06 01:34:56'),
(15, 12, 10, 1, 'pasillo', 100, '2016-12-06 01:38:03'),
(16, 9, 11, 23, 'ventana', 150, '2016-12-06 01:38:27'),
(17, 9, 12, 17, 'pasillo', 150, '2016-12-06 01:38:56'),
(18, 15, 13, 26, 'ventana', 120, '2016-12-06 01:45:02');

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
(3, 'Juan', 'Perez', 'juan@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 'admin', '2016-11-28 15:58:49'),
(4, 'Pedro', 'Fernandez', 'pedro@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 'user', '2016-12-01 17:10:05');

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
(9, 7, 6, 'Lunes - Miercoles y Viernes 16', 'Sucre', 'Cochabamba', '2016-12-06 01:16:37'),
(10, 7, 6, 'Martes - Juevez y Sábado a las', 'Sucre', 'Santa Cruz', '2016-12-06 01:17:52'),
(11, 8, 5, 'Lunes - Viernes 11:00am', 'Sucre', 'Potosí', '2016-12-06 01:18:27'),
(12, 8, 5, 'Sabado a las 07:00', 'Sucre', 'Monteagudo', '2016-12-06 01:19:31'),
(13, 9, 7, 'Lunes - Martes y Miercoles a l', 'Sucre', 'Oruro', '2016-12-06 01:20:12'),
(14, 9, 8, 'Juevez - Viernes y Sabado', 'Sucre', 'Villazon', '2016-12-06 01:20:55'),
(15, 8, 7, 'Sabado y Domingo a las 08:00', 'Sucre', 'Serrano', '2016-12-06 01:28:30');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `chofer`
--
ALTER TABLE `chofer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `pasaje`
--
ALTER TABLE `pasaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `viaje`
--
ALTER TABLE `viaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
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
