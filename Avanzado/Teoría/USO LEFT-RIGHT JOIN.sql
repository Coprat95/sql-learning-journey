USE spotifysimulator;
SELECT * FROM Canciones;
SELECT * FROM Artistas;

-- LEFT JOIN: Todas las canciones, incluso sin artista. INNER JOIN SI QUE DEBE TENER artista y cancion
SELECT c.titulo , a.nombre
FROM Canciones c
 LEFT JOIN Artistas a ON c.artista_id = a.artista_id;
 
 -- RIGHT JOIN: Todos los artistas , incluso sin canciones
 SELECT  c.titulo , a.nombre
 FROM canciones c 
 RIGHT JOIN artistas a ON c.artista_id = a.artista_id;
 
 
 
 
 
 
 
