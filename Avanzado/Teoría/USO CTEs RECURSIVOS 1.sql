 -- USO CTEs RECURSIVOS  Musica>urbano>reggaeton
 
 
WITH RECURSIVE generos_jerarquia AS (
    -- PARTE INICIAL: Solo el género raíz principal (nivel 1, ejemplo: "Música")
    SELECT
        genero_id,        -- ID del género
        nombre,         -- Nombre del género
        genero_padre_id,  -- ID del género padre (NULL para el nivel 1)
        nivel,            -- Nivel en la jerarquía (1 para el género raíz)
        CAST(nombre AS CHAR(1000)) AS ruta  -- Ruta inicial con el nombre del género raíz
    FROM Generos
    WHERE nivel = 1

    UNION ALL

    -- PARTE RECURSIVA: Encontrar todos los subgéneros
    SELECT
        g.genero_id,        -- ID del subgénero
        g.nombre,           -- Nombre del subgénero
        g.genero_padre_id,  -- ID del género padre
        gj.nivel + 1 AS nivel,  -- Nivel en la jerarquía
        CONCAT(gj.ruta, ' > ', g.nombre) AS ruta  -- Construcción de la ruta jerárquica
    FROM Generos g
    JOIN generos_jerarquia gj ON g.genero_padre_id = gj.genero_id
)
-- Mostramos los resultados
SELECT
    -- Agregamos espacios según el nivel para visualizar la jerarquía
    CONCAT(REPEAT(' ', nivel - 1), nombre) AS jerarquia,
    ruta AS ruta_completa,     -- Mostramos la ruta completa desde la raíz
    nivel                      -- Mostramos el nivel jerárquico
FROM generos_jerarquia
ORDER BY ruta;                -- Ordenamos por la ruta para mantener la estructura jerárquica
