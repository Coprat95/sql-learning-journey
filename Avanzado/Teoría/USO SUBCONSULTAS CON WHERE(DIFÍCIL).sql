
-- SUBCONSULTAS QUE DURAN MÁS DEL PROMEDIO DE DURACIÓN NORMAL
-- EJEMPLO 1

SELECT 
	titulo AS Canción,
    duracion AS Duración
    FROM canciones
    WHERE Duracion > 
    ( SELECT AVG(Duracion) AS Media_duracion
		FROM Canciones)
        ;

-- EJEMPLO 2
-- Muestra el top3 artistas con más canciones
SELECT Artista, total_canciones
FROM (
		 -- Primero contamos las canciones por artista
					SELECT a.nombre  as artista, COUNT(*) AS total_canciones
                  FROM Artistas a 
                  JOIN Canciones c ON a.artista_id = c.artista_id
                  GROUP BY a.nombre
        -- --------------------------------------------------------          
	) AS conteo
    ORDER BY total_canciones DESC
    LIMIT 3;
    
    
    
    
    
    
    -- Muestra el top3 artistas con más canciones
SELECT artista , total_canciones
	FROM	(
					SELECT a.nombre AS Artista , COUNT(*) AS total_canciones
                    FROM artistas a INNER JOIN canciones c 
                    ON a.artista_id = c.artista_id
                    GROUP BY a.nombre
			) AS Conteo
	ORDER BY total_canciones DESC
    LIMIT 3;

-- FINAL: Encontrar el usuario más antiguo de Colombia que escucha canciones populares
SELECT u.nombre AS 'Usuario Premiado', 
       u.email AS 'Contacto', 
       u.pais AS 'País', 
       u.fecha_registro AS 'Miembro desde', 
       'Usuario Premium Vitalicio' AS 'Premio Otorgado'
FROM Usuarios u
WHERE u.nombre IN (

    -- CUARTO: Filtrar usuarios que son de Colombia
    SELECT u2.nombre
    FROM Usuarios u2
    WHERE u2.pais = 'Colombia'
    AND u2.nombre IN (

        -- TERCERO: Obtener los usuarios que han reproducido las canciones más escuchadas
        SELECT DISTINCT u3.nombre
        FROM Usuarios u3
        JOIN Reproducciones r ON u3.usuario_id = r.usuario_id
        JOIN Canciones c ON r.cancion_id = c.cancion_id
        WHERE c.titulo IN (

            -- SEGUNDO: Obtener canciones que se han reproducido más que el promedio general
            SELECT c2.titulo
            FROM Canciones c2
            JOIN Reproducciones r2 ON c2.cancion_id = r2.cancion_id
            GROUP BY c2.titulo
            HAVING COUNT(r2.reproduccion_id) > (

                -- PRIMERO: Calcular el promedio de reproducciones por canción
                SELECT AVG(veces_reproducida)
                FROM (
                    SELECT COUNT(reproduccion_id) AS veces_reproducida
                    FROM Reproducciones
                    GROUP BY cancion_id
                ) AS estadisticas_reproduccion
            )
        )
    )
)
-- Ordenar por fecha de registro ascendente para encontrar al usuario más antiguo
ORDER BY u.fecha_registro ASC

-- Limitar el resultado a uno solo: el usuario más veterano
LIMIT 1;