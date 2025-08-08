-- EJEMPLO1: CTE Recursivo para ver la jerarquía de géneros musicales
WITH RECURSIVE generos_jerarquia AS (
   -- PARTE INICIAL: Solo el género raíz principal (nivel 1, ejemplo: "Música")
   SELECT 
       genero_id,          -- ID del género
       nombre,             -- Nombre del género
       genero_padre_id,    -- ID del género padre (NULL para el nivel 1)
       nivel,              -- Nivel en la jerarquía (1 para el género raíz)
       CAST(nombre AS CHAR(1000)) AS ruta  -- Iniciamos la ruta solo con el nombre del género raíz
   FROM Generos
   WHERE nivel = 1  -- Comenzamos con el género de nivel 1 (género raíz)

   UNION ALL

   -- PARTE RECURSIVA: Encontrar todos los subgéneros
   SELECT 
       g.genero_id,           -- ID del subgénero
       g.nombre,              -- Nombre del subgénero
       g.genero_padre_id,     -- ID del género padre
       g.nivel,               -- Nivel en la jerarquía
       CONCAT(gj.ruta, ' > ', g.nombre) AS ruta  -- Agregamos el nuevo subgénero a la ruta
   FROM Generos g
   JOIN generos_jerarquia gj ON g.genero_padre_id = gj.genero_id  -- Unimos con los géneros ya encontrados
)

-- Mostramos los resultados
SELECT 
   -- Agregamos espacios según el nivel para visualizar la jerarquía
   CONCAT(REPEAT('        ', nivel - 1), nombre) as jerarquia,
   ruta as ruta_completa,  -- Mostramos la ruta completa desde la raíz
   nivel                   -- Mostramos el nivel jerárquico
FROM generos_jerarquia
ORDER BY ruta;  -- Ordenamos por la ruta para mantener la estructura jerárquica

-- EJEMPLO 2: CTE Recursivo para ver amigos de amigos
WITH RECURSIVE red_amigos AS (
    -- PARTE INICIAL: Solo los amigos directos (nivel 1)
    SELECT 
        usuario_id,           -- Usuario inicial
        amigo_id,            -- Amigo directo
        1 as nivel_amistad,  -- Nivel 1 de amistad (amigos directos)
        CAST(CONCAT(
            (SELECT nombre FROM Usuarios WHERE usuario_id = a.usuario_id),
            ' > ',
            (SELECT nombre FROM Usuarios WHERE usuario_id = a.amigo_id)
        ) AS CHAR(1000)) as cadena_amigos
    FROM Amigos a
    WHERE usuario_id = 1  -- Empezamos con usuario ID 1

    UNION ALL

    -- PARTE RECURSIVA: Encontrar amigos de los amigos
    SELECT 
        ra.usuario_id,          -- Mantenemos el usuario inicial
        a.amigo_id,            -- Nuevo amigo encontrado
        ra.nivel_amistad + 1,  -- Aumentamos el nivel
        CONCAT(ra.cadena_amigos, ' > ', 
            (SELECT nombre FROM Usuarios WHERE usuario_id = a.amigo_id)
        ) -- Agregamos el nuevo amigo a la cadena
    FROM Amigos a
    JOIN red_amigos ra ON a.usuario_id = ra.amigo_id
)

-- Mostramos los resultados
SELECT 
    nivel_amistad as 'Nivel de Amistad',
    cadena_amigos as 'Cadena de Conexiones'
FROM red_amigos
ORDER BY nivel_amistad;