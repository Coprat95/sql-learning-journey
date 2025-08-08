USE clasesql
GO

----------- OPERACIONES CON INNER JOIN ----------- se utiliza para combinar filas (datos) 
												-- de dos tablas bas�ndose en una columna(campos) que comparten

SELECT* 
FROM Votos

SELECT*
FROM poblacion

----------- Votos y poblaci�n por distrito federal------- (dbo.poblacion y dbo.votos comparten columna Distrito_Federal
SELECT ENTIDAD, votos.DISTRITO_FEDERAL, Votos , poblacion  -- escogemos votos.distrito_Federal porque queremos saber
														   -- la poblaci�n por distrito_federal donde se recogieron votos
FROM votos INNER JOIN poblacion   -- vamos a unir la tabla de votos con la de poblaci�n
ON votos.DISTRITO_FEDERAL = poblacion.DISTRITO_FEDERAL

---------- Votos con alg�n filtro de poblaci�n---------
----- solo quiero que nos muestre resultados  donde la poblaci�n sea mayor que 1.000.000

SELECT ENTIDAD , votos.DISTRITO_FEDERAL ,votos, poblacion
FROM votos INNER JOIN poblacion
ON votos.DISTRITO_FEDERAL = poblacion.DISTRITO_FEDERAL
WHERE poblacion.poblacion >= 1000000  -- se podr�a poner solo una poblacion, ya que poblaci�n no existe en otra tabla 
									  -- por lo tanto no hay ambig�edad

---------- Renombrando con INNER JOIN -------

SELECT ENTIDAD , vot.DISTRITO_FEDERAL ,votos, poblacion		-- hay que poner el nombre renombrado en todos los sitios donde 
FROM votos AS Vot INNER JOIN poblacion AS Pob				-- hagas referencia a la tabla
ON vot.DISTRITO_FEDERAL = pob.DISTRITO_FEDERAL
WHERE pob.poblacion >= 1000000 

---------- Suma de poblaci�n de algunas Entidades -------
SELECT vot.ENTIDAD, SUM (pob.poblacion) AS poblacion_estatal -- sumamos la poblacion de cada entidad
FROM votos AS vot INNER JOIN poblacion AS pob		-- utilizando las dos tablas y renombrandolas
ON vot.DISTRITO_FEDERAL = pob.DISTRITO_FEDERAL		-- campo  de uni�n (clave compartida)
WHERE vot.ENTIDAD IN ('NAYARIT', 'HIDALGO' , 'MORELOS') -- filtramos solo esas entidades
GROUP BY vot.ENTIDAD									-- ordenados por entidades (a-z)















