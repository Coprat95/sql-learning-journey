-- Comparar popularidad con siguiente y anterior a nivel global:
SELECT 
    c.titulo,
    c.popularidad as popularidad_Cancion_actual,
    -- Anterior en toda la tabla
    LAG(c.popularidad) OVER (
        ORDER BY c.popularidad DESC
    ) as popularidad_Cancion_anterior,
    -- Siguiente en toda la tabla
    LEAD(c.popularidad) OVER (
        ORDER BY c.popularidad DESC
    ) as popularidad_Cancion_siguiente
FROM Canciones c;

-- Ver historial de reproducciones por usuario:
SELECT 
    u.nombre,
    r.fecha_reproduccion,
    c.titulo,
    -- Anterior del mismo usuario
    LAG(c.titulo) OVER (
        PARTITION BY u.usuario_id
        ORDER BY r.fecha_reproduccion
    ) as anterior_del_usuario,
    -- Siguiente del mismo usuario
    LEAD(c.titulo) OVER (
        PARTITION BY u.usuario_id
        ORDER BY r.fecha_reproduccion
    ) as siguiente_del_usuario
FROM Usuarios u
JOIN Reproducciones r ON u.usuario_id = r.usuario_id
JOIN Canciones c ON r.cancion_id = c.cancion_id;


-- Ver si la popularidad sube o baja (Tendencias (subida/bajada))
SELECT 
    c.titulo,
    c.fecha_lanzamiento as fecha_actual,
    c.popularidad as popularidad_actual,
    -- Diferencia con canción anterior
    c.popularidad - LAG(c.popularidad) OVER (
        ORDER BY fecha_lanzamiento
    ) as tendencia_popularidad,
    -- Interpretación
    CASE 
        WHEN c.popularidad - LAG(c.popularidad) OVER (ORDER BY fecha_lanzamiento) > 0 THEN 'SUBIÓ'
        WHEN c.popularidad - LAG(c.popularidad) OVER (ORDER BY fecha_lanzamiento) < 0 THEN 'BAJÓ'
        ELSE 'IGUAL'
    END as tendencia
FROM Canciones c;

