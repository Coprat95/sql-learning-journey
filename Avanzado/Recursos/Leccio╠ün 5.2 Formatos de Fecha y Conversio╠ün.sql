-- Formatear fechas de diferentes maneras:
SELECT 
    fecha_lanzamiento,
    -- Formato común español
    DATE_FORMAT(fecha_lanzamiento, '%d/%m/%Y') as fecha_española,
    -- Formato común inglés
    DATE_FORMAT(fecha_lanzamiento, '%Y-%m-%d') as fecha_inglesa,
    -- Formato con mes en texto
    DATE_FORMAT(fecha_lanzamiento, '%d de %M de %Y') as fecha_larga,
    -- Formato corto
    DATE_FORMAT(fecha_lanzamiento, '%d-%b-%y') as fecha_corta
FROM Canciones;


-- Mostrar fechas y horas completas:
SELECT 
    fecha_reproduccion,
    -- Fecha y hora completa
    DATE_FORMAT(fecha_reproduccion, '%d/%m/%Y %H:%i:%s') as fecha_hora_completa,
    -- Solo hora
    DATE_FORMAT(fecha_reproduccion, '%H:%i') as solo_hora,
    -- Fecha con día de semana
    DATE_FORMAT(fecha_reproduccion, '%W, %d %M %Y') as fecha_con_dia
FROM Reproducciones;


-- Extraer partes de una fecha:
SELECT 
    fecha_registro,
    -- Extraer año
    EXTRACT(YEAR FROM fecha_registro) as año,
    -- Extraer mes
    EXTRACT(MONTH FROM fecha_registro) as mes,
    -- Extraer día
    EXTRACT(DAY FROM fecha_registro) as dia
FROM Usuarios;