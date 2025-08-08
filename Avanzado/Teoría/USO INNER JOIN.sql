SELECT* FROM Canciones;
SELECT* FROM Artistas;

SELECT*                                               -- Selecciona todas las columnas de ambas tablas (Canciones y Artistas).
FROM Canciones c									  -- de la tabla canciones con alias 'c'
INNER JOIN Artistas a ON c.artista_id = a.artista_id  -- Une ambas tablas cuando el ID del artista en la canción coincida con el ID en la tabla Artistas.

SELECT*												  -- Es indiferente poner  una tabla u otra antes o despues del INNER JOIN ,
FROM artistas a										  -- solamente afecta al orden de visualización
INNER JOIN canciones c ON a.artista_id = c.artista_id