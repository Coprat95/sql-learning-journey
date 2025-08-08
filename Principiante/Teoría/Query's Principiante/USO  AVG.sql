USE clasesql
GO

-------------- USO DE AVG -------------

-------------- AVG TOTAL --------------
SELECT AVG(Votos)
FROM dbo.votos

-------------- RENOMBRANDO CON AS --------
SELECT AVG (Votos) AS Votacion_media
FROM dbo.votos

-------------- USANDO FILTROS -------------
SELECT AVG (Votos) AS Votacion_media
FROM dbo.votos
WHERE DISTRITO_FEDERAL LIKE '%PAZ%'

-------------- USANDO FILTROS CON NULOS --------
SELECT AVG (Votos) AS Votacion_media
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL

SELECT AVG (Votos) AS Votacion_media
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES' , 'BAJA CALIFORNIA' , 'CAMPECHE')

