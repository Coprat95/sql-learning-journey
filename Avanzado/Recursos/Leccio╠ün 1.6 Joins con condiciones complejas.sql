use spotifysimulator;

-- Muestra canciones con popularidad superior a 93 (hits/éxitos)
-- Utiliza INNER JOIN para asegurar que solo se muestren canciones que tienen tanto artista como género asignado
SELECT  
    c.titulo AS cancion,          
    a.nombre AS artista,          
    g.nombre AS genero,           
    c.popularidad                
FROM Canciones c 
INNER JOIN Artistas a ON c.artista_id = a.artista_id        
INNER JOIN Generos g ON a.genero_id = g.genero_id           
WHERE c.popularidad > 90                                   
ORDER BY c.popularidad ASC;                                



















-- Esta consulta con LEFT JOIN muestra el historial completo de escucha de todos los usuarios
-- Mantiene TODOS los usuarios, incluso si no han escuchado música (aparecerían con NULL en canción)
SELECT  
    u.nombre AS usuario,
    u.pais AS pais_usuario,
    c.titulo AS cancion,
    a.nombre AS artista,
    g.nombre AS genero
FROM Usuarios u
LEFT JOIN Reproducciones r ON u.usuario_id = r.usuario_id
LEFT JOIN Canciones c ON r.cancion_id = c.cancion_id
LEFT JOIN Artistas a ON c.artista_id = a.artista_id
LEFT JOIN Generos g ON a.genero_id = g.genero_id
ORDER BY u.nombre;




















-- Esta consulta RIGHT JOIN Cuenta cuántos usuarios únicos han escuchado cada canción
-- Mantiene TODOS los géneros y artistas, incluso si no tienen oyentes
SELECT  
    g.nombre AS genero,
    a.nombre AS artista,
    a.pais AS pais_artista,
    c.titulo AS cancion,
    COUNT(DISTINCT u.usuario_id) as total_oyentes
FROM Usuarios u
RIGHT JOIN Reproducciones r ON u.usuario_id = r.usuario_id
RIGHT JOIN Canciones c ON r.cancion_id = c.cancion_id
RIGHT JOIN Artistas a ON c.artista_id = a.artista_id
RIGHT JOIN Generos g ON a.genero_id = g.genero_id
GROUP BY g.nombre, a.nombre, a.pais, c.titulo
ORDER BY total_oyentes DESC;