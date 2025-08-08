-- Desactivar y volver a activar (limpia los perfiles)
SET profiling = 0;
SET profiling = 1;
SHOW PROFILES;

-- 1. ÍNDICES SIMPLES: -------------------------------------------------------------------------
-- Son como el índice de un libro, pero para una sola columna
-- Útiles para búsquedas frecuentes en una columna específica

		-- Ejemplo 1: Índice para búsqueda de canciones por título
        -- SIN INDICE
        SELECT * FROM Canciones WHERE titulo = 'Despacito';
        SHOW PROFILES;

        -- CON INDICE
		CREATE INDEX idx_canciones_titulo ON Canciones(titulo);
		SELECT * FROM Canciones WHERE titulo = 'Despacito';
		SHOW PROFILES;

         
-- 2. ÍNDICES COMPUESTOS: ----------------------------------------------------------------------
-- Son como índices que combinan múltiples columnas
-- Útiles cuando frecuentemente buscamos usando varias columnas juntas

		-- Ejemplo 1: Índice para búsqueda de reproducciones por usuario y fecha
        -- SIN INDICE
        SELECT * FROM Reproducciones WHERE usuario_id = 1 AND fecha_reproduccion > '2019-01-01';
         SHOW PROFILES;
         
        -- CON INDICE
		CREATE INDEX idx_repro_usuario_fecha ON Reproducciones(usuario_id, fecha_reproduccion);
		SELECT * FROM Reproducciones WHERE usuario_id = 1 AND fecha_reproduccion > '2019-01-01';
		SHOW PROFILES;
        
		-- Ejemplo 2: Índice para búsqueda de usuarios por país y fecha registro
        -- SIN INDICE
        SELECT * FROM Usuarios WHERE pais = 'México' AND fecha_registro >= '2018-01-01';
         SHOW PROFILES;
         
        -- CON INDICE
		CREATE INDEX idx_usuarios_pais_fecha ON Usuarios(pais, fecha_registro);
		SELECT * FROM Usuarios WHERE pais = 'México' AND fecha_registro >= '2018-01-01';
		SHOW PROFILES;

-- 3. ÍNDICES ÚNICOS:-----------------------------------------------------------------------------
-- Garantizan que no haya valores duplicados en las columnas
-- Perfectos para datos que deben ser únicos como emails o códigos

		-- Ejemplo 1: Índice único para emails de usuarios
        -- SIN INDICE
        SELECT * FROM Usuarios WHERE email = 'pedro.martinez@email.com';
         SHOW PROFILES;
         
        -- CON INDICE
		CREATE UNIQUE INDEX idx_usuarios_email ON Usuarios(email);
		SELECT * FROM Usuarios WHERE email = 'pedro.martinez@email.com';
		 SHOW PROFILES;

		-- Ejemplo 2: Índice único compuesto para nombre y artista de canción
        -- SIN INDICE
        SELECT * FROM Canciones WHERE titulo = 'Despacito' AND artista_id = 3;
         SHOW PROFILES;
         
        -- CON INDICE
		CREATE UNIQUE INDEX idx_cancion_nombre_artista ON Canciones(titulo, artista_id);
		SELECT * FROM Canciones WHERE titulo = 'Despacito' AND artista_id = 3;
         SHOW PROFILES;
         
-- COMO BORRAR UN INDICE
DROP INDEX idx_canciones_titulo ON canciones;