








-- PROCEDURES

/* 
Podríamos verlo como los métodos void del JAVA
Bloque de código que se guarda en la BDD y se 
invoca por código.

ESTRUCTURA BÁSICA : 

CREATE PROCEDURE nombre_procedimiento(parámetros)
LANGUAGE plpgsql
AS $$     
BEGIN
    -- Código SQL
END;
$$;

*/

-- PROCEDIMIENTO para añadir un cliente nuevo:

CREATE OR REPLACE PROCEDURE alta_cliente (
c_nombre VARCHAR(20),
c_apellido VARCHAR(20),
c_direccion TEXT,
c_telefono VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
	BEGIN
		INSERT INTO clientes (nombre,apellido,direccion,telefono) VALUES
		(c_nombre ,c_apellido ,c_direccion ,c_telefono);
		RAISE NOTICE 'El alta del cliente se ha realizado correctamente';
		EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'El alta del cliente no se ha podido realizar : %', SQULERRM;
	END;
$$;
-- LLAMAMOS A LAS PROCEDURES CON CALL PARA EJECUTARLAS
 CALL  alta_cliente('Oliver','Trave','Calle Jaume C','689645555');
	
-- SELECT * FROM clientes;
-- DELETE from clientes where nombre = 'Oliver';

-- ________________________________________________________________
-- _____________
/* Ejercicio 2:  Procedimiento para registrar una venta
Este PROCEDURE gestiona la transacción completa: 
comprueba stock, actualiza inventario e inserta la venta. */

CREATE OR REPLACE PROCEDURE registro_venta(
v_cliente_id INT,
v_producto_id INT,
v_fecha_venta TIMESTAMP,
v_cantidad INT

)
LANGUAGE plpgsql
AS $$
	DECLARE 
	v_precio DECIMAL(10,2);
	v_inventario INT;
	v_total DECIMAL(10,2);
	BEGIN
		-- Consultamos el precio y stock del producto
		SELECT precio,inventario
		-- lo volcamos en otras dos variables
		INTO v_precio, v_inventario
		FROM productos
		WHERE id = v_producto_id;

		IF 
			v_inventario >= v_cantidad THEN
			UPDATE productos
			SET inventario = inventario - v_cantidad
			WHERE id=v_producto_id;
			-- Calculamos total de la venta
			v_total = v_precio * v_cantidad;
			-- Insertamos la venta
			INSERT INTO ventas(cliente_id,producto_id,fecha_venta,cantidad,total)
			VALUES(
			v_cliente_id, v_producto_id, v_fecha_venta, v_cantidad,v_total);
			
			RAISE NOTICE ' Se ha completado la venta por valor de % €.', v_total;
		ELSE 
			RAISE NOTICE ' Stock insuficiente. No se ha podido completar la venta .';
		END IF;		
	END;
$$;


-- CALL registro_venta(14,6,'2025-08-06 14:00:00',2 );
-- SELECT * FROM clientes;
-- SELECT * FROM productos;