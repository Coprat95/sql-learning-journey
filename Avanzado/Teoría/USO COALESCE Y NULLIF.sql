
-- USO COALESCE()   ( Si es NULL , cambiame a esto ) 
-- SI la cancion es NULL , muestra 'SIn calificacion'
SELECT 
	c.titulo AS cancion,
    COALESCE(r.calificacion, 'Sin calificacion') AS calificacion -- le damos nombre a la columna
FROM Reproducciones r												-- PONEMOS FROM REproducciones porque es la que queremos analizar
																	-- el corazón de la consulta
LEFT JOIN Canciones c ON r.cancion_id = c.cancion_id
ORDER BY cancion;

-- ________________________________________

-- USO NULLIF()  ( Si se cumple esta condicion, hazmelo NULL)
-- Muestra el nombre del artista ( pero vetamos a Bad Bunny como NULL)
SELECT
	NULLIF(a.nombre , 'Bad Bunny') AS Artista,
    c.titulo 
    FROM artistas a
    LEFT JOIN canciones c ON a.artista_id = c.artista_id
    ORDER BY Artista
    ;
-- ___________________________________________________

-- USO COMBINADO COALESCE Y NULLIF
-- Muestra todas las canciones EXCEPTO las de Bad Bunny, con su información ( calificacion, total_reproducciones, promedio_tiempo_escuchado,popularidad)
																			-- [Alta :+80,  Media :+50  , Baja: Resto]
SELECT
	c.titulo AS cancion,
	COALESCE(NULLIF(a.nombre , 'Bad Bunny'), 'Artista Vetado') AS Artistas,
	r.calificacion,
	COUNT(r.reproduccion_id) AS total_reproducciones,
	AVG(r.tiempo_escuchado) AS promedio_tiempo_escuchado,
    CASE 											
		WHEN c.popularidad > 80 THEN 'Alta'
        WHEN c.popularidad > 50 THEN 'Media'
        ELSE 'Baja'
    END AS popularidad
FROM reproducciones r
	JOIN canciones c ON r.cancion_id = c.cancion_id
	JOIN artistas a ON c.artista_id = a.artista_id
GROUP BY c.titulo, a.nombre, r.calificacion,popularidad;  
/* EXPLICACIÓN IMPORTANTE DEL GROUP BY: 
Pongo c.titulo, a.nombre, r.calificacion,popularidad por :    Cuando pones una función tipo (AVG, COUNT, SUM, MAX...) te obligas a usar GROUP BY 
																A no ser que todas las columnas estén incluidas en esas funciones. 
En el group by TIENES QUE PONER las COLUMNAS que has puesto en el SELECT. En este caso 4 . 

	
