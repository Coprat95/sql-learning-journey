
-- USO ROW_NUMER() Asigna generos números consecutivos

-- Esta consulta enumera todas las canciones ordenadas por popularidad de mayor a menos
SELECT 
	ROW_NUMBER() OVER ( ORDER BY c.popularidad DESC) AS indice_popularidad,
    titulo
FROM canciones c
;
-- USO ROW_NUMBER() con PARTITION BY     Hace particiones lógicas. Por ejemplo si hablamos de las mejores canciones y lo particionas por artistas te saldrán
									 -- las mejores de bad bunny, luego las mejores de anuel , luego las de ozuna, pero no saldrán mezcladas entre artistas
									
-- esta consulta enumera todas las canciones por artista según su fecha de lanzamiento
SELECT 
	artista_id,
    ROW_NUMBER() OVER ( PARTITION BY artista_id ORDER BY fecha_lanzamiento ) AS numero_cancion,
    titulo,
    fecha_lanzamiento
    FROM canciones;
    














