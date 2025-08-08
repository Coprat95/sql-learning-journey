-- SELF JOIN

SELECT * FROM GENEROS  -- nos muestra todos los géneros de música
-- Nivel 1: Música   no tiene padre  |   Nivel 2: Tropical    su padre es nivel 1   |  Nivel 3: Salsa   su padre es nivel 2 ...

-- EN ORACLE SI EXISTE EL SELF JOIN, EN MYSQL NO , debemos hacer un LEFT JOIN + una autoreferencia

SELECT
	CASE
		WHEN g1.nivel = 1 THEN CONCAT ('*', g1.nombre) -- Nivel 1: Género raíz (Música)
		WHEN g1.nivel = 2 THEN CONCAT ('      |-- *  ', g1.nombre) -- Nivel 2: Géneros principales
        ELSE CONCAT ('             |--* ', g1.nombre)   -- Nivel 3: Subgéneros
	END AS  'Jerarquía de Género' ,  -- muestra la columna como Jerarquía de Género
    g1.nivel AS 'Nivel'  -- Muestra y renombra el nivel numérico de cada género 
    -- Tabla principal de géneros
    FROM Generos g1 -- Join con la misma tabla para establecer relaciones padre-hijo ( g1 y g2 es lo mismo pero usamos dos alias diferentes para generos para
					-- poder compararlo consigo mismo .
    LEFT JOIN Generos g2 ON g1.genero_padre_id -- Filtros para mostrar solo :
    WHERE g1.nombre = 'Electrónica Latina' -- El Género específico que queremos ver
		OR g1.genero_padre_id IN (SELECT genero_id FROM Generos WHERE nombre = 'Urbano') -- Sus subgeneros
        OR g1.nombre = 'Música'  	-- El género raíz
        ORDER BY g1.nivel, g1.nombre ; -- Ordenamiento por nivel y nombre para mantener la jerarquía
    