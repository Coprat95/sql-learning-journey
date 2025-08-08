
---------- USO DE HAVING ------- Filtra grupos después de estar agrupados en GROUP BY


SELECT ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG (Votos) AS Promedio_Votos , MIN (Votos) AS minimo_votos, MAX (Votos) AS maximo_votos
FROM votos
GROUP BY ENTIDAD
HAVING SUM(Votos) >1500000  -- Muestra sumvotos, promedio etc, agrupados por entidad donde la suma de los votos mayor que 1500000

---------- HAVING MULTIPLE --------
SELECT ENTIDAD, DISTRITO_FEDERAL, SUM(Votos) AS Sum_Votos , AVG(Votos) AS Avg_votos , MIN(Votos) AS min_Votos , MAX(Votos) AS max_Votos
FROM VOTOS 
GROUP BY ENTIDAD, DISTRITO_FEDERAL
HAVING MIN (Votos) >250000

---------- HAVING APLICANDO FILTROS ---------

SELECT ENTIDAD, DISTRITO_FEDERAL, SUM(Votos) AS Sum_Votos , AVG(Votos) AS Avg_votos , MIN(Votos) AS min_Votos , MAX(Votos) AS max_Votos
FROM VOTOS 
WHERE ENTIDAD != 'CIUDAD DE MÉXICO'
GROUP BY ENTIDAD, DISTRITO_FEDERAL
HAVING MIN (Votos) >250000

--------- HAVING MULTIPLE CON VARIAS CONDICIONES -----

SELECT Fecha_Publicacion, ENTIDAD, SUM(Votos) AS Sum_Votos, AVG(Votos) AS Avg_Votos, MIN(Votos) AS Min_Votos, MAX(Votos)AS Max_Votos
FROM Votos
GROUP BY Fecha_Publicacion, ENTIDAD
HAVING SUM(Votos) > 1500000 AND MIN (Votos) != MAX (Votos)  -- Mostramos sum votos, avg votos etc agrupandolos por fecha_publicacion
															-- y entidad. Luego les aplicamos filtro de que la suma de los votos sea
															-- mayor que 1.500.000 y que el Mínimo y máximo de votos sea diferente. 
