/*Tablas de pasajes*/
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
	fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


CREATE TABLE bus (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	placa varchar(15),
    marca varchar(30),
    modelo varchar(30),
    cilindrada varchar(15),
    motor varchar(15),
    combustible varchar(15),
    capacidad varchar(15),
    num_puertas int,
    tipo varchar(15),
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

CREATE TABLE pasaje (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_viaje int,

    num_asiento int,
    fecha datetime,
    FOREIGN KEY (id_viaje) REFERENCES viaje(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE cliente (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	ci varchar(15),
    nombre varchar(50),
    apellido varchar(50),
    fecha datetime
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
	IN v_descripcion text
)
BEGIN
	INSERT INTO user VALUES(null,v_ci,v_nombre,v_apellido,v_categoria,v_descripcion,CURRENT_TIMESTAMP);
	SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertBus;
CREATE PROCEDURE pInsertBus (
	IN v_placa varchar(15),
    IN v_marca varchar(30),
    IN v_modelo varchar(30),
    IN v_cilindrada varchar(15),
    IN v_motor varchar(15),
    IN v_combustible varchar(15),
    IN v_capacidad varchar(15),
    IN v_num_puertas int,
    IN v_tipo varchar(15)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM bus WHERE placa LIKE v_placa) THEN
		INSERT INTO bus VALUES(null,v_placa,v_marca,v_modelo,v_cilindrada,v_motor,v_combustible,v_capacidad,v_num_puertas,v_tipo,CURRENT_TIMESTAMP);
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
	INSERT INTO viaje VALUES(null,v_id_chofer,v_id_bus,v_horario,v_origen,v_destino,CURRENT_TIMESTAMP);
	SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertPasaje;
CREATE PROCEDURE pInsertPasaje (
	IN v_id_viaje int,
    IN v_num_asiento int
)
BEGIN
	IF NOT EXISTS(SELECT id FROM pasaje WHERE id_viaje = v_id_viaje AND num_asiento = v_num_asiento) THEN
		INSERT INTO pasaje VALUES(null,v_id_viaje,v_num_asiento,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha,'success' AS error;
	ELSE
		SELECT 'Error: Número de asiento ya ocupado.' error;
	END IF;
END //

DROP PROCEDURE IF EXISTS pInsertCliente;
CREATE PROCEDURE pInsertCliente (
	IN v_ci varchar(15),
    IN v_nombre varchar(50),
    IN v_apellido varchar(50)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM cliente WHERE ci LIKE v_ci) THEN
		INSERT INTO cliente VALUES(null,v_ci,v_nombre,v_apellido,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,CURRENT_TIMESTAMP AS fecha, 'success' AS error;
	ELSE
		SELECT 'Error: CI ya registrado.' error;
	END IF;
END //
