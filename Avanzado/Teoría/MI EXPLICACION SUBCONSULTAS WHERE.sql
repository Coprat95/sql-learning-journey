
-- todo el rato el principio de la frase va en el select y la segunda parte es la condicion que le damos a la subconsulta (ultima linea)

						-- FINAL: Encontrar el usuario más antiguo de Colombia que escucha canciones populares
						SELECT u4.nombre AS 'Usuario premiado'  
                        FROM usuarios u4
                        WHERE u4.nombre IN (
							-- CUARTO: Filtrar usuarios que son de Colombia
							SELECT u3.nombre 
                            FROM usuarios u3 
                            WHERE u3.pais = 'Colombia' 
                            AND u3.nombre IN (
								-- TERCERO: Obtener los usuarios que han reproducido las canciones más escuchadas
								SELECT DISTINCT u2.nombre AS Usuario                                           -- ponemos distinct porque se repiten
                                FROM usuarios u2 JOIN  reproducciones r2 ON u2.usuario_id = r2.usuario_id
                                JOIN canciones c2 ON   r2.cancion_id =  c2.cancion_id
                                WHERE c2.titulo IN (        -- los usuarios que han escuchado las canciones WHERE titulo IN ( que se encuentran entre las + reproducidas)
									-- SEGUNDO: Obtener canciones que se han reproducido más que el promedio general
                                    SELECT c.titulo AS Cancion 					
                                    FROM canciones c JOIN reproducciones  r ON c.cancion_id = r.cancion_id
                                    GROUP BY c.titulo
                                    HAVING COUNT(r.reproduccion_id) > (
                                   		-- PRIMERO: Calcular el promedio de reproducciones por canción
											SELECT AVG(veces_reproducida) AS  media_reproduccion
                                            FROM (
                                                SELECT COUNT(reproduccion_id) AS veces_reproducida
                                                FROM reproducciones
                                                GROUP BY cancion_id 
                                                ) AS conteo_reproducciones
											)
										)
									)
								)
							ORDER BY u4.fecha_registro ASC
                            LIMIT 1;
                                                
								/* 1: usamos el FROM ( ) y no ponemos la tabla porque el avg de veces_reproducida
									no sale de ningúna
									tabla sino de la tabla virtual que hemos creado estadísticas_reproduccion
                                    
                                    2: r_reproduccion_Id es = a  reproducciones, por lo tal hay que usar el 
                                    CONTAR el total . 
                                    HAVING= WHERE pero se utiliza tras una función ( SUM, AVG, MAX, COUNT , etc)
                                    
                                    3: Selecciona distintos nombres de usuario que cumplen con lo siguiente ( ponemos las FK)
                                    
                                    4: Selecciona los nombres de los usuarios que son de Colombia y cuyo nombre aparece en el resultado de esta subconsulta.

                                    FINAL: seleccionamos el usuario con la fecha de registro mas antigua y lo limitamos a 1. 
                                    */