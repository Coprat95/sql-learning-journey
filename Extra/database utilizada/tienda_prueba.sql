-- Creación de tablas clientes, productos, ventas
CREATE TABLE clientes(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nombre VARCHAR(20),
apellido VARCHAR(20),
direccion TEXT,
telefono VARCHAR(15)
);

CREATE TABLE productos(
id 	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nombre VARCHAR(40),
descripcion TEXT,
precio DECIMAL(10,2) NOT NULL 
					 CHECK (precio >= 0),
inventario INT NOT NULL DEFAULT 0
);

CREATE TABLE ventas(
venta_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
cliente_id INT  NOT NULL REFERENCES clientes(id),
producto_id INT NOT NULL REFERENCES productos(id),
fecha_venta TIMESTAMP NOT NULL DEFAULT NOW(),
cantidad INT NOT NULL CHECK (cantidad>0),
total DECIMAL(10,2) NOT NULL CHECK (total>=0)
ALTER TABLE productos
ALTER COLUMN nombre TYPE VARCHAR(50);
-- Añadimos los valores a las tablas
INSERT INTO clientes
(nombre,apellido,direccion,telefono) VALUES
('Laura', 'Gómez', 'Calle Mayor 12, Madrid', '+34 612345678'),
('David', 'Martínez', 'Av. Andalucía 45, Sevilla', '+34 689123456'),
('María', 'Sánchez', 'Carrer del Sol 3, Barcelona', '+34 634789012');

INSERT INTO productos 
(nombre,descripcion,precio,inventario) VALUES
('Auriculares Bluetooth', 'Modelo con cancelación de ruido', 59.99, 100),
('Teclado Mecánico', 'Switches rojos y retroiluminación RGB', 89.90, 50),
('Monitor 27"', 'Pantalla 4K para uso profesional', 299.00, 25);

-- Añadimos ejemplos de ventas
-- David (id = 14) compra 2 monitores (id = 6)
INSERT INTO ventas (cliente_id, producto_id, cantidad, total)
VALUES (14, 6, 2, 299.00 * 2);

-- Laura (id = 13) compra 1 teclado mecánico (id = 5)
INSERT INTO ventas (cliente_id, producto_id, cantidad, total)
VALUES (13, 5, 1, 89.90 * 1);

-- María (id = 15) compra 3 auriculares bluetooth (id = 4)
INSERT INTO ventas (cliente_id, producto_id, cantidad, total)
VALUES (15, 4, 3, 59.99 * 3);
