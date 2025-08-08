
-- USO DE RANK  Y DENSE_RANK
/* RANK: ATLETISMO								DENSE_RANK : Gimnasia

	Atleta	Tiempo		Salida						Gimnasta	Puntuación
1: 	Bolt		9,82	 1					1:Simone	9,2
1: 	Blake		9,82	 1		
	a.nombre			1: Nina     9,2 
3: 	Gatling		9,90     3					-: Maria    9,1
*/

-- Ranking de artistas por número de canciones
SELECT 
a.nombre,
COUNT(*) AS total_canciones,
	RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking_con_saltos -- me haces el ranking y lo ordenas por el total de canciones en orden descendente
FROM artistas a LEFT JOIN canciones c 
ON a.artista_id = c.artista_id
GROUP BY a.nombre;

-- DENSE_RANK
SELECT 
a.nombre,
COUNT(*) AS total_canciones,
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking_con_saltos -- me haces el ranking y lo ordenas por el total de canciones en orden descendente
FROM artistas a LEFT JOIN canciones c 
ON a.artista_id = c.artista_id
GROUP BY a.nombre;

-- JUNTOS RANK Y DENSE RANK
SELECT 
a.nombre,
COUNT(*) AS total_canciones,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking_sin_saltos ,
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking_con_saltos 
FROM artistas a LEFT JOIN canciones c 
ON a.artista_id = c.artista_id
GROUP BY a.nombre;

-- Ranking de artistas por número de canciones
SELECT
a.nombre,
COUNT(*) AS total_canciones,
RANK () OVER ( ORDER BY COUNT(*) DESC) AS ranking_con_saltos
FROM artistas a  LEFT JOIN canciones c ON a.artista_id = c.artista_id 
GROUP BY a.nombre;


-- Ranking de artistas por número de canciones

SELECT
a.nombre,
RANK() OVER (ORDER BY COUNT(*)) AS numero_canciones
FROM canciones c
JOIN artistas a ON c.artista_id = a.artista_id
GROUP BY a.nombre