-- OPTIMIZACIÓN DE CONSULTAS con MÚLTIPLES JOIN

-- Unir primero las tablas mas pequeñas
-- Seleccionar las columnas necesarias, evitar en lo posible el SELECT(*)
-- Filtrar datos lo antes posible (WHERE antes que JOIN usando CTEs)

-- 1 : Mostrar todos los géneros musicales, artistas y títulos de las canciones que se han reprducido desde 2024

SELECT COUNT(*) from Generos;    -- 20 
SELECT COUNT(*) from Artistas;   -- 30
SELECT COUNT(*) FROM Canciones;  -- 45
SELECT COUNT(*) FROM Reproducciones;  -- 70

SELECT COUNT(*)
FROM Generos g -- 20 
JOIN Artistas a ON g.genero_id = a.genero_id; -- 30  = 50 en el BUFFER 

-- X NO OPTIMIZADO (Empieza con la tabla mas grande):

SELECT g.nombre AS genero,
 a.nombre AS artista,
 c.titulo
 FROM reproducciones r -- 70
 JOIN canciones c ON r.cancion_id = c.cancion_id -- 70
 JOIN artistas a ON c.artista_id = a.artista_id -- 70
 JOIN generos g ON a.genero_id = g.genero_id  -- 70
 WHERE r.fecha_reproduccion >= '2024-01-01'; --  total espacio en buffer utilizado de filas 280

-- OPTIMIZADO (empieza con tablas pequeñas)
SELECT g.nombre AS genero,
a.nombre AS artista,
c.titulo 
FROM generos g 
JOIN artistas a ON g.genero_id = a.genero_id		
JOIN canciones c ON a.artista_id = c.artista_id
JOIN reproducciones r ON c.cancion_id = r.cancion_id
WHERE r.fecha_reproduccion >= '2024-01-01'; -- total espacio en buffer utilizado 165 ( 20+30+45+70)


-- NO OPTIMIZADO (SELECT*) : 
SELECT * 
FROM usuarios u
JOIN reproducciones r ON u.usuario_id = r.usuario_id
JOIN canciones c ON r.cancion_id = c.cancion_id;

-- OPTIMIZADO (solo columnas necesarias)
SELECT
	u.nombre AS usuario,
    c.titulo AS cancion,
    r.fecha_reproduccion
FROM usuarios u 
JOIN reproducciones r ON u.usuario_id = r.usuario_id
JOIN canciones c ON r.cancion_id = c.cancion_id;


-- OTRO EJEMPLO 
-- Canciones reproducidas de artistas colombianos a partir del 1 de enero de 2018

-- X NO OPTIMIZADO (filtro después de JOINs):
SELECT DISTINCT
    a.nombre,
    c.titulo,
    r.fecha_reproduccion
FROM Artistas a -- 30
JOIN Canciones c ON a.artista_id = c.artista_id -- 45
JOIN Reproducciones r ON c.cancion_id = r.cancion_id -- 70
WHERE a.pais = 'Colombia' -- 145											-- total 145 filas usadas en el buffer 
AND r.fecha_reproduccion >= '2018-01-01'
GROUP BY c.titulo ;

-- OPTIMIZADO (filtro antes de JOINs usando CTE):
WITH ArtistasColombiano AS (              -- Primero haces una CTE para filtrar ya la cantidad de artistas de 30 a 5. 
    SELECT artista_id, nombre
    FROM Artistas
    WHERE pais = 'Colombia'
), -- 5
PrimeraReproduccion AS (				  -- Despues hace una segunda CTE para filtrar la cantidad de reproducciones posteriores al 2018-01-01
    SELECT DISTINCT
        cancion_id,
        MIN(fecha_reproduccion) as fecha_reproduccion
    FROM Reproducciones
    WHERE fecha_reproduccion >= '2018-01-01'
    GROUP BY cancion_id
) -- 40
SELECT
    a.nombre,
    c.titulo,
    r.fecha_reproduccion
FROM ArtistasColombiano a -- 5
JOIN Canciones c ON a.artista_id = c.artista_id -- 45
JOIN PrimeraReproduccion r ON c.cancion_id = r.cancion_id; -- 40
-- 90																				-- total 90 filas hemos usado en el buffer










