


USE SpotifySimulator;
-- SIN CTE (manera tradicional con subconsultas repetidas) ---------------------------------------------
-- 1. Ver cuántos usuarios escuchan canciones populares
SELECT COUNT(DISTINCT u.usuario_id) as total_usuarios
FROM Usuarios u
JOIN Reproducciones r ON u.usuario_id = r.usuario_id
WHERE r.cancion_id IN (
    SELECT cancion_id 
    FROM Canciones 
    WHERE popularidad > 90
);

-- Ver cuántas reproducciones tienen canciones populares
SELECT COUNT(*) as total_reproducciones
FROM Reproducciones r
WHERE r.cancion_id IN (
    SELECT cancion_id 
    FROM Canciones 
    WHERE popularidad > 90
);


-- CON CTE (reutilizando la consulta de canciones populares) -----------------
-- CTEs
WITH canciones_populares AS (
    SELECT cancion_id, titulo 
    FROM Canciones 
    WHERE popularidad > 90
)

-- 1. Ver cuántos usuarios las escuchan canciones populares
SELECT COUNT(DISTINCT u.usuario_id) as total_usuarios
FROM canciones_populares cp
JOIN Reproducciones r ON cp.cancion_id = r.cancion_id
JOIN Usuarios u ON r.usuario_id = u.usuario_id;

-- 2. Ver cuántas reproducciones tienen canciones populares
SELECT COUNT(*) as total_reproducciones
FROM canciones_populares cp
JOIN Reproducciones r ON cp.cancion_id = r.cancion_id;


-- Tercer Ejmeplo
WITH 
-- Definimos canciones populares una vez
canciones_populares AS (
    SELECT cancion_id, titulo 
    FROM Canciones 
    WHERE popularidad > 80
),
-- Definimos usuarios activos una vez
usuarios_activos AS (
    SELECT usuario_id, nombre
    FROM Usuarios
    WHERE ultima_conexion >= DATE_SUB(NOW(), INTERVAL 20 MONTH)
)

-- Podemos usar ambas CTEs:
-- Conteo de reproducciones de canciones populares por usuarios activos
SELECT cp.titulo, COUNT(*) as reproducciones
FROM canciones_populares cp
JOIN Reproducciones r ON cp.cancion_id = r.cancion_id
JOIN usuarios_activos ua ON r.usuario_id = ua.usuario_id
GROUP BY cp.titulo;
