USE clasesql
GO
------------------ USO DE SUM --------------  suma columnas de valor numérico o decimal

------------------ SUMA ERROR --------------

SELECT SUM(ENTIDAD) AS error
FROM dbo.votos  -- da mensaje de error: El tipo de datos varchar del operando no es válido para el operador sum.

----------------- SUM TOTAL ---------------
SELECT SUM (Votos) AS Suma_Total_Votos
FROM dbo.votos

----------------- USANDO FILTROS -----------
SELECT SUM (Votos) AS Suma_Total_Votos
FROM dbo.votos
WHERE ENTIDAD IN ('AGUASCALIENTES') -- calculo de votos totales solamente en aguascalientes

---------------- USANDO FILTROS CON NULOS -------------
SELECT SUM (Votos) AS Suma_Total_Votos   -- nº de votos donde distrito es null 
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL 

SELECT SUM (Votos) AS Suma_Total_Votos	-- nº de votos donde distrito es null de las entidades aguascalientes, bj y campeche
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL 
AND ENTIDAD IN ('AGUASCALIENTES' , 'BAJA CALIFORNIA', 'CAMPECHE')

