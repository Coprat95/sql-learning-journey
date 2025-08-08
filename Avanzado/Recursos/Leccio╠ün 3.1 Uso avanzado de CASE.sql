USE SpotifySimulator;
-- CASE SIMPLE
-- "Clasifica las calificaciones de las canciones y muestra un emoji correspondiente

SELECT 
    c.titulo,
    CASE r.calificacion
        WHEN 5 THEN '⭐⭐⭐⭐⭐'
        WHEN 4 THEN '⭐⭐⭐⭐'
        WHEN 3 THEN '⭐⭐⭐'
        WHEN 2 THEN '⭐⭐'
        WHEN 1 THEN '⭐'
        ELSE 'Sin calificación'
    END as estrellas
FROM Canciones c
LEFT JOIN Reproducciones r ON c.cancion_id = r.cancion_id
GROUP BY c.titulo;




-- CASE Buscado (searched CASE):
-- "Clasifica las canciones por su duración en categorías: 'Corta', 'Media', 'Larga'"
SELECT 
    titulo,
    duracion,
    CASE 
        WHEN duracion < 180 THEN 'Corta'
        WHEN duracion < 300 THEN 'Media'
        ELSE 'Larga'
    END as duracion_categoria
FROM Canciones;



-- CASE Buscado (searched CASE):
-- "Evalúa el nivel de actividad de los usuarios basado en varios factores"
SELECT 
    u.nombre,
    COUNT(r.reproduccion_id) as total_reproducciones,
    AVG(r.tiempo_escuchado) as promedio_tiempo,
    AVG(r.calificacion) as promedio_calificacion,
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
    END as perfil_usuario
FROM Usuarios u
LEFT JOIN Reproducciones r ON u.usuario_id = r.usuario_id
GROUP BY u.nombre;