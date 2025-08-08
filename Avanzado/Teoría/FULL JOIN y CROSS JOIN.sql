select * from Canciones;
select * from Artistas;

-- FULL JOIN (UNION de LEFT + RIGHT JOIN)
SELECT c.titulo AS 'Canción',
       a.nombre AS 'Artista'
FROM Canciones c
LEFT JOIN Artistas a ON c.artista_id = a.artista_id
UNION
SELECT c.titulo,
       a.nombre
FROM Canciones c
RIGHT JOIN Artistas a ON c.artista_id = a.artista_id
WHERE c.artista_id IS NULL;

-- CROSS JOIN
SELECT c.titulo AS 'Canción',
       a.nombre AS 'Artista'
FROM Canciones c
CROSS JOIN Artistas a;  -- Limitamos porque puede ser muy grande