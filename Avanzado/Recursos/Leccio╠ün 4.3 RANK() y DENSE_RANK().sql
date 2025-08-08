-- Ranking de artistas por número de canciones:
SELECT 
    a.nombre,
    COUNT(*) as total_canciones,
    RANK() OVER (ORDER BY COUNT(*) DESC) as ranking_con_saltos
FROM Artistas a
JOIN Canciones c ON a.artista_id = c.artista_id
GROUP BY a.nombre;


-- Ranking de canciones por popularidad:
SELECT 
    titulo,
    popularidad,
    RANK() OVER (ORDER BY popularidad DESC) as ranking_con_saltos,
    DENSE_RANK() OVER (ORDER BY popularidad DESC) as ranking_sin_saltos
FROM Canciones;