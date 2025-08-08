/*
----------------TRIGGERS

🧠 ¿Qué es un trigger (repaso rápido)?
Un trigger es un bloque de código que se ejecuta automáticamente cuando
ocurre un evento (INSERT, UPDATE o DELETE) en una tabla.

🔹 BEFORE: se ejecuta antes de que se haga la operación.
🔹 AFTER: se ejecuta después de que se haga la operación.

USOS---

----BEFORE----
-Validar datos entrantes
-Rellenar campos calculados o normalizar valores
-Cancelar una operación si no cumple las reglas

----AFTER-----
-Auditar cambios en otra tabla.
-Sincronizar datos relacionados(actualizar stock)
-Lanzar tareas externas ( enviar un correo,
publicar un mensaje en una cola de mensajeria..)

-- EJEMPLO PRÁCTICO
BEFORE INSERT en ventas para calcular el total automáticamente
AFTER INSERT en ventas para descontar stock de productos


----- BEFORE INSERT----
-- Función que calcula el total de un producto


-- EJERCICIO: Crea una función que usa un TRIGGER 
para calcular el valor total de una venta. */

-- Paso 1: Creamos la función que calcule el total:
CREATE OR REPLACE FUNCTION fn_calc_total_venta()-- no ponemos parámetros
RETURNS TRIGGER -- disparará el trigger
LANGUAGE plpgsql
AS $$ 
DECLARE
precio_prod DECIMAL(10,2); -- variable guardar precio producto
BEGIN 
	SELECT precio INTO precio_prod
	FROM productos 
	WHERE id = NEW.producto_id; --  nueva fila producto_id que entrará cuando se ejecute un insert/update.
	-- Ahora calculamos el valor de la venta
	NEW.total := ROUND(precio_prod * NEW.cantidad ,2); -- new.cantidad llegará a través del insert/update
	RETURN NEW; -- devolvemos la fila modificada con el valor ya calculado
END;
$$;

-- Paso 2: Creamos el TRIGGER que use esta funcion:
CREATE TRIGGER trg_calc_total_venta
BEFORE INSERT ON ventas -- se ejecuta antes de que se inserte una fila en ventas. 
FOR EACH ROW -- se dispara una vez por cada fila individual que se inserte . ( 1 vez por un producto, 2 veces por dos productos etc)
EXECUTE FUNCTION fn_calc_total_venta(); -- se utilizará esta función

-- Paso 3: Ejemplo de uso

INSERT INTO ventas (cliente_id , producto_id, cantidad,fecha_venta)
VALUES (13,5,3,NOW()) ;


--select * FROM ventas;
--select * FROM productos;


-- ______________________________________________________________

-- AFTER INSERT -------------------

/* EJERCICIO : 
- Crear un trigger para actualizar el inventario tras una venta
 
Crea una función en PL/pgSQL que:
- Reciba los datos de la nueva venta.
- Reste la cantidad vendida del campo stock del producto correspondiente.
- Crea un trigger que:
- Se dispare después de insertar una nueva fila en la tabla ventas.
- Ejecute la función que actualiza el inventario. */


-- 1. Creación de la función que actualiza el stock tras una venta
CREATE OR REPLACE FUNCTION fn_actualizar_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
stock_actual INT;
BEGIN

  -- Comprobar que el stock actual es mayor que la cantidad pedida
  
	SELECT inventario INTO stock_actual
	FROM productos
	WHERE id = NEW.producto_id;

	  IF NEW.cantidad > stock_actual THEN 
	  RAISE EXCEPTION 'La cantidad pedida es mayor al Stock actual. Ha pedido % y el stock es de %.',NEW.cantidad, stock_actual;
	  END IF;
  -- Reducir el inventario del producto vendido
  -- NEW.cantidad representa la cantidad vendida en la nueva fila insertada en ventas
	  UPDATE productos
	  SET inventario = inventario - NEW.cantidad 
	  WHERE id = NEW.producto_id;  -- NEW.producto_id refiere al producto asociado a esta venta

  -- Es fundamental retornar NEW para que la inserción de la venta se complete correctamente
  RETURN NEW;
END;
$$;

-- 2. Creación del trigger que activa la función justo después de insertar una venta
CREATE OR REPLACE TRIGGER trg_actualizar_stock
AFTER INSERT ON ventas       -- Se dispara tras insertar una nueva fila en ventas
FOR EACH ROW                 -- Se ejecuta por cada fila insertada
EXECUTE FUNCTION fn_actualizar_stock();



-- ______________________________________________

-- Función que corrige stock tras UPDATE en ventas

CREATE OR REPLACE FUNCTION fn_stock_update()
  RETURNS TRIGGER
  LANGUAGE plpgsql
AS $$
BEGIN
  

  IF OLD.producto_id <> NEW.producto_id THEN
    -- Caso 1: cambio de producto
    -- devolver stock al producto antiguo
    UPDATE productos
      SET inventario = inventario + OLD.cantidad
    WHERE id = OLD.producto_id;

    -- restar stock al nuevo producto
    UPDATE productos
      SET inventario = inventario - NEW.cantidad
    WHERE id = NEW.producto_id;

  ELSE
    -- Caso 2: misma fila, varía solo la cantidad
    UPDATE productos
      SET inventario = inventario + OLD.cantidad - NEW.cantidad
    WHERE id = NEW.producto_id;
  END IF;

  RETURN NEW;
END;
$$;

-- Trigger que llama a la función tras cada UPDATE en ventas
CREATE OR REPLACE TRIGGER trg_stock_update
  AFTER UPDATE ON ventas
  FOR EACH ROW
  EXECUTE FUNCTION fn_stock_update();


2. Ejemplo de trigger AFTER DELETE
Objetivo: al borrar una venta, devolver la cantidad vendida al inventario.


-- Función que devuelve stock tras DELETE en ventas
CREATE OR REPLACE FUNCTION fn_stock_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE productos
    SET inventario = inventario + OLD.cantidad
  WHERE id = OLD.producto_id;

  RETURN OLD;
END;
$$;

-- Trigger que llama a la función tras cada DELETE en ventas
CREATE OR REPLACE TRIGGER trg_stock_delete
AFTER DELETE ON ventas
FOR EACH ROW
EXECUTE FUNCTION fn_stock_delete();
