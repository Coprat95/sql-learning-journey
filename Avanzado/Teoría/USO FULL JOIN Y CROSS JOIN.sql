SELECT * FROM Canciones;
SELECT * FROM Artistas;

-- FULL JOIN ( UNION DE LEFT + RIGHT JOIN), nos muestra todo, artistas sin cancoines y canciones sin artistas tambien
SELECT c.titulo AS 'Canción',
	   a.nombre AS 'Artista'
FROM canciones c 
LEFT JOIN artistas a ON c.artista_id = a.artista_id
UNION							-- Básicamente es hacer un LEFT JOIN + UNION + RIGHT JOIN
SELECT c.titulo ,
	   a.nombre
FROM canciones c
RIGHT JOIN artistas a ON c.artista_id = a.artista_id
WHERE c.artista_id IS NULL;


-- CROSS JOIN            Cada canción se une con cada uno de los artistas
SELECT c.titulo AS 'Canción',
	   a.nombre AS 'Artista'
FROM Canciones c
CROSS JOIN Artistas a; -- Limitamos porque puede ser muy grande 
	
