-- Primero eliminamos índices existentes
DROP INDEX idx_canciones_titulo ON Canciones;
DROP INDEX idx_repro_usuario_fecha ON Reproducciones;
DROP INDEX idx_usuarios_pais_fecha ON Usuarios;
DROP INDEX idx_usuarios_email ON Usuarios;
DROP INDEX idx_cancion_nombre_artista ON Canciones;

-- 1. EXPLAIN Y ANALYZE BÁSICO: -------------------------------------------------------------------------
-- Análisis simple de una consulta
	-- Sin índice
	EXPLAIN SELECT * FROM Canciones WHERE titulo = 'Despacito';
    -- ANALISIS ------------------
-- (id = 1: )✅ CORRECTO: Indica una consulta simple sin subconsultas
-- (select_type = SIMPLE:) ✅ CORRECTO: Es una consulta directa sin uniones complejas
-- (table = Canciones:)✅ CORRECTO: Indica la tabla que se está consultando
-- (partitions = NULL:)✅ CORRECTO: Indica que la tabla no está particionada


-- (type = ALL:)❌ PROBLEMA: Está haciendo un escaneo completo de la tabla
				-- SOLUCIÓN: Crear índices en las columnas del WHERE
				-- ESPERADO: Debería ser 'ref' o 'range' usando índices


-- (possible_keys = NULL:) ❌ PROBLEMA: No hay índices disponibles para usar
						-- SOLUCIÓN: Crear índices en las columnas de búsqueda
						-- ESPERADO: Debería mostrar al menos un índice disponible


-- (key = NULL:) ❌ PROBLEMA: No se está usando ningún índice
				-- SOLUCIÓN: Asegurar que existan índices y la consulta los use
				-- ESPERADO: Debería mostrar el nombre del índice usado

-- (key_len = NULL:)❌ PROBLEMA: Indica que no se está usando ningún índice
					-- RAZÓN: Al no usar índice, no hay longitud de clave que mostrar
					-- ESPERADO: Debería mostrar un número que indica el tamaño en bytes del índice usado


-- (ref = NULL:)❌ PROBLEMA: Indica que no hay referencias a columnas o constantes para búsqueda
				-- RAZÓN: No se está usando ningún índice para comparaciones
				-- ESPERADO: Debería mostrar 'const' o el nombre de la columna usada para join

-- (rows = 40:)❌ PROBLEMA: Debe examinar todas las filas (40)
				-- SOLUCIÓN: Con índices, debería examinar menos filas
				-- ESPERADO: Con un buen índice, debería ser cercano al número real de resultados


-- (filtered = 10.00:) ❌ PROBLEMA: Solo 10% de filas son relevantes
						-- SOLUCIÓN: Usar índices para filtrar antes de leer los datos
						-- ESPERADO: Un porcentaje más alto indica mejor filtrado


-- (Extra = Using where:) ⚠️ ADVERTENCIA: Aplica filtro después de leer los datos
							-- SOLUCIÓN: Usar índices para filtrar durante la lectura
							-- ESPERADO: Debería mostrar "Using index" si usa índices correctamente
    
    
	-- Crear índice y analizar diferencia
	CREATE INDEX idx_canciones_titulo ON Canciones(titulo);
	EXPLAIN SELECT * FROM Canciones WHERE titulo = 'Despacito';
    EXPLAIN SELECT * FROM Canciones WHERE titulo = 'Despacito';
-- ANÁLISIS ------------------

-- (id = 1:) ✅ CORRECTO: Indica una consulta simple sin subconsultas

-- (select_type = SIMPLE:) ✅ CORRECTO: Es una consulta directa sin uniones complejas

-- (table = Canciones:) ✅ CORRECTO: Indica la tabla que se está consultando

-- (partitions = NULL:) ✅ CORRECTO: Indica que la tabla no está particionada

-- (type = ref:) ✅ CORRECTO: Está usando un índice para búsqueda por referencia
                -- INFO: 'ref' es eficiente para búsquedas por igualdad
                -- NOTA: Es uno de los mejores tipos de acceso

-- (possible_keys = idx_canciones_titulo:) ✅ CORRECTO: Muestra el índice disponible
                                        -- INFO: El optimizador puede usar este índice
                                        -- NOTA: Es bueno tener índices disponibles

-- (key = idx_canciones_titulo:) ✅ CORRECTO: Está usando el índice adecuado
                                -- INFO: El optimizador eligió usar este índice
                                -- NOTA: Coincide con possible_keys, lo cual es óptimo

-- (key_len = 1022:) ✅ CORRECTO: Muestra la longitud del índice usado
                    -- INFO: Indica que se está usando el índice completo
                    -- NOTA: Un valor numérico aquí confirma uso de índice

-- (ref = const:) ✅ CORRECTO: Usa una constante para la búsqueda
                -- INFO: Ideal para búsquedas por igualdad
                -- NOTA: 'const' indica comparación con valor constante

-- (rows = 1:) ✅ CORRECTO: Solo necesita examinar 1 fila
            -- INFO: Número óptimo para búsqueda por índice único
            -- NOTA: Indica que el índice es muy eficiente

-- (filtered = 100.00:) ✅ CORRECTO: Todas las filas examinadas son relevantes
                    -- INFO: 100% indica filtrado perfecto
                    -- NOTA: El mejor porcentaje posible

-- (Extra = NULL:) ✅ CORRECTO: No necesita procesamiento adicional
                -- INFO: Sin operaciones extra necesarias
                -- NOTA: Indica que la consulta es eficiente


    
    
    
    
    
-- ------------------------------------------------------------------
-- 2. EXPLAIN Y ANALYZE CON JOINS: --------------------------------------------------------------------
-- Análisis de consultas con uniones de tablas
EXPLAIN ANALYZE 
SELECT u.nombre, c.titulo, r.fecha_reproduccion
FROM Usuarios u
JOIN Reproducciones r ON u.usuario_id = r.usuario_id
JOIN Canciones c ON r.cancion_id = c.cancion_id
WHERE r.fecha_reproduccion >= '2024-01-01';

-- ANÁLISIS ------------------
-- Primer nivel de JOIN:
-- -> Nested loop inner join  (cost=23.58 rows=23) (actual time=0.122..0.819 rows=70 loops=1)
		-- ❌ PROBLEMA: 
			-- Costo estimado: 23.58
			-- Filas estimadas: 23
			-- Filas reales: 70
			-- Tiempo: 0.122 a 0.819 ms
		-- ANÁLISIS:
			-- La estimación de filas está muy por debajo de la realidad (23 vs 70)
			-- Indica que las estadísticas de la tabla podrían estar desactualizadas
		-- SOLUCIÓN:
			-- Actualizar estadísticas: ANALYZE TABLE
			-- Crear índices compuestos

-- Segundo nivel de JOIN:
-- -> Nested loop inner join  (cost=15.42 rows=23) (actual time=0.109..0.535 rows=70 loops=1)
		-- ❌ PROBLEMA:
			-- Similar discrepancia en la estimación
			-- El costo es menor pero sigue siendo alto
		-- ANÁLISIS:
			-- Mejor tiempo de ejecución que el primer JOIN
			-- Pero misma discrepancia en filas
		-- SOLUCIÓN:
			-- Crear índice compuesto en (usuario_id, fecha_reproduccion)

-- Filtro de fecha:
-- -> Filter: ((r.fecha_reproduccion >= TIMESTAMP'2024-01-01 00...)
		-- ⚠️ ADVERTENCIA:
			-- El filtro se aplica después de los JOINs
		-- SOLUCIÓN:
			-- Crear índice en fecha_reproduccion
			-- Mover el filtro antes de los JOINs usando CTE


-- OPTIMIZACIÓN RECOMENDADA:
-- 1. Actualizar estadísticas
ANALYZE TABLE Reproducciones, Usuarios, Canciones;

-- 2. Crear índices necesarios
CREATE INDEX idx_repro_fecha_usuario ON Reproducciones(fecha_reproduccion, usuario_id);
CREATE INDEX idx_repro_cancion ON Reproducciones(cancion_id);

-- 3. Reescribir la consulta usando CTE
EXPLAIN ANALYZE
WITH ReproduccionesRecientes AS (
    SELECT * FROM Reproducciones 
    WHERE fecha_reproduccion >= '2024-01-01'
)
SELECT u.nombre, c.titulo, r.fecha_reproduccion
FROM ReproduccionesRecientes r
JOIN Usuarios u ON r.usuario_id = u.usuario_id
JOIN Canciones c ON r.cancion_id = c.cancion_id;


-- -> Nested loop inner join (cost=56.25 rows=70) (actual time=0.066..0.556 rows=70 loops=1)
   -- ✅ CORRECTO:
       -- La estimación de filas coincide exactamente con la realidad (70 vs 70)
       -- Indica que las estadísticas están actualizadas gracias al ANALYZE TABLE
       -- Tiempo de ejecución reducido en un 32%


-- -> Nested loop inner join (cost=31.75 rows=70) (actual time=0.059..0.358 rows=70 loops=1)
   -- ✅ CORRECTO:
       -- El JOIN anidado es eficiente
       -- La estimación coincide con la realidad
       -- Mejor rendimiento gracias a los índices

-- -> Filter: (reproducciones.fecha_reproduccion >= TIMESTAMP'...)
   -- ✅ CORRECTO:
       -- Filtrado eficiente gracias al índice
       -- Se reduce el conjunto de datos antes de los JOINs











    
    
    
    
    
    


