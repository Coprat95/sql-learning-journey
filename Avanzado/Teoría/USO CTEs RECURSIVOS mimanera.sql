 -- USO CTEs RECURSIVOS  Musica>urbano>reggaeton
 
    -- PARTE INICIAL: Solo el género raíz principal (nivel 1, ejemplo: "Música")
    WITH RECURSIVE generos_jerarquia AS (
	SELECT
		genero_id,-- ID del género
		nombre,-- Nombre del género
		genero_padre_id,	-- ID del género padre (NULL para el nivel 1)
		nivel, 
		CAST(nombre AS CHAR(1000)) AS ruta	 -- Ruta inicial con el nombre del género raíz
	FROM generos
    WHERE nivel = 1
    
    UNION ALL     -- Une los resultados de las dos consultas sin eliminar duplicados
       	
    -- PARTE RECURSIVA: Encontrar todos los subgéneros
    SELECT
		g.genero_id,-- ID del subgénero
		g.nombre,	   -- Nombre del subgénero
		g.genero_padre_id,	  -- ID del género padre
		g.nivel,	   -- Nivel en la jerarquía
		CONCAT(gj.ruta, ' > ', g.nombre) AS ruta	 -- Construcción de la ruta jerárquica
		FROM generos g
        JOIN generos_jerarquia gj ON g.genero_padre_id = gj.genero_id
		)
        
        -- Mostramos los resultados
	SELECT 
    -- Agregamos espacios según el nivel para visualizar la jerarquía
		CONCAT(REPEAT('   ', nivel -1), nombre) AS jerarquia,
       -- Mostramos la ruta completa desde la raíz
		ruta AS ruta_jerarquica	,
                      -- Mostramos el nivel jerárquico
		nivel	
        FROM generos_jerarquia
                    	
               -- Ordenamos por la ruta para mantener la estructuraa jerárquica
		ORDER BY ruta_jerarquica;