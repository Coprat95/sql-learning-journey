-- Si la canción no tiene calificación, muestra 'Sin clasificacion'
SELECT 
    c.titulo as cancion,
    COALESCE(r.calificacion, 'clasificacion nula') as calificacion
FROM Reproducciones r
LEFT JOIN Canciones c ON r.cancion_id = c.cancion_id;


-- Muestra el nombre del artista (pero Bad Bunny aparece como NULL)
SELECT 
    NULLIF(a.nombre, 'Prince Royce') as artista_filtrado,
    c.titulo as cancion
FROM Artistas a
LEFT JOIN Canciones c ON a.artista_id = c.artista_id;



-- Muestra todas las canciones EXCEPTO las de Bad Bunny, con su información.
SELECT 
    c.titulo as cancion,
    -- Manejo del artista
    COALESCE(NULLIF(a.nombre, 'Bad Bunny'), 'Artista Vetado') as artista,
    -- Manejo de calificación
    COALESCE(r.calificacion, 'Sin calificación') as calificacion,
    -- Manejo de popularidad
    CASE 
        WHEN c.popularidad > 80 THEN 'Alta'
        WHEN c.popularidad > 50 THEN 'Media'
        ELSE 'Baja'
    END as popularidad,
    -- Conteo de reproducciones
    COUNT(r.reproduccion_id) as total_reproducciones,
    -- Promedio de tiempo escuchado
    COALESCE(AVG(r.tiempo_escuchado), 0) as promedio_tiempo_escuchado
FROM Canciones c
LEFT JOIN Artistas a ON c.artista_id = a.artista_id
LEFT JOIN Reproducciones r ON c.cancion_id = r.cancion_id
GROUP BY 
    c.titulo,
    a.nombre,
    c.popularidad,
    r.calificacion;