/*Tablas de pasajes*/
CREATE DATABASE pasajes;
use pasajes;

CREATE TABLE user (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(50),
	apellido varchar(50),
	correo varchar(100),
	contra varchar(100),
	tipo varchar(5),
	fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE chofer (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	ci varchar(15),
	nombre varchar(50),
	apellido varchar(50),
	categoria varchar(5),
	descripcion text,
	celular int,
	fecha_nac date,
	img varchar(150),
	fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


CREATE TABLE bus (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	placa varchar(15),
    marca varchar(30),
    num varchar(10),
    color varchar(15),
    capacidad int,
    tipo varchar(15),
    img varchar(150),
    fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE viaje (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_chofer int,
	id_bus int,

	horario varchar(30),
	origen varchar(30),
	destino varchar(30),
	fecha datetime,
	FOREIGN KEY (id_chofer) REFERENCES chofer(id),
	FOREIGN KEY (id_bus) REFERENCES bus(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE cliente (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	ci varchar(15),
    nombre varchar(50),
    apellido varchar(50),
    fecha_nac date,
    fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE pasaje (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_viaje int,
	id_cliente int,

    num_asiento int,
    ubicacion varchar(10),
    precio float,
    fecha datetime,
    FOREIGN KEY (id_viaje) REFERENCES viaje(id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;







/*Procediminetos Almacenados*/
delimiter //
DROP PROCEDURE IF EXISTS pSession;
CREATE PROCEDURE pSession(
	IN v_correo varchar(100),
	IN v_pwd varchar(100)
)
BEGIN
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
END //


DROP PROCEDURE IF EXISTS pInsertUser;
CREATE PROCEDURE pInsertUser (
	IN v_nombre varchar(50),
	IN v_apellido varchar(50),
	IN v_correo varchar(100),
	IN v_contra varchar(100),
	IN v_tipo varchar(5)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM user WHERE correo LIKE v_correo) THEN
		INSERT INTO user VALUES(null,v_nombre,v_apellido,v_correo,v_contra,v_tipo,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,v_tipo AS tipo, 'success' AS error;
	ELSE
		SELECT 'Error: Correo ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pInsertChofer;
CREATE PROCEDURE pInsertChofer (
	IN v_ci varchar(15),
	IN v_nombre varchar(50),
	IN v_apellido varchar(50),
	IN v_categoria varchar(5),
	IN v_descripcion text,
	IN v_celular int,
	IN v_fecha_nac date,
	IN v_img varchar(150)
)
BEGIN
	INSERT INTO chofer VALUES(null,v_ci,v_nombre,v_apellido,v_categoria,v_descripcion,v_celular,v_fecha_nac,v_img,CURRENT_TIMESTAMP);
	SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertBus;
CREATE PROCEDURE pInsertBus (
	IN v_placa varchar(15),
	IN v_marca varchar(30),
	IN v_num varchar(10),
	IN v_color varchar(15),
	IN v_capacidad int,
	IN v_tipo varchar(15),
	IN v_img varchar(150)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM bus WHERE placa LIKE v_placa) THEN
		INSERT INTO bus VALUES(null, v_placa, v_marca, v_num, v_color, v_capacidad, v_tipo, v_img,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
	ELSE
		SELECT 'Error: placa ya registrada' error;
	END IF;
END //

DROP PROCEDURE IF EXISTS pInsertViaje;
CREATE PROCEDURE pInsertViaje (
	IN v_id_chofer int,
	IN v_id_bus int,
	IN v_horario varchar(30),
	IN v_origen varchar(30),
	IN v_destino varchar(30)
)
BEGIN
	DECLARE nameChofer varchar(50);
	DECLARE numBus varchar(10);
	SET nameChofer = (SELECT nombre FROM chofer WHERE id = v_id_chofer);
	SET numBus = (SELECT num FROM bus WHERE id = v_id_bus);
	INSERT INTO viaje VALUES(null,v_id_chofer,v_id_bus,v_horario,v_origen,v_destino,CURRENT_TIMESTAMP);
	SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,nameChofer,numBus,'success' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertPasaje;
CREATE PROCEDURE pInsertPasaje (
	IN v_id_viaje int,
	IN v_id_cliente int,
	IN v_num_asiento int,
	IN v_ubicacion varchar(10),
	IN v_precio float
)
BEGIN
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
END //

DROP PROCEDURE IF EXISTS pInsertCliente;
CREATE PROCEDURE pInsertCliente (
	IN v_ci varchar(15),
    IN v_nombre varchar(50),
    IN v_apellido varchar(50),
    IN v_fecha_nac date
)
BEGIN
	IF NOT EXISTS(SELECT id FROM cliente WHERE ci LIKE v_ci) THEN
		INSERT INTO cliente VALUES(null,v_ci,v_nombre,v_apellido, v_fecha_nac,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha, 'success' AS error;
	ELSE
		SELECT 'Error: CI ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pReporte;
CREATE PROCEDURE pReporte (
    IN v_fecha date
)
BEGIN
	IF EXISTS(SELECT id FROM pasaje WHERE SUBSTRING(fecha,1,10) LIKE v_fecha) THEN
		SELECT p.id,p.num_asiento,p.ubicacion,p.precio,p.fecha,v.horario,
			v.origen,v.destino,ch.ci AS ci_chofer,ch.nombre AS nombre_chofer,b.num AS num_bus,
			cli.ci AS ci_cliente,cli.nombre AS nombre_cliente,cli.apellido AS apellido_cliente 
		FROM bus as b,chofer as ch,viaje as v,cliente as cli,pasaje as p 
		WHERE v.id_chofer=ch.id AND v.id_bus=b.id AND p.id_viaje=v.id AND p.id_cliente=cli.id AND 
			p.fecha > CONCAT(v_fecha,' ','00:00:01') AND p.fecha < CONCAT(v_fecha,' ','23:59:59');
	ELSE
		SELECT 'No se encontraron ventas en esa fecha' error;
	END IF;
END //

--SELECT * FROM bus as b,chofer as ch,viaje as v,cliente as cli,pasaje as p WHERE v.id_chofer=ch.id AND v.id_bus=b.id AND p.id_viaje=v.id AND p.id_cliente=cli.id;

--SELECT p.id,p.num_asiento,p.ubicacion,p.precio,p.fecha,v.horario,v.origen,v.destino,ch.ci AS ci_chofer,ch.nombre AS nombre_chofer,b.num AS num_bus,cli.ci AS ci_cliente,cli.nombre AS nombre_cliente,cli.apellido AS apellido_cliente FROM bus as b,chofer as ch,viaje as v,cliente as cli,pasaje as p WHERE v.id_chofer=ch.id AND v.id_bus=b.id AND p.id_viaje=v.id AND p.id_cliente=cli.id AND p.fecha = '2016-12-06';
