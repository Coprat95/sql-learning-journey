USE clasesql
GO

------------- USO DE COUNT -------------
------------- COUNT TOTAL -------------- cuenta todas las filas paras todas las columnas incluyendo los valores nulos

SELECT COUNT (*)
FROM dbo.votos

------------- COUNT SIN CONTAR NULOS ---- Distrito _federal es la unica columna con nulos
SELECT COUNT (DISTRITO_FEDERAL)
FROM dbo.votos

------------- RENOMBRANDO CON AS-------------
SELECT COUNT (*) as Boletas_Totales    -- hay que renombrarlas ya que no existe una columna con el total de columnas 
FROM dbo.votos 

------------- USANDO FILTROS ---------  
----- cuenta el total de votos de la entidad 'AGUASCALIENTES'
SELECT COUNT (*) as Boletas_Totales_Aguascalientes
FROM dbo.votos
WHERE ENTIDAD = 'AGUASCALIENTES'

------------- USANDO FILTROS CON NULOS -----------
SELECT COUNT(Votos) as Boletas_Totales_Distritos_Sin_Nombre
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL


---- Cantidad de votos donde distrito sea null y la entidad sea aguascalientes ,BJ , o campeche
SELECT COUNT(Votos) AS Boletas_Totales_Distritos_Sin_Nombre
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL 
AND ENTIDAD IN ('AGUASCALIENTES' , 'BAJA CALIFORNIA' , 'CAMPECHE')


