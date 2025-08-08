-- Muestra la canción más popular de toda la base de datos
SELECT DISTINCT 
    -- ORDER BY popularidad DESC: La más popular primero
    FIRST_VALUE(CONCAT(c.titulo, ' - popularidad: ', c.popularidad)) OVER (
        ORDER BY c.popularidad DESC
    ) as cancion_mas_popular_global
FROM Canciones c;


-- Esta consulta muestra la canción más popular de cada artista
SELECT DISTINCT 
    a.nombre as artista,
    -- PARTITION BY a.artista_id: Agrupa por artista
    FIRST_VALUE(CONCAT(c.titulo, ' - popularidad: ', c.popularidad)) OVER (
        PARTITION BY a.artista_id 
        ORDER BY c.popularidad DESC
    ) as cancion_mas_popular
FROM Artistas a
JOIN Canciones c ON a.artista_id = c.artista_id;




-- Muestra la canción menos popular de toda la base de datos
SELECT DISTINCT 
    -- ROWS BETWEEN...: Necesario para que LAST_VALUE vea todas las filas
    LAST_VALUE(CONCAT(c.titulo, ' - popularidad: ', c.popularidad)) OVER (
        ORDER BY c.popularidad DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as cancion_menos_popular_global
FROM Canciones c;

-- Esta consulta muestra la canción menos escuchada de cada género musical
SELECT DISTINCT 
    g.nombre as genero,
    -- ROWS BETWEEN...: Necesario para que LAST_VALUE vea todas las filas del grupo
    LAST_VALUE(CONCAT(c.titulo, ' - reproducciones: ', COUNT(*))) OVER (
        PARTITION BY g.genero_id 
        ORDER BY COUNT(*) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as cancion_menos_escuchada
FROM Generos g
JOIN Artistas a ON g.genero_id = a.genero_id
JOIN Canciones c ON a.artista_id = c.artista_id
JOIN Reproducciones r ON c.cancion_id = r.cancion_id
-- Agrupamos para poder contar reproducciones
GROUP BY g.genero_id, g.nombre, c.titulo;



-- Muestra la primera y última canción de cada artista con sus fechas
SELECT DISTINCT 
    -- Seleccionamos el nombre del artista
    a.nombre as artista,
    -- PARTITION BY a.artista_id: Agrupa los resultados por artista
    FIRST_VALUE(CONCAT(c.titulo, ' (', c.fecha_lanzamiento, ')')) OVER (
        PARTITION BY a.artista_id 
        ORDER BY c.fecha_lanzamiento
    ) as primera_cancion_y_fecha,
    -- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING:
    -- Esto es necesario para LAST_VALUE y significa:
    -- - UNBOUNDED PRECEDING: Considera desde la primera fila del grupo
    -- - UNBOUNDED FOLLOWING: Hasta la última fila del grupo
    LAST_VALUE(CONCAT(c.titulo, ' (', c.fecha_lanzamiento, ')')) OVER (
        PARTITION BY a.artista_id 
        ORDER BY c.fecha_lanzamiento 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as ultima_cancion_y_fecha
FROM Artistas a
JOIN Canciones c ON a.artista_id = c.artista_id;