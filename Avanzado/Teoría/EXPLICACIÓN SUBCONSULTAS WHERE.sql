USE spotifysimulator;
-- Ejemplo estructura básica subconsulta WHERE
SELECT * FROM PRODUCTOS WHERE PRECIO > ALL (SELECT PRECIO FROM PRODUCTOS WHERE SECCIÓN='CERÁMICA');
-- SUBCONSULTAS: CANCIONES QUE DURAN MÁS DEL PROMEDIO DE DURACIÓN NORMAL

-- EJEMPLO 1  ( como yo lo he hecho ) 
	SELECT c.titulo AS Canción , c.duracion AS Tiempo
	FROM canciones c
    WHERE c.duracion >
    (SELECT AVG(c2.duracion) AS Tiempo_promedio FROM canciones c2 ) ;
    
    -- como se debería hacer 
    
    SELECT 
	titulo AS Canción,
    duracion AS Duración
    FROM canciones
    WHERE Duracion > 
    ( SELECT AVG(Duracion) AS Media_duracion
		FROM Canciones)
        ;

-- _______________________________________________________________
 
-- EJEMPLO 2: -- EJEMPLO 2
-- Muestra el top3 artistas con más canciones
-- LO QUE YO HE HECHO 

-- LO QUE SE DEBE HACER 
SELECT Artista, total_canciones
FROM (
		 -- Primero contamos las canciones por artista
			SELECT a.nombre  as artista, COUNT(*) AS total_canciones    -- Sentencia clave: Cuando haces un JOIN entre la tabla artistas y canciones usando artista_id,
																	    -- estás combinando los datos de ambos para que puedas ver,
																		-- por ejemplo, el nombre del artista junto a cada canción. 
																		-- Luego, el COUNT(*) se usa para contar cuántas canciones hay asociadas a cada artista.
			FROM Artistas a 
			JOIN Canciones c ON a.artista_id = c.artista_id
			GROUP BY a.nombre											-- NECESARIO con AVG, COUNT,  SUM , ETC
        -- --------------------------------------------------------          
	) AS conteo    														-- al poner una subconsulta dsps del FROM , se ha de nombrar la tabla derivada que se crea
    ORDER BY total_canciones DESC
    LIMIT 3;
    /* Explicación: Primero, contamos cuántas canciones tiene cada artista.”
Para eso, hacemos una subconsulta que:
- Toma la tabla Artistas y la une con la tabla Canciones usando JOIN, vinculando cada canción con su artista correspondiente a través del campo artista_id.
- Seleccionamos el nombre del artista (a.nombre) y lo renombramos como artista para que sea más legible.
- Contamos todas las canciones de cada artista con COUNT(*) y renombramos ese conteo como total_canciones.
- Agrupamos los resultados por nombre de artista con GROUP BY a.nombre, para que el conteo se haga por cada artista por separado.

Luego, usamos esa subconsulta como si fuera una tabla temporal llamada conteo.”
Desde ahí, seleccionamos:
- El nombre del artista (Artista).
- La cantidad total de canciones (total_canciones).

Por último, ordenamos los resultados para ver quién tiene más canciones, y mostramos solo los tres primeros.”
Esto se hace con ORDER BY total_canciones DESC (de mayor a menor) y LIMIT 3 para mostrar los 3 artistas con más canciones en la base de datos.
*/

    
