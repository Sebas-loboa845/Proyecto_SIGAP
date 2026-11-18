-- ====================================================================================
--  DDL - DATA DEFINITION LANGUAGE - LENGUAJE DE DEFINICION DE DATOS
--  Base de datos: db_sigap (MySQL / MariaDB - XAMPP)
-- ====================================================================================
--
--  01. MOSTRAR LAS BASES DE DATOS ............ SHOW DATABASES ;
--  02. CREAR UNA BASE DE DATOS ............... CREATE DATABASE ____ ;
--  03. USAR UNA BASE DE DATOS ................ USE ____ ;
--  04. ELIMINAR UNA BASE DE DATOS ............ DROP DATABASE ____ ;
--  05. MOSTRAR TABLAS ........................ SHOW TABLES ;
--  06. MOSTRAR COLUMNAS ...................... SHOW COLUMNS FROM ____ ; DESCRIBE ____ ;
--  07. AGREGAR COLUMNA ........................ ALTER TABLE ____ ADD ____ ____ ;
--  08. RENOMBRAR COLUMNA ...................... ALTER TABLE ____ CHANGE ____ ____ ____ ;
--  09. ELIMINAR COLUMNA ....................... ALTER TABLE ____ DROP ____ ;
--  10. AGREGAR VALOR X DEFECTO A COLUMNA ...... ALTER TABLE ____ ALTER ____ SET DEFAULT ____ ;
--  11. ELIMINAR VALOR X DEFECTO DE COLUMNA .... ALTER TABLE ____ ALTER ____ DROP DEFAULT ;
--  12. MOSTRAR CREACION DE TABLA .............. SHOW CREATE TABLE ____ ;
--  13. ELIMINAR RESTRICCION ................... ALTER TABLE ____ DROP FOREIGN KEY ____ ;
--                                               ALTER TABLE ____ DROP CONSTRAINT ____ ;
--  14. ELIMINAR INDICE ....................... ALTER TABLE ____ DROP INDEX ____ ;
--  15. ELIMINAR LLAVE PRIMARIA ................ ALTER TABLE ____ DROP PRIMARY KEY ;
--  16. LIMPIAR REGISTROS ...................... TRUNCATE ____ ;
--  17. ELIMINAR TABLA ......................... DROP TABLE ____ ;
--  18. CREAR TABLA ............................ CREATE TABLE ____ ( ____ , ____ ) ;
--  19. RENOMBRAR TABLA ........................ RENAME TABLE ____ TO ____ ;
--  20. CREAR LLAVE PRIMARIA ................... ALTER TABLE ____ ADD PRIMARY KEY ( ____ ) ;
--  21. CREAR INDICE UN CAMPO .................. CREATE INDEX ____ ON ____ ( ____ ) ;
--  22. CREAR INDICE MULTICAMPO ................ CREATE INDEX ____ ON ____ ( ____ , ____ ) ;
--  23. CREAR INDICE UNICO ..................... CREATE UNIQUE INDEX ____ ON ____ ( ____ ) ;
--  24. CREAR RESTRICCION ...................... ALTER TABLE ____ ADD CONSTRAINT ____
--                                               FOREIGN KEY ( ____ ) REFERENCES ____ ( ____ )
--                                               ON DELETE ____ ON UPDATE ____ ;
--
-- ====================================================================================
--  ADVERTENCIA: este archivo es una GUIA de comandos, no un script para ejecutar
--  de corrido. Los comandos 04, 15, 16 y 17 borran informacion. Ejecutalos uno a uno.
--  Los ejemplos estan pensados para correr en orden SOBRE una base db_sigap ya
--  creada con 01_db_SIGAP_v2.sql (cada comando "deshace" lo que otro anterior hizo).
-- ====================================================================================
--
--  BIBLIOGRAFIA
--  Tutoriales de Programacion ya. (s.f.). MySQL ya.
--      https://www.tutorialesprogramacionya.com/mysqlya/
--  Pildoras Informaticas. (16 de Julio de 2015). Curso SQL. [Video]
--      https://www.youtube.com/playlist?list=PLU8oAlHdN5Bmx-LChV4K3MbHrpZKefNwn
--
--  EN CONSOLA: XAMPP / SHELL / cd mysql/bin / mysql -h localhost -u root -p / ENTER
-- ====================================================================================


-- ------------------------------------------------------------------------------------
-- 01. Mostrar las bases de datos.
--     SHOW DATABASES :
-- ------------------------------------------------------------------------------------
SHOW DATABASES;


-- ------------------------------------------------------------------------------------
-- 02. Crear una base de datos.
--     CREATE DATABASE __ :
-- ------------------------------------------------------------------------------------
CREATE DATABASE db_sigap DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


-- ------------------------------------------------------------------------------------
-- 03. Usar una base de datos.
--     USE __ :
-- ------------------------------------------------------------------------------------
USE db_sigap;


-- ------------------------------------------------------------------------------------
-- 04. Eliminar una base de datos.
--     DROP DATABASE __ :
-- ------------------------------------------------------------------------------------
DROP DATABASE db_sigap;


-- (Despues del comando 04 hay que volver a ejecutar 02 y 03 y cargar 01_db_SIGAP_v2.sql)


-- ------------------------------------------------------------------------------------
-- 05. Mostrar tablas.
--     SHOW TABLES :
-- ------------------------------------------------------------------------------------
SHOW TABLES;


-- ------------------------------------------------------------------------------------
-- 06. Mostrar columnas.
--     SHOW COLUMNS FROM __ . DESCRIBE __ :
-- ------------------------------------------------------------------------------------
SHOW COLUMNS FROM usuario;
DESCRIBE usuario;
DESCRIBE producto;


-- ------------------------------------------------------------------------------------
-- 07. Agregar columna.
--     ALTER TABLE __ ADD __ __ :
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario ADD documento VARCHAR(20) NULL DEFAULT NULL;


-- ------------------------------------------------------------------------------------
-- 08. Renombrar columna.
--     ALTER TABLE __ CHANGE __ __ __ :
--     (CHANGE exige: nombre_actual nombre_nuevo tipo_de_dato)
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario CHANGE telefono celular VARCHAR(20) NOT NULL;
ALTER TABLE usuario CHANGE celular telefono VARCHAR(20) NOT NULL;   -- deshacer


-- ------------------------------------------------------------------------------------
-- 09. Eliminar columna.
--     ALTER TABLE __ DROP __ :
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario DROP documento;


-- ------------------------------------------------------------------------------------
-- 10. Agregar valor por defecto a una columna.
--     ALTER TABLE __ ALTER __ SET DEFAULT __ :
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario ALTER id_rol SET DEFAULT 2;
ALTER TABLE producto ALTER stock_minimo SET DEFAULT 5;


-- ------------------------------------------------------------------------------------
-- 11. Eliminar valor por defecto de una columna.
--     ALTER TABLE __ ALTER __ DROP DEFAULT :
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario ALTER id_rol DROP DEFAULT;
ALTER TABLE producto ALTER stock_minimo SET DEFAULT 0;   -- el valor original era 0


-- ------------------------------------------------------------------------------------
-- 12. Mostrar creacion de tabla.
--     SHOW CREATE TABLE __ :
-- ------------------------------------------------------------------------------------
SHOW CREATE TABLE usuario;
SHOW CREATE TABLE producto;
SHOW CREATE TABLE venta;
SHOW CREATE TABLE detalle_venta;


-- ------------------------------------------------------------------------------------
-- 13. Eliminar restriccion.
--     Llaves foraneas : ALTER TABLE __ DROP FOREIGN KEY __ :
--     Restricciones CHECK (creadas en el comando 24) :
--                       ALTER TABLE __ DROP CONSTRAINT __ :
--     Nota: el indice que MySQL crea para una FK NO se borra con ella; se borra
--     despues con el comando 14.
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario DROP FOREIGN KEY fk_usuario_rol;
ALTER TABLE venta DROP FOREIGN KEY fk_venta_grupo;
ALTER TABLE bitacora DROP FOREIGN KEY fk_bitacora_usuario;

-- Solo funcionan si ya se ejecuto el comando 24 (parte de CHECK):
ALTER TABLE producto DROP CONSTRAINT chk_producto_precio;
ALTER TABLE detalle_venta DROP CONSTRAINT chk_detalle_venta_cantidad;
ALTER TABLE puntuacion DROP CONSTRAINT chk_puntuacion_estrellas;


-- ------------------------------------------------------------------------------------
-- 14. Eliminar indice.
--     ALTER TABLE __ DROP INDEX __ :
--     Nota: MySQL no deja borrar un indice que una FK este usando; por eso se
--     eligieron indices que no sirven a ninguna llave foranea.
-- ------------------------------------------------------------------------------------
ALTER TABLE usuario DROP INDEX uq_usuario_correo;
ALTER TABLE producto DROP INDEX uq_producto_nombre;
ALTER TABLE venta DROP INDEX idx_venta_fecha;


-- ------------------------------------------------------------------------------------
-- 15. Eliminar llave primaria.
--     ALTER TABLE __ DROP PRIMARY KEY :
--     Nota: la PK es AUTO_INCREMENT, asi que primero se quita el AUTO_INCREMENT
--     con MODIFY; si no, MySQL da error. Se usa una tabla "hoja" (que ninguna otra
--     tabla referencia) para no chocar con llaves foraneas.
-- ------------------------------------------------------------------------------------
ALTER TABLE puntuacion MODIFY id_puntuacion INT UNSIGNED NOT NULL;
ALTER TABLE puntuacion DROP PRIMARY KEY;


-- ------------------------------------------------------------------------------------
-- 16. Limpiar registros.
--     TRUNCATE __ :
--     Nota: TRUNCATE falla en tablas referenciadas por una FK; bitacora no lo esta.
-- ------------------------------------------------------------------------------------
TRUNCATE bitacora;


-- ------------------------------------------------------------------------------------
-- 17. Eliminar tabla.
--     DROP TABLE __ :
-- ------------------------------------------------------------------------------------
DROP TABLE bitacora;


-- ------------------------------------------------------------------------------------
-- 18. Crear tabla.
--     CREATE TABLE __ ( __ , __ ) :
--     Se crea solo con columnas; la PK, los indices y la FK se agregan despues
--     con los comandos 20 a 24.
-- ------------------------------------------------------------------------------------
CREATE TABLE bitacora (
  id_bitacora INT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NULL DEFAULT NULL,
  accion VARCHAR(40) NOT NULL,
  entidad VARCHAR(40) NOT NULL,
  id_registro INT UNSIGNED NULL DEFAULT NULL,
  detalle VARCHAR(255) NULL DEFAULT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;


-- ------------------------------------------------------------------------------------
-- 19. Renombrar tabla.
--     RENAME TABLE __ TO __ :
-- ------------------------------------------------------------------------------------
RENAME TABLE bitacora TO bitacora_temp;
RENAME TABLE bitacora_temp TO bitacora;   -- deshacer


-- ------------------------------------------------------------------------------------
-- 20. Crear llave primaria.
--     ALTER TABLE __ ADD PRIMARY KEY ( __ ) :
--     Despues se vuelve a poner el AUTO_INCREMENT.
-- ------------------------------------------------------------------------------------
ALTER TABLE bitacora ADD PRIMARY KEY (id_bitacora);
ALTER TABLE bitacora MODIFY id_bitacora INT UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE puntuacion ADD PRIMARY KEY (id_puntuacion);
ALTER TABLE puntuacion MODIFY id_puntuacion INT UNSIGNED NOT NULL AUTO_INCREMENT;


-- ------------------------------------------------------------------------------------
-- 21. Crear indice de un campo.
--     CREATE INDEX __ ON __ ( __ ) :
-- ------------------------------------------------------------------------------------
CREATE INDEX idx_bitacora_usuario ON bitacora (id_usuario);
CREATE INDEX idx_venta_fecha ON venta (fecha_venta);


-- ------------------------------------------------------------------------------------
-- 22. Crear indice multicampo.
--     CREATE INDEX __ ON __ ( __ , __ ) :
-- ------------------------------------------------------------------------------------
CREATE INDEX idx_bitacora_entidad ON bitacora (entidad, id_registro);


-- ------------------------------------------------------------------------------------
-- 23. Crear indice unico.
--     CREATE UNIQUE INDEX __ ON __ ( __ ) :
-- ------------------------------------------------------------------------------------
CREATE UNIQUE INDEX uq_usuario_correo ON usuario (correo);
CREATE UNIQUE INDEX uq_producto_nombre ON producto (nombre);


-- ------------------------------------------------------------------------------------
-- 24. Crear restriccion.
--     ALTER TABLE __ ADD CONSTRAINT __ FOREIGN KEY ( __ ) REFERENCES __ ( __ )
--     ON DELETE __ ON UPDATE __ :
--     Se usan las mismas reglas ON DELETE / ON UPDATE de 01_db_SIGAP_v2.sql.
-- ------------------------------------------------------------------------------------
ALTER TABLE bitacora ADD
CONSTRAINT fk_bitacora_usuario
  FOREIGN KEY (id_usuario)
  REFERENCES usuario (id_usuario)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE usuario ADD
CONSTRAINT fk_usuario_rol
  FOREIGN KEY (id_rol)
  REFERENCES rol (id_rol)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

ALTER TABLE venta ADD
CONSTRAINT fk_venta_grupo
  FOREIGN KEY (id_grupo_venta)
  REFERENCES grupo_venta (id_grupo_venta)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

-- Restricciones CHECK (la base original no las tiene; son un ejemplo de uso).
-- Requieren MySQL 8.0.16+ o MariaDB 10.2.1+.
ALTER TABLE producto ADD
CONSTRAINT chk_producto_precio
  CHECK (precio >= 0);

ALTER TABLE detalle_venta ADD
CONSTRAINT chk_detalle_venta_cantidad
  CHECK (cantidad > 0);

ALTER TABLE puntuacion ADD
CONSTRAINT chk_puntuacion_estrellas
  CHECK (valor_estrellas BETWEEN 1 AND 5);
