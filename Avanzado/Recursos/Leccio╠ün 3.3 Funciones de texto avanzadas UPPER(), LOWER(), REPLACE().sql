USE SpotifySimulator;

-- Convierte nombres de canciones a mayúsculas
SELECT 
    titulo,
    UPPER(titulo) as titulo_mayusculas
FROM Canciones;

-- Convierte nombres de artistas a minúsculas
SELECT 
    nombre,
    LOWER(nombre) as nombre_minusculas
FROM Artistas;


-- Reemplaza espacios por guiones en títulos
SELECT 
    titulo,
    REPLACE(titulo, ' ', '-') as titulo_con_guiones
FROM Canciones;


-- Limpia datos para mejor uso
SELECT 
    titulo as titulo_original,
    -- Versión en mayúsculas del título limpio
    UPPER(  -- Pone en mayuscua todo
				REPLACE(
							REPLACE(
										REPLACE(
											titulo,
											'Anio', 'Año'   -- Quita guiones
										),
								'.', ''  -- Quita puntos
							),
					'/', ' ' -- Reemplaza / por espacio
				)
    ) as titulo_mayusculas
FROM Canciones;
-- "Atrévete-te-te"  → "ATREVETE TE TE"
-- "2/Catorce"  → "2 CATORCE"
-- "El Mambo No. 5" → "EL MAMBO NO 5" 

