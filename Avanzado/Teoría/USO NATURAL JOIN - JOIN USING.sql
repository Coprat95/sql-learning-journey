-- ambas tablas tienen la columna artista_Id ( existe una unión)

SELECT * FROM Artistas;
SELECT * FROM Canciones;


-- NATURAL JOIN :  - usado
SELECT * 
FROM Canciones c
NATURAL JOIN Artistas a;  -- Une las dos tablas ya que tienen un nexo común (artista_id) . 
						  -- Primero todas las columnas de canciones y luego artistas ( no se repite artista_id)
                          
-- JOIN USING  : Debes especificar la columna común .   + usado

SELECT *
FROM Canciones c
JOIN Artistas a USING (artista_id);

 