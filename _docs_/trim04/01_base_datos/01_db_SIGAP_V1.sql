
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
  direccion VARCHAR(120) NOT NULL,
  estado TINYINT(1) NOT NULL DEFAULT 1,
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
-- Table db_sigap.producto
-- -----------------------------------------------------
CREATE TABLE producto (
  id_producto INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_categoria INT UNSIGNED NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  descripcion VARCHAR(150) NULL DEFAULT NULL,
  precio DECIMAL(12,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  estado TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id_producto),
  UNIQUE INDEX uq_producto_nombre (nombre ASC) ,
  INDEX idx_producto_categoria (id_categoria ASC) ,
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (id_categoria)
    REFERENCES db_sigap.categoria (id_categoria)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
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
-- Table db_sigap.venta
-- -----------------------------------------------------
CREATE TABLE venta (
  id_venta INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_cliente INT UNSIGNED NOT NULL,
  id_vendedor INT UNSIGNED NOT NULL,
  id_estado_venta TINYINT UNSIGNED NOT NULL,
  fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  direccion_entrega VARCHAR(120) NULL DEFAULT NULL,
  PRIMARY KEY (id_venta),
  INDEX idx_venta_cliente (id_cliente ASC) ,
  INDEX idx_venta_vendedor (id_vendedor ASC) ,
  INDEX idx_venta_estado (id_estado_venta ASC) ,
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
-- Table db_sigap.puntuacion
-- -----------------------------------------------------
CREATE TABLE puntuacion (
  id_puntuacion INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_venta INT UNSIGNED NOT NULL,
  valor_estrellas TINYINT UNSIGNED NOT NULL,
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
-- Table db_sigap.producto_rechazado
-- -----------------------------------------------------
CREATE TABLE producto_rechazado (
  id_producto_rechazado INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_detalle_venta INT UNSIGNED NOT NULL,
  cantidad_rechazada INT NOT NULL,
  motivo VARCHAR(150) NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_producto_rechazado),
  INDEX idx_rechazado_detalle (id_detalle_venta ASC) ,
  CONSTRAINT fk_rechazado_detalle
    FOREIGN KEY (id_detalle_venta)
    REFERENCES db_sigap.detalle_venta (id_detalle_venta)
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
  id_proveedor INT UNSIGNED NOT NULL,
  id_empleado INT UNSIGNED NOT NULL,
  fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  direccion_entrega VARCHAR(120) NOT NULL,
  PRIMARY KEY (id_pedido),
  INDEX idx_pedido_proveedor (id_proveedor ASC) ,
  INDEX idx_pedido_empleado (id_empleado ASC) ,
  CONSTRAINT fk_pedido_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES db_sigap.usuario (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_empleado
    FOREIGN KEY (id_empleado)
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
  precio_unitario DECIMAL(12,2) NOT NULL,
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
  fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_fase_pedido),
  INDEX idx_fase_pedido (id_pedido ASC, fecha_cambio ASC) ,
  INDEX idx_fase_estado (id_estado_pedido ASC) ,
  CONSTRAINT fk_fase_pedido
    FOREIGN KEY (id_pedido)
    REFERENCES db_sigap.pedido (id_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_fase_estado
    FOREIGN KEY (id_estado_pedido)
    REFERENCES db_sigap.estado_pedido (id_estado_pedido)
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