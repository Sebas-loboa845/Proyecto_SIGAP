/* ************************************************************************************* */
/* ---------------------------------------- DML ---------------------------------------- */
/* ---------------------------- DATA MANIPULATION LANGUAGE ----------------------------- */
/* ------------------------- LENGUAJE DE MANIPULACION DE DATOS ------------------------- */
/* ------------------------------------- UNA TABLA ------------------------------------- */
/* ------------------------------ Base de datos: db_sigap ------------------------------ */
/* ************************************************************************************* */
/* ------------------------------------------------------------------------------------- */
/* 1. CONSULTAS DE ACCION [Inicio] : . INSERT INTO, UPDATE, DELETE                       */
/* 1.1. Crear o Registrar : .......... INSERT INTO __ ( __ ) VALUES ( __ , __ )          */
/* 1.1.1. Datos Correctos : .......... Ver Archivo '1_dml_insercion.sql'                 */
/* 1.1.2. Datos Incorrectos : ........ INSERT INTO __ ( __ ) VALUES ( __ , __ )          */
/* 1.2. Actualizar : ................. UPDATE __ SET __ = __ WHERE __ = __               */
/* 1.3. Eliminar : ................... DELETE FROM __ WHERE __ = __                      */
/* 2. CONSULTAS DE SELECCION : ....... SELECT                                            */
/* 2.1. Generales : .................. SELECT * FROM __                                  */
/* 2.2. Especificas : ................ SELECT __ , __ FROM __                            */
/* 2.3. Con Criterios: ............... SELECT __ FROM __ WHERE __ = __                   */
/* 2.4. Con Operadores Logicos : ..... OR, AND, NOT                                      */
/* 2.4.1. O [OR] : ................... SELECT __ FROM __ WHERE __ = __ OR __ = __        */
/* 2.4.2. Y [AND] : .................. SELECT __ FROM __ WHERE __ = __ AND __ = __       */
/* 2.4.3. No [NOT] : ................. SELECT __ FROM __ WHERE __ NOT IN ( __ )          */
/* 2.5. Con Operadores Comparacion : . <>, <, <=, >, >=                                  */
/* 2.5.1. Diferente [<>] : ........... SELECT __ FROM __ WHERE __ <> __                  */
/* 2.5.2. Menor que [<] : ............ SELECT __ FROM __ WHERE __ <  __                  */
/* 2.5.3. Mayor que [>] : ............ SELECT __ FROM __ WHERE __ >  __                  */
/* 2.5.4. Menor o igual [<=] : ....... SELECT __ FROM __ WHERE __ <= __                  */
/* 2.5.5. Mayor o igual [>=] : ....... SELECT __ FROM __ WHERE __ >= __                  */
/* 2.6. Con otros Operadores : ....... LIKE '_%' , BETWEEN __ AND __ , IN ( __ , __ )    */
/* 2.6.1. Comodin [LIKE '_%'] : ...... SELECT __ FROM __ WHERE __ LIKE '_%'              */
/* 2.6.2. Entre [BETWEEN] : .......... SELECT __ FROM __ WHERE __ BETWEEN __ AND __      */
/* 2.6.3. Lista [IN ( __ )] : ........ SELECT __ FROM __ WHERE __ IN( __ , __ )          */
/* 2.7. Ordenadas : .................. ORDER BY __                                       */
/* 2.7.1. Ascendente [ASC] : ......... SELECT __ FROM __ WHERE __ = __ ORDER BY __ ASC   */
/* 2.7.2. Descendente [DESC] : ....... SELECT __ FROM __ WHERE __ = __ ORDER BY __ DESC  */
/* 2.7.3. Combinadas : ............... SELECT __ FROM __ WHERE __ = __ ORDER BY __ , __  */
/* 2.8. Calculadas con Funciones: .... GROUP BY __                                       */
/* 2.8.1. Suma [SUM()] : ............. SELECT __ , SUM( __ ) FROM __ GROUP BY __         */
/* 2.8.2. Promedio [AVG()] : ......... SELECT __ , AVG( __ ) FROM __ GROUP BY __         */
/* 2.8.3. Maximo [MAX()] : ........... SELECT __ , MAX( __ ) FROM __ GROUP BY __         */
/* 2.8.4. Minimo [MIN()] : ........... SELECT __ , MIN( __ ) FROM __ GROUP BY __         */
/* 2.8.5. Conteo [COUNT()] : ......... SELECT __ , COUNT( __ ) FROM __ GROUP BY __       */
/* 2.9. Calculadas con Alias : ....... SELECT __ , FUN( __ ) AS __ FROM __               */
/* 2.10. Calculadas Condicionantes : . GROUP BY __ HAVING __ = __ OR __ = __             */
/* 2.11. Calculadas con Operadores : . SELECT __ , __ , ROUND( __*0.19,2) AS __ FROM __  */
/* 2.12. Calculadas con Fechas : ..... NOW(), DATE_FORMAT(), TIMESTAMPDIFF()             */
/* 2.12.1. Fecha Actual : ............ NOW()                                             */
/* 2.12.2. Formato Fecha : ........... DATE_FORMAT(NOW(), '%Y-%m-%d')                    */
/* 2.12.3. Diferencia Fechas : ....... TIMESTAMPDIFF(DAY, __ , NOW())                    */
/* 3. CONSULTAS DE ACCION [Final] : .. INSERT INTO, UPDATE, DELETE                       */
/* ------------------------------------------------------------------------------------- */
/* BIBLIOGRAFIA                                                                          */
/* ------------------------------------------------------------------------------------- */
/* ************************************************************************************* */
/* EN CONSOLA: XAMPP / SHELL / cd mysql/bin / mysql -h localhost -u root -p / ENTER      */
/* ************************************************************************************* */
/*                                                                                       */
/* NOTAS PARA USAR ESTE ARCHIVO                                                          */
/* - Primero: USE db_sigap; y cargar los datos correctos (1_dml_insercion.sql).          */
/*   Sin datos, los SELECT devuelven vacio y los INSERT "incorrectos" no fallan.         */
/* - Los valores numericos de llaves (id_rol = 2, id_estado_venta = 1, etc.) y los       */
/*   correos de ejemplo son SUPUESTOS: ajustalos a los datos que tengas cargados.        */
/* - A diferencia de la guia original, los INSERT nombran las columnas, porque las       */
/*   tablas de SIGAP tienen AUTO_INCREMENT y valores por defecto.                        */
/* - Las contrasenas se guardan con SHA2(...,256) (64 caracteres, caben en VARCHAR(255)).*/
/* ************************************************************************************* */

USE db_sigap;


/* ************************************************************************************* */
/* -------------------------- 1. CONSULTAS DE ACCION [Inicio] -------------------------- */
/* ---------------------------- INSERT INTO, UPDATE, DELETE ---------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- 1.1. Crear o Registrar. ------------------------------------------------------------- --
--      INSERT INTO __ ( __ ) VALUES ( __ , __ ) : ------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 1.1.1. Datos Correctos -------------------------------------------------------------- --
--        Ver Archivo '1_dml_insercion.sql' : ------------------------------------------ --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 1.1.2. Datos Incorrectos ------------------------------------------------------------ --
--        INSERT INTO __ ( __ ) VALUES ( __ , __ ) : ----------------------------------- --
--        Cada uno debe FALLAR; el comentario dice por que.                              --
-- ------------------------------------------------------------------------------------- --

-- Llave primaria repetida (Error 1062): ya existe el usuario con id 1.
INSERT INTO usuario (id_usuario, id_rol, nombre, apellido, correo, contrasena, telefono)
VALUES (1, 2, 'Alejandra', 'Martinez', 'alejandra@gmail.com', SHA2('45678', 256), '3001112233');

-- Indice unico repetido (Error 1062): uq_usuario_correo, el correo ya esta registrado.
INSERT INTO usuario (id_rol, nombre, apellido, correo, contrasena, telefono)
VALUES (2, 'Wilson', 'Cifuentes', 'wilson@gmail.com', SHA2('45678', 256), '3004445566');

-- Llave foranea inexistente (Error 1452): fk_usuario_rol, el rol 99 no existe.
INSERT INTO usuario (id_rol, nombre, apellido, correo, contrasena, telefono)
VALUES (99, 'Marina', 'Roncancio', 'marinita@gmail.com', SHA2('45678', 256), '3007778899');

-- Columna NOT NULL con NULL (Error 1048): nombre es obligatorio.
INSERT INTO usuario (id_rol, nombre, apellido, correo, contrasena, telefono)
VALUES (2, NULL, 'Roncancio', 'marina2@gmail.com', SHA2('45678', 256), '3007778899');

-- Indice unico repetido (Error 1062): uq_rol_nombre.
INSERT INTO rol (nombre_rol, descripcion)
VALUES ('Administrador', 'Rol duplicado');

-- Llave foranea inexistente (Error 1452): fk_producto_categoria, la categoria 99 no existe.
INSERT INTO producto (id_categoria, id_estado_producto, nombre, precio)
VALUES (99, 1, 'Panela pastilla x 24', 3500.00);

-- Columna NOT NULL sin valor por defecto (Error 1364): falta precio.
INSERT INTO producto (id_categoria, id_estado_producto, nombre)
VALUES (1, 1, 'Panela redonda 500 g');

-- Indice unico compuesto repetido (Error 1062): uq_detalle_venta (id_venta, id_producto).
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario)
VALUES (1, 1, 2, 3500.00);

-- Valor fuera de rango (Error 1264): valor_estrellas es TINYINT UNSIGNED (maximo 255).
INSERT INTO puntuacion (id_venta, valor_estrellas, comentario)
VALUES (2, 300, 'Excelente');

-- Llave foranea inexistente (Error 1452): fk_pago_metodo, el metodo de pago 99 no existe.
INSERT INTO pago (id_venta, id_metodo_pago, id_estado_pago, monto)
VALUES (1, 99, 1, 10000.00);

-- ------------------------------------------------------------------------------------- --
-- 1.2. Actualizar. -------------------------------------------------------------------- --
--      UPDATE __ SET __ = __ WHERE __ = __ : ------------------------------------------ --
-- ------------------------------------------------------------------------------------- --
UPDATE rol SET
nombre_rol = 'Cliente'
WHERE id_rol = 3;

-- Cambiar una llave primaria: las tablas hijas se actualizan solas (ON UPDATE CASCADE).
UPDATE usuario SET
id_usuario = 10
WHERE id_usuario = 5;

UPDATE producto SET
precio = ROUND(precio * 1.05, 2)
WHERE id_categoria = 2;

-- Borrado logico: SIGAP usa eliminado_en en lugar de borrar la fila.
UPDATE usuario SET
estado = 0,
eliminado_en = NOW()
WHERE id_usuario = 10;

-- ------------------------------------------------------------------------------------- --
-- 1.3. Eliminar. ---------------------------------------------------------------------- --
--      DELETE FROM __ WHERE __ = __ : ------------------------------------------------- --
--      Con ON DELETE RESTRICT el borrado falla si la fila tiene ventas, pedidos, etc. -- --
-- ------------------------------------------------------------------------------------- --
DELETE FROM usuario
WHERE id_usuario = 10;

DELETE FROM codigo_recuperacion
WHERE usado = 1;

DELETE FROM bitacora
WHERE fecha < '2026-01-01 00:00:00';

/* ************************************************************************************* */
/* ----------------------------- 2. CONSULTAS DE SELECCION ----------------------------- */
/* --------------------------------------- SELECT -------------------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- 2.1. Generales. --------------------------------------------------------------------- --
--      SELECT * FROM __ : ------------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM rol;
SELECT * FROM usuario;
SELECT * FROM direccion_usuario;
SELECT * FROM codigo_recuperacion;
SELECT * FROM bitacora;
SELECT * FROM categoria;
SELECT * FROM estado_producto;
SELECT * FROM producto;
SELECT * FROM reemplazo_producto;
SELECT * FROM tipo_movimiento;
SELECT * FROM estado_venta;
SELECT * FROM grupo_venta;
SELECT * FROM venta;
SELECT * FROM detalle_venta;
SELECT * FROM metodo_pago;
SELECT * FROM estado_pago;
SELECT * FROM pago;
SELECT * FROM estado_disposicion;
SELECT * FROM producto_rechazado;
SELECT * FROM estado_pedido;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM fase_pedido;
SELECT * FROM estado_empaquetado;
SELECT * FROM empaquetado;
SELECT * FROM fase_empaquetado;
SELECT * FROM movimiento_inventario;
SELECT * FROM tipo_ticket;
SELECT * FROM estado_ticket;
SELECT * FROM ticket;
SELECT * FROM respuesta_ticket;
SELECT * FROM puntuacion;
SELECT * FROM tipo_notificacion;
SELECT * FROM notificacion;

-- ------------------------------------------------------------------------------------- --
-- 2.2. Especificas. ------------------------------------------------------------------- --
--      SELECT __ , __ FROM __ : ------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_usuario, correo, id_rol FROM usuario;

-- ------------------------------------------------------------------------------------- --
-- 2.3. Con Criterios. ----------------------------------------------------------------- --
--      SELECT __ , __ FROM __ WHERE __ = __ : ----------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_rol, id_usuario, correo FROM usuario
WHERE id_rol = 5;

-- ------------------------------------------------------------------------------------- --
-- 2.4. Con Operadores Logicos. -------------------------------------------------------- --
--      OR, AND, NOT : ----------------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.4.1. O [OR] . --------------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ = __ OR __ = __ : ---------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_rol, id_usuario, correo FROM usuario
WHERE id_rol = 2 OR id_rol = 5;

-- ------------------------------------------------------------------------------------- --
-- 2.4.2. Y [AND] . -------------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ = __ AND __ = __ : --------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, id_cliente, id_vendedor, id_estado_venta, direccion_entrega FROM venta
WHERE id_estado_venta = 1 AND id_vendedor = 2;

-- ------------------------------------------------------------------------------------- --
-- 2.4.3. NO [NOT] . ------------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ NOT IN ( __ ) : ------------------------------ --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, id_cliente, id_estado_venta FROM venta
WHERE id_estado_venta NOT IN (1);

-- ------------------------------------------------------------------------------------- --
-- 2.5. Con Operadores de Comparacion. ------------------------------------------------- --
--      <>, <, <=, >, >= : ------------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.5.1. Diferente [<>] . ------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ <> __ : -------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE precio <> 8500;

-- ------------------------------------------------------------------------------------- --
-- 2.5.2. Menor que [<] . -------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ < __ : --------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE precio < 4500;

-- ------------------------------------------------------------------------------------- --
-- 2.5.3. Mayor que [>] . -------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ > __ : --------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE precio > 3500;

-- ------------------------------------------------------------------------------------- --
-- 2.5.4. Menor o igual que [<=] . ----------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ <= __ : -------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE precio <= 6500;

-- ------------------------------------------------------------------------------------- --
-- 2.5.5. Mayor o igual que [>=] . ----------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ >= __ : -------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE precio >= 7500;

-- ------------------------------------------------------------------------------------- --
-- 2.6. Con otros Operadores. ---------------------------------------------------------- --
--      LIKE, BETWEEN, IN -------------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.6.1. Comodin [LIKE '_%'] . -------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ LIKE '_%' : ---------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto WHERE nombre LIKE 'p%';

SELECT * FROM producto WHERE nombre LIKE '_a%';

SELECT id_usuario, nombre, correo FROM usuario WHERE correo LIKE '%@gmail.com';

-- ------------------------------------------------------------------------------------- --
-- 2.6.2. Entre [BETWEEN] . ------------------------------------------------------------ --
--        SELECT __ , __ FROM __ WHERE __ BETWEEN __ AND __ : -------------------------- --
--        fecha_registro es DATETIME: se escribe la hora para incluir todo el ultimo dia --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM usuario
WHERE fecha_registro BETWEEN '2026-10-01 00:00:00' AND '2026-10-31 23:59:59';

SELECT * FROM usuario
WHERE fecha_registro >= '2026-10-01 00:00:00' AND fecha_registro <= '2026-10-31 23:59:59';

-- ------------------------------------------------------------------------------------- --
-- 2.6.3. Lista [IN ( __ )] . ---------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ IN( __ , __ ) : ------------------------------ --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto
WHERE id_categoria IN (1, 3);

-- ------------------------------------------------------------------------------------- --
-- 2.7. Ordenadas. --------------------------------------------------------------------- --
--      ORDER BY, ASC, DESC : ---------------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.7.1. Ascendente [ASC] . ----------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ = __ ORDER BY __ ASC : ----------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto
WHERE id_categoria = 2
ORDER BY id_categoria;

SELECT * FROM producto
WHERE id_categoria = 2 OR id_categoria = 3
ORDER BY id_categoria ASC;

SELECT * FROM producto
WHERE id_categoria = 2 OR id_categoria = 3
ORDER BY precio ASC;

-- ------------------------------------------------------------------------------------- --
-- 2.7.2. Descendente [DESC] . --------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ = __ ORDER BY __ DESC : ---------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto
WHERE id_categoria = 2
ORDER BY id_categoria DESC;

SELECT * FROM producto
WHERE id_categoria = 2 OR id_categoria = 3
ORDER BY id_categoria DESC;

SELECT * FROM producto
WHERE id_categoria = 2 OR id_categoria = 3
ORDER BY precio DESC;

-- ------------------------------------------------------------------------------------- --
-- 2.7.3. Combinadas . ----------------------------------------------------------------- --
--        SELECT __ , __ FROM __ WHERE __ = __ ORDER BY __ ASC, __ DESC : -------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM producto
WHERE id_categoria = 2 OR id_categoria = 3
ORDER BY id_categoria ASC, precio DESC;

-- ------------------------------------------------------------------------------------- --
-- 2.8. Calculadas con Funciones. ------------------------------------------------------ --
--      GROUP BY : --------------------------------------------------------------------- --
--      Todas las columnas no calculadas del SELECT van tambien en el GROUP BY. -------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.8.1. Suma [SUM()] . --------------------------------------------------------------- --
--        SELECT __ , SUM( __ ) FROM __ GROUP BY __ : ---------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT SUM(monto) FROM pago;

SELECT id_venta, SUM(monto) FROM pago
WHERE id_venta = 1
GROUP BY id_venta;

SELECT id_venta, SUM(monto) FROM pago
GROUP BY id_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.8.2. Promedio [AVG()] . ----------------------------------------------------------- --
--        SELECT __ , AVG( __ ) FROM __ GROUP BY __ : ---------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, AVG(monto) FROM pago
WHERE id_venta = 1
GROUP BY id_venta;

SELECT id_venta, AVG(monto) FROM pago
GROUP BY id_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.8.3. Maximo [MAX()] . ------------------------------------------------------------- --
--        SELECT __ , MAX( __ ) FROM __ GROUP BY __ : ---------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, MAX(monto) FROM pago
WHERE id_venta = 1
GROUP BY id_venta;

SELECT id_venta, MAX(monto) FROM pago
GROUP BY id_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.8.4. Minimo [MIN()] . ------------------------------------------------------------- --
--        SELECT __ , MIN( __ ) FROM __ GROUP BY __ : ---------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, MIN(monto) FROM pago
WHERE id_venta = 1
GROUP BY id_venta;

SELECT id_venta, MIN(monto) FROM pago
GROUP BY id_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.8.5. Conteo [COUNT()] . ----------------------------------------------------------- --
--        SELECT __ , COUNT( __ ) FROM __ GROUP BY __ : -------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT id_estado_venta, COUNT(id_venta) FROM venta
WHERE id_estado_venta = 1
GROUP BY id_estado_venta;

SELECT id_estado_venta, COUNT(id_venta) FROM venta
GROUP BY id_estado_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.9. Calculadas con Alias. ---------------------------------------------------------- --
--      SELECT __ , FUN( __ ) AS __ : -------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT SUM(monto) AS suma_pagos FROM pago;

SELECT id_venta, SUM(monto) AS suma_pagos
FROM pago
GROUP BY id_venta
ORDER BY suma_pagos ASC;

SELECT id_venta, AVG(monto) AS promedio_pagos
FROM pago
GROUP BY id_venta
ORDER BY promedio_pagos DESC;

SELECT id_venta, MAX(monto) AS maximo_pago
FROM pago
GROUP BY id_venta
ORDER BY maximo_pago DESC;

SELECT id_venta, MIN(monto) AS minimo_pago
FROM pago
GROUP BY id_venta
ORDER BY minimo_pago ASC;

SELECT id_estado_venta, COUNT(id_venta) AS cant_ventas
FROM venta
GROUP BY id_estado_venta
ORDER BY cant_ventas DESC;

-- ------------------------------------------------------------------------------------- --
-- 2.10. Calculadas Condicionantes. ---------------------------------------------------- --
--       SELECT __ , FUN( __ ) AS __ FROM __ GROUP BY __ HAVING __ = __ OR __ = __ : -- --
-- ------------------------------------------------------------------------------------- --
SELECT id_venta, id_estado_pago, SUM(monto) AS suma_pagos
FROM pago
GROUP BY id_venta, id_estado_pago
HAVING id_venta = 1 AND id_estado_pago = 2
ORDER BY suma_pagos ASC;

SELECT id_venta, id_estado_pago, AVG(monto) AS promedio_pagos
FROM pago
GROUP BY id_venta, id_estado_pago
HAVING id_venta = 1 AND id_estado_pago = 2
ORDER BY promedio_pagos ASC;

SELECT id_venta, id_estado_pago, MAX(monto) AS maximo_pago
FROM pago
GROUP BY id_venta, id_estado_pago
HAVING id_venta = 1 AND id_estado_pago = 2
ORDER BY maximo_pago ASC;

SELECT id_venta, id_estado_pago, MIN(monto) AS minimo_pago
FROM pago
GROUP BY id_venta, id_estado_pago
HAVING id_venta = 1 AND id_estado_pago = 2
ORDER BY minimo_pago ASC;

SELECT id_estado_venta, COUNT(id_venta) AS cant_ventas
FROM venta
GROUP BY id_estado_venta
HAVING id_estado_venta = 1 OR id_estado_venta = 2
ORDER BY cant_ventas DESC;

-- ------------------------------------------------------------------------------------- --
-- 2.11. Calculadas con Operadores. ---------------------------------------------------- --
--       SELECT __ , __ , __*0.19 AS __ FROM __ : ------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT nombre, precio, precio * 0.19
FROM producto;

SELECT nombre, precio, precio * 0.19 AS iva_producto
FROM producto;

SELECT nombre, precio, ROUND(precio * 0.19, 2) AS iva_producto
FROM producto;

SELECT id_venta, id_producto, cantidad, precio_unitario,
cantidad * precio_unitario AS subtotal
FROM detalle_venta;

-- ------------------------------------------------------------------------------------- --
-- 2.12. Calculadas con Fechas. -------------------------------------------------------- --
--       NOW(), DATE_FORMAT(), TIMESTAMPDIFF() : --------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.12.1. Fecha Actual. --------------------------------------------------------------- --
--         SELECT __ , __ , NOW() AS __ FROM __ : -------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT nombre, precio, NOW() FROM producto;

SELECT nombre, precio, NOW() AS fecha_actual FROM producto;

-- ------------------------------------------------------------------------------------- --
-- 2.12.2. Formato de Fecha. ----------------------------------------------------------- --
--         SELECT __ , __ , DATE_FORMAT(NOW(), '%Y-%m-%d') AS __ FROM __ : ------------- --
-- ------------------------------------------------------------------------------------- --
SELECT nombre, precio,
DATE_FORMAT(NOW(), '%Y-%m-%d') AS fecha_actual
FROM producto;

-- ------------------------------------------------------------------------------------- --
-- 2.12.3. Diferencia Fechas. ---------------------------------------------------------- --
--         SELECT __ , fecha ,                                                           --
--         DATE_FORMAT(NOW(), '%Y-%m-%d') AS __ ,                                        --
--         TIMESTAMPDIFF(DAY, __ , NOW()) AS __                                          --
--         FROM __ :                                                                     --
--         Los dias restantes se calculan despues de los meses completos (mas exacto     --
--         que restar meses * 30).                                                       --
-- ------------------------------------------------------------------------------------- --
SELECT id_usuario, estado, fecha_registro,
DATE_FORMAT(NOW(), '%Y-%m-%d') AS fecha_actual,
TIMESTAMPDIFF(YEAR, fecha_registro, NOW()) AS anios_transcurridos,
TIMESTAMPDIFF(MONTH, fecha_registro, NOW()) AS meses_transcurridos,
TIMESTAMPDIFF(DAY,
  DATE_ADD(fecha_registro, INTERVAL TIMESTAMPDIFF(MONTH, fecha_registro, NOW()) MONTH),
  NOW()) AS dias_restantes
FROM usuario;


/* ************************************************************************************* */
/* -------------------------- 3. CONSULTAS DE ACCION [Final] --------------------------- */
/* ---------------------------- INSERT INTO, UPDATE, DELETE ---------------------------- */
/* ************************************************************************************* */

-- Se usan los valores por defecto: estado, idioma, fuente y fecha_registro se llenan solos.
INSERT INTO usuario (id_rol, nombre, apellido, correo, contrasena, telefono)
VALUES (2, 'Pepito', 'Perez', 'pepito@gmail.com', SHA2('12345', 256), '3001234567');

-- LAST_INSERT_ID() devuelve el id_usuario recien creado.
INSERT INTO bitacora (id_usuario, accion, entidad, id_registro, detalle, fecha)
VALUES (1, 'INSERT', 'usuario', LAST_INSERT_ID(), 'Registro de usuario nuevo', NOW());

INSERT INTO producto (id_categoria, id_estado_producto, nombre, descripcion, precio, stock, stock_minimo)
VALUES (1, 1, 'Panela cuadrada x 12', 'Panela en bloque, caja de 12 unidades', 12000.00, 50, 10);

-- El monto se calcula en el mismo INSERT: valor base + IVA del 19 %.
INSERT INTO pago (id_venta, id_metodo_pago, id_estado_pago, monto, referencia, fecha_pago)
VALUES (1, 1, 1, ROUND(10000.00 * 1.19, 2), 'REF-0001', NOW());


/* ************************************************************************************* */
/* ------------------------------------------------------------------------------------- */
/* ----------------------------------- BIBLIOGRAFIA ------------------------------------ */
/* ------------------------------------------------------------------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- Tutoriales de Programacion ya. (s.f.). MySQL ya. Recuperado el 15 de Mayo de 2022,    --
--      de https://www.tutorialesprogramacionya.com/mysqlya/                             --
-- ------------------------------------------------------------------------------------- --
-- Pildoras Informaticas. (16 de Julio de 2015). Curso SQL.                              --
--      Recuperado el 16 de Abril de 2022, de [Archivo de Video]                         --
--      https://www.youtube.com/playlist?list=PLU8oAlHdN5Bmx-LChV4K3MbHrpZKefNwn         --
-- ------------------------------------------------------------------------------------- --
