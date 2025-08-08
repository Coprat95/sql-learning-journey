/* VISTAS 
Se utilizan para realizar consultas recurrentes. 
Que clientes tengo ?  En vez de tener que escribirla cada vez, invocas a la 
vista y ya está. 

✅ ¿Qué es una vista?
Una vista (o view) es como una tabla virtual que no almacena datos 
por sí misma, sino que muestra datos que provienen de una o más tablas reales.

Es como una consulta SQL guardada que puedes reutilizar.

Puedes hacer SELECT sobre ella como si fuera una tabla.

Pero no ocupa espacio físico (a menos que sea una materialized view).
🛠️ ¿Cómo se crea una vista?
*/
CREATE VIEW nombre_de_la_vista AS
SELECT columnas
FROM tabla
[WHERE condiciones];

_______________________________________________-

-- Ejemplo  : quieres una vista que muestre
-- el nombre del cliente con el total gastado:
CREATE VIEW total_gasto_cliente AS 
SELECT 
c.nombre,
c.apellido,
SUM (v.total) AS total_gastado
FROM clientes c 
JOIN ventas v ON c.id = v.cliente_id
GROUP BY c.nombre,c.apellido;

--Llamamos así a la vista. 
SELECT *
FROM total_gasto_cliente