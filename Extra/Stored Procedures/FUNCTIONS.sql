-- FUNCTIONS & PROCEDURES

-- FUNCTIONS
/*
Bloque de código reutilizable que realiza
una operación y devuelve un resultado.
Como los métodos / funciones en JAVA. 

SINTAXIS BÁSICA: 

CREATE [OR REPLACE] FUNCTION nombre_funcion(parámetros)
RETURNS tipo_de_dato
LANGUAGE plpgsql
AS $$
DECLARE
  -- Declaración de variables (opcional)
BEGIN
  -- Cuerpo de la función
  RETURN valor;
END;
$$;

Ejemplo sencillo:  función sumar dos números

*/
CREATE OR REPLACE FUNCTION suma (a INT, b INT )
RETURNS INT
LANGUAGE plpgsql
AS $$
	-- DECLARE ( no declaramos variables aquí)
	BEGIN 
		RETURN a + b;
	END;
	$$;

SELECT suma(3,5);

-- Función de cálculo de total con IVA

CREATE OR REPLACE FUNCTION calcular_prod_iva(
v_prod DECIMAL, base_iva DECIMAL DEFAULT 0.21)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
	BEGIN  -- Todo entre begin end debe ir con ;
		RETURN ROUND (v_prod * (1 + base_iva ),2);
	END;
	$$;
SELECT calcular_prod_iva (100.00);

-- 1:  Función para dar de alta un cliente,
debe manejar errores y devolver el id generado.
*/
CREATE OR REPLACE FUNCTION dar_de_alta (
c_nombre VARCHAR(20),
c_apellido VARCHAR(20),
c_direccion TEXT,
c_telefono VARCHAR(20)
) RETURNS INT
LANGUAGE plpgsql
AS $$
	DECLARE c_id INT;
	BEGIN 
	INSERT INTO clientes(nombre,apellido,direccion,telefono) VALUES
				(c_nombre,c_apellido,c_direccion,c_telefono)
				RETURNING id INTO c_id;
	RETURN c_id;
	-- Lanzamos excepcion cuando ocurra cualquier otra cosa
	EXCEPTION WHEN OTHERS THEN 
	-- Mensaje + $(contiene SQLERRM [mensaje del error generado])
	RAISE NOTICE 'El alta de cliente no se pudo realizar : %', SQLERRM;
	RETURN NULL;
	END;
$$;

-- SELECT dar_de_alta('Oliver','Trave','calle Jaume casanovas','689633333');


/* borramos, no queremos utilizar este cliente
DELETE 
FROM clientes 
WHERE id = 28;

SELECT * FROM clientes;  */


