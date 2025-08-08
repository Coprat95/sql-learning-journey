SELECT * FROM Canciones;
SELECT* FROM Artistas;
SELECT* FROM Géneros;

-- Muestra  canciones con índice de popularidad >93
-- Utiliza INNER JOIN para asegurar que solo se muestren canciones que tengan artista y género asignado

SELECT c.titulo AS 'Título' ,
	   a.nombre AS 'Artista',
       g.nombre AS 'Género',
       c.popularidad AS 'Índice de Popularidad'
FROM  		canciones c
INNER JOIN  artistas a ON c.artista_id = a.artista_id    -- cuando el artista coincida  
INNER JOIN generos g ON a.genero_id = g.genero_id		 -- cuando el género coincida
WHERE c.popularidad >93
ORDER BY c.popularidad DESC;


-- LEFT JOIN EN CASCADA

-- Esta consulta LEFT JOIN muestra el historial completo de escucha de todos los usuarios
-- Mantiene TODOS los usuarios, incluso si no han escuchado música (aparecerían con NULL en canción)
SELECT 
	u.nombre AS usuario,
    u.pais AS pais_usuario,
    c.titulo AS cancion,
    a.nombre AS artista,
    g.nombre AS genero
FROM  usuarios u
	LEFT JOIN Reproducciones r ON u.usuario_id = r.usuario_id
	LEFT JOIN canciones c ON r.cancion_id = c.cancion_id
    LEFT JOIN artistas a ON c.artista_id = a.artista_id
    LEFT JOIN generos g	 ON a.genero_id = g.genero_id
ORDER BY u.nombre;
    
-- RIGHT JOIN EN CASCADA
-- Esta consulta RIGHT JOIN Cuenta cuantos usuarios ÚNICOS han escuchado cada canción
-- Mantiene TODOS los géneros y artistas , incluso si no tienen oyentes

SELECT 
	g.nombre AS Genero,
    a.nombre AS Artista,
    c.titulo AS Cancion,
    COUNT(DISTINCT u.usuario_id) AS Total_oyentes
    FROM    usuarios u 
    RIGHT JOIN  reproducciones r ON u.usuario_id = r.usuario_id
    RIGHT JOIN canciones c		 ON r.cancion_id = c.cancion_id
    RIGHT JOIN artistas a  		 ON c.artista_id = a.artista_id
    RIGHT JOIN generos g 		 ON a.genero_id = g.genero_id
    GROUP BY g.nombre , a.nombre, c.titulo
    ORDER BY Total_oyentes DESC;
    
