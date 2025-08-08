
-- SIN USAR CTE ( sin reutilizar la consulta de canciones populares) 

-- 1: Ver cuantos usuarios escuchan canciones populares

		SELECT COUNT(DISTINCT(u.usuario_id)) AS total_usuarios
        FROM usuarios u JOIN reproducciones r ON u.usuario_id = r.usuario_id
        WHERE r.cancion_id IN ( 
			SELECT cancion_id
			FROM  canciones
			WHERE popularidad > 80
            ) ; 																-- VEMOS QUE SE REPITE EL SUBCÓDIGO EN LOS DOS CASOS 
																		-- imagina que son 20 códigos que reutiliar y que queremos cambiar popularidad de >80 a 
																		-- > 90  . Habría que substituir 20 códigos
         
-- 2: Ver cuantas reproducciones tienen canciones populares 
		SELECT COUNT(*) AS total_reproducciones
        FROM reproducciones 
        WHERE cancion_id IN ( 
			SELECT cancion_id
			FROM  canciones
			WHERE popularidad > 80
            ) ;
   -- CON CTE (reutilizando la consulta de canciones populares -----
   
   -- CREACIÓN CTE ( tabla se guarda en espacio temporal, no se almacena 
   WITH canciones_populares AS (   -- nombramos la tabla temporal como canciones_populares que muestra las canciones populares
	SELECT cancion_id, titulo
    FROM Canciones
    WHERE popularidad > 80
    )
   
   -- 1 : Ver cuántos usuarios escuchan canciones populares
   SELECT COUNT(DISTINCT u.usuario_id) AS total_usuarios			-- Calculo de usarios distintos
   FROM canciones_populares cp										-- que hayan escuchado canciones populares
	JOIN Reproducciones r ON cp.cancion_id = r.cancion_id															
   JOIN Usuarios u ON r.usuario_id = u.usuario_id					-- para pasar de usarios a canciones hay que hacer join con reproducciones
   	;																-- hasta llegar a cancion
  
	
  -- 2: Ver cuántas reproducciones tienen canciones populares
  WITH canciones_populares AS (   -- copia y pega del with
	SELECT cancion_id, titulo
    FROM Canciones
    WHERE popularidad > 80
    )
	SELECT COUNT(*) AS total_reproducciones
    FROM canciones_populares cp
    JOIN reproducciones r ON cp.cancion_id = r.cancion_id ;
    -- __________________________________________________________________________
    
    -- Ahora usaremos dos CTE en un solo lugar o varios lugares
    -- Definimos canciones populares una vez
     WITH canciones_populares AS (  
	SELECT cancion_id, titulo
    FROM Canciones
    WHERE popularidad > 80
    ),
    --  Definimos usuarios activos una vez
     usuarios_activos AS (
    SELECT usuario_id, nombre
    FROM usuarios
    WHERE ultima_conexion >= DATE_SUB(NOW(), INTERVAL 20 MONTH)
    )
    
    -- Podemos usar ambas CTEs:
    -- Conteo de reproducciones de canciones populares por usuarios activos
    SELECT cp.titulo, COUNT(*) AS numero_reproducciones
    FROM canciones_populares cp 
    JOIN reproducciones r ON cp.cancion_id = r.cancion_id
    JOIN usuarios_activos ua ON r.usuario_id = ua.usuario_id
    GROUP BY cp.titulo;
    