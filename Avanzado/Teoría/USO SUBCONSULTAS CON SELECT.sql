USE spotifysimulator;

-- SUBCONSULTAS CON SELECT

SELECT
	titulo,
    popularidad,
    	(SELECT MAX(popularidad) FROM Canciones) AS maxima_popularidad -- SUBCONSULTA que nos muestra la popularidad máxima

    FROM Canciones;
    
    -- queremos que nos muestre cada canción y compararla con la duración promedio de todas las canciones
SELECT
	c.titulo AS Canción,
    a.nombre AS Artista,
	c.duracion AS Duración,
		(SELECT AVG(duracion) FROM canciones) AS Duración_promedio
    FROM canciones c INNER JOIN artistas a ;
    
