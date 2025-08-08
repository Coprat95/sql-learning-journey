select * from Canciones;
select * from Artistas;

-- LEFT JOIN: Todas las canciones, incluso sin artista
SELECT c.titulo, a.nombre
FROM Canciones c
LEFT JOIN Artistas a ON c.artista_id = a.artista_id;

-- RIGHT JOIN: Todos los artistas, incluso sin canciones
SELECT c.titulo, a.nombre
FROM Canciones c
RIGHT JOIN Artistas a ON c.artista_id = a.artista_id;
