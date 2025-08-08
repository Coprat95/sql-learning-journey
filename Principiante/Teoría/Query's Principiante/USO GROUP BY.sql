
--------- USO DE GROUP BY ---------- ordenar por categoría
SELECT* 
FROM Votos
--------- GROUP BY INDIVIDUAL ----------
SELECT ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG (Votos) AS Promedio_Votos , MIN (Votos) AS minimo_votos, MAX (Votos) AS maximo_votos
FROM votos
GROUP BY ENTIDAD      -- quiero la suma, el promedio , el mínimo y máximo de los votos AGRUPADO por ENTIDAD
					  -- 1  ponemos ENTIDAD dsps del SELECT porque es la columna por la cual queremos agrupar los datos
					  -- 2  FROM la tabla a la que queremos hacer esa consulta
					  -- 3  GROUP BY "la columna a la cual queremos hacer la agrupacion(ENTIDAD)"

--------- GROUP BY MULTIPLE  -----
SELECT ENTIDAD , DISTRITO_FEDERAL, SUM(Votos) AS Sum_Votos , AVG (Votos) AS Avg_Votos , MIN(Votos) AS Min_Votos , MAX(Votos) AS Max_Votos
FROM Votos
GROUP BY ENTIDAD , DISTRITO_FEDERAL  -- Muestra los resultados agrupados por entidad y distrito federal


SELECT ENTIDAD, Fecha_Publicacion , SUM(Votos) AS Sum_Votos , AVG (Votos) AS Avg_Votos , MIN(Votos) AS Min_Votos , MAX(Votos) AS Max_Votos
FROM Votos
GROUP BY ENTIDAD , Fecha_Publicacion

---- si lo complicamos con una condición como ( que tenga + de 1000 votos) 

SELECT ENTIDAD, Fecha_Publicacion , SUM(Votos) AS Sum_Votos , AVG (Votos) AS Avg_Votos , MIN(Votos) AS Min_Votos , MAX(Votos) AS Max_Votos
FROM Votos
WHERE Votos >= '1000'
GROUP BY ENTIDAD , Fecha_Publicacion
