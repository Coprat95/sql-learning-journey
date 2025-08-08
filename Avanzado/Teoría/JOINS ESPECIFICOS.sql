select * from Artistas;
select * from canciones;

-- Une automáticamente las tablas por columnas del mismo nombre
SELECT *
FROM Canciones c
NATURAL JOIN Artistas a;

-- Especifica explícitamente la columna común
SELECT *
FROM Canciones c
JOIN Artistas a USING (artista_id);


