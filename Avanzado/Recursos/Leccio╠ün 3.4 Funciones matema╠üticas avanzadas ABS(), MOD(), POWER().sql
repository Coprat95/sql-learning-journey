-- Diferencia absoluta de popularidad entre canciones  
-- DA = |Popularidad - 80|
SELECT 
    titulo,
    popularidad,
    ABS(popularidad - 80) as distancia_del_objetivo
FROM Canciones;

-- Identificar usuarios con ID par/impar
-- Residuo de Usuario/2
SELECT 
    nombre,
    usuario_id,
    CASE 
        WHEN MOD(usuario_id, 2) = 0 THEN 'Par'
        ELSE 'Impar'
    END as tipo_id
FROM Usuarios;

-- Calcular factor de impacto (popularidad al cuadrado)
-- FI = Popularidad ^ 2
SELECT 
    titulo,
    popularidad,
    POWER(popularidad, 2) as impacto
FROM Canciones;

-- Calcular score complejo de canciones
-- Score=〖(|Popularidad-50 |)〗^2 + Residuo(Duracion/60)
SELECT 
    titulo,
    popularidad,
    POWER(ABS(popularidad - 50), 2) + MOD(duracion, 60) as score_complejo
FROM Canciones;