-- Antigüedad de canciones:
SELECT 
    titulo,
    fecha_lanzamiento,
    DATEDIFF(CURRENT_DATE, fecha_lanzamiento) as dias_desde_lanzamiento
FROM Canciones
ORDER BY dias_desde_lanzamiento DESC;






-- Aniversario primer año, mes y semana
SELECT 
    nombre,
    fecha_registro,
    DATE_ADD(fecha_registro, INTERVAL 1 YEAR) as fecha_primer_aniversario,
    DATE_ADD(fecha_registro, INTERVAL 30 DAY) as fecha_primer_mes,
    DATE_ADD(fecha_registro, INTERVAL 7 DAY) as fecha_primera_semana
FROM Usuarios;






-- Antigüedad de usuarios:
SELECT 
    nombre,
    fecha_registro,
    -- Calcula días desde el registro
    DATEDIFF(CURRENT_DATE, fecha_registro) as dias_registrado,
    -- Calcula meses desde el registro
    DATEDIFF(CURRENT_DATE, fecha_registro)/30 as meses_registrado,
    -- Calcula años desde el registro
    DATEDIFF(CURRENT_DATE, fecha_registro)/365 as años_registrado
FROM Usuarios;






-- Análisis de retención de usuarios combinando DATE_ADD y DATEDIFF
SELECT 
    u.nombre,
    -- Info básica
    u.fecha_registro,
    
    -- Usando DATE_ADD para fechas importantes
    DATE_ADD(u.fecha_registro, INTERVAL 100 DAY) as fecha_fin_periodo_nuevo,
    DATE_ADD(u.fecha_registro, INTERVAL 1 YEAR) as fecha_aniversario,
    
    -- Calculamos antigüedad con DATEDIFF
    DATEDIFF(CURRENT_DATE, u.fecha_registro) as dias_como_usuario,
    
    -- Días restantes hasta fechas importantes usando DATEDIFF con DATE_ADD
    DATEDIFF(
        DATE_ADD(u.fecha_registro, INTERVAL 1 YEAR),
        CURRENT_DATE
    ) as dias_hasta_aniversario,
    
    -- Categorización usando DATEDIFF
    CASE 
        WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 100 THEN 'Nuevo Usuario'
        WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 900 THEN 'Usuario Regular'
        WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 1600 THEN 'Usuario Establecido'
        ELSE 'Usuario Veterano'
    END as categoria_usuario,
    
    -- Próximas fechas importantes usando DATE_ADD
    DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY) as fecha_proxima_revision,
    
    -- Actividad reciente usando DATEDIFF
    DATEDIFF(
        CURRENT_DATE, 
        MAX(r.fecha_reproduccion)
    ) as dias_desde_ultima_reproduccion,
    
    -- Próxima fecha objetivo usando DATE_ADD basado en última actividad
    DATE_ADD(MAX(r.fecha_reproduccion), INTERVAL 70 DAY) as fecha_limite_actividad,
    
    -- Estado de actividad usando DATEDIFF
    CASE 
        WHEN DATEDIFF(CURRENT_DATE, MAX(r.fecha_reproduccion)) <= 70 THEN 'Usuario Activo'
        WHEN DATEDIFF(CURRENT_DATE, MAX(r.fecha_reproduccion)) <= 400 THEN 'Usuario Semi-Activo'
        ELSE 'Usuario Inactivo'
    END as estado_actividad
FROM Usuarios u
LEFT JOIN Reproducciones r ON u.usuario_id = r.usuario_id
GROUP BY u.usuario_id, u.nombre, u.fecha_registro;