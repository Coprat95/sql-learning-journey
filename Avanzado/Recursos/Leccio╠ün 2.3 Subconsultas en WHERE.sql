-- Obtener canciones que duran más que el promedio de duración
	SELECT titulo, duracion
	FROM Canciones 
	WHERE duracion > ( 
				-- Primero obtener promedio de duracion -----
					SELECT AVG(duracion)
					FROM Canciones
				-- ------------------------------------------
	); -- ---------------------------------------------------











-- Mostrar el top 3 de artistas con más canciones
SELECT artista, total_canciones
	FROM (
				-- Primero contamos las canciones por artista-------------
					SELECT a.nombre as artista, COUNT(*) as total_canciones
					FROM Artistas a
					JOIN Canciones c ON a.artista_id = c.artista_id
					GROUP BY a.nombre
				-- -------------------------------------------------------
	) AS conteo
ORDER BY total_canciones DESC
LIMIT 3;










-- FINAL: Encontrar el usuario más antiguo de Colombia que escucha canciones populares
SELECT u.nombre as 'Usuario Premiado', u.email as 'Contacto', u.pais as 'País', u.fecha_registro as 'Miembro desde', 'Usuario Premium Vitalicio' as 'Premio Otorgado'
FROM Usuarios u
WHERE u.nombre IN (
			-- CUARTO: Filtrar usuarios de Colombia ----------------------------------------------------------------
			SELECT u2.nombre
			FROM Usuarios u2
			WHERE u2.pais = 'Colombia' 
			AND u2.nombre IN (
						-- TERCERO: Obtener los usuarios que escuchan las canciones más reproducidas ---------------
						SELECT DISTINCT u3.nombre
						FROM Usuarios u3
						JOIN Reproducciones r ON u3.usuario_id = r.usuario_id
						JOIN Canciones c ON r.cancion_id = c.cancion_id
						WHERE c.titulo IN (
									-- SEGUNDO: Obtener títulos de canciones más escuchadas que el promedio --------
									SELECT c2.titulo
									FROM Canciones c2
									JOIN Reproducciones r2 ON c2.cancion_id = r2.cancion_id
									GROUP BY c2.titulo
									HAVING COUNT(r2.reproduccion_id) > (
												-- PRIMERO: Calcular el promedio de reproducciones por canción ------
												SELECT AVG(veces_reproducida)
												FROM (
													SELECT COUNT(reproduccion_id) as veces_reproducida
													FROM Reproducciones
													GROUP BY cancion_id
												) AS estadisticas_reproduccion -- -----------------------------------
									) -- ----------------------------------------------------------------------------
						) -- ----------------------------------------------------------------------------------------
			) -- ----------------------------------------------------------------------------------------------------
) 
ORDER BY u.fecha_registro ASC
LIMIT 1;


