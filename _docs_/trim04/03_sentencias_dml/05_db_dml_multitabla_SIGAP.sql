/* ************************************************************************************* */
/* ---------------------------------------- DML ---------------------------------------- */
/* ---------------------------- DATA MANIPULATION LANGUAGE ----------------------------- */
/* ------------------------- LENGUAJE DE MANIPULACION DE DATOS ------------------------- */
/* -------------------------------- MULTITABLA / UNION --------------------------------- */
/* ------------------------------ Base de datos: db_sigap ------------------------------ */
/* ************************************************************************************* */
/* ------------------------------------------------------------------------------------- */
/* 1. CONSULTAS DE ACCION [Inicio]                                                       */
/* 1.1. Crear una Tabla con Otra : ... CREATE TABLE _ SELECT _ FROM _ WHERE _ = _        */
/* 1.2. Insertar Datos Anexados : .... INSERT INTO _ SELECT _ FROM _                     */
/* 2. CONSULTAS DE SELECCION                                                             */
/* 2.1. Union Externa : .............. UNION, UNION ALL                                  */
/* 2.1.1. UNION : .................... SELECT _ FROM _ UNION SELECT _ FROM _             */
/* 2.1.2. UNION ALL : ................ SELECT _ FROM _ UNION ALL SELECT _ FROM _         */
/* 2.2. Union Interna : .............. INNER JOIN, LEFT JOIN, RIGHT JOIN                 */
/* 2.2.1. INNER JOIN : ............... SELECT _ FROM _ INNER JOIN _ ON _._ = _._         */
/* 2.2.1.1. Con Repeticiones : ....... INNER JOIN                                        */
/* 2.2.1.2. Sin Repeticiones : ....... DISTINCT                                          */
/* 2.2.1.3. Condicionada : ........... WHERE, OPERADORES, ORDER BY                       */
/* 2.2.2. LEFT JOIN : ................ SELECT _ FROM _ LEFT JOIN _ ON _._ = _._          */
/* 2.2.3. RIGHT JOIN : ............... SELECT _ FROM _ RIGHT JOIN _ ON _._ = _._         */
/* 2.3. Subconsultas : ............... IN, NOT IN, ANY, ALL, EXISTS                      */
/* 2.3.1. Escalonada : ............... SELECT _ FROM _ WHERE _ IN (SELECT _ FROM _ )     */
/* 2.3.2. Lista : .................... SELECT _ FROM _ WHERE _ > ALL (SELECT _ FROM _ )  */
/* 2.3.3. Correlacionada : ........... SELECT _ FROM _ WHERE _ > (SELECT _ FROM _ )      */
/* 3. CONSULTAS DE ACCION [Final]                                                        */
/* ------------------------------------------------------------------------------------- */
/* BIBLIOGRAFIA                                                                          */
/* ------------------------------------------------------------------------------------- */
/* ************************************************************************************* */
/* EN CONSOLA: XAMPP / SHELL / cd mysql/bin / mysql -h localhost -u root -p / ENTER      */
/* ************************************************************************************* */
/*                                                                                       */
/* NOTAS PARA USAR ESTE ARCHIVO                                                          */
/* - Primero: USE db_sigap; y cargar los datos correctos (1_dml_insercion.sql).          */
/*   Sin datos, las consultas devuelven vacio.                                           */
/* - Los ids (id_venta = 6, id_estado_pago = 1, etc.) y los nombres de las tablas de     */
/*   catalogo ('Entregada', 'Enviada', 'Vendedor', 'Empleado', 'Cliente') son SUPUESTOS: */
/*   ajustalos a los datos que tengas cargados.                                          */
/* - En SIGAP la tabla venta NO guarda el total: se calcula con                          */
/*   SUM(cantidad * precio_unitario) sobre detalle_venta.                                */
/* - Cuando una tabla tiene alias (AS V), las columnas se califican con el alias         */
/*   (V.id_venta), no con el nombre original de la tabla.                                */
/* ************************************************************************************* */

USE db_sigap;


/* ************************************************************************************* */
/* ------------------------------ 1. CONSULTAS DE ACCION ------------------------------- */
/* -------------------------------------- INICIO --------------------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- 1.1. Crear una Tabla a partir de Otra. ---------------------------------------------- --
--      CREATE TABLE __ SELECT __ FROM __ WHERE __ = __ : ------------------------------ --
--      Se usa pago porque ninguna otra tabla depende de ella (sin cascadas).            --
--      CREATE TABLE ... SELECT copia las columnas y los datos, pero NO copia llaves,    --
--      indices ni AUTO_INCREMENT.                                                       --
-- ------------------------------------------------------------------------------------- --
CREATE TABLE pago_pendiente SELECT * FROM pago
WHERE id_estado_pago = 1;

-- -------------------------------------------
DELETE FROM pago
WHERE id_estado_pago = 1;

-- ------------------------------------------------------------------------------------- --
-- 1.2. Datos Anexados. ---------------------------------------------------------------- --
--      INSERT INTO __ SELECT __ FROM __ : --------------------------------------------- --
-- ------------------------------------------------------------------------------------- --
INSERT INTO pago SELECT * FROM pago_pendiente;
DROP TABLE pago_pendiente;


/* ************************************************************************************* */
/* ----------------------------- 2. CONSULTAS DE SELECCION ----------------------------- */
/* -------------------------- EXTERNA, INTERNA Y SUBCONSULTAS -------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- 2.1. Union Externa. ----------------------------------------------------------------- --
--      UNION, UNION ALL : ------------------------------------------------------------- --
--      Los SELECT deben tener el mismo numero de columnas y tipos compatibles.          --
--      Los nombres de columna del resultado son los del primer SELECT.                  --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.1.1. UNION. ----------------------------------------------------------------------- --
--        SELECT __ FROM __ UNION SELECT __ FROM __ : ---------------------------------- --
--        UNION elimina las filas repetidas.                                             --
-- ------------------------------------------------------------------------------------- --
-- Productos que aparecen en ventas o en pedidos, con su cantidad.
SELECT id_producto, cantidad FROM detalle_venta
UNION
SELECT id_producto, cantidad FROM detalle_pedido;

-- Con criterio en cada SELECT.
SELECT id_producto, cantidad FROM detalle_venta WHERE cantidad > 3
UNION
SELECT id_producto, cantidad FROM detalle_pedido WHERE cantidad > 3;

-- Columnas con nombres distintos en cada tabla y una columna fija que indica el origen.
SELECT id_cliente AS id_usuario, fecha_venta AS fecha, 'venta' AS origen
FROM venta
UNION
SELECT id_solicitante, fecha_pedido, 'pedido'
FROM pedido
ORDER BY fecha DESC;

-- Todos los usuarios que participan en ventas o pedidos (sin repetir).
SELECT id_cliente AS id_usuario FROM venta
UNION
SELECT id_vendedor FROM venta WHERE id_vendedor IS NOT NULL
UNION
SELECT id_solicitante FROM pedido
UNION
SELECT id_proveedor FROM pedido;

-- ------------------------------------------------------------------------------------- --
-- 2.1.2. UNION ALL. ------------------------------------------------------------------- --
--        SELECT __ FROM __ UNION ALL SELECT __ FROM __ : ------------------------------ --
--        UNION ALL conserva las filas repetidas (y es mas rapido).                      --
-- ------------------------------------------------------------------------------------- --
SELECT id_producto, cantidad FROM detalle_venta
UNION ALL
SELECT id_producto, cantidad FROM detalle_pedido;

SELECT id_cliente AS id_usuario, fecha_venta AS fecha, 'venta' AS origen
FROM venta
UNION ALL
SELECT id_solicitante, fecha_pedido, 'pedido'
FROM pedido
ORDER BY fecha DESC;


-- ------------------------------------------------------------------------------------- --
-- 2.2. Union Interna. ----------------------------------------------------------------- --
--      INNER JOIN, LEFT JOIN, RIGHT JOIN : -------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.2.1. INNER JOIN. ------------------------------------------------------------------ --
--        SELECT __ FROM __ INNER JOIN __ ON __.__ = __.__ : --------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM usuario INNER JOIN venta
ON usuario.id_usuario = venta.id_cliente;

SELECT * FROM rol AS R
INNER JOIN usuario AS U
ON R.id_rol = U.id_rol
INNER JOIN venta AS V
ON U.id_usuario = V.id_cliente;

SELECT * FROM venta AS V
INNER JOIN detalle_venta AS DV
ON V.id_venta = DV.id_venta
INNER JOIN producto AS P
ON DV.id_producto = P.id_producto;

-- La tabla usuario se usa dos veces (con alias distintos): cliente y vendedor de la venta.
SELECT * FROM venta AS V
INNER JOIN usuario AS C
ON V.id_cliente = C.id_usuario
INNER JOIN usuario AS S
ON V.id_vendedor = S.id_usuario;

-- ------------------------------------------------------------------------------------- --
-- 2.2.1.1. Con repeticiones. ---------------------------------------------------------- --
--          SELECT __ FROM __ INNER JOIN __ ON __.__ = __.__ : ------------------------- --
-- ------------------------------------------------------------------------------------- --
-- Consultar los usuarios con su rol
SELECT R.id_rol, R.nombre_rol, U.id_usuario, U.nombre, U.apellido, U.correo
FROM rol AS R
INNER JOIN usuario AS U
ON R.id_rol = U.id_rol;

-- ------------------------------------------------------------------------------------- --
-- Consultar las ventas con su cliente, su vendedor y su estado
SELECT V.id_venta, V.fecha_venta, V.direccion_entrega,
C.id_usuario AS id_cliente, C.nombre AS nombre_cliente, C.apellido AS apellido_cliente,
C.correo AS correo_cliente,
S.nombre AS nombre_vendedor, S.apellido AS apellido_vendedor,
E.nombre AS estado_venta
FROM venta AS V
INNER JOIN usuario AS C
ON V.id_cliente = C.id_usuario
INNER JOIN usuario AS S
ON V.id_vendedor = S.id_usuario
INNER JOIN estado_venta AS E
ON V.id_estado_venta = E.id_estado_venta;

-- ------------------------------------------------------------------------------------- --
-- Consultar el detalle de cada venta con el nombre del producto
SELECT V.id_venta, V.fecha_venta, P.id_producto, P.nombre AS producto,
DV.cantidad, DV.precio_unitario
FROM venta AS V
INNER JOIN detalle_venta AS DV
ON V.id_venta = DV.id_venta
INNER JOIN producto AS P
ON DV.id_producto = P.id_producto;

-- ------------------------------------------------------------------------------------- --
-- 2.2.1.2. Sin repeticiones. ---------------------------------------------------------- --
--          SELECT DISTINCT __ FROM __ INNER JOIN __ ON __.__ = __.__ : ---------------- --
-- ------------------------------------------------------------------------------------- --
-- Clientes que han comprado al menos una vez (cada cliente sale una sola vez).
SELECT DISTINCT U.id_usuario, U.nombre, U.apellido
FROM usuario AS U
INNER JOIN venta AS V
ON U.id_usuario = V.id_cliente;


-- ------------------------------------------------------------------------------------- --
-- 2.2.1.3. Condicionada. -------------------------------------------------------------- --
--          WHERE, OPERADORES, ORDER BY : ---------------------------------------------- --
-- ------------------------------------------------------------------------------------- --
SELECT V.id_venta, U.id_usuario, U.nombre, U.apellido, U.correo,
V.fecha_venta, V.direccion_entrega, E.nombre AS estado_venta
FROM usuario AS U
INNER JOIN venta AS V
ON U.id_usuario = V.id_cliente
INNER JOIN estado_venta AS E
ON V.id_estado_venta = E.id_estado_venta
WHERE E.nombre = 'Entregada' OR E.nombre = 'Enviada'
ORDER BY V.fecha_venta DESC;

SELECT V.id_venta, U.id_usuario, U.nombre, U.apellido, U.correo,
V.fecha_venta, V.direccion_entrega, E.nombre AS estado_venta
FROM usuario AS U
INNER JOIN venta AS V
ON U.id_usuario = V.id_cliente
INNER JOIN estado_venta AS E
ON V.id_estado_venta = E.id_estado_venta
WHERE V.direccion_entrega LIKE '%Medellín%' AND E.nombre = 'Entregada'
ORDER BY V.fecha_venta DESC;

-- "Factura" de una venta: se usa DV.precio_unitario (precio al momento de vender),
-- no P.precio (precio actual del producto).
SELECT V.id_venta, V.id_cliente, P.id_producto, P.nombre AS producto,
DV.precio_unitario, DV.cantidad,
(DV.precio_unitario * DV.cantidad) AS total_parcial,
ROUND((DV.precio_unitario * DV.cantidad) * 0.19, 2) AS iva,
(DV.precio_unitario * DV.cantidad) +
ROUND((DV.precio_unitario * DV.cantidad) * 0.19, 2) AS total
FROM venta AS V
INNER JOIN detalle_venta AS DV
ON V.id_venta = DV.id_venta
INNER JOIN producto AS P
ON DV.id_producto = P.id_producto
WHERE V.id_venta = 6;

-- Total de cada venta (reemplaza al "total del pedido" que SIGAP no almacena).
SELECT V.id_venta, V.id_cliente,
SUM(DV.cantidad * DV.precio_unitario) AS total_venta
FROM venta AS V
INNER JOIN detalle_venta AS DV
ON V.id_venta = DV.id_venta
GROUP BY V.id_venta, V.id_cliente
ORDER BY total_venta DESC;

-- ------------------------------------------------------------------------------------- --
-- 2.2.2. LEFT JOIN. ------------------------------------------------------------------- --
--        SELECT __ FROM __ LEFT JOIN __ ON __.__ = __.__ : ---------------------------- --
--        Devuelve todas las filas de la tabla izquierda, tengan o no pareja.            --
-- ------------------------------------------------------------------------------------- --

-- Todos los usuarios con rol Cliente, con sus ventas si las tienen.
SELECT U.id_usuario, U.nombre, U.apellido, U.correo,
V.id_venta, V.fecha_venta, V.id_estado_venta
FROM usuario AS U
INNER JOIN rol AS R
ON U.id_rol = R.id_rol
LEFT JOIN venta AS V
ON U.id_usuario = V.id_cliente
WHERE R.nombre_rol = 'Cliente';

-- Clientes que NO han comprado nunca.
SELECT U.id_usuario, U.nombre, U.apellido, U.correo
FROM usuario AS U
INNER JOIN rol AS R
ON U.id_rol = R.id_rol
LEFT JOIN venta AS V
ON U.id_usuario = V.id_cliente
WHERE R.nombre_rol = 'Cliente' AND V.id_venta IS NULL;

-- Ventas sin vendedor asignado (id_vendedor admite NULL).
SELECT V.id_venta, V.id_cliente, V.fecha_venta
FROM venta AS V
LEFT JOIN usuario AS S
ON V.id_vendedor = S.id_usuario
WHERE S.id_usuario IS NULL;

-- Productos que nunca se han vendido.
SELECT P.id_producto, P.nombre, P.precio, P.stock
FROM producto AS P
LEFT JOIN detalle_venta AS DV
ON P.id_producto = DV.id_producto
WHERE DV.id_detalle_venta IS NULL;

-- ------------------------------------------------------------------------------------- --
-- 2.2.3. RIGHT JOIN. ------------------------------------------------------------------ --
--        SELECT __ FROM __ RIGHT JOIN __ ON __.__ = __.__ : --------------------------- --
--        Devuelve todas las filas de la tabla derecha, tengan o no pareja.              --
-- ------------------------------------------------------------------------------------- --
SELECT * FROM usuario AS U
RIGHT JOIN venta AS V
ON U.id_usuario = V.id_cliente;

-- NOTA: Esta consulta devuelve lo mismo que un INNER JOIN, ya que cada venta tiene
--       asociado un cliente (id_cliente es NOT NULL y es llave foranea). No puede existir
--       una venta sin cliente.

-- Aqui SI hay filas sin pareja: productos (derecha) que no estan en ninguna venta.
SELECT P.id_producto, P.nombre, DV.id_venta
FROM detalle_venta AS DV
RIGHT JOIN producto AS P
ON DV.id_producto = P.id_producto
WHERE DV.id_venta IS NULL;
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.3. Subconsultas. ------------------------------------------------------------------ --
--      IN, NOT IN, ANY, ALL, EXISTS : ------------------------------------------------- --
-- ------------------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------------------- --
-- 2.3.1. Escalonada. ------------------------------------------------------------------ --
--        SELECT __ FROM __ WHERE __ IN (SELECT __ FROM __ WHERE __ ) : ---------------- --
--        Una consulta dentro de otra, que puede anidarse varios niveles.                --
-- ------------------------------------------------------------------------------------- --

-- Con INNER JOIN:
SELECT DISTINCT P.nombre, P.precio
FROM producto AS P
INNER JOIN detalle_venta AS DV
ON P.id_producto = DV.id_producto
WHERE DV.cantidad > 3;

-- Lo mismo con subconsulta:
SELECT nombre, precio
FROM producto
WHERE id_producto IN
(SELECT id_producto FROM detalle_venta WHERE cantidad > 3);

SELECT nombre, precio
FROM producto
WHERE id_producto NOT IN
(SELECT id_producto FROM detalle_venta WHERE cantidad > 3);

-- Usuarios que han comprado.
SELECT nombre, apellido, correo
FROM usuario
WHERE id_usuario IN
(SELECT id_cliente FROM venta);

-- Tres niveles: productos vendidos en ventas con estado 'Entregada'.
SELECT nombre, precio
FROM producto
WHERE id_producto IN
(SELECT id_producto FROM detalle_venta
 WHERE id_venta IN
 (SELECT id_venta FROM venta
  WHERE id_estado_venta =
  (SELECT id_estado_venta FROM estado_venta WHERE nombre = 'Entregada')));

-- ------------------------------------------------------------------------------------- --
-- 2.3.2. Lista. ----------------------------------------------------------------------- --
--        SELECT __ FROM __ WHERE __ > ALL (SELECT __ FROM __ WHERE __ ) : ------------- --
--        La subconsulta devuelve una lista de valores que se compara con IN, ANY o ALL. --
-- ------------------------------------------------------------------------------------- --

-- Usuarios cuyo rol es Vendedor o Empleado.
SELECT id_usuario, nombre, apellido, id_rol
FROM usuario
WHERE id_rol IN
(SELECT id_rol FROM rol WHERE nombre_rol IN ('Vendedor', 'Empleado'));

-- Productos mas caros que TODOS los de la categoria 1.
SELECT nombre, precio, id_categoria
FROM producto
WHERE precio > ALL
(SELECT precio FROM producto WHERE id_categoria = 1);

-- Productos mas caros que ALGUNO de la categoria 1 (basta superar al mas barato).
SELECT nombre, precio, id_categoria
FROM producto
WHERE precio > ANY
(SELECT precio FROM producto WHERE id_categoria = 1);

-- Productos con precio mayor al promedio general (la subconsulta devuelve un solo valor).
SELECT nombre, precio
FROM producto
WHERE precio > (SELECT AVG(precio) FROM producto);

-- ------------------------------------------------------------------------------------- --
-- 2.3.3. Correlacionada. -------------------------------------------------------------- --
--        SELECT __ FROM __ AS A WHERE __ > (SELECT __ FROM __ WHERE __ = A.__ ) : ----- --
--        La subconsulta usa una columna de la consulta externa y se evalua por cada fila.
-- ------------------------------------------------------------------------------------- --

-- Productos con precio mayor al promedio de SU categoria.
SELECT P.nombre, P.precio, P.id_categoria
FROM producto AS P
WHERE P.precio >
(SELECT AVG(P2.precio) FROM producto AS P2 WHERE P2.id_categoria = P.id_categoria);

-- Clientes con mas de una compra.
SELECT U.id_usuario, U.nombre, U.apellido
FROM usuario AS U
WHERE (SELECT COUNT(*) FROM venta AS V WHERE V.id_cliente = U.id_usuario) > 1;

-- EXISTS: usuarios que tienen al menos una venta.
SELECT U.id_usuario, U.nombre, U.apellido
FROM usuario AS U
WHERE EXISTS
(SELECT 1 FROM venta AS V WHERE V.id_cliente = U.id_usuario);

-- NOT EXISTS: productos sin ningun movimiento de inventario.
SELECT P.id_producto, P.nombre
FROM producto AS P
WHERE NOT EXISTS
(SELECT 1 FROM movimiento_inventario AS M WHERE M.id_producto = P.id_producto);


/* ************************************************************************************* */
/* ------------------------------ 3. CONSULTAS DE ACCION ------------------------------- */
/* --------------------------------------- FINAL --------------------------------------- */
/* ************************************************************************************* */

-- ------------------------------------------------------------------------------------- --
-- 3.1. Eliminar Datos de una Tabla Relacionada. --------------------------------------- --
--      DELETE __ FROM __ INNER JOIN / LEFT JOIN __ ON __.__ = __.__ WHERE __ : -------- --
--      Se indica entre DELETE y FROM la tabla de la que se borran las filas.           --
-- ------------------------------------------------------------------------------------- --

-- Borrar las notificaciones de usuarios desactivados.
DELETE N FROM notificacion AS N
INNER JOIN usuario AS U
ON N.id_destinatario = U.id_usuario
WHERE U.estado = 0;

-- Borrar productos eliminados (borrado logico) que nunca se vendieron.
-- Puede fallar con Error 1451 si el producto esta en pedidos, movimientos, etc. (RESTRICT).
DELETE P FROM producto AS P
LEFT JOIN detalle_venta AS DV
ON P.id_producto = DV.id_producto
WHERE DV.id_detalle_venta IS NULL AND P.eliminado_en IS NOT NULL;


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
