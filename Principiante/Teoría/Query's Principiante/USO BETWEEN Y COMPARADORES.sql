USE clasesql
GO

------------  Usando <= y >= -------------
SELECT * 
FROM dbo.votos
WHERE ENTIDAD IN ('NUEVO LEÓN', 'OAXACA' , 'VERACRUZ')
AND Fecha_Publicacion >= '2024-06-05' 
AND Fecha_Publicacion <= '2024-06-06'

----------- Usando BETWEEN ----------

----------- FECHAS ---------------

SELECT * 
FROM dbo.votos 
WHERE ENTIDAD IN ('NUEVO LEÓN' , 'OAXACA', 'VERACRUZ')
AND Fecha_Publicacion BETWEEN '2024-06-05' AND '2024-06-06'

----------- NUMEROS -----------------

SELECT * 
FROM dbo.votos
WHERE ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
AND Votos BETWEEN '180000' AND '200000'

----------- TEXTO -------------
SELECT * 
FROM dbo.votos
WHERE ENTIDAD  BETWEEN 'CHIHUAHUA' AND 'HIDALGO'
