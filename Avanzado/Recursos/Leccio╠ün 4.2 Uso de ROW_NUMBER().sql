-- Esta consulta enumera todas las canciones ordenadas por popularidad de mayor a menor
SELECT 
   ROW_NUMBER() OVER (ORDER BY popularidad DESC) as numero,  -- Asigna números consecutivos empezando en 1
   titulo,                                                   
   popularidad                                            
FROM Canciones;      


-- Numerar canciones por artista (reinicia numeración):
-- Esta consulta enumera las canciones por artista según su fecha de lanzamiento
SELECT 
   artista_id,                                                                             
   ROW_NUMBER() OVER (PARTITION BY artista_id ORDER BY fecha_lanzamiento) as numero_cancion,-- Enumera canciones por artista
   titulo,                                                                                 
   fecha_lanzamiento                                                                       
FROM Canciones;




/* 
Esta consulta utiliza un CTE (Common Table Expression) para encontrar las 3 canciones más reproducidas 
de cada artista, siguiendo estos pasos:
*/

WITH RankedSongs AS (
   SELECT 
       a.nombre as artista,                    
       c.titulo,                               
       COUNT(*) as reproducciones,             -- Cuenta total de reproducciones
       ROW_NUMBER() OVER (                     -- Asigna ranking dentro del grupo de cada artista
           PARTITION BY a.artista_id           -- Agrupa por artista
           ORDER BY COUNT(*) DESC              -- Ordena por número de reproducciones descendente
       ) as ranking
   FROM Reproducciones r
   JOIN Canciones c ON r.cancion_id = c.cancion_id           
   JOIN Artistas a ON c.artista_id = a.artista_id           
   GROUP BY a.artista_id, a.nombre, c.titulo                -- Agrupa para contar reproducciones
)



SELECT * FROM RankedSongs WHERE ranking <= 3;   -- Filtra solo las 3 canciones más populares
                                       