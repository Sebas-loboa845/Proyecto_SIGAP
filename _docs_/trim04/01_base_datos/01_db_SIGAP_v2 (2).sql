CREATE DATABASE db_sigap DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE db_sigap ;

-- -----------------------------------------------------
-- Table db_sigap.rol
-- -----------------------------------------------------
CREATE TABLE rol (
  id_rol INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre_rol VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (id_rol),
  UNIQUE INDEX uq_rol_nombre (nombre_rol ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.usuario
-- -----------------------------------------------------
CREATE TABLE usuario (
  id_usuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_rol INT UNSIGNED NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  apellido VARCHAR(60) NOT NULL,
  correo VARCHAR(100) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  idioma VARCHAR(5) NOT NULL DEFAULT 'es',
  fuente VARCHAR(30) NOT NULL DEFAULT 'Predeterminada',
  tamano_fuente TINYINT UNSIGNED NOT NULL DEFAULT 14,
  estado TINYINT(1) NOT NULL DEFAULT 1,
  fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  eliminado_en DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE INDEX uq_usuario_correo (correo ASC) ,
  INDEX idx_usuario_rol (id_rol ASC) ,
  CONSTRAINT fk_usuario_rol
    FOREIGN KEY (id_rol)
    REFERENCES db_sigap.rol (id_rol)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.direccion_usuario
-- -----------------------------------------------------
CREATE TABLE direccion_usuario (
  id_direccion INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NOT NULL,
  alias VARCHAR(30) NULL DEFAULT NULL,
  direccion VARCHAR(150) NOT NULL,
  es_principal TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_direccion),
  INDEX idx_direccion_usuario (id_usuario ASC) ,
  CONSTRAINT fk_direccion_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.codigo_recuperacion
-- -----------------------------------------------------
CREATE TABLE codigo_recuperacion (
  id_codigo INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NOT NULL,
  codigo_hash VARCHAR(255) NOT NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expira_en DATETIME NOT NULL,
  usado TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_codigo),
  INDEX idx_codigo_usuario (id_usuario ASC) ,
  CONSTRAINT fk_codigo_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.bitacora
-- -----------------------------------------------------
CREATE TABLE bitacora (
  id_bitacora INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NULL DEFAULT NULL,
  accion VARCHAR(40) NOT NULL,
  entidad VARCHAR(40) NOT NULL,
  id_registro INT UNSIGNED NULL DEFAULT NULL,
  detalle VARCHAR(255) NULL DEFAULT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_bitacora),
  INDEX idx_bitacora_usuario (id_usuario ASC) ,
  INDEX idx_bitacora_entidad (entidad ASC, id_registro ASC) ,
  CONSTRAINT fk_bitacora_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.categoria
-- -----------------------------------------------------
CREATE TABLE categoria (
  id_categoria INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (id_categoria),
  UNIQUE INDEX uq_categoria_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_producto
-- -----------------------------------------------------
CREATE TABLE estado_producto (
  id_estado_producto TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_producto),
  UNIQUE INDEX uq_estado_producto_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.producto
-- -----------------------------------------------------
CREATE TABLE producto (
  id_producto INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_categoria INT UNSIGNED NOT NULL,
  id_estado_producto TINYINT UNSIGNED NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  descripcion VARCHAR(150) NULL DEFAULT NULL,
  precio DECIMAL(12,2) NOT NULL,
  promocion VARCHAR(100) NULL DEFAULT NULL,
  imagen_url VARCHAR(255) NULL DEFAULT NULL,
  stock INT NOT NULL DEFAULT 0,
  stock_minimo INT NOT NULL DEFAULT 0,
  eliminado_en DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (id_producto),
  UNIQUE INDEX uq_producto_nombre (nombre ASC) ,
  INDEX idx_producto_categoria (id_categoria ASC) ,
  INDEX idx_producto_estado (id_estado_producto ASC) ,
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (id_categoria)
    REFERENCES db_sigap.categoria (id_categoria)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_producto_estado
    FOREIGN KEY (id_estado_producto)
    REFERENCES db_sigap.estado_producto (id_estado_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.reemplazo_producto
-- -----------------------------------------------------
CREATE TABLE reemplazo_producto (
  id_reemplazo INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_producto_anterior INT UNSIGNED NOT NULL,
  id_producto_nuevo INT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_reemplazo),
  INDEX idx_reemplazo_anterior (id_producto_anterior ASC) ,
  INDEX idx_reemplazo_nuevo (id_producto_nuevo ASC) ,
  INDEX idx_reemplazo_usuario (id_usuario ASC) ,
  CONSTRAINT fk_reemplazo_anterior
    FOREIGN KEY (id_producto_anterior)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_reemplazo_nuevo
    FOREIGN KEY (id_producto_nuevo)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_reemplazo_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.tipo_movimiento
-- -----------------------------------------------------
CREATE TABLE tipo_movimiento (
  id_tipo_movimiento TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_tipo_movimiento),
  UNIQUE INDEX uq_tipo_movimiento_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_venta
-- -----------------------------------------------------
CREATE TABLE estado_venta (
  id_estado_venta TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_venta),
  UNIQUE INDEX uq_estado_venta_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.grupo_venta
-- -----------------------------------------------------
CREATE TABLE grupo_venta (
  id_grupo_venta INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  criterio VARCHAR(100) NULL DEFAULT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_grupo_venta),
  INDEX idx_grupo_venta_usuario (id_usuario ASC) ,
  CONSTRAINT fk_grupo_venta_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.venta
-- -----------------------------------------------------
CREATE TABLE venta (
  id_venta INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_cliente INT UNSIGNED NOT NULL,
  id_vendedor INT UNSIGNED NULL DEFAULT NULL,
  id_estado_venta TINYINT UNSIGNED NOT NULL,
  id_grupo_venta INT UNSIGNED NULL DEFAULT NULL,
  fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  direccion_entrega VARCHAR(150) NULL DEFAULT NULL,
  eliminado_en DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (id_venta),
  INDEX idx_venta_cliente (id_cliente ASC) ,
  INDEX idx_venta_vendedor (id_vendedor ASC) ,
  INDEX idx_venta_estado (id_estado_venta ASC) ,
  INDEX idx_venta_grupo (id_grupo_venta ASC) ,
  INDEX idx_venta_fecha (fecha_venta ASC) ,
  CONSTRAINT fk_venta_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_venta_vendedor
    FOREIGN KEY (id_vendedor)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_venta_estado
    FOREIGN KEY (id_estado_venta)
    REFERENCES db_sigap.estado_venta (id_estado_venta)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_venta_grupo
    FOREIGN KEY (id_grupo_venta)
    REFERENCES db_sigap.grupo_venta (id_grupo_venta)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.detalle_venta
-- -----------------------------------------------------
CREATE TABLE detalle_venta (
  id_detalle_venta INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_venta INT UNSIGNED NOT NULL,
  id_producto INT UNSIGNED NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (id_detalle_venta),
  UNIQUE INDEX uq_detalle_venta (id_venta ASC, id_producto ASC) ,
  INDEX idx_detalle_venta_producto (id_producto ASC) ,
  CONSTRAINT fk_dv_venta
    FOREIGN KEY (id_venta)
    REFERENCES db_sigap.venta (id_venta)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_dv_producto
    FOREIGN KEY (id_producto)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.metodo_pago
-- -----------------------------------------------------
CREATE TABLE metodo_pago (
  id_metodo_pago TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_metodo_pago),
  UNIQUE INDEX uq_metodo_pago_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_pago
-- -----------------------------------------------------
CREATE TABLE estado_pago (
  id_estado_pago TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_pago),
  UNIQUE INDEX uq_estado_pago_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.pago
-- -----------------------------------------------------
CREATE TABLE pago (
  id_pago INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_venta INT UNSIGNED NOT NULL,
  id_metodo_pago TINYINT UNSIGNED NOT NULL,
  id_estado_pago TINYINT UNSIGNED NOT NULL,
  monto DECIMAL(12,2) NOT NULL,
  referencia VARCHAR(60) NULL DEFAULT NULL,
  fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_pago),
  INDEX idx_pago_venta (id_venta ASC) ,
  INDEX idx_pago_metodo (id_metodo_pago ASC) ,
  INDEX idx_pago_estado (id_estado_pago ASC) ,
  CONSTRAINT fk_pago_venta
    FOREIGN KEY (id_venta)
    REFERENCES db_sigap.venta (id_venta)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_pago_metodo
    FOREIGN KEY (id_metodo_pago)
    REFERENCES db_sigap.metodo_pago (id_metodo_pago)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_pago_estado
    FOREIGN KEY (id_estado_pago)
    REFERENCES db_sigap.estado_pago (id_estado_pago)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_disposicion
-- -----------------------------------------------------
CREATE TABLE estado_disposicion (
  id_estado_disposicion TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_estado_disposicion),
  UNIQUE INDEX uq_estado_disposicion_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.producto_rechazado
-- -----------------------------------------------------
CREATE TABLE producto_rechazado (
  id_producto_rechazado INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_detalle_venta INT UNSIGNED NOT NULL,
  id_estado_disposicion TINYINT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  cantidad_rechazada INT NOT NULL,
  motivo VARCHAR(150) NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_producto_rechazado),
  INDEX idx_rechazado_detalle (id_detalle_venta ASC) ,
  INDEX idx_rechazado_estado (id_estado_disposicion ASC) ,
  INDEX idx_rechazado_usuario (id_usuario ASC) ,
  CONSTRAINT fk_rechazado_detalle
    FOREIGN KEY (id_detalle_venta)
    REFERENCES db_sigap.detalle_venta (id_detalle_venta)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_rechazado_estado
    FOREIGN KEY (id_estado_disposicion)
    REFERENCES db_sigap.estado_disposicion (id_estado_disposicion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_rechazado_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_pedido
-- -----------------------------------------------------
CREATE TABLE estado_pedido (
  id_estado_pedido TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_pedido),
  UNIQUE INDEX uq_estado_pedido_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.pedido
-- -----------------------------------------------------
CREATE TABLE pedido (
  id_pedido INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_solicitante INT UNSIGNED NOT NULL,
  id_proveedor INT UNSIGNED NOT NULL,
  fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_estimada_entrega DATE NULL DEFAULT NULL,
  direccion_entrega VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (id_pedido),
  INDEX idx_pedido_solicitante (id_solicitante ASC) ,
  INDEX idx_pedido_proveedor (id_proveedor ASC) ,
  CONSTRAINT fk_pedido_solicitante
    FOREIGN KEY (id_solicitante)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.detalle_pedido
-- -----------------------------------------------------
CREATE TABLE detalle_pedido (
  id_detalle_pedido INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_pedido INT UNSIGNED NOT NULL,
  id_producto INT UNSIGNED NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(12,2) NULL DEFAULT NULL,
  PRIMARY KEY (id_detalle_pedido),
  UNIQUE INDEX uq_detalle_pedido (id_pedido ASC, id_producto ASC) ,
  INDEX idx_detalle_pedido_producto (id_producto ASC) ,
  CONSTRAINT fk_dp_pedido
    FOREIGN KEY (id_pedido)
    REFERENCES db_sigap.pedido (id_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_dp_producto
    FOREIGN KEY (id_producto)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.fase_pedido
-- -----------------------------------------------------
CREATE TABLE fase_pedido (
  id_fase_pedido INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_pedido INT UNSIGNED NOT NULL,
  id_estado_pedido TINYINT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_fase_pedido),
  INDEX idx_fase_pedido (id_pedido ASC, fecha_cambio ASC) ,
  INDEX idx_fase_pedido_estado (id_estado_pedido ASC) ,
  INDEX idx_fase_pedido_usuario (id_usuario ASC) ,
  CONSTRAINT fk_fase_pedido_pedido
    FOREIGN KEY (id_pedido)
    REFERENCES db_sigap.pedido (id_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_fase_pedido_estado
    FOREIGN KEY (id_estado_pedido)
    REFERENCES db_sigap.estado_pedido (id_estado_pedido)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_fase_pedido_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_empaquetado
-- -----------------------------------------------------
CREATE TABLE estado_empaquetado (
  id_estado_empaquetado TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_empaquetado),
  UNIQUE INDEX uq_estado_empaquetado_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.empaquetado
-- -----------------------------------------------------
CREATE TABLE empaquetado (
  id_empaquetado INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_detalle_pedido INT UNSIGNED NOT NULL,
  id_empleado INT UNSIGNED NOT NULL,
  id_asignador INT UNSIGNED NOT NULL,
  fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_empaquetado),
  UNIQUE INDEX uq_empaquetado_detalle (id_detalle_pedido ASC) ,
  INDEX idx_empaquetado_empleado (id_empleado ASC) ,
  INDEX idx_empaquetado_asignador (id_asignador ASC) ,
  CONSTRAINT fk_empaquetado_detalle
    FOREIGN KEY (id_detalle_pedido)
    REFERENCES db_sigap.detalle_pedido (id_detalle_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_empaquetado_empleado
    FOREIGN KEY (id_empleado)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_empaquetado_asignador
    FOREIGN KEY (id_asignador)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.fase_empaquetado
-- -----------------------------------------------------
CREATE TABLE fase_empaquetado (
  id_fase_empaquetado INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_empaquetado INT UNSIGNED NOT NULL,
  id_estado_empaquetado TINYINT UNSIGNED NOT NULL,
  fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_fase_empaquetado),
  INDEX idx_fase_empaquetado (id_empaquetado ASC, fecha_cambio ASC) ,
  INDEX idx_fase_empaquetado_estado (id_estado_empaquetado ASC) ,
  CONSTRAINT fk_fase_emp_empaquetado
    FOREIGN KEY (id_empaquetado)
    REFERENCES db_sigap.empaquetado (id_empaquetado)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_fase_emp_estado
    FOREIGN KEY (id_estado_empaquetado)
    REFERENCES db_sigap.estado_empaquetado (id_estado_empaquetado)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.movimiento_inventario
-- -----------------------------------------------------
CREATE TABLE movimiento_inventario (
  id_movimiento INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_producto INT UNSIGNED NOT NULL,
  id_tipo_movimiento TINYINT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  id_detalle_venta INT UNSIGNED NULL DEFAULT NULL,
  id_detalle_pedido INT UNSIGNED NULL DEFAULT NULL,
  cantidad INT NOT NULL,
  observacion VARCHAR(150) NULL DEFAULT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_movimiento),
  INDEX idx_mov_producto (id_producto ASC, fecha ASC) ,
  INDEX idx_mov_tipo (id_tipo_movimiento ASC) ,
  INDEX idx_mov_usuario (id_usuario ASC) ,
  INDEX idx_mov_detalle_venta (id_detalle_venta ASC) ,
  INDEX idx_mov_detalle_pedido (id_detalle_pedido ASC) ,
  CONSTRAINT fk_mov_producto
    FOREIGN KEY (id_producto)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_mov_tipo
    FOREIGN KEY (id_tipo_movimiento)
    REFERENCES db_sigap.tipo_movimiento (id_tipo_movimiento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_mov_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_mov_dventa
    FOREIGN KEY (id_detalle_venta)
    REFERENCES db_sigap.detalle_venta (id_detalle_venta)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_mov_dpedido
    FOREIGN KEY (id_detalle_pedido)
    REFERENCES db_sigap.detalle_pedido (id_detalle_pedido)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.tipo_ticket
-- -----------------------------------------------------
CREATE TABLE tipo_ticket (
  id_tipo_ticket TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_tipo_ticket),
  UNIQUE INDEX uq_tipo_ticket_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.estado_ticket
-- -----------------------------------------------------
CREATE TABLE estado_ticket (
  id_estado_ticket TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_estado_ticket),
  UNIQUE INDEX uq_estado_ticket_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.ticket
-- -----------------------------------------------------
CREATE TABLE ticket (
  id_ticket INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario INT UNSIGNED NOT NULL,
  id_tipo_ticket TINYINT UNSIGNED NOT NULL,
  id_estado_ticket TINYINT UNSIGNED NOT NULL,
  asunto VARCHAR(100) NOT NULL,
  descripcion TEXT NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  eliminado_en DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (id_ticket),
  INDEX idx_ticket_usuario (id_usuario ASC) ,
  INDEX idx_ticket_tipo (id_tipo_ticket ASC) ,
  INDEX idx_ticket_estado (id_estado_ticket ASC) ,
  CONSTRAINT fk_ticket_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_ticket_tipo
    FOREIGN KEY (id_tipo_ticket)
    REFERENCES db_sigap.tipo_ticket (id_tipo_ticket)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_ticket_estado
    FOREIGN KEY (id_estado_ticket)
    REFERENCES db_sigap.estado_ticket (id_estado_ticket)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.respuesta_ticket
-- -----------------------------------------------------
CREATE TABLE respuesta_ticket (
  id_respuesta_ticket INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_ticket INT UNSIGNED NOT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  respuesta TEXT NOT NULL,
  fecha_respuesta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_respuesta_ticket),
  INDEX idx_resp_ticket (id_ticket ASC) ,
  INDEX idx_resp_usuario (id_usuario ASC) ,
  CONSTRAINT fk_resp_ticket
    FOREIGN KEY (id_ticket)
    REFERENCES db_sigap.ticket (id_ticket)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_resp_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.puntuacion
-- -----------------------------------------------------
CREATE TABLE puntuacion (
  id_puntuacion INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_venta INT UNSIGNED NOT NULL,
  valor_estrellas TINYINT UNSIGNED NOT NULL,
  comentario VARCHAR(255) NULL DEFAULT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_puntuacion),
  UNIQUE INDEX uq_puntuacion_venta (id_venta ASC) ,
  CONSTRAINT fk_puntuacion_venta
    FOREIGN KEY (id_venta)
    REFERENCES db_sigap.venta (id_venta)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.tipo_notificacion
-- -----------------------------------------------------
CREATE TABLE tipo_notificacion (
  id_tipo_notificacion TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_tipo_notificacion),
  UNIQUE INDEX uq_tipo_notificacion_nombre (nombre ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table db_sigap.notificacion
-- -----------------------------------------------------
CREATE TABLE notificacion (
  id_notificacion INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_destinatario INT UNSIGNED NOT NULL,
  id_remitente INT UNSIGNED NULL DEFAULT NULL,
  id_tipo_notificacion TINYINT UNSIGNED NOT NULL,
  asunto VARCHAR(100) NOT NULL,
  mensaje TEXT NOT NULL,
  id_producto INT UNSIGNED NULL DEFAULT NULL,
  id_pedido INT UNSIGNED NULL DEFAULT NULL,
  id_venta INT UNSIGNED NULL DEFAULT NULL,
  id_ticket INT UNSIGNED NULL DEFAULT NULL,
  fecha_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  leida TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_notificacion),
  INDEX idx_notif_destinatario (id_destinatario ASC, leida ASC) ,
  INDEX idx_notif_remitente (id_remitente ASC) ,
  INDEX idx_notif_tipo (id_tipo_notificacion ASC) ,
  INDEX idx_notif_producto (id_producto ASC) ,
  INDEX idx_notif_pedido (id_pedido ASC) ,
  INDEX idx_notif_venta (id_venta ASC) ,
  INDEX idx_notif_ticket (id_ticket ASC) ,
  CONSTRAINT fk_notif_destinatario
    FOREIGN KEY (id_destinatario)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_remitente
    FOREIGN KEY (id_remitente)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_tipo
    FOREIGN KEY (id_tipo_notificacion)
    REFERENCES db_sigap.tipo_notificacion (id_tipo_notificacion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_producto
    FOREIGN KEY (id_producto)
    REFERENCES db_sigap.producto (id_producto)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_pedido
    FOREIGN KEY (id_pedido)
    REFERENCES db_sigap.pedido (id_pedido)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_venta
    FOREIGN KEY (id_venta)
    REFERENCES db_sigap.venta (id_venta)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_notif_ticket
    FOREIGN KEY (id_ticket)
    REFERENCES db_sigap.ticket (id_ticket)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;