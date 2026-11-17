-- ============================================================
-- 03_db_dml_datos.sql
-- Proyecto: SIGAP
-- Motor: MySQL 8.0+ / InnoDB
--
-- Contiene datos iniciales y datos de prueba relacionados para
-- los 34 objetos (tablas) definidos en el DDL compartido.
-- 
-- IMPORTANTE:
-- 1. Ejecutar primero el archivo de creación de la BD (DDL).
-- 2. Este archivo está pensado para ejecutarse UNA SOLA VEZ sobre
--    una base de datos recién creada. Si ya existen estos IDs,
--    pueden producirse errores de clave duplicada.
-- 3. Las contraseñas son hashes SHA-256 DEMOSTRATIVOS. Para un
--    sistema real, reemplazarlos por hashes bcrypt/Argon2 creados
--    desde la aplicación. No usar este mecanismo como autenticación
--    de producción.
-- 4. Los datos son ficticios y solo sirven para pruebas académicas.
-- ============================================================

USE db_sigap;

START TRANSACTION;

-- ============================================================
-- 1. MODULO DE USUARIOS Y SEGURIDAD
-- ============================================================

INSERT INTO rol (id_rol, nombre_rol, descripcion) VALUES
(1, 'Administrador', 'Administra la configuración y operación general de SIGAP'),
(2, 'Vendedor', 'Gestiona ventas y atención comercial'),
(3, 'Empleado', 'Apoya los procesos operativos y de empaquetado'),
(4, 'Proveedor', 'Atiende pedidos de abastecimiento'),
(5, 'Cliente', 'Consulta productos y realiza compras');

INSERT INTO usuario
(id_usuario, id_rol, nombre, apellido, correo, contrasena, telefono,
 idioma, fuente, tamano_fuente, estado, fecha_registro, eliminado_en)
VALUES
(1, 1, 'Laura', 'Gomez', 'admin@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000001', 'es', 'Predeterminada', 14, 1, '2026-01-05 08:00:00', NULL),
(2, 2, 'Carlos', 'Martinez', 'carlos.vendedor@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000002', 'es', 'Predeterminada', 14, 1, '2026-01-06 08:15:00', NULL),
(3, 2, 'Diana', 'Rodriguez', 'diana.vendedora@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000003', 'es', 'Predeterminada', 14, 1, '2026-01-06 08:30:00', NULL),
(4, 3, 'Andres', 'Lopez', 'andres.empleado@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000004', 'es', 'Predeterminada', 14, 1, '2026-01-07 09:00:00', NULL),
(5, 4, 'Panela', 'del Valle', 'proveedor.valle@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000005', 'es', 'Predeterminada', 14, 1, '2026-01-08 10:00:00', NULL),
(6, 4, 'Suministros', 'Andinos', 'proveedor.andino@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000006', 'es', 'Predeterminada', 14, 1, '2026-01-08 10:30:00', NULL),
(7, 5, 'Maria', 'Perez', 'maria.cliente@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000007', 'es', 'Predeterminada', 14, 1, '2026-01-10 11:00:00', NULL),
(8, 5, 'Jorge', 'Ramirez', 'jorge.cliente@sigap.test', SHA2('Demo_SIGAP_2026!', 256), '3000000008', 'es', 'Predeterminada', 14, 1, '2026-01-11 11:30:00', NULL);

INSERT INTO direccion_usuario
(id_direccion, id_usuario, alias, direccion, es_principal)
VALUES
(1, 7, 'Casa', 'Calle 10 # 15-20, Bogota', 1),
(2, 7, 'Trabajo', 'Carrera 20 # 30-40, Bogota', 0),
(3, 8, 'Casa', 'Calle 25 # 8-15, Bogota', 1),
(4, 2, 'Sucursal', 'Carrera 7 # 12-35, Bogota', 1);

INSERT INTO codigo_recuperacion
(id_codigo, id_usuario, codigo_hash, creado_en, expira_en, usado)
VALUES
(1, 7, SHA2('CODIGO-DEMO-741852', 256), '2026-02-01 09:00:00', '2026-02-01 09:30:00', 1),
(2, 8, SHA2('CODIGO-DEMO-963258', 256), '2026-02-02 10:00:00', '2026-02-02 10:30:00', 0);

INSERT INTO bitacora
(id_bitacora, id_usuario, accion, entidad, id_registro, detalle, fecha)
VALUES
(1, 1, 'INSERTAR', 'usuario', 7, 'Registro de cliente de prueba', '2026-01-10 11:00:00'),
(2, 2, 'CREAR', 'venta', 1, 'Creacion de venta de prueba', '2026-02-10 10:15:00'),
(3, 1, 'ACTUALIZAR', 'producto', 1, 'Actualizacion de informacion del producto', '2026-02-11 08:30:00');

-- ============================================================
-- 2. MODULO DE PRODUCTOS
-- ============================================================

INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
(1, 'Panela en bloque', 'Panela tradicional moldeada en diferentes presentaciones'),
(2, 'Panela pulverizada', 'Panela molida de textura fina'),
(3, 'Panela granulada', 'Panela en granulos para disolver y preparar bebidas'),
(4, 'Panela saborizada', 'Panela con ingredientes o sabores adicionales'),
(5, 'Derivados de panela', 'Productos elaborados a partir de panela');

INSERT INTO estado_producto (id_estado_producto, nombre) VALUES
(1, 'Disponible'),
(2, 'Agotado'),
(3, 'Inactivo'),
(4, 'En promocion');

INSERT INTO producto
(id_producto, id_categoria, id_estado_producto, nombre, descripcion, precio,
 promocion, imagen_url, stock, stock_minimo, eliminado_en)
VALUES
(1, 1, 1, 'Panela redonda tradicional 500 g', 'Panela de cana de azucar en bloque redondo de 500 gramos', 4500.00, NULL, 'img/panela-redonda-500.jpg', 120, 20, NULL),
(2, 1, 1, 'Panela cuadrada tradicional 500 g', 'Panela en bloque cuadrado de 500 gramos', 4500.00, NULL, 'img/panela-cuadrada-500.jpg', 100, 20, NULL),
(3, 1, 1, 'Panela en pastilla 250 g', 'Presentacion compacta de panela en pastilla', 2800.00, NULL, 'img/panela-pastilla-250.jpg', 80, 15, NULL),
(4, 2, 1, 'Panela pulverizada 500 g', 'Panela pulverizada empacada para facil preparacion', 5200.00, NULL, 'img/panela-pulverizada-500.jpg', 90, 15, NULL),
(5, 3, 4, 'Panela granulada 500 g', 'Panela granulada de rapida disolucion', 5500.00, 'Promocion de lanzamiento', 'img/panela-granulada-500.jpg', 65, 15, NULL),
(6, 4, 1, 'Panela con jengibre 500 g', 'Panela saborizada con jengibre', 6500.00, NULL, 'img/panela-jengibre-500.jpg', 40, 10, NULL),
(7, 4, 1, 'Panela con limon 500 g', 'Panela saborizada con limon', 6500.00, NULL, 'img/panela-limon-500.jpg', 35, 10, NULL),
(8, 5, 1, 'Melado de panela  botella 500 ml', 'Melado elaborado a partir de panela', 7000.00, NULL, 'img/melado-500.jpg', 25, 8, NULL),
(9, 1, 2, 'Panela panelon 1 kg', 'Presentacion grande de panela en bloque', 8500.00, NULL, 'img/panelon-1kg.jpg', 0, 10, NULL);

INSERT INTO reemplazo_producto
(id_reemplazo, id_producto_anterior, id_producto_nuevo, id_usuario, fecha)
VALUES
(1, 9, 1, 1, '2026-02-12 09:00:00');

-- ============================================================
-- 3. MODULO DE VENTAS
-- ============================================================

INSERT INTO estado_venta (id_estado_venta, nombre) VALUES
(1, 'Pendiente'),
(2, 'Confirmada'),
(3, 'En preparacion'),
(4, 'Enviada'),
(5, 'Entregada'),
(6, 'Cancelada');

INSERT INTO grupo_venta
(id_grupo_venta, id_usuario, nombre, criterio, fecha_creacion)
VALUES
(1, 2, 'Ventas de febrero', 'Agrupacion por periodo', '2026-02-01 08:00:00'),
(2, 3, 'Clientes frecuentes', 'Agrupacion por tipo de cliente', '2026-02-01 08:30:00');

INSERT INTO venta
(id_venta, id_cliente, id_vendedor, id_estado_venta, id_grupo_venta,
 fecha_venta, direccion_entrega, eliminado_en)
VALUES
(1, 7, 2, 5, 1, '2026-02-10 10:15:00', 'Calle 10 # 15-20, Bogota', NULL),
(2, 8, 3, 3, 2, '2026-02-11 14:20:00', 'Calle 25 # 8-15, Bogota', NULL),
(3, 7, 2, 1, 1, '2026-02-12 09:45:00', 'Calle 10 # 15-20, Bogota', NULL);

INSERT INTO detalle_venta
(id_detalle_venta, id_venta, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 1, 2, 4500.00),
(2, 1, 4, 1, 5200.00),
(3, 2, 2, 3, 4500.00),
(4, 2, 5, 2, 5500.00),
(5, 3, 6, 1, 6500.00);

INSERT INTO metodo_pago (id_metodo_pago, nombre) VALUES
(1, 'Efectivo'),
(2, 'Transferencia'),
(3, 'Tarjeta debito'),
(4, 'Tarjeta credito'),
(5, 'PSE');

INSERT INTO estado_pago (id_estado_pago, nombre) VALUES
(1, 'Pendiente'),
(2, 'Aprobado'),
(3, 'Rechazado'),
(4, 'Reembolsado');

INSERT INTO pago
(id_pago, id_venta, id_metodo_pago, id_estado_pago, monto, referencia, fecha_pago)
VALUES
(1, 1, 2, 2, 14200.00, 'TRX-SIGAP-0001', '2026-02-10 10:20:00'),
(2, 2, 1, 1, 24500.00, 'PAGO-PENDIENTE-0002', '2026-02-11 14:25:00'),
(3, 3, 5, 1, 6500.00, 'PSE-SIGAP-0003', '2026-02-12 09:50:00');

INSERT INTO puntuacion
(id_puntuacion, id_venta, valor_estrellas, comentario, fecha)
VALUES
(1, 1, 5, 'Pedido recibido completo y en buen estado', '2026-02-10 17:00:00');

-- ============================================================
-- 4. MODULO DE PRODUCTOS RECHAZADOS
-- ============================================================

INSERT INTO estado_disposicion (id_estado_disposicion, nombre) VALUES
(1, 'Pendiente de revision'),
(2, 'Devuelto al proveedor'),
(3, 'Reintegrado a inventario'),
(4, 'Desechado');

INSERT INTO producto_rechazado
(id_producto_rechazado, id_detalle_venta, id_estado_disposicion,
 id_usuario, cantidad_rechazada, motivo, fecha)
VALUES
(1, 3, 1, 4, 1, 'Empaque deteriorado durante la entrega', '2026-02-11 16:00:00');

-- ============================================================
-- 5. MODULO DE PEDIDOS A PROVEEDORES
-- ============================================================

INSERT INTO estado_pedido (id_estado_pedido, nombre) VALUES
(1, 'Solicitado'),
(2, 'Aceptado por proveedor'),
(3, 'En preparacion'),
(4, 'Enviado'),
(5, 'Recibido'),
(6, 'Cancelado');

INSERT INTO pedido
(id_pedido, id_solicitante, id_proveedor, fecha_pedido,
 fecha_estimada_entrega, direccion_entrega)
VALUES
(1, 1, 5, '2026-02-05 08:00:00', '2026-02-09', 'Bodega principal SIGAP, Bogota'),
(2, 1, 6, '2026-02-12 09:00:00', '2026-02-16', 'Bodega principal SIGAP, Bogota');

INSERT INTO detalle_pedido
(id_detalle_pedido, id_pedido, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 1, 100, 3200.00),
(2, 1, 4, 60, 3900.00),
(3, 2, 5, 50, 4100.00),
(4, 2, 6, 30, 4800.00);

INSERT INTO fase_pedido
(id_fase_pedido, id_pedido, id_estado_pedido, id_usuario, fecha_cambio)
VALUES
(1, 1, 1, 1, '2026-02-05 08:00:00'),
(2, 1, 2, 5, '2026-02-05 11:00:00'),
(3, 1, 3, 5, '2026-02-06 08:30:00'),
(4, 1, 4, 5, '2026-02-08 15:00:00'),
(5, 1, 5, 1, '2026-02-09 10:00:00'),
(6, 2, 1, 1, '2026-02-12 09:00:00'),
(7, 2, 2, 6, '2026-02-12 13:00:00');

-- ============================================================
-- 6. MODULO DE EMPAQUETADO
-- ============================================================

INSERT INTO estado_empaquetado (id_estado_empaquetado, nombre) VALUES
(1, 'Pendiente'),
(2, 'En proceso'),
(3, 'Empacado'),
(4, 'Entregado a despacho');

INSERT INTO empaquetado
(id_empaquetado, id_detalle_pedido, id_empleado, id_asignador, fecha_asignacion)
VALUES
(1, 1, 4, 1, '2026-02-08 08:00:00'),
(2, 2, 4, 1, '2026-02-08 08:15:00'),
(3, 3, 4, 1, '2026-02-13 09:00:00');

INSERT INTO fase_empaquetado
(id_fase_empaquetado, id_empaquetado, id_estado_empaquetado, fecha_cambio)
VALUES
(1, 1, 1, '2026-02-08 08:00:00'),
(2, 1, 2, '2026-02-08 08:30:00'),
(3, 1, 3, '2026-02-08 10:00:00'),
(4, 2, 1, '2026-02-08 08:15:00'),
(5, 2, 2, '2026-02-08 09:00:00'),
(6, 3, 1, '2026-02-13 09:00:00');

-- ============================================================
-- 7. MODULO DE INVENTARIO
-- ============================================================

INSERT INTO tipo_movimiento (id_tipo_movimiento, nombre) VALUES
(1, 'Entrada por compra'),
(2, 'Salida por venta'),
(3, 'Ajuste positivo'),
(4, 'Ajuste negativo'),
(5, 'Devolucion'),
(6, 'Producto rechazado');

INSERT INTO movimiento_inventario
(id_movimiento, id_producto, id_tipo_movimiento, id_usuario,
 id_detalle_venta, id_detalle_pedido, cantidad, observacion, fecha)
VALUES
(1, 1, 1, 1, NULL, 1, 100, 'Entrada de inventario por pedido recibido', '2026-02-09 10:30:00'),
(2, 4, 1, 1, NULL, 2, 60, 'Entrada de panela pulverizada por compra', '2026-02-09 10:35:00'),
(3, 1, 2, 2, 1, NULL, -2, 'Salida por venta entregada', '2026-02-10 10:20:00'),
(4, 4, 2, 2, 2, NULL, -1, 'Salida por venta entregada', '2026-02-10 10:20:00'),
(5, 2, 2, 3, 3, NULL, -3, 'Salida asociada a venta en preparacion', '2026-02-11 14:30:00'),
(6, 2, 6, 4, 3, NULL, -1, 'Unidad reportada como producto rechazado', '2026-02-11 16:00:00');

-- ============================================================
-- 8. MODULO PQR
-- ============================================================

INSERT INTO tipo_ticket (id_tipo_ticket, nombre) VALUES
(1, 'Peticion'),
(2, 'Queja'),
(3, 'Reclamo'),
(4, 'Sugerencia');

INSERT INTO estado_ticket (id_estado_ticket, nombre) VALUES
(1, 'Abierto'),
(2, 'En proceso'),
(3, 'Respondido'),
(4, 'Cerrado');

INSERT INTO ticket
(id_ticket, id_usuario, id_tipo_ticket, id_estado_ticket,
 asunto, descripcion, fecha_creacion, eliminado_en)
VALUES
(1, 7, 3, 3, 'Producto recibido con empaque deteriorado',
 'Solicito revision de una unidad de panela cuadrada que llego con el empaque deteriorado.',
 '2026-02-11 16:10:00', NULL),
(2, 8, 4, 1, 'Sugerencia sobre presentaciones',
 'Seria util incorporar presentaciones familiares de panela pulverizada.',
 '2026-02-12 11:00:00', NULL);

INSERT INTO respuesta_ticket
(id_respuesta_ticket, id_ticket, id_usuario, respuesta, fecha_respuesta)
VALUES
(1, 1, 2, 'Hemos recibido el reclamo y se encuentra en revision por el equipo de servicio al cliente.', '2026-02-11 17:00:00'),
(2, 2, 1, 'Gracias por la sugerencia. La tendremos en cuenta para futuras mejoras del catalogo.', '2026-02-12 12:00:00');

-- ============================================================
-- 9. MODULO DE NOTIFICACIONES
-- ============================================================

INSERT INTO tipo_notificacion (id_tipo_notificacion, nombre) VALUES
(1, 'Venta'),
(2, 'Pago'),
(3, 'Pedido'),
(4, 'Inventario'),
(5, 'PQR'),
(6, 'Sistema');

INSERT INTO notificacion
(id_notificacion, id_destinatario, id_remitente, id_tipo_notificacion,
 asunto, mensaje, id_producto, id_pedido, id_venta, id_ticket,
 fecha_envio, leida)
VALUES
(1, 7, 2, 1, 'Venta entregada', 'Tu venta numero 1 fue entregada correctamente.', NULL, NULL, 1, NULL, '2026-02-10 17:00:00', 1),
(2, 1, 5, 3, 'Pedido recibido', 'El proveedor reporto la entrega del pedido numero 1.', NULL, 1, NULL, NULL, '2026-02-09 10:05:00', 1),
(3, 2, 1, 5, 'Nuevo reclamo', 'Se registro un reclamo de un cliente que requiere revision.', NULL, NULL, NULL, 1, '2026-02-11 16:15:00', 0),
(4, 1, 4, 4, 'Stock bajo', 'Revisar existencias del producto panela panelon 1 kg.', 9, NULL, NULL, NULL, '2026-02-12 08:00:00', 0),
(5, 8, NULL, 6, 'Bienvenido a SIGAP', 'Tu cuenta de cliente fue registrada correctamente.', NULL, NULL, NULL, NULL, '2026-01-11 11:35:00', 1);

-- ============================================================
-- 10. VALIDACIONES RAPIDAS (CONSULTAS DE COMPROBACION)
-- Estas consultas no modifican datos.
-- ============================================================

COMMIT;

SELECT 'rol' AS tabla, COUNT(*) AS registros FROM rol
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'direccion_usuario', COUNT(*) FROM direccion_usuario
UNION ALL SELECT 'codigo_recuperacion', COUNT(*) FROM codigo_recuperacion
UNION ALL SELECT 'bitacora', COUNT(*) FROM bitacora
UNION ALL SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL SELECT 'estado_producto', COUNT(*) FROM estado_producto
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'reemplazo_producto', COUNT(*) FROM reemplazo_producto
UNION ALL SELECT 'tipo_movimiento', COUNT(*) FROM tipo_movimiento
UNION ALL SELECT 'estado_venta', COUNT(*) FROM estado_venta
UNION ALL SELECT 'grupo_venta', COUNT(*) FROM grupo_venta
UNION ALL SELECT 'venta', COUNT(*) FROM venta
UNION ALL SELECT 'detalle_venta', COUNT(*) FROM detalle_venta
UNION ALL SELECT 'metodo_pago', COUNT(*) FROM metodo_pago
UNION ALL SELECT 'estado_pago', COUNT(*) FROM estado_pago
UNION ALL SELECT 'pago', COUNT(*) FROM pago
UNION ALL SELECT 'estado_disposicion', COUNT(*) FROM estado_disposicion
UNION ALL SELECT 'producto_rechazado', COUNT(*) FROM producto_rechazado
UNION ALL SELECT 'estado_pedido', COUNT(*) FROM estado_pedido
UNION ALL SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL SELECT 'fase_pedido', COUNT(*) FROM fase_pedido
UNION ALL SELECT 'estado_empaquetado', COUNT(*) FROM estado_empaquetado
UNION ALL SELECT 'empaquetado', COUNT(*) FROM empaquetado
UNION ALL SELECT 'fase_empaquetado', COUNT(*) FROM fase_empaquetado
UNION ALL SELECT 'movimiento_inventario', COUNT(*) FROM movimiento_inventario
UNION ALL SELECT 'tipo_ticket', COUNT(*) FROM tipo_ticket
UNION ALL SELECT 'estado_ticket', COUNT(*) FROM estado_ticket
UNION ALL SELECT 'ticket', COUNT(*) FROM ticket
UNION ALL SELECT 'respuesta_ticket', COUNT(*) FROM respuesta_ticket
UNION ALL SELECT 'puntuacion', COUNT(*) FROM puntuacion
UNION ALL SELECT 'tipo_notificacion', COUNT(*) FROM tipo_notificacion
UNION ALL SELECT 'notificacion', COUNT(*) FROM notificacion;
