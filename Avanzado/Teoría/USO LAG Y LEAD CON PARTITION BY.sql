-- LAG (ANTES) Y LEAD (DESPUES)  COMO SI FUERA UN REPRODUCTOR DE MÚSICA, cancion anterior(lag) canción siguiente(lead)
-- SE PUEDE PONER PARTITION BY para agrupar por un campo

-- Comparar popularidad con siguiente y anterior a nivel global:
SELECT
	titulo AS cancion,
    popularidad AS 'Popularidad actual',
    LAG(popularidad) OVER (ORDER BY popularidad DESC) AS 'Popularidad anterior',
    LEAD(popularidad) OVER (ORDER BY popularidad DESC) AS 'Populariad siguiente'
FROM canciones
;
-- Ejemplo 2:  Ver historial de reproducciones por usuario:
SELECT
	u.nombre,
    r.fecha_reproduccion,
    c.titulo,
    -- Anterior del mismo usuario
    LAG(c.titulo) OVER (										
    PARTITION BY (u.usuario_id)										-- Organizamos lo que muestre por distintos usuarios  ( id '1' = Ana silva, id '2' = Pedro Martínez)
    ORDER BY r.fecha_reproduccion) AS anterior_del_usuario,			-- lo ordenamos por fecha_reproduccion( salen primero los mas antiguos)
    -- Siguiente del mismo usuario
    LEAD(c.titulo) OVER (
    PARTITION BY u.usuario_id
    ORDER BY r.fecha_reproduccion) AS siguiente_del_usuario
    FROM Usuarios u
    JOIN Reproducciones r ON u.usuario_id = r.usuario_id
    JOIN Canciones c ON r.cancion_id = c.cancion_id;