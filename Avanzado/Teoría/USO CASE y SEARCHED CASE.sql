-- CASE SIMPLE
-- Clasifica las calificaciones de las canciones y muestra un emoji correspondiente
SELECT
	c.titulo,
    CASE r.calificacion					-- CASE (en caso de que la columna tal )
		WHEN 5 THEN '*****'				-- cuando sea tal entonces haz esto
		WHEN 4 THEN '****'
        WHEN 3 THEN '***'
        WHEN 2 THEN '**'
        WHEN 1 THEN '*'
        ELSE 'Sin calificar'
        END AS estrellas				-- cierra el CASE y renombralo
FROM canciones c LEFT JOIN reproducciones r 
ON c.cancion_id = r.cancion_id
ORDER BY c.titulo;

-- CASE SEARCHED 
-- Clasifica las canciones por su duración en categorías : Corta, media , larga
SELECT
titulo,
duracion,
CASE 											-- CASE SEARCHED: se pone el nombre de la columna en cada WHEN 
	WHEN duracion < 180 THEN 'Corta'			-- menor de 180 = corta
    WHEN duracion < 300 THEN 'Media'			-- autointuye que debe ser mayor de 180 pero menor de 300
    ELSE 'Larga'								-- todo lo demás
END AS duracion_canciones
FROM canciones
ORDER BY titulo;

-- CASE BUSCADO (SEARCHED CASE) + DIFÍCIL
-- Evalúa el nivel de actividad de los usuarios basado en varios factores 
-- CASE Buscado (searched CASE):
-- Evalúa el nivel de actividad de los usuarios basado en varios factores

SELECT
    u.nombre,
    COUNT(r.reproduccion_id) AS total_reproducciones,
    AVG(r.tiempo_escuchado) AS promedio_tiempo,
    AVG(r.calificacion) AS promedio_calificacion,
    CASE
        WHEN COUNT(r.reproduccion_id) > 100
            AND AVG(r.tiempo_escuchado) > 200
            AND AVG(r.calificacion) >= 4 THEN 'Usuario Premium Activo'

        WHEN COUNT(r.reproduccion_id) > 50
            AND AVG(r.tiempo_escuchado) > 150
            AND AVG(r.calificacion) >= 3 THEN 'Usuario Regular Activo'

        WHEN COUNT(r.reproduccion_id) > 0
            AND AVG(r.tiempo_escuchado) < 60 THEN 'Usuario de Previews'

        WHEN COUNT(r.reproduccion_id) > 0
            AND AVG(r.calificacion) < 2 THEN 'Usuario Insatisfecho'

        WHEN COUNT(r.reproduccion_id) = 0 THEN 'Usuario Inactivo'

        ELSE 'Usuario Casual'
    END AS perfil_usuario
FROM
    usuarios u
LEFT JOIN
    reproducciones r ON u.usuario_id = r.usuario_id   -- LEFT JOIN: Quiero todos los usuarios, incluso si no tienen ninguna reproducción registrada.

GROUP BY
    u.nombre;