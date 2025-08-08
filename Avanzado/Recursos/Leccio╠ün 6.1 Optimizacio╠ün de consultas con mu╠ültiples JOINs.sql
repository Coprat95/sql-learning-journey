-- Unir primero las tablas más pequeñas 
-- Mostrar los géneros musicales, artistas y títulos de las canciones que se han reproducido desde 2024 ---------------------------
SELECT COUNT(*) from Generos; -- 20
SELECT COUNT(*) from Artistas; -- 30
SELECT COUNT(*) from Canciones; -- 45
SELECT COUNT(*) from Reproducciones; -- 70

SELECT COUNT(*)
FROM Generos g -- 20 
JOIN Artistas a ON g.genero_id = a.genero_id; -- 30 = 50

-- ❌ NO OPTIMIZADO (empieza con tabla grande):
SELECT g.nombre as genero, a.nombre as artista, c.titulo
FROM Reproducciones r -- 70
JOIN Canciones c ON r.cancion_id = c.cancion_id -- 70
JOIN Artistas a ON c.artista_id = a.artista_id -- 70
JOIN Generos g ON a.genero_id = g.genero_id -- 70
WHERE r.fecha_reproduccion >= '2024-01-01'; -- 280


-- ✅ OPTIMIZADO (empieza con tablas pequeñas):
SELECT *
FROM Generos g -- 20
JOIN Artistas a ON g.genero_id = a.genero_id  -- 30
JOIN Canciones c ON a.artista_id = c.artista_id -- 45
JOIN Reproducciones r ON c.cancion_id = r.cancion_id -- 70
WHERE r.fecha_reproduccion >= '2024-01-01'; -- 165 --



-- --------------------------------------------------
-- Seleccionar solo las columnas necesarias, evitar SELECT *  
-- Mostrar qué usuarios han escuchado qué canciones y cuándo----------------------------


-- ❌ NO OPTIMIZADO (SELECT *):
SELECT *
FROM Usuarios u
JOIN Reproducciones r ON u.usuario_id = r.usuario_id
JOIN Canciones c ON r.cancion_id = c.cancion_id;


-- ✅ OPTIMIZADO (solo columnas necesarias):
SELECT 
    u.nombre as usuario,
    c.titulo as cancion,
    r.fecha_reproduccion
FROM Usuarios u
JOIN Reproducciones r ON u.usuario_id = r.usuario_id
JOIN Canciones c ON r.cancion_id = c.cancion_id;




-- -------------------------------------------------
-- Filtrar datos lo antes posible, WHERE antes de JOIN 
-- Mostrar las canciones de artistas colombianos que se han reproducido desde 2018-------------

SELECT COUNT(*) from Artistas; -- 30
SELECT COUNT(*) from Canciones; -- 45
SELECT COUNT(*) from Reproducciones; -- 70

-- ❌ NO OPTIMIZADO (filtro después de JOINs):
SELECT DISTINCT 
    a.nombre, 
    c.titulo, 
    r.fecha_reproduccion
FROM Artistas a -- 30
JOIN Canciones c ON a.artista_id = c.artista_id  -- 45
JOIN Reproducciones r ON c.cancion_id = r.cancion_id -- 70
WHERE a.pais = 'Colombia' -- 145
AND r.fecha_reproduccion >= '2018-01-01'
GROUP BY c.titulo  ;


-- ✅ OPTIMIZADO (filtro antes de JOINs usando CTE):
WITH ArtistasColombiano AS (
    SELECT artista_id, nombre
    FROM Artistas
    WHERE pais = 'Colombia'
),
PrimeraReproduccion AS (
    SELECT DISTINCT 
        cancion_id, 
        MIN(fecha_reproduccion) as fecha_reproduccion
    FROM Reproducciones
    WHERE fecha_reproduccion >= '2018-01-01'
    GROUP BY cancion_id
)
SELECT 
    a.nombre,
    c.titulo,
    r.fecha_reproduccion
FROM ArtistasColombiano a
JOIN Canciones c ON a.artista_id = c.artista_id
JOIN PrimeraReproduccion r ON c.cancion_id = r.cancion_id;

