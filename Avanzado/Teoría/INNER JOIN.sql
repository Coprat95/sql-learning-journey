select * from Canciones;
select * from Artistas;

SELECT *
FROM Canciones c
INNER JOIN Artistas a ON c.artista_id = a.artista_id

