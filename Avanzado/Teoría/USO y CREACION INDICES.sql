/*Desactivar y volver a activar (limpia los perfiles)
SET profiling = 0;
SET profiling = 1;
SHOW PROFILES;


🧼 SET profiling = 0;
- Desactiva temporalmente el perfilado.
- Esto borra el historial anterior para empezar de cero.
🔄 SET profiling = 1;
- Vuelve a activar el perfilado.
- A partir de aquí, MySQL empezará a guardar detalles sobre las siguientes consultas que ejecutes.
📊 SHOW PROFILES;
- Muestra una lista de todas las consultas recientes junto con:
- Su número de orden
- El texto SQL
- El tiempo total de ejecución (en segundos) */

-- 1 ÍNDICES SIMPLES: ----------------------------------
-- Son como el índice de un libro, pero para una sola columna
-- Útiles para búsquedas frecuentes en una columna específica
-- ----------------------------------------------

		-- Ejemplo 1 : Índice para búsqueda de canciones por título
-- SIN ÍNDICE : 
SELECT * 
FROM canciones
WHERE titulo = 'Despacito';
SHOW PROFILES;

-- CON ÍNDICE 
CREATE INDEX idx_canciones_titulo ON Canciones(titulo);  -- podría ser indice_canciones  ON tabla(columna)
														 -- lo que hace es que SQL los ordena y directamente se va a buscar por la letra D 
                                                         -- en vez de buscar cancion por cancion
SELECT *
FROM canciones
WHERE titulo = 'Despacito';
SHOW PROFILES;


-- 2.  ÍNDICES COMPUESTOS --------------------------
-- Son como índices que combinan MÚLTIPLES COLUMNAS
-- Útiles cuando frecuentemente buscamos usando varias columnas juntas

-- EJEMPLO 1: Índice para búsqueda de reproducciones por usuario y fecha
-- SIN INDICE
SELECT usuario_id, fecha_reproduccion
FROM reproducciones
WHERE usuario_id = 1 AND fecha_reproduccion > '2019-01-01';
SHOW PROFILES; -- 0,000999


-- CON INDICE
CREATE INDEX repro_usuario_fecha ON reproducciones(usuario_id,fecha_reproduccion);
SELECT usuario_id, fecha_reproduccion
FROM reproducciones 
WHERE usuario_id = 1 AND fecha_reproduccion > '2019-01-01';
SHOW PROFILES;  -- 0,0018


-- 3. ÍNDICES ÚNICOS -----------------
-- Garantizan que no haya valores duplicados en las columnas
-- Perfectos para datos que deben ser únicos como emails o códigos(DNI, nºSS, nº carnet conducir etc)

-- SIN ÍNDICE
SELECT * 
FROM usuarios
WHERE email = 'pedro.martinez@email.com';
SHOW PROFILES;  -- 0,016sec

-- CON ÍNDICE
CREATE UNIQUE INDEX indice_email ON usuarios(email);
SELECT * 
FROM usuarios
WHERE email = 'pedro.martinez@email.com';
SHOW PROFILES; -- 0,00 sec