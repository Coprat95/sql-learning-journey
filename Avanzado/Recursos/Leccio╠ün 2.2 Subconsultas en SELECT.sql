-- Muestra la popularidad de cada canción comparada con la máxima
SELECT 
    titulo,                               
    popularidad,                          
    ( SELECT MAX(popularidad) FROM Canciones    -- PRIMERO: Subconsulta que encuentra la máxima popularidad             
    ) as maxima_popularidad             
FROM Canciones;

-- Muestra cada canción y la compara con la duración promedio de todas las canciones
SELECT 
    titulo,
    duracion,
    (SELECT AVG(duracion) FROM Canciones   -- PRIMERO: Subconsulta que muestra duración promedio de todas las canciones
    ) as duracion_promedio 
FROM Canciones;

